package package_74
{
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.GameEvents;
   import package_115.class_26;
   import package_42.name_184;
   import package_42.name_477;
   import package_45.name_182;
   import package_46.name_194;
   import package_71.name_252;
   import package_75.class_15;
   import package_75.name_236;
   import package_76.name_256;
   import package_79.name_622;
   import package_86.name_257;
   import package_86.name_540;
   import package_90.name_273;
   import package_92.name_271;
   
   public class name_283 extends EntityComponent implements class_24, class_25, name_477
   {
      private static const COLLISION_MASK:int = name_257.STATIC | name_257.WEAPON;
      
      private static var rayHit:name_273 = new name_273();
      
      private static var filter:name_540 = new name_540();
      
      private static var barrelOrigin:name_194 = new name_194();
      
      private static var muzzlePosition:name_194 = new name_194();
      
      private static var gunDirection:name_194 = new name_194();
      
      private static var gunElevationAxis:name_194 = new name_194();
      
      private static var shotDirection:name_194 = new name_194();
      
      private static var recoilForceVector:name_194 = new name_194();
      
      private var energyCapacity:Number;
      
      private var energyPerShot:Number;
      
      private var energyRechargeRate:Number;
      
      private var reloadTime:int;
      
      private var recoilForce:Number;
      
      private var targetingSystem:name_622;
      
      private var ammunition:class_23;
      
      private var callback:name_621;
      
      private var isActive:Boolean;
      
      private var var_439:Boolean;
      
      private var var_438:Boolean;
      
      private var var_441:Boolean;
      
      private var var_440:name_184;
      
      private var gameKernel:GameKernel;
      
      private var baseTime:int;
      
      private var var_446:int;
      
      private var var_445:class_15;
      
      private var chassisComponent:name_236;
      
      private var var_447:class_26;
      
      private var var_448:int;
      
      private var maxRange:Number;
      
      private var barrelIndex:int;
      
      public function name_283(energyCapacity:Number, energyPerShot:Number, energyRechargeRate:Number, reloadTime:int, recoilForce:Number, maxRange:Number, targetingSystem:name_622, callback:name_621, isActive:Boolean)
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
      
      public function method_383(callback:name_621) : void
      {
         this.callback = callback;
      }
      
      public function method_528(targetingSystem:name_622) : void
      {
         this.targetingSystem = targetingSystem;
      }
      
      override public function initComponent() : void
      {
         this.var_445 = class_15(entity.getComponentStrict(class_15));
         this.chassisComponent = name_236(entity.getComponentStrict(name_236));
         this.var_447 = class_26(entity.getComponentStrict(class_26));
         this.ammunition = class_23(entity.getComponentStrict(class_23));
         if(this.isActive)
         {
            entity.addEventHandler(name_252.SET_ACTIVE_STATE,this.setActiveState);
            entity.addEventHandler(name_252.SET_ACTIVATING_STATE,this.method_400);
            entity.addEventHandler(name_252.SET_DEAD_STATE,this.method_400);
            entity.addEventHandler(name_252.SET_RESPAWN_STATE,this.method_400);
            entity.addEventHandler(GameEvents.BATTLE_FINISHED,this.method_400);
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
      
      public function method_394() : void
      {
         if(!this.var_438)
         {
            this.var_438 = true;
            if(this.var_439)
            {
               this.method_403();
            }
         }
      }
      
      public function method_393() : void
      {
         if(this.var_438)
         {
            this.var_438 = false;
            this.method_401();
         }
      }
      
      public function method_395() : void
      {
         this.runLogic();
      }
      
      public function method_396() : Number
      {
         return this.method_398(name_182.time,this.baseTime) / this.energyCapacity;
      }
      
      public function runLogic() : void
      {
         var barrelLength:Number = NaN;
         var shotId:int = 0;
         var shooterBody:name_271 = null;
         var collisionDetector:name_256 = null;
         var shotType:name_496 = null;
         var round:name_233 = null;
         var now:int = name_182.time;
         var currentEnergy:Number = this.method_398(now,this.baseTime);
         if(now >= this.var_446 && currentEnergy >= this.energyPerShot)
         {
            this.var_446 = now + this.reloadTime;
            this.baseTime = now - 1000 * (currentEnergy - this.energyPerShot) / this.energyRechargeRate;
            this.var_445.getGunData(this.barrelIndex,barrelOrigin,gunDirection,gunElevationAxis);
            barrelLength = Number(this.var_445.getBarrelLength(this.barrelIndex));
            muzzlePosition.copy(barrelOrigin).method_362(barrelLength,gunDirection);
            shotId = this.var_448++;
            shooterBody = this.chassisComponent.getBody();
            collisionDetector = this.gameKernel.method_112().name_246().collisionDetector;
            filter.body = shooterBody;
            if(collisionDetector.raycast(barrelOrigin,gunDirection,COLLISION_MASK,barrelLength + 0.01,filter,rayHit))
            {
               shotType = name_496.CLOSE_SHOT;
               shotDirection.copy(gunDirection);
            }
            else
            {
               shotType = name_496.NORMAL_SHOT;
               this.targetingSystem.name_624(shooterBody,muzzlePosition,gunDirection,gunElevationAxis,this.maxRange,shotDirection);
            }
            filter.body = null;
            this.method_415(shotType,this.barrelIndex,barrelOrigin,muzzlePosition,gunDirection,gunElevationAxis);
            if(this.callback != null)
            {
               this.callback.name_623(shotId,shotType,shotDirection,this.barrelIndex);
            }
            round = this.ammunition.getRound(shotType,this.maxRange);
            round.method_372(this.gameKernel,shotId,shooterBody,barrelOrigin,barrelLength,shotDirection,muzzlePosition);
            this.barrelIndex = (this.barrelIndex + 1) % this.var_445.getBarrelCount();
         }
      }
      
      public function method_372(shotId:int, shotType:name_496, shotDirection:name_194, barrelIndex:int) : void
      {
         var shooterBody:name_271 = this.chassisComponent.getBody();
         var barrelLength:Number = Number(this.var_445.getBarrelLength(barrelIndex));
         this.var_445.getGunData(barrelIndex,barrelOrigin,gunDirection,gunElevationAxis);
         muzzlePosition.copy(barrelOrigin).method_362(barrelLength,gunDirection);
         this.method_415(shotType,barrelIndex,barrelOrigin,muzzlePosition,gunDirection,gunElevationAxis);
         var round:name_233 = this.ammunition.getRound(shotType,this.maxRange);
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
                  this.method_403();
               }
            }
            else
            {
               this.method_401();
            }
         }
      }
      
      private function method_415(shotType:name_496, barrelIndex:int, barrelOrigin:name_194, muzzlePosition:name_194, gunDirection:name_194, gunElevationAxis:name_194) : void
      {
         recoilForceVector.copy(gunDirection).scale(-this.recoilForce);
         this.chassisComponent.getBody().name_525(barrelOrigin,recoilForceVector);
         if(shotType == name_496.NORMAL_SHOT)
         {
            this.var_447.method_411(barrelIndex,barrelOrigin,muzzlePosition,gunDirection,gunElevationAxis);
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
      
      private function method_403() : void
      {
         if(!this.var_441)
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
      
      private function method_398(time:int, baseTime:int) : Number
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

