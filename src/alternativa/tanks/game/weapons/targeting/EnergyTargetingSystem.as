package alternativa.tanks.game.weapons.targeting
{
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.physics.collision.ICollisionDetector;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.game.physics.CollisionGroup;
   import alternativa.tanks.game.physics.SimpleRaycastFilter;
   
   public class EnergyTargetingSystem implements IEnergyTargetingSystem
   {
      private static const RICOCHET_NORMAL_OFFSET:Number = 0.01;
      
      private static var COLLISION_MASK:int = CollisionGroup.STATIC | CollisionGroup.WEAPON;
      
      private static var direction:Vector3 = new Vector3();
      
      private static var currDirection:Vector3 = new Vector3();
      
      private static var currOrigin:Vector3 = new Vector3();
      
      private var angleUp:Number;
      
      private var numRaysUp:int;
      
      private var angleDown:Number;
      
      private var numRaysDown:int;
      
      private var collisionDetector:ICollisionDetector;
      
      private var maxRicochets:int;
      
      private var targetEvaluator:IGenericTargetEvaluator;
      
      private var rayHit:RayHit = new RayHit();
      
      private var filter:SimpleRaycastFilter = new SimpleRaycastFilter();
      
      private var matrix:Matrix3 = new Matrix3();
      
      private var var_509:Number;
      
      public function EnergyTargetingSystem(angleUp:Number, numRaysUp:int, angleDown:Number, numRaysDown:int, maxRicochets:int, collisionDetector:ICollisionDetector, targetValidator:IGenericTargetEvaluator)
      {
         super();
         this.angleUp = angleUp;
         this.numRaysUp = numRaysUp;
         this.angleDown = angleDown;
         this.numRaysDown = numRaysDown;
         this.maxRicochets = maxRicochets;
         this.collisionDetector = collisionDetector;
         this.targetEvaluator = targetValidator;
      }
      
      public function setCollisionDetector(collisionDetector:ICollisionDetector) : void
      {
         this.collisionDetector = collisionDetector;
      }
      
      public function setTargetValidator(validator:IGenericTargetEvaluator) : void
      {
         this.targetEvaluator = validator;
      }
      
      public function getShotDirection(shooter:Body, muzzlePosition:Vector3, barrelDirection:Vector3, gunElevationAxis:Vector3, maxDistance:Number, result:Vector3) : void
      {
         this.var_509 = 0;
         this.checkDirection(shooter,muzzlePosition,barrelDirection,maxDistance,0,result);
         this.checkSector(shooter,muzzlePosition,barrelDirection,gunElevationAxis,maxDistance,this.angleUp / this.numRaysUp,this.numRaysUp,result);
         this.checkSector(shooter,muzzlePosition,barrelDirection,gunElevationAxis,maxDistance,-this.angleDown / this.numRaysDown,this.numRaysDown,result);
         this.filter.body = null;
         if(this.var_509 == 0)
         {
            result.copy(barrelDirection);
         }
      }
      
      private function checkDirection(shooter:Body, origin:Vector3, direction:Vector3, maxDistance:Number, angle:Number, result:Vector3) : void
      {
         var body:Body = null;
         var distance:Number = NaN;
         var targetPriority:Number = NaN;
         var _loc12_:Vector3 = null;
         var remainingDistance:Number = maxDistance;
         currOrigin.copy(origin);
         currDirection.copy(direction);
         this.filter.body = shooter;
         for(var ricochetCount:int = 0; remainingDistance > 0; )
         {
            if(!this.collisionDetector.raycast(currOrigin,currDirection,COLLISION_MASK,remainingDistance,this.filter,this.rayHit))
            {
               return;
            }
            remainingDistance -= this.rayHit.t;
            if(remainingDistance < 0)
            {
               remainingDistance = 0;
            }
            body = this.rayHit.primitive.body;
            if(body != null)
            {
               distance = maxDistance - remainingDistance;
               targetPriority = Number(this.targetEvaluator.getTargetPriority(shooter,body,distance,angle));
               if(targetPriority > this.var_509)
               {
                  this.var_509 = targetPriority;
                  result.copy(direction);
               }
               return;
            }
            ricochetCount++;
            if(ricochetCount > this.maxRicochets)
            {
               return;
            }
            this.filter.body = null;
            _loc12_ = this.rayHit.normal;
            currDirection.addScaled(-2 * currDirection.dot(_loc12_),_loc12_);
            currOrigin.copy(this.rayHit.position).addScaled(RICOCHET_NORMAL_OFFSET,_loc12_);
         }
      }
      
      private function checkSector(shooter:Body, origin:Vector3, gunDirection:Vector3, gunElevationAxis:Vector3, maxDistance:Number, angleStep:Number, numRays:int, result:Vector3) : void
      {
         direction.copy(gunDirection);
         this.matrix.fromAxisAngle(gunElevationAxis,angleStep);
         if(angleStep < 0)
         {
            angleStep = -angleStep;
         }
         var angle:Number = angleStep;
         for(var i:int = 0; i < numRays; i++,angle += angleStep)
         {
            direction.transform3(this.matrix);
            this.checkDirection(shooter,origin,direction,maxDistance,angle,result);
         }
      }
   }
}

