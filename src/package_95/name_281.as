package package_95
{
   import flash.utils.Dictionary;
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameKernel;
   import package_46.name_194;
   import package_74.name_508;
   import package_75.class_15;
   import package_75.name_236;
   import package_79.name_282;
   
   public class name_281 extends EntityComponent implements name_508
   {
      private static var barrelOrigin:name_194 = new name_194();
      
      private static var gunDirection:name_194 = new name_194();
      
      private static var gunElevationAxis:name_194 = new name_194();
      
      private static var BARREL_INDEX:int = 0;
      
      private var turret:class_15;
      
      private var chassis:name_236;
      
      private var targetingSystem:name_282;
      
      private var effects:class_28;
      
      private var fullDamageRange:Number;
      
      private var rangeDiscretization:Number;
      
      private var targetToDistance:Dictionary;
      
      private var var_459:Dictionary;
      
      private var callback:name_545;
      
      private var isLocal:Boolean;
      
      private var createStarted:Boolean;
      
      public function name_281(fullDamageRange:Number, rangeDiscretization:Number, targetingSystem:name_282, callback:name_545, isLocal:Boolean, createStarted:Boolean)
      {
         super();
         this.fullDamageRange = fullDamageRange;
         this.rangeDiscretization = rangeDiscretization;
         this.targetingSystem = targetingSystem;
         this.callback = callback;
         this.isLocal = isLocal;
         this.createStarted = createStarted;
         this.targetToDistance = new Dictionary();
         this.var_459 = new Dictionary();
      }
      
      public function method_383(callback:name_545) : void
      {
         this.callback = callback;
      }
      
      override public function initComponent() : void
      {
         this.turret = class_15(entity.getComponentStrict(class_15));
         this.chassis = name_236(entity.getComponentStrict(name_236));
         this.effects = class_28(entity.getComponentStrict(class_28));
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         if(this.createStarted)
         {
            this.start();
         }
      }
      
      override public function removeFromGame(gameKernel:GameKernel) : void
      {
      }
      
      public function start() : void
      {
         this.effects.start();
         if(this.callback != null)
         {
            this.callback.name_548();
         }
      }
      
      public function stop() : void
      {
         var key:* = undefined;
         this.effects.stop();
         if(this.callback != null)
         {
            this.callback.name_547();
         }
         if(this.isLocal)
         {
            for(key in this.targetToDistance)
            {
               delete this.targetToDistance[key];
            }
         }
      }
      
      public function update() : void
      {
         var key:* = undefined;
         var targetsChanged:Boolean = false;
         var storedDistance:Number = NaN;
         var newDistance:Number = NaN;
         var difference:Number = NaN;
         var tmp:Dictionary = null;
         this.turret.getGunData(BARREL_INDEX,barrelOrigin,gunDirection,gunElevationAxis);
         var barrelLength:Number = Number(this.turret.getBarrelLength(BARREL_INDEX));
         this.targetingSystem.method_433(this.chassis.getBody(),barrelOrigin,barrelLength,0,gunDirection,gunElevationAxis,this.var_459);
         for(key in this.var_459)
         {
            storedDistance = Number(this.targetToDistance[key]);
            if(isNaN(storedDistance))
            {
               targetsChanged = true;
               break;
            }
            newDistance = Number(this.var_459[key]);
            if(storedDistance > this.fullDamageRange || newDistance > this.fullDamageRange)
            {
               difference = newDistance - storedDistance;
               if(difference > this.rangeDiscretization || difference < -this.rangeDiscretization)
               {
                  targetsChanged = true;
                  break;
               }
            }
         }
         if(!targetsChanged)
         {
            for(key in this.targetToDistance)
            {
               if(this.var_459[key] == null)
               {
                  targetsChanged = true;
                  break;
               }
            }
         }
         if(targetsChanged)
         {
            tmp = this.targetToDistance;
            this.targetToDistance = this.var_459;
            this.var_459 = tmp;
            if(this.callback != null)
            {
               this.callback.name_546(this.targetToDistance);
            }
         }
         for(key in this.var_459)
         {
            delete this.var_459[key];
         }
      }
   }
}

