package alternativa.tanks.game.weapons
{
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.physics.collision.ICollisionDetector;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameEvents;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.entities.tank.TankEvents;
   import alternativa.tanks.game.entities.tank.physics.IChassisPhysicsComponent;
   import alternativa.tanks.game.entities.tank.physics.ITurretPhysicsComponent;
   import alternativa.tanks.game.physics.CollisionGroup;
   import alternativa.tanks.game.physics.SimpleRaycastFilter;
   import alternativa.tanks.game.subsystems.logicsystem.ILogic;
   import alternativa.tanks.game.subsystems.logicsystem.ILogicUnit;
   import alternativa.tanks.game.subsystems.timesystem.TimeSystem;
   import alternativa.tanks.game.weapons.effects.IWeaponShotEffects;
   import alternativa.tanks.game.weapons.targeting.IEnergyTargetingSystem;
   
   public class EnergyShotWeaponComponent extends EntityComponent implements IBasicWeapon, IWeapon, ILogicUnit
   {
      private static const COLLISION_MASK:int = CollisionGroup.STATIC | CollisionGroup.WEAPON;
      
      private static var rayHit:RayHit = new RayHit();
      
      private static var filter:SimpleRaycastFilter = new SimpleRaycastFilter();
      
      private static var barrelOrigin:Vector3 = new Vector3();
      
      private static var muzzlePosition:Vector3 = new Vector3();
      
      private static var gunDirection:Vector3 = new Vector3();
      
      private static var gunElevationAxis:Vector3 = new Vector3();
      
      private static var shotDirection:Vector3 = new Vector3();
      
      private static var recoilForceVector:Vector3 = new Vector3();
      
      private var energyCapacity:Number;
      
      private var energyPerShot:Number;
      
      private var energyRechargeRate:Number;
      
      private var reloadTime:int;
      
      private var recoilForce:Number;
      
      private var targetingSystem:IEnergyTargetingSystem;
      
      private var ammunition:IEnergyAmmunition;
      
      private var callback:IEnergyShotWeaponCallback;
      
      private var isActive:Boolean;
      
      private var var_439:Boolean;
      
      private var var_438:Boolean;
      
      private var var_440:Boolean;
      
      private var var_441:ILogic;
      
      private var gameKernel:GameKernel;
      
      private var baseTime:int;
      
      private var var_446:int;
      
      private var var_445:ITurretPhysicsComponent;
      
      private var chassisComponent:IChassisPhysicsComponent;
      
      private var var_447:IWeaponShotEffects;
      
      private var var_448:int;
      
      private var maxRange:Number;
      
      private var barrelIndex:int;
      
      public function EnergyShotWeaponComponent(energyCapacity:Number, energyPerShot:Number, energyRechargeRate:Number, reloadTime:int, recoilForce:Number, maxRange:Number, targetingSystem:IEnergyTargetingSystem, callback:IEnergyShotWeaponCallback, isActive:Boolean)
      {
         super();
         this.energyCapacity = energyCapacity;
         this.energyPerShot = energyPerShot;
         this.energyRechargeRate = energyRechargeRate;
         this.reloadTime = reloadTime;
         this.recoilForce = recoilForce;
         this.maxRange = maxRange;
         this.targetingSystem = targetingSystem;
         this.callback = callback;
         this.isActive = isActive;
      }
      
      public function setCallback(callback:IEnergyShotWeaponCallback) : void
      {
         this.callback = callback;
      }
      
      public function setTargetingSystem(targetingSystem:IEnergyTargetingSystem) : void
      {
         this.targetingSystem = targetingSystem;
      }
      
      override public function initComponent() : void
      {
         this.var_445 = ITurretPhysicsComponent(entity.getComponentStrict(ITurretPhysicsComponent));
         this.chassisComponent = IChassisPhysicsComponent(entity.getComponentStrict(IChassisPhysicsComponent));
         this.var_447 = IWeaponShotEffects(entity.getComponentStrict(IWeaponShotEffects));
         this.ammunition = IEnergyAmmunition(entity.getComponentStrict(IEnergyAmmunition));
         if(this.isActive)
         {
            entity.addEventHandler(TankEvents.SET_ACTIVE_STATE,this.setActiveState);
            entity.addEventHandler(TankEvents.SET_ACTIVATING_STATE,this.setInactiveState);
            entity.addEventHandler(TankEvents.SET_DEAD_STATE,this.setInactiveState);
            entity.addEventHandler(TankEvents.SET_RESPAWN_STATE,this.setInactiveState);
            entity.addEventHandler(GameEvents.BATTLE_FINISHED,this.setInactiveState);
         }
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         this.gameKernel = gameKernel;
         this.var_441 = gameKernel.getLogicSystem2();
      }
      
      override public function removeFromGame(gameKernel:GameKernel) : void
      {
         this.var_441 = null;
         this.gameKernel = null;
      }
      
      public function pullTrigger() : void
      {
         if(!this.var_438)
         {
            this.var_438 = true;
            if(this.var_439)
            {
               this.enableLogic();
            }
         }
      }
      
      public function releaseTrigger() : void
      {
         if(this.var_438)
         {
            this.var_438 = false;
            this.disableLogic();
         }
      }
      
      public function forceUpdate() : void
      {
         this.runLogic();
      }
      
      public function getStatus() : Number
      {
         return this.getCurrentEnergy(TimeSystem.time,this.baseTime) / this.energyCapacity;
      }
      
      public function runLogic() : void
      {
         var barrelLength:Number = NaN;
         var shotId:int = 0;
         var shooterBody:Body = null;
         var collisionDetector:ICollisionDetector = null;
         var shotType:EnergyShotType = null;
         var round:IGenericRound = null;
         var now:int = TimeSystem.time;
         var currentEnergy:Number = this.getCurrentEnergy(now,this.baseTime);
         if(now >= this.var_446 && currentEnergy >= this.energyPerShot)
         {
            this.var_446 = now + this.reloadTime;
            this.baseTime = now - 1000 * (currentEnergy - this.energyPerShot) / this.energyRechargeRate;
            this.var_445.getGunData(this.barrelIndex,barrelOrigin,gunDirection,gunElevationAxis);
            barrelLength = Number(this.var_445.getBarrelLength(this.barrelIndex));
            muzzlePosition.copy(barrelOrigin).addScaled(barrelLength,gunDirection);
            shotId = this.var_448++;
            shooterBody = this.chassisComponent.getBody();
            collisionDetector = this.gameKernel.getPhysicsSystem().getPhysicsScene().collisionDetector;
            filter.body = shooterBody;
            if(collisionDetector.raycast(barrelOrigin,gunDirection,COLLISION_MASK,barrelLength + 0.01,filter,rayHit))
            {
               shotType = EnergyShotType.CLOSE_SHOT;
               shotDirection.copy(gunDirection);
            }
            else
            {
               shotType = EnergyShotType.NORMAL_SHOT;
               this.targetingSystem.getShotDirection(shooterBody,muzzlePosition,gunDirection,gunElevationAxis,this.maxRange,shotDirection);
            }
            filter.body = null;
            this.doShowShotEffects(shotType,this.barrelIndex,barrelOrigin,muzzlePosition,gunDirection,gunElevationAxis);
            if(this.callback != null)
            {
               this.callback.onEnergyShotWeaponFire(shotId,shotType,shotDirection,this.barrelIndex);
            }
            round = this.ammunition.getRound(shotType,this.maxRange);
            round.shoot(this.gameKernel,shotId,shooterBody,barrelOrigin,barrelLength,shotDirection,muzzlePosition);
            this.barrelIndex = (this.barrelIndex + 1) % this.var_445.getBarrelCount();
         }
      }
      
      public function shoot(shotId:int, shotType:EnergyShotType, shotDirection:Vector3, barrelIndex:int) : void
      {
         var shooterBody:Body = this.chassisComponent.getBody();
         var barrelLength:Number = Number(this.var_445.getBarrelLength(barrelIndex));
         this.var_445.getGunData(barrelIndex,barrelOrigin,gunDirection,gunElevationAxis);
         muzzlePosition.copy(barrelOrigin).addScaled(barrelLength,gunDirection);
         this.doShowShotEffects(shotType,barrelIndex,barrelOrigin,muzzlePosition,gunDirection,gunElevationAxis);
         var round:IGenericRound = this.ammunition.getRound(shotType,this.maxRange);
         round.shoot(this.gameKernel,shotId,shooterBody,barrelOrigin,barrelLength,shotDirection,muzzlePosition);
      }
      
      public function get enabled() : Boolean
      {
         return this.var_439;
      }
      
      public function set enabled(value:Boolean) : void
      {
         if(this.var_439 != value)
         {
            this.var_439 = value;
            if(this.var_439)
            {
               if(this.var_438)
               {
                  this.enableLogic();
               }
            }
            else
            {
               this.disableLogic();
            }
         }
      }
      
      private function doShowShotEffects(shotType:EnergyShotType, barrelIndex:int, barrelOrigin:Vector3, muzzlePosition:Vector3, gunDirection:Vector3, gunElevationAxis:Vector3) : void
      {
         recoilForceVector.copy(gunDirection).scale(-this.recoilForce);
         this.chassisComponent.getBody().addWorldForce(barrelOrigin,recoilForceVector);
         if(shotType == EnergyShotType.NORMAL_SHOT)
         {
            this.var_447.createShotEffects(barrelIndex,barrelOrigin,muzzlePosition,gunDirection,gunElevationAxis);
         }
      }
      
      private function setActiveState(eventType:String, eventData:*) : void
      {
         this.enabled = true;
      }
      
      private function setInactiveState(eventType:String, eventData:*) : void
      {
         this.enabled = false;
      }
      
      private function enableLogic() : void
      {
         if(!this.var_440)
         {
            this.var_440 = true;
            this.var_441.addLogicUnit(this);
         }
      }
      
      private function disableLogic() : void
      {
         if(this.var_440)
         {
            this.var_440 = false;
            this.var_441.removeLogicUnit(this);
         }
      }
      
      private function getCurrentEnergy(time:int, baseTime:int) : Number
      {
         var energy:Number = 0.001 * (time - baseTime) * this.energyRechargeRate;
         if(energy < 0)
         {
            return 0;
         }
         if(energy > this.energyCapacity)
         {
            return this.energyCapacity;
         }
         return energy;
      }
   }
}

