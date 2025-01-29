package alternativa.tanks.game.weapons
{
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.GameEvents;
   import package_115.class_26;
   import package_27.name_501;
   import package_42.name_184;
   import package_42.name_477;
   import package_45.name_182;
   import package_46.name_194;
   import package_71.name_252;
   import package_75.class_15;
   import package_75.name_236;
   import package_92.name_271;
   
   public class InstantShotWeaponComponent extends EntityComponent implements IWeapon, IBasicWeapon, name_477
   {
      private static var barrelOrigin:name_194 = new name_194();
      
      private static var muzzlePosition:name_194 = new name_194();
      
      private static var gunDirection:name_194 = new name_194();
      
      private static var gunElevationAxis:name_194 = new name_194();
      
      private static var shotDirection:name_194 = new name_194();
      
      private static var recoilForceVector:name_194 = new name_194();
      
      private static const BARREL_INDEX:int = 0;
      
      private var reloadTime:int;
      
      private var recoilForce:Number;
      
      private var targetingSystem:IGenericTargetingSystem;
      
      private var ammunition:IGenericAmmunition;
      
      private var callback:IInstantShotWeaponCallback;
      
      private var var_446:int;
      
      private var var_445:class_15;
      
      private var chassisComponent:name_236;
      
      private var var_447:class_26;
      
      private var var_440:name_184;
      
      private var var_439:Boolean;
      
      private var var_438:Boolean;
      
      private var var_441:Boolean;
      
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
         this.var_445 = class_15(entity.getComponentStrict(class_15));
         this.chassisComponent = name_236(entity.getComponentStrict(name_236));
         this.var_447 = class_26(entity.getComponentStrict(class_26));
         if(this.isActive)
         {
            entity.addEventHandler(name_252.SET_ACTIVE_STATE,this.setActiveState);
            entity.addEventHandler(name_252.SET_ACTIVATING_STATE,this.setInactiveState);
            entity.addEventHandler(name_252.SET_DEAD_STATE,this.setInactiveState);
            entity.addEventHandler(name_252.SET_RESPAWN_STATE,this.setInactiveState);
            entity.addEventHandler(GameEvents.BATTLE_FINISHED,this.setInactiveState);
         }
      }
      
      private function setActiveState(eventType:String, eventData:*) : void
      {
         this.name_308 = true;
      }
      
      private function setInactiveState(eventType:String, eventData:*) : void
      {
         this.name_308 = false;
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         this.gameKernel = gameKernel;
         this.var_440 = gameKernel.getLogicSystem2();
      }
      
      override public function removeFromGame(gameKernel:GameKernel) : void
      {
         this.var_440 = null;
         this.gameKernel = null;
      }
      
      public function method_396() : Number
      {
         var readiness:Number = 1 + (name_182.time - this.var_446) / this.reloadTime;
         return readiness > 1 ? 1 : readiness;
      }
      
      public function method_394() : void
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
      
      public function method_393() : void
      {
         if(this.var_438)
         {
            this.var_438 = false;
            this.disableLogic();
         }
      }
      
      public function method_395() : void
      {
         this.runLogic();
      }
      
      public function runLogic() : void
      {
         if(name_182.time < this.var_446)
         {
            return;
         }
         this.var_446 = name_182.time + this.reloadTime;
         if(this.callback != null)
         {
            this.callback.name_526();
         }
         this.var_445.getGunData(BARREL_INDEX,barrelOrigin,gunDirection,gunElevationAxis);
         var barrelLength:Number = Number(this.var_445.getBarrelLength(BARREL_INDEX));
         muzzlePosition.copy(barrelOrigin).method_362(barrelLength,gunDirection);
         this.doShowShotEffects(barrelOrigin,muzzlePosition,gunDirection,gunElevationAxis);
         var shotId:int = this.var_448++;
         var shooterBody:name_271 = this.chassisComponent.getBody();
         this.targetingSystem.name_527(shooterBody,muzzlePosition,barrelOrigin,gunDirection,barrelLength,gunElevationAxis,name_501.BIG_VALUE,shotDirection);
         var round:IGenericRound = this.ammunition.getRound();
         round.method_372(this.gameKernel,shotId,shooterBody,barrelOrigin,barrelLength,shotDirection,muzzlePosition);
      }
      
      public function get name_308() : Boolean
      {
         return this.var_439;
      }
      
      public function set name_308(value:Boolean) : void
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
      
      public function method_416() : void
      {
         this.var_445.getGunData(BARREL_INDEX,barrelOrigin,gunDirection,gunElevationAxis);
         muzzlePosition.copy(barrelOrigin).method_362(this.var_445.getBarrelLength(BARREL_INDEX),gunDirection);
         this.doShowShotEffects(barrelOrigin,muzzlePosition,gunDirection,gunElevationAxis);
      }
      
      private function doShowShotEffects(barrelOrigin:name_194, muzzlePosition:name_194, gunDirection:name_194, gunElevationAxis:name_194) : void
      {
         recoilForceVector.copy(gunDirection).scale(-this.recoilForce);
         this.chassisComponent.getBody().name_525(barrelOrigin,recoilForceVector);
         this.var_447.method_411(BARREL_INDEX,barrelOrigin,muzzlePosition,gunDirection,gunElevationAxis);
      }
      
      private function enableLogic() : void
      {
         if(!this.var_441)
         {
            this.var_441 = true;
            this.var_440.addLogicUnit(this);
         }
      }
      
      private function disableLogic() : void
      {
         if(this.var_441)
         {
            this.var_441 = false;
            this.var_440.removeLogicUnit(this);
         }
      }
   }
}

