package package_79
{
   import flash.utils.Dictionary;
   import package_46.Matrix3;
   import package_46.name_194;
   import package_76.name_256;
   import package_86.name_257;
   import package_86.name_540;
   import package_90.name_273;
   import package_92.name_271;
   
   public class name_282
   {
      private static const COLLISION_MASK:int = name_257.WEAPON | name_257.STATIC;
      
      private var filter:name_540 = new name_540();
      
      private var rayHit:name_273 = new name_273();
      
      private var range:Number;
      
      private var var_452:Number;
      
      private var numRays:int;
      
      private var numSteps:int;
      
      private var collisionDetector:name_256;
      
      private var sideAxis:name_194 = new name_194();
      
      private var rayDirection:name_194 = new name_194();
      
      private var var_449:name_194 = new name_194();
      
      private var var_450:Matrix3 = new Matrix3();
      
      private var var_451:Matrix3 = new Matrix3();
      
      private var targetToDistance:Dictionary;
      
      private var targetEvaluator:name_326;
      
      public function name_282(range:Number, coneAngle:Number, numRays:int, numSteps:int, collisionDetector:name_256, targetEvaluator:name_326)
      {
         super();
         this.range = range;
         this.var_452 = 0.5 * coneAngle;
         this.numRays = numRays;
         this.numSteps = numSteps;
         this.collisionDetector = collisionDetector;
         this.targetEvaluator = targetEvaluator;
      }
      
      public function method_433(shooter:name_271, barrelOrigin:name_194, barrelLength:Number, originOffsetCoeff:Number, gunDirection:name_194, gunElevationAxis:name_194, targetToDistance:Dictionary) : void
      {
         var key:* = undefined;
         var body:name_271 = null;
         var actualRange:Number = NaN;
         var angleStep:Number = NaN;
         var i:int = 0;
         var realDistance:Number = NaN;
         this.filter.body = shooter;
         this.targetToDistance = targetToDistance;
         var originOffset:Number = originOffsetCoeff * barrelLength;
         if(this.collisionDetector.raycast(barrelOrigin,gunDirection,COLLISION_MASK,barrelLength,this.filter,this.rayHit))
         {
            body = this.rayHit.primitive.body;
            if(body != null && this.targetEvaluator.name_541(shooter,body,0,0) > 0)
            {
               targetToDistance[body] = 0;
            }
         }
         else
         {
            this.sideAxis.copy(gunElevationAxis);
            this.var_449.copy(barrelOrigin).method_362(barrelLength - originOffset,gunDirection);
            actualRange = this.range + originOffset;
            this.method_431(shooter,this.var_449,gunDirection,actualRange);
            this.var_451.method_344(gunDirection,Math.PI / this.numSteps);
            angleStep = this.var_452 / this.numRays;
            for(i = 0; i < this.numSteps; i++)
            {
               this.method_432(shooter,this.var_449,actualRange,gunDirection,this.sideAxis,this.numRays,angleStep);
               this.method_432(shooter,this.var_449,actualRange,gunDirection,this.sideAxis,this.numRays,-angleStep);
               this.sideAxis.transform3(this.var_451);
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
      
      private function method_432(shooter:name_271, rayOrigin:name_194, rayLength:Number, gunDirection:name_194, rotationAxis:name_194, numRays:int, angleStep:Number) : void
      {
         this.var_450.method_344(rotationAxis,angleStep);
         this.rayDirection.copy(gunDirection);
         for(var i:int = 0; i < numRays; i++)
         {
            this.rayDirection.transform3(this.var_450);
            this.method_431(shooter,rayOrigin,this.rayDirection,rayLength);
         }
      }
      
      private function method_431(shooter:name_271, rayOrigin:name_194, rayDirection:name_194, rayLength:Number) : void
      {
         var body:name_271 = null;
         var realDistance:Number = NaN;
         var storedDistance:Number = NaN;
         if(this.collisionDetector.raycast(rayOrigin,rayDirection,COLLISION_MASK,rayLength,this.filter,this.rayHit))
         {
            body = this.rayHit.primitive.body;
            if(body != null && this.targetEvaluator.name_541(shooter,body,0,0) > 0)
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

