package alternativa.tanks.game.weapons
{
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.GameEvents;
   import package_39.name_160;
   import package_42.name_184;
   import package_42.name_477;
   import package_45.name_182;
   import alternativa.osgi.OSGi;
   import package_71.name_252;
   
   public class ContinuousActionGunPlatformComponent extends EntityComponent implements IWeapon, IBasicWeapon, name_477
   {
      private var energyCapacity:Number;
      
      private var energyDrainRate:Number;
      
      private var energyRecoveryRate:Number;
      
      private var var_442:IContinuousActionWeapon;
      
      private var baseTime:Number;
      
      private var var_437:Boolean;
      
      private var var_438:Boolean;
      
      private var var_439:Boolean;
      
      private var var_441:Boolean;
      
      private var isLocal:Boolean;
      
      private var gameKernel:GameKernel;
      
      private var var_440:name_184;
      
      public function ContinuousActionGunPlatformComponent(energyCapacity:Number, energyDrainRate:Number, energyRecoveryRate:Number, isLocal:Boolean)
      {
         super();
         this.energyCapacity = energyCapacity;
         this.energyDrainRate = energyDrainRate;
         this.energyRecoveryRate = energyRecoveryRate;
         this.isLocal = isLocal;
         this.baseTime = -1000;
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
            if(value)
            {
               if(this.var_438)
               {
                  this.getLogger().log("gun","ContinuousActionGunPlatformComponent::enabled() activating");
                  this.activate();
                  this.enableLogic();
               }
            }
            else
            {
               this.getLogger().log("gun","ContinuousActionGunPlatformComponent::enabled() deactivating");
               this.deactivate();
               this.disableLogic();
            }
         }
      }
      
      override public function initComponent() : void
      {
         this.var_442 = IContinuousActionWeapon(entity.getComponentStrict(IContinuousActionWeapon));
         if(this.isLocal)
         {
            entity.addEventHandler(name_252.SET_ACTIVE_STATE,this.setActiveState);
            entity.addEventHandler(name_252.SET_ACTIVATING_STATE,this.setActivatingState);
            entity.addEventHandler(name_252.SET_DEAD_STATE,this.setInactiveState);
            entity.addEventHandler(name_252.SET_RESPAWN_STATE,this.setInactiveState);
            entity.addEventHandler(GameEvents.BATTLE_FINISHED,this.setInactiveState);
         }
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
         return this.getCurrentEnergy(name_182.timeSeconds,this.var_437) / this.energyCapacity;
      }
      
      public function method_394() : void
      {
         if(!this.var_438)
         {
            this.getLogger().log("gun","ContinuousActionGunPlatformComponent::pullTrigger()");
            this.var_438 = true;
            this.activate();
            this.enableLogic();
         }
      }
      
      public function method_393() : void
      {
         if(this.var_438)
         {
            this.getLogger().log("gun","ContinuousActionGunPlatformComponent::releaseTrigger()");
            this.var_438 = false;
            this.deactivate();
            this.disableLogic();
         }
      }
      
      private function getLogger() : name_160
      {
         return name_160(OSGi.name_8().name_30(name_160));
      }
      
      public function method_395() : void
      {
      }
      
      public function runLogic() : void
      {
         var currentEnergy:Number = this.getCurrentEnergy(name_182.timeSeconds,this.var_437);
         if(currentEnergy > 0)
         {
            this.var_442.update();
         }
         else
         {
            this.deactivate();
            this.disableLogic();
         }
      }
      
      private function getCurrentEnergy(time:Number, active:Boolean) : Number
      {
         var energy:Number = NaN;
         if(active)
         {
            energy = this.energyCapacity - (time - this.baseTime) * this.energyDrainRate;
         }
         else
         {
            energy = (time - this.baseTime) * this.energyRecoveryRate;
         }
         if(energy < 0)
         {
            energy = 0;
         }
         else if(energy > this.energyCapacity)
         {
            energy = this.energyCapacity;
         }
         return energy;
      }
      
      private function enableLogic() : void
      {
         if(!this.var_441 && this.var_439)
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
      
      private function activate() : void
      {
         var now:Number = NaN;
         var currentEnergy:Number = NaN;
         if(!this.var_437 && this.var_439)
         {
            this.var_437 = true;
            this.var_442.start();
            now = name_182.timeSeconds;
            currentEnergy = this.getCurrentEnergy(now,false);
            this.baseTime = now - (this.energyCapacity - currentEnergy) / this.energyDrainRate;
         }
      }
      
      private function deactivate() : void
      {
         var now:Number = NaN;
         if(this.var_437)
         {
            this.var_437 = false;
            this.var_442.stop();
            now = name_182.timeSeconds;
            this.baseTime = now - this.getCurrentEnergy(now,true) / this.energyRecoveryRate;
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
      
      private function setActivatingState(eventType:String, eventData:*) : void
      {
         this.name_308 = false;
         this.baseTime = -100000;
      }
   }
}

