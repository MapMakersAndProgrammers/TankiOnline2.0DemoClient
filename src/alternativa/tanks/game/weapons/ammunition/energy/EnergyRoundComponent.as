package alternativa.tanks.game.weapons.ammunition.energy
{
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.physics.collision.CollisionPrimitive;
   import alternativa.physics.collision.ICollisionDetector;
   import alternativa.physics.collision.IRaycastFilter;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.physics.CollisionGroup;
   import alternativa.tanks.game.subsystems.physicssystem.IPhysicsController;
   import alternativa.tanks.game.subsystems.physicssystem.PhysicsSystem;
   import alternativa.tanks.game.subsystems.timesystem.TimeSystem;
   import alternativa.tanks.game.utils.GameMathUtils;
   import alternativa.tanks.game.weapons.EnergyShotType;
   import alternativa.tanks.game.weapons.IGenericRound;
   
   public class EnergyRoundComponent extends EntityComponent implements IPhysicsController, IGenericRound, IRaycastFilter
   {
      private static const NUM_PERIPHERAL_RAYS:int = 8;
      
      private static const RADIAL_ANGLE_STEP:Number = 2 * Math.PI / NUM_PERIPHERAL_RAYS;
      
      private static var rayHit:RayHit = new RayHit();
      
      private static var _rotationMatrix:Matrix3 = new Matrix3();
      
      private static var _vector:Vector3 = new Vector3();
      
      private static var _normal:Vector3 = new Vector3();
      
      private var gameKernel:GameKernel;
      
      private var name_oF:Vector3 = new Vector3();
      
      private var name_hV:Vector3 = new Vector3();
      
      private var direction:Vector3 = new Vector3();
      
      private var name_PL:Number;
      
      private var shotId:int;
      
      private var shooter:Body;
      
      private var collisionDetector:ICollisionDetector;
      
      private var callback:IEnergyRoundCallback;
      
      private var roundData:EnergyRoundData;
      
      private var maxRange:Number;
      
      private var effect:IEnergyRoundEffect;
      
      private var shotType:EnergyShotType;
      
      private var ricochetCount:int;
      
      private var name_LC:Vector.<Vector3>;
      
      private var effectsFactory:IEnergyRoundEffectsFactory;
      
      public function EnergyRoundComponent()
      {
         super();
         this.name_LC = new Vector.<Vector3>(NUM_PERIPHERAL_RAYS);
         for(var i:int = 0; i < NUM_PERIPHERAL_RAYS; i++)
         {
            this.name_LC[i] = new Vector3();
         }
      }
      
      public function init(shotType:EnergyShotType, roundData:EnergyRoundData, maxRange:Number, effectsFactory:IEnergyRoundEffectsFactory, callback:IEnergyRoundCallback) : void
      {
         this.shotType = shotType;
         this.roundData = roundData;
         this.maxRange = maxRange;
         this.callback = callback;
         this.effectsFactory = effectsFactory;
         this.ricochetCount = 0;
      }
      
      override public function initComponent() : void
      {
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         this.gameKernel = gameKernel;
         var physicsSystem:PhysicsSystem = gameKernel.getPhysicsSystem();
         this.collisionDetector = physicsSystem.getPhysicsScene().collisionDetector;
         physicsSystem.addControllerBefore(this);
         if(this.shotType == EnergyShotType.NORMAL_SHOT)
         {
            physicsSystem.addInterpolationController(this);
            this.effect = this.effectsFactory.createEnergyRoundEffect();
         }
      }
      
      override public function removeFromGame(gameKernel:GameKernel) : void
      {
         var physicsSystem:PhysicsSystem = gameKernel.getPhysicsSystem();
         physicsSystem.removeControllerBefore(this);
         this.gameKernel = null;
         this.roundData = null;
         this.effectsFactory = null;
         this.shooter = null;
         this.collisionDetector = null;
         if(this.effect != null)
         {
            physicsSystem.removeInterpolationController(this);
            this.effect.kill();
            this.effect = null;
         }
         EnergyAmmunitionComponent.destroyRound(entity);
      }
      
      public function acceptRayHit(primitive:CollisionPrimitive) : Boolean
      {
         return primitive.body != this.shooter;
      }
      
      public function updateBeforeSimulation(physicsStep:int) : void
      {
         var i:int = 0;
         var raycastResult:int = 0;
         var filter:IRaycastFilter = null;
         var hitTime:Number = NaN;
         var body:Body = null;
         var origin:Vector3 = null;
         var impactForce:Number = NaN;
         var deltaDistance:Number = this.roundData.speed * TimeSystem.timeDeltaSeconds;
         for(var frameDistance:Number = 0; deltaDistance > GameMathUtils.EPSILON; )
         {
            raycastResult = 0;
            filter = this.ricochetCount == 0 ? this : null;
            hitTime = deltaDistance + 1;
            body = null;
            if(this.collisionDetector.raycast(this.name_hV,this.direction,CollisionGroup.WEAPON | CollisionGroup.STATIC,deltaDistance,filter,rayHit))
            {
               raycastResult = 1;
               hitTime = rayHit.t;
               body = rayHit.primitive.body;
               _normal.copy(rayHit.normal);
            }
            for(i = 0; i < NUM_PERIPHERAL_RAYS; )
            {
               origin = this.name_LC[i];
               if(this.collisionDetector.raycast(origin,this.direction,CollisionGroup.WEAPON,deltaDistance,filter,rayHit))
               {
                  if(rayHit.t < hitTime)
                  {
                     raycastResult = 2;
                     hitTime = rayHit.t;
                     body = rayHit.primitive.body;
                     _normal.copy(rayHit.normal);
                  }
               }
               i++;
            }
            if(raycastResult <= 0)
            {
               this.name_PL += deltaDistance;
               if(this.name_PL > this.maxRange)
               {
                  this.gameKernel.removeEntity(entity);
               }
               else
               {
                  this.name_oF.copy(this.name_hV);
                  _vector.copy(this.direction).scale(deltaDistance);
                  this.name_hV.add(_vector);
                  for(i = 0; i < NUM_PERIPHERAL_RAYS; i++)
                  {
                     Vector3(this.name_LC[i]).add(_vector);
                  }
               }
               return;
            }
            this.name_PL += hitTime;
            if(this.name_PL >= this.maxRange)
            {
               this.gameKernel.removeEntity(entity);
               return;
            }
            if(!(raycastResult == 1 && this.ricochetCount < this.roundData.maxRicochets && body == null))
            {
               this.effectsFactory.createExplosionEffects(rayHit.position);
               if(body != null)
               {
                  impactForce = this.roundData.weakening.getWeakeningCoefficient(this.name_PL) * this.roundData.impactForce;
                  body.addWorldForceScaled(rayHit.position,this.direction,impactForce);
                  if(this.callback != null)
                  {
                     this.callback.onEnergyRoundHit(this.shotId,rayHit.position,this.name_PL,body);
                  }
               }
               this.gameKernel.removeEntity(entity);
               return;
            }
            ++this.ricochetCount;
            frameDistance += hitTime;
            this.name_PL += hitTime;
            deltaDistance -= hitTime;
            _vector.copy(this.name_hV).addScaled(hitTime,this.direction);
            this.effectsFactory.createRicochetEffects(_vector,_normal,this.direction);
            this.name_hV.addScaled(hitTime,this.direction).addScaled(0.01,_normal);
            this.direction.addScaled(-2 * this.direction.dot(_normal),_normal);
            this.name_oF.copy(this.name_hV).addScaled(-frameDistance,this.direction);
            this.initRadialPoints(this.name_hV,this.direction,this.roundData.radius);
         }
      }
      
      public function updateAfterSimulation(physicsStep:int) : void
      {
      }
      
      public function interpolate(interpolationCoeff:Number) : void
      {
         _vector.diff(this.name_hV,this.name_oF).scale(interpolationCoeff).add(this.name_oF);
         this.effect.setPosition(_vector);
      }
      
      public function shoot(gameKernel:GameKernel, shotId:int, shooter:Body, barrelOrigin:Vector3, barrelLength:Number, shotDirection:Vector3, muzzlePosition:Vector3) : void
      {
         this.shotId = shotId;
         this.shooter = shooter;
         this.direction.copy(shotDirection);
         this.name_PL = 0;
         switch(this.shotType)
         {
            case EnergyShotType.CLOSE_SHOT:
               this.name_hV.copy(barrelOrigin);
               break;
            case EnergyShotType.NORMAL_SHOT:
               this.name_hV.copy(muzzlePosition);
         }
         this.initRadialPoints(this.name_hV,shotDirection,this.roundData.radius);
         gameKernel.addEntity(entity);
      }
      
      private function initRadialPoints(centerPoint:Vector3, shotDirection:Vector3, radius:Number) : void
      {
         var axis:int = 0;
         var min:Number = 10;
         var d:Number = shotDirection.x < 0 ? -shotDirection.x : shotDirection.x;
         if(d < min)
         {
            min = d;
            axis = 0;
         }
         d = shotDirection.y < 0 ? -shotDirection.y : shotDirection.y;
         if(d < min)
         {
            min = d;
            axis = 1;
         }
         d = shotDirection.z < 0 ? -shotDirection.z : shotDirection.z;
         if(d < min)
         {
            axis = 2;
         }
         var v:Vector3 = new Vector3();
         switch(axis)
         {
            case 0:
               v.x = 0;
               v.y = shotDirection.z;
               v.z = -shotDirection.y;
               break;
            case 1:
               v.x = -shotDirection.z;
               v.y = 0;
               v.z = shotDirection.x;
               break;
            case 2:
               v.x = shotDirection.y;
               v.y = -shotDirection.x;
               v.z = 0;
         }
         v.normalize().scale(radius);
         _rotationMatrix.fromAxisAngle(shotDirection,RADIAL_ANGLE_STEP);
         Vector3(this.name_LC[0]).copy(centerPoint).add(v);
         for(var i:int = 1; i < NUM_PERIPHERAL_RAYS; i++)
         {
            v.transform3(_rotationMatrix);
            Vector3(this.name_LC[i]).copy(centerPoint).add(v);
         }
      }
   }
}

