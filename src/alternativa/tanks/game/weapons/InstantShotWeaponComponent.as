package alternativa.tanks.game.weapons
{
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameEvents;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.entities.tank.TankEvents;
   import alternativa.tanks.game.entities.tank.physics.IChassisPhysicsComponent;
   import alternativa.tanks.game.entities.tank.physics.ITurretPhysicsComponent;
   import alternativa.tanks.game.subsystems.logicsystem.ILogic;
   import alternativa.tanks.game.subsystems.logicsystem.ILogicUnit;
   import alternativa.tanks.game.subsystems.timesystem.TimeSystem;
   import alternativa.tanks.game.utils.GameMathUtils;
   import alternativa.tanks.game.weapons.effects.IWeaponShotEffects;
   
   public class InstantShotWeaponComponent extends EntityComponent implements IWeapon, IBasicWeapon, ILogicUnit
   {
      private static var barrelOrigin:Vector3 = new Vector3();
      
      private static var muzzlePosition:Vector3 = new Vector3();
      
      private static var gunDirection:Vector3 = new Vector3();
      
      private static var gunElevationAxis:Vector3 = new Vector3();
      
      private static var shotDirection:Vector3 = new Vector3();
      
      private static var recoilForceVector:Vector3 = new Vector3();
      
      private static const BARREL_INDEX:int = 0;
      
      private var reloadTime:int;
      
      private var recoilForce:Number;
      
      private var targetingSystem:IGenericTargetingSystem;
      
      private var ammunition:IGenericAmmunition;
      
      private var callback:IInstantShotWeaponCallback;
      
      private var var_446:int;
      
      private var var_445:ITurretPhysicsComponent;
      
      private var chassisComponent:IChassisPhysicsComponent;
      
      private var var_447:IWeaponShotEffects;
      
      private var var_441:ILogic;
      
      private var var_439:Boolean;
      
      private var var_438:Boolean;
      
      private var var_440:Boolean;
      
      private var var_448:int;
      
      private var gameKernel:GameKernel;
      
      private var isActive:Boolean;
      
      public function InstantShotWeaponComponent(reloadTime:int, recoilForce:Number, targetingSystem:IGenericTargetingSystem, ammunition:IGenericAmmunition, callback:IInstantShotWeaponCallback, isActive:Boolean)
      {
         super();
         this.reloadTime = reloadTime;
         this.recoilForce = recoilForce;
         this.targetingSystem = targetingSystem;
         this.ammunition = ammunition;
         this.callback = callback;
         this.isActive = isActive;
      }
      
      override public function initComponent() : void
      {
         this.var_445 = ITurretPhysicsComponent(entity.getComponentStrict(ITurretPhysicsComponent));
         this.chassisComponent = IChassisPhysicsComponent(entity.getComponentStrict(IChassisPhysicsComponent));
         this.var_447 = IWeaponShotEffects(entity.getComponentStrict(IWeaponShotEffects));
         if(this.isActive)
         {
            entity.addEventHandler(TankEvents.SET_ACTIVE_STATE,this.setActiveState);
            entity.addEventHandler(TankEvents.SET_ACTIVATING_STATE,this.setInactiveState);
            entity.addEventHandler(TankEvents.SET_DEAD_STATE,this.setInactiveState);
            entity.addEventHandler(TankEvents.SET_RESPAWN_STATE,this.setInactiveState);
            entity.addEventHandler(GameEvents.BATTLE_FINISHED,this.setInactiveState);
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
      
      public function getStatus() : Number
      {
         var readiness:Number = 1 + (TimeSystem.time - this.var_446) / this.reloadTime;
         return readiness > 1 ? 1 : readiness;
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
      
      public function runLogic() : void
      {
         if(TimeSystem.time < this.var_446)
         {
            return;
         }
         this.var_446 = TimeSystem.time + this.reloadTime;
         if(this.callback != null)
         {
            this.callback.onInstantShot();
         }
         this.var_445.getGunData(BARREL_INDEX,barrelOrigin,gunDirection,gunElevationAxis);
         var barrelLength:Number = Number(this.var_445.getBarrelLength(BARREL_INDEX));
         muzzlePosition.copy(barrelOrigin).addScaled(barrelLength,gunDirection);
         this.doShowShotEffects(barrelOrigin,muzzlePosition,gunDirection,gunElevationAxis);
         var shotId:int = this.var_448++;
         var shooterBody:Body = this.chassisComponent.getBody();
         this.targetingSystem.calculateShotDirection(shooterBody,muzzlePosition,barrelOrigin,gunDirection,barrelLength,gunElevationAxis,GameMathUtils.BIG_VALUE,shotDirection);
         var round:IGenericRound = this.ammunition.getRound();
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
      
      public function showShotEffects() : void
      {
         this.var_445.getGunData(BARREL_INDEX,barrelOrigin,gunDirection,gunElevationAxis);
         muzzlePosition.copy(barrelOrigin).addScaled(this.var_445.getBarrelLength(BARREL_INDEX),gunDirection);
         this.doShowShotEffects(barrelOrigin,muzzlePosition,gunDirection,gunElevationAxis);
      }
      
      private function doShowShotEffects(barrelOrigin:Vector3, muzzlePosition:Vector3, gunDirection:Vector3, gunElevationAxis:Vector3) : void
      {
         recoilForceVector.copy(gunDirection).scale(-this.recoilForce);
         this.chassisComponent.getBody().addWorldForce(barrelOrigin,recoilForceVector);
         this.var_447.createShotEffects(BARREL_INDEX,barrelOrigin,muzzlePosition,gunDirection,gunElevationAxis);
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
   }
}

