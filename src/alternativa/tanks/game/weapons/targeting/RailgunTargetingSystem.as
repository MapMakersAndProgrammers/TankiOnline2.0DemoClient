package alternativa.tanks.game.weapons.targeting
{
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.physics.collision.ICollisionDetector;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.game.physics.CollisionGroup;
   import alternativa.tanks.game.weapons.IGenericTargetingSystem;
   import alternativa.tanks.game.weapons.ammunition.railgun.MultybodyRaycastFilter;
   import alternativa.tanks.game.weapons.railgun.IRailgunTargetEvaluator;
   import flash.utils.Dictionary;
   
   public class RailgunTargetingSystem implements IGenericTargetingSystem
   {
      private const COLLISION_MASK:int = CollisionGroup.WEAPON | CollisionGroup.STATIC;
      
      private var collisionDetector:ICollisionDetector;
      
      private var angleUp:Number;
      
      private var angleDown:Number;
      
      private var numRaysUp:int;
      
      private var numRaysDown:int;
      
      private var var_504:MultybodyRaycastFilter = new MultybodyRaycastFilter();
      
      private var rayHit:RayHit = new RayHit();
      
      private var direction:Vector3 = new Vector3();
      
      private var rotationMatrix:Matrix3 = new Matrix3();
      
      private var origin:Vector3 = new Vector3();
      
      private var targetEvaluator:IRailgunTargetEvaluator;
      
      public function RailgunTargetingSystem(angleUp:Number, numRaysUp:int, angleDown:Number, numRaysDown:int, collisionDetector:ICollisionDetector, targetEvaluator:IRailgunTargetEvaluator)
      {
         super();
         this.angleUp = angleUp;
         this.angleDown = angleDown;
         this.numRaysUp = numRaysUp;
         this.numRaysDown = numRaysDown;
         this.collisionDetector = collisionDetector;
         this.targetEvaluator = targetEvaluator;
      }
      
      public function calculateShotDirection(shooter:Body, muzzlePosition:Vector3, barrelOrigin:Vector3, barrelDirection:Vector3, barrelLength:Number, gunElevationAxis:Vector3, maxDistance:Number, result:Vector3) : void
      {
         var centerLineValue:Number = this.evaluateDirection(shooter,barrelOrigin,barrelDirection,barrelLength,maxDistance);
         var directionValue:Number = 0;
         directionValue = this.evaluateSector(this.numRaysUp,this.angleUp / this.numRaysUp,directionValue,shooter,barrelOrigin,barrelDirection,barrelLength,gunElevationAxis,maxDistance,result);
         directionValue = this.evaluateSector(this.numRaysDown,-this.angleDown / this.numRaysDown,directionValue,shooter,barrelOrigin,barrelDirection,barrelLength,gunElevationAxis,maxDistance,result);
         if(centerLineValue >= directionValue)
         {
            result.copy(barrelDirection);
         }
      }
      
      private function evaluateSector(numRays:int, angleStep:Number, maxDirectionValue:Number, shooter:Body, barrelOrigin:Vector3, barrelDirection:Vector3, barrelLength:Number, gunElevationAxis:Vector3, maxDistance:Number, result:Vector3) : Number
      {
         var directionValue:Number = NaN;
         this.rotationMatrix.fromAxisAngle(gunElevationAxis,angleStep);
         this.direction.copy(barrelDirection);
         for(var i:int = 0; i < numRays; )
         {
            this.direction.transform3(this.rotationMatrix);
            directionValue = this.evaluateDirection(shooter,barrelOrigin,this.direction,barrelLength,maxDistance);
            if(directionValue > maxDirectionValue)
            {
               maxDirectionValue = directionValue;
               result.copy(this.direction);
            }
            i++;
         }
         return maxDirectionValue;
      }
      
      private function evaluateDirection(shooter:Body, barrelOrigin:Vector3, barrelDirection:Vector3, barrelLength:Number, maxDistance:Number) : Number
      {
         var body:Body = null;
         var distance:Number = NaN;
         var targetValue:Number = NaN;
         var directionValue:Number = 0;
         var firstTarget:Boolean = true;
         this.var_504.name_438 = new Dictionary();
         this.var_504.name_438[shooter] = true;
         this.origin.copy(barrelOrigin);
         while(this.collisionDetector.raycast(this.origin,barrelDirection,this.COLLISION_MASK,maxDistance,this.var_504,this.rayHit))
         {
            body = this.rayHit.primitive.body;
            if(body == null)
            {
               break;
            }
            distance = this.rayHit.t - barrelLength;
            if(distance < 0)
            {
               distance = 0;
            }
            targetValue = Number(this.targetEvaluator.getTargetPriority(body,distance));
            if(firstTarget)
            {
               if(targetValue < 0)
               {
                  break;
               }
               firstTarget = false;
            }
            directionValue += targetValue;
            this.var_504.name_438[body] = true;
            this.origin.copy(this.rayHit.position);
         }
         this.var_504.name_438 = null;
         return directionValue;
      }
   }
}

