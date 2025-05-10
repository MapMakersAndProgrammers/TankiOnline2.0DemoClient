package alternativa.tanks.game.weapons
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameEvents;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.entities.tank.TankEvents;
   import alternativa.tanks.game.subsystems.logicsystem.ILogic;
   import alternativa.tanks.game.subsystems.logicsystem.ILogicUnit;
   import alternativa.tanks.game.subsystems.timesystem.TimeSystem;
   
   public class ContinuousActionGunPlatformComponent extends EntityComponent implements IWeapon, IBasicWeapon, ILogicUnit
   {
      private var energyCapacity:Number;
      
      private var energyDrainRate:Number;
      
      private var energyRecoveryRate:Number;
      
      private var name_lp:IContinuousActionWeapon;
      
      private var baseTime:Number;
      
      private var name_Lq:Boolean;
      
      private var name_3:Boolean;
      
      private var name_Rr:Boolean;
      
      private var name_f3:Boolean;
      
      private var isLocal:Boolean;
      
      private var gameKernel:GameKernel;
      
      private var name_hE:ILogic;
      
      public function ContinuousActionGunPlatformComponent(energyCapacity:Number, energyDrainRate:Number, energyRecoveryRate:Number, isLocal:Boolean)
      {
         super();
         this.energyCapacity = energyCapacity;
         this.energyDrainRate = energyDrainRate;
         this.energyRecoveryRate = energyRecoveryRate;
         this.isLocal = isLocal;
         this.baseTime = -1000;
      }
      
      public function get enabled() : Boolean
      {
         return this.name_Rr;
      }
      
      public function set enabled(value:Boolean) : void
      {
         if(this.name_Rr != value)
         {
            this.name_Rr = value;
            if(value)
            {
               if(this.name_3)
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
         this.name_lp = IContinuousActionWeapon(entity.getComponentStrict(IContinuousActionWeapon));
         if(this.isLocal)
         {
            entity.addEventHandler(TankEvents.SET_ACTIVE_STATE,this.setActiveState);
            entity.addEventHandler(TankEvents.SET_ACTIVATING_STATE,this.setActivatingState);
            entity.addEventHandler(TankEvents.SET_DEAD_STATE,this.setInactiveState);
            entity.addEventHandler(TankEvents.SET_RESPAWN_STATE,this.setInactiveState);
            entity.addEventHandler(GameEvents.BATTLE_FINISHED,this.setInactiveState);
         }
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         this.gameKernel = gameKernel;
         this.name_hE = gameKernel.getLogicSystem2();
      }
      
      override public function removeFromGame(gameKernel:GameKernel) : void
      {
         this.name_hE = null;
         this.gameKernel = null;
      }
      
      public function getStatus() : Number
      {
         return this.getCurrentEnergy(TimeSystem.timeSeconds,this.name_Lq) / this.energyCapacity;
      }
      
      public function pullTrigger() : void
      {
         if(!this.name_3)
         {
            this.getLogger().log("gun","ContinuousActionGunPlatformComponent::pullTrigger()");
            this.name_3 = true;
            this.activate();
            this.enableLogic();
         }
      }
      
      public function releaseTrigger() : void
      {
         if(this.name_3)
         {
            this.getLogger().log("gun","ContinuousActionGunPlatformComponent::releaseTrigger()");
            this.name_3 = false;
            this.deactivate();
            this.disableLogic();
         }
      }
      
      private function getLogger() : IClientLog
      {
         return IClientLog(OSGi.getInstance().getService(IClientLog));
      }
      
      public function forceUpdate() : void
      {
      }
      
      public function runLogic() : void
      {
         var currentEnergy:Number = this.getCurrentEnergy(TimeSystem.timeSeconds,this.name_Lq);
         if(currentEnergy > 0)
         {
            this.name_lp.update();
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
         if(!this.name_f3 && this.name_Rr)
         {
            this.name_f3 = true;
            this.name_hE.addLogicUnit(this);
         }
      }
      
      private function disableLogic() : void
      {
         if(this.name_f3)
         {
            this.name_f3 = false;
            this.name_hE.removeLogicUnit(this);
         }
      }
      
      private function activate() : void
      {
         var now:Number = NaN;
         var currentEnergy:Number = NaN;
         if(!this.name_Lq && this.name_Rr)
         {
            this.name_Lq = true;
            this.name_lp.start();
            now = TimeSystem.timeSeconds;
            currentEnergy = this.getCurrentEnergy(now,false);
            this.baseTime = now - (this.energyCapacity - currentEnergy) / this.energyDrainRate;
         }
      }
      
      private function deactivate() : void
      {
         var now:Number = NaN;
         if(this.name_Lq)
         {
            this.name_Lq = false;
            this.name_lp.stop();
            now = TimeSystem.timeSeconds;
            this.baseTime = now - this.getCurrentEnergy(now,true) / this.energyRecoveryRate;
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
      
      private function setActivatingState(eventType:String, eventData:*) : void
      {
         this.enabled = false;
         this.baseTime = -100000;
      }
   }
}

