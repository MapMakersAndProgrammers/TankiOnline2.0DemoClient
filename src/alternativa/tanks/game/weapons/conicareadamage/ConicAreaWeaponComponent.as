package alternativa.tanks.game.weapons.conicareadamage
{
   import alternativa.math.Vector3;
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.entities.tank.physics.IChassisPhysicsComponent;
   import alternativa.tanks.game.entities.tank.physics.ITurretPhysicsComponent;
   import alternativa.tanks.game.weapons.IContinuousActionWeapon;
   import alternativa.tanks.game.weapons.targeting.ConicAreaTargetingSystem;
   import flash.utils.Dictionary;
   
   public class ConicAreaWeaponComponent extends EntityComponent implements IContinuousActionWeapon
   {
      private static var barrelOrigin:Vector3 = new Vector3();
      
      private static var gunDirection:Vector3 = new Vector3();
      
      private static var gunElevationAxis:Vector3 = new Vector3();
      
      private static var BARREL_INDEX:int = 0;
      
      private var turret:ITurretPhysicsComponent;
      
      private var chassis:IChassisPhysicsComponent;
      
      private var targetingSystem:ConicAreaTargetingSystem;
      
      private var effects:IConicAreaWeaponSFX;
      
      private var fullDamageRange:Number;
      
      private var rangeDiscretization:Number;
      
      private var targetToDistance:Dictionary;
      
      private var name_9m:Dictionary;
      
      private var callback:IConicAreaWeaponCallback;
      
      private var isLocal:Boolean;
      
      private var createStarted:Boolean;
      
      public function ConicAreaWeaponComponent(fullDamageRange:Number, rangeDiscretization:Number, targetingSystem:ConicAreaTargetingSystem, callback:IConicAreaWeaponCallback, isLocal:Boolean, createStarted:Boolean)
      {
         super();
         this.fullDamageRange = fullDamageRange;
         this.rangeDiscretization = rangeDiscretization;
         this.targetingSystem = targetingSystem;
         this.callback = callback;
         this.isLocal = isLocal;
         this.createStarted = createStarted;
         this.targetToDistance = new Dictionary();
         this.name_9m = new Dictionary();
      }
      
      public function setCallback(callback:IConicAreaWeaponCallback) : void
      {
         this.callback = callback;
      }
      
      override public function initComponent() : void
      {
         this.turret = ITurretPhysicsComponent(entity.getComponentStrict(ITurretPhysicsComponent));
         this.chassis = IChassisPhysicsComponent(entity.getComponentStrict(IChassisPhysicsComponent));
         this.effects = IConicAreaWeaponSFX(entity.getComponentStrict(IConicAreaWeaponSFX));
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
            this.callback.onConicAreaWeaponStart();
         }
      }
      
      public function stop() : void
      {
         var key:* = undefined;
         this.effects.stop();
         if(this.callback != null)
         {
            this.callback.onConicAreaWeaponStop();
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
         this.targetingSystem.getTargets(this.chassis.getBody(),barrelOrigin,barrelLength,0,gunDirection,gunElevationAxis,this.name_9m);
         for(key in this.name_9m)
         {
            storedDistance = Number(this.targetToDistance[key]);
            if(isNaN(storedDistance))
            {
               targetsChanged = true;
               break;
            }
            newDistance = Number(this.name_9m[key]);
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
               if(this.name_9m[key] == null)
               {
                  targetsChanged = true;
                  break;
               }
            }
         }
         if(targetsChanged)
         {
            tmp = this.targetToDistance;
            this.targetToDistance = this.name_9m;
            this.name_9m = tmp;
            if(this.callback != null)
            {
               this.callback.onConicAreaWeaponTargetSetChange(this.targetToDistance);
            }
         }
         for(key in this.name_9m)
         {
            delete this.name_9m[key];
         }
      }
   }
}

