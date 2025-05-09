package alternativa.tanks.game.weapons.targeting
{
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.physics.collision.ICollisionDetector;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.game.physics.CollisionGroup;
   import alternativa.tanks.game.physics.SimpleRaycastFilter;
   import flash.utils.Dictionary;
   
   public class ConicAreaTargetingSystem
   {
      private static const COLLISION_MASK:int = CollisionGroup.WEAPON | CollisionGroup.STATIC;
      
      private var filter:SimpleRaycastFilter = new SimpleRaycastFilter();
      
      private var rayHit:RayHit = new RayHit();
      
      private var range:Number;
      
      private var §_-HN§:Number;
      
      private var numRays:int;
      
      private var numSteps:int;
      
      private var collisionDetector:ICollisionDetector;
      
      private var sideAxis:Vector3 = new Vector3();
      
      private var rayDirection:Vector3 = new Vector3();
      
      private var §_-84§:Vector3 = new Vector3();
      
      private var §_-2z§:Matrix3 = new Matrix3();
      
      private var §_-FX§:Matrix3 = new Matrix3();
      
      private var targetToDistance:Dictionary;
      
      private var targetEvaluator:IGenericTargetEvaluator;
      
      public function ConicAreaTargetingSystem(range:Number, coneAngle:Number, numRays:int, numSteps:int, collisionDetector:ICollisionDetector, targetEvaluator:IGenericTargetEvaluator)
      {
         super();
         this.range = range;
         this.§_-HN§ = 0.5 * coneAngle;
         this.numRays = numRays;
         this.numSteps = numSteps;
         this.collisionDetector = collisionDetector;
         this.targetEvaluator = targetEvaluator;
      }
      
      public function getTargets(shooter:Body, barrelOrigin:Vector3, barrelLength:Number, originOffsetCoeff:Number, gunDirection:Vector3, gunElevationAxis:Vector3, targetToDistance:Dictionary) : void
      {
         var key:* = undefined;
         var body:Body = null;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:int = 0;
         var realDistance:Number = NaN;
         this.filter.body = shooter;
         this.targetToDistance = targetToDistance;
         var originOffset:Number = originOffsetCoeff * barrelLength;
         if(this.collisionDetector.raycast(barrelOrigin,gunDirection,COLLISION_MASK,barrelLength,this.filter,this.rayHit))
         {
            body = this.rayHit.primitive.body;
            if(body != null && this.targetEvaluator.getTargetPriority(shooter,body,0,0) > 0)
            {
               targetToDistance[body] = 0;
            }
         }
         else
         {
            this.sideAxis.copy(gunElevationAxis);
            this.§_-84§.copy(barrelOrigin).addScaled(barrelLength - originOffset,gunDirection);
            _loc11_ = this.range + originOffset;
            this.checkDirection(shooter,this.§_-84§,gunDirection,_loc11_);
            this.§_-FX§.fromAxisAngle(gunDirection,Math.PI / this.numSteps);
            _loc12_ = this.§_-HN§ / this.numRays;
            for(_loc13_ = 0; _loc13_ < this.numSteps; _loc13_++)
            {
               this.processSector(shooter,this.§_-84§,_loc11_,gunDirection,this.sideAxis,this.numRays,_loc12_);
               this.processSector(shooter,this.§_-84§,_loc11_,gunDirection,this.sideAxis,this.numRays,-_loc12_);
               this.sideAxis.transform3(this.§_-FX§);
            }
         }
         for(key in targetToDistance)
         {
            realDistance = targetToDistance[key] - originOffset;
            if(realDistance < 0)
            {
               realDistance = 0;
            }
            targetToDistance[key] = realDistance;
         }
         this.filter.body = null;
         this.targetToDistance = null;
      }
      
      private function processSector(shooter:Body, rayOrigin:Vector3, rayLength:Number, gunDirection:Vector3, rotationAxis:Vector3, numRays:int, angleStep:Number) : void
      {
         this.§_-2z§.fromAxisAngle(rotationAxis,angleStep);
         this.rayDirection.copy(gunDirection);
         for(var i:int = 0; i < numRays; i++)
         {
            this.rayDirection.transform3(this.§_-2z§);
            this.checkDirection(shooter,rayOrigin,this.rayDirection,rayLength);
         }
      }
      
      private function checkDirection(shooter:Body, rayOrigin:Vector3, rayDirection:Vector3, rayLength:Number) : void
      {
         var body:Body = null;
         var realDistance:Number = NaN;
         var storedDistance:Number = NaN;
         if(this.collisionDetector.raycast(rayOrigin,rayDirection,COLLISION_MASK,rayLength,this.filter,this.rayHit))
         {
            body = this.rayHit.primitive.body;
            if(body != null && this.targetEvaluator.getTargetPriority(shooter,body,0,0) > 0)
            {
               realDistance = this.rayHit.t;
               storedDistance = Number(this.targetToDistance[body]);
               if(Boolean(isNaN(storedDistance)) || storedDistance > realDistance)
               {
                  this.targetToDistance[body] = realDistance;
               }
            }
         }
      }
   }
}

