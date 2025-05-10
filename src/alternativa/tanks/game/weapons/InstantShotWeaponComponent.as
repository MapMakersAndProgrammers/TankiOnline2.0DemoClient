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
      
      private var §_-g8§:int;
      
      private var §_-Zu§:ITurretPhysicsComponent;
      
      private var chassisComponent:IChassisPhysicsComponent;
      
      private var §_-bQ§:IWeaponShotEffects;
      
      private var §_-hE§:ILogic;
      
      private var §_-Rr§:Boolean;
      
      private var §_-3§:Boolean;
      
      private var §_-f3§:Boolean;
      
      private var §_-eN§:int;
      
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
         this.§_-Zu§ = ITurretPhysicsComponent(entity.getComponentStrict(ITurretPhysicsComponent));
         this.chassisComponent = IChassisPhysicsComponent(entity.getComponentStrict(IChassisPhysicsComponent));
         this.§_-bQ§ = IWeaponShotEffects(entity.getComponentStrict(IWeaponShotEffects));
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
         this.§_-hE§ = gameKernel.getLogicSystem2();
      }
      
      override public function removeFromGame(gameKernel:GameKernel) : void
      {
         this.§_-hE§ = null;
         this.gameKernel = null;
      }
      
      public function getStatus() : Number
      {
         var readiness:Number = 1 + (TimeSystem.time - this.§_-g8§) / this.reloadTime;
         return readiness > 1 ? 1 : readiness;
      }
      
      public function pullTrigger() : void
      {
         if(!this.§_-3§)
         {
            this.§_-3§ = true;
            if(this.§_-Rr§)
            {
               this.enableLogic();
            }
         }
      }
      
      public function releaseTrigger() : void
      {
         if(this.§_-3§)
         {
            this.§_-3§ = false;
            this.disableLogic();
         }
      }
      
      public function forceUpdate() : void
      {
         this.runLogic();
      }
      
      public function runLogic() : void
      {
         if(TimeSystem.time < this.§_-g8§)
         {
            return;
         }
         this.§_-g8§ = TimeSystem.time + this.reloadTime;
         if(this.callback != null)
         {
            this.callback.onInstantShot();
         }
         this.§_-Zu§.getGunData(BARREL_INDEX,barrelOrigin,gunDirection,gunElevationAxis);
         var barrelLength:Number = Number(this.§_-Zu§.getBarrelLength(BARREL_INDEX));
         muzzlePosition.copy(barrelOrigin).addScaled(barrelLength,gunDirection);
         this.doShowShotEffects(barrelOrigin,muzzlePosition,gunDirection,gunElevationAxis);
         var shotId:int = this.§_-eN§++;
         var shooterBody:Body = this.chassisComponent.getBody();
         this.targetingSystem.calculateShotDirection(shooterBody,muzzlePosition,barrelOrigin,gunDirection,barrelLength,gunElevationAxis,GameMathUtils.BIG_VALUE,shotDirection);
         var round:IGenericRound = this.ammunition.getRound();
         round.shoot(this.gameKernel,shotId,shooterBody,barrelOrigin,barrelLength,shotDirection,muzzlePosition);
      }
      
      public function get enabled() : Boolean
      {
         return this.§_-Rr§;
      }
      
      public function set enabled(value:Boolean) : void
      {
         if(this.§_-Rr§ != value)
         {
            this.§_-Rr§ = value;
            if(this.§_-Rr§)
            {
               if(this.§_-3§)
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
         this.§_-Zu§.getGunData(BARREL_INDEX,barrelOrigin,gunDirection,gunElevationAxis);
         muzzlePosition.copy(barrelOrigin).addScaled(this.§_-Zu§.getBarrelLength(BARREL_INDEX),gunDirection);
         this.doShowShotEffects(barrelOrigin,muzzlePosition,gunDirection,gunElevationAxis);
      }
      
      private function doShowShotEffects(barrelOrigin:Vector3, muzzlePosition:Vector3, gunDirection:Vector3, gunElevationAxis:Vector3) : void
      {
         recoilForceVector.copy(gunDirection).scale(-this.recoilForce);
         this.chassisComponent.getBody().addWorldForce(barrelOrigin,recoilForceVector);
         this.§_-bQ§.createShotEffects(BARREL_INDEX,barrelOrigin,muzzlePosition,gunDirection,gunElevationAxis);
      }
      
      private function enableLogic() : void
      {
         if(!this.§_-f3§)
         {
            this.§_-f3§ = true;
            this.§_-hE§.addLogicUnit(this);
         }
      }
      
      private function disableLogic() : void
      {
         if(this.§_-f3§)
         {
            this.§_-f3§ = false;
            this.§_-hE§.removeLogicUnit(this);
         }
      }
   }
}

