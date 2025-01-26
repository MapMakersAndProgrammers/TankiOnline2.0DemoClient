package package_74
{
   import package_10.class_17;
   import package_10.name_17;
   import package_10.name_57;
   import package_39.name_160;
   import package_42.name_184;
   import package_42.name_477;
   import package_45.name_182;
   import package_5.name_3;
   import package_71.name_252;
   
   public class name_286 extends class_17 implements class_25, class_24, name_477
   {
      private var energyCapacity:Number;
      
      private var energyDrainRate:Number;
      
      private var energyRecoveryRate:Number;
      
      private var var_442:name_508;
      
      private var baseTime:Number;
      
      private var var_437:Boolean;
      
      private var var_438:Boolean;
      
      private var var_439:Boolean;
      
      private var var_441:Boolean;
      
      private var isLocal:Boolean;
      
      private var gameKernel:name_17;
      
      private var var_440:name_184;
      
      public function name_286(energyCapacity:Number, energyDrainRate:Number, energyRecoveryRate:Number, isLocal:Boolean)
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
                  this.method_397().log("gun","ContinuousActionGunPlatformComponent::enabled() activating");
                  this.method_402();
                  this.method_403();
               }
            }
            else
            {
               this.method_397().log("gun","ContinuousActionGunPlatformComponent::enabled() deactivating");
               this.method_399();
               this.method_401();
            }
         }
      }
      
      override public function initComponent() : void
      {
         this.var_442 = name_508(entity.getComponentStrict(name_508));
         if(this.isLocal)
         {
            entity.addEventHandler(name_252.SET_ACTIVE_STATE,this.setActiveState);
            entity.addEventHandler(name_252.SET_ACTIVATING_STATE,this.setActivatingState);
            entity.addEventHandler(name_252.SET_DEAD_STATE,this.method_400);
            entity.addEventHandler(name_252.SET_RESPAWN_STATE,this.method_400);
            entity.addEventHandler(name_57.BATTLE_FINISHED,this.method_400);
         }
      }
      
      override public function addToGame(gameKernel:name_17) : void
      {
         this.gameKernel = gameKernel;
         this.var_440 = gameKernel.getLogicSystem2();
      }
      
      override public function removeFromGame(gameKernel:name_17) : void
      {
         this.var_440 = null;
         this.gameKernel = null;
      }
      
      public function method_396() : Number
      {
         return this.method_398(name_182.timeSeconds,this.var_437) / this.energyCapacity;
      }
      
      public function method_394() : void
      {
         if(!this.var_438)
         {
            this.method_397().log("gun","ContinuousActionGunPlatformComponent::pullTrigger()");
            this.var_438 = true;
            this.method_402();
            this.method_403();
         }
      }
      
      public function method_393() : void
      {
         if(this.var_438)
         {
            this.method_397().log("gun","ContinuousActionGunPlatformComponent::releaseTrigger()");
            this.var_438 = false;
            this.method_399();
            this.method_401();
         }
      }
      
      private function method_397() : name_160
      {
         return name_160(name_3.name_8().name_30(name_160));
      }
      
      public function method_395() : void
      {
      }
      
      public function runLogic() : void
      {
         var currentEnergy:Number = this.method_398(name_182.timeSeconds,this.var_437);
         if(currentEnergy > 0)
         {
            this.var_442.update();
         }
         else
         {
            this.method_399();
            this.method_401();
         }
      }
      
      private function method_398(time:Number, active:Boolean) : Number
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
      
      private function method_403() : void
      {
         if(!this.var_441 && this.var_439)
         {
            this.var_441 = true;
            this.var_440.addLogicUnit(this);
         }
      }
      
      private function method_401() : void
      {
         if(this.var_441)
         {
            this.var_441 = false;
            this.var_440.removeLogicUnit(this);
         }
      }
      
      private function method_402() : void
      {
         var now:Number = NaN;
         var currentEnergy:Number = NaN;
         if(!this.var_437 && this.var_439)
         {
            this.var_437 = true;
            this.var_442.start();
            now = name_182.timeSeconds;
            currentEnergy = this.method_398(now,false);
            this.baseTime = now - (this.energyCapacity - currentEnergy) / this.energyDrainRate;
         }
      }
      
      private function method_399() : void
      {
         var now:Number = NaN;
         if(this.var_437)
         {
            this.var_437 = false;
            this.var_442.stop();
            now = name_182.timeSeconds;
            this.baseTime = now - this.method_398(now,true) / this.energyRecoveryRate;
         }
      }
      
      private function setActiveState(eventType:String, eventData:*) : void
      {
         this.name_308 = true;
      }
      
      private function method_400(eventType:String, eventData:*) : void
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

