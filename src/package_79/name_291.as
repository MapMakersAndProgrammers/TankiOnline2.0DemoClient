package package_79
{
   import flash.utils.Dictionary;
   import package_117.name_542;
   import package_120.name_606;
   import package_46.Matrix3;
   import package_46.name_194;
   import package_74.name_524;
   import package_76.name_256;
   import package_86.name_257;
   import package_90.name_273;
   import package_92.name_271;
   
   public class name_291 implements name_524
   {
      private const COLLISION_MASK:int = name_257.WEAPON | name_257.STATIC;
      
      private var collisionDetector:name_256;
      
      private var angleUp:Number;
      
      private var angleDown:Number;
      
      private var numRaysUp:int;
      
      private var numRaysDown:int;
      
      private var var_504:name_606 = new name_606();
      
      private var rayHit:name_273 = new name_273();
      
      private var direction:name_194 = new name_194();
      
      private var rotationMatrix:Matrix3 = new Matrix3();
      
      private var origin:name_194 = new name_194();
      
      private var targetEvaluator:name_542;
      
      public function name_291(angleUp:Number, numRaysUp:int, angleDown:Number, numRaysDown:int, collisionDetector:name_256, targetEvaluator:name_542)
      {
         super();
         this.angleUp = angleUp;
         this.angleDown = angleDown;
         this.numRaysUp = numRaysUp;
         this.numRaysDown = numRaysDown;
         this.collisionDetector = collisionDetector;
         this.targetEvaluator = targetEvaluator;
      }
      
      public function name_527(shooter:name_271, muzzlePosition:name_194, barrelOrigin:name_194, barrelDirection:name_194, barrelLength:Number, gunElevationAxis:name_194, maxDistance:Number, result:name_194) : void
      {
         var centerLineValue:Number = this.method_522(shooter,barrelOrigin,barrelDirection,barrelLength,maxDistance);
         var directionValue:Number = 0;
         directionValue = this.method_523(this.numRaysUp,this.angleUp / this.numRaysUp,directionValue,shooter,barrelOrigin,barrelDirection,barrelLength,gunElevationAxis,maxDistance,result);
         directionValue = this.method_523(this.numRaysDown,-this.angleDown / this.numRaysDown,directionValue,shooter,barrelOrigin,barrelDirection,barrelLength,gunElevationAxis,maxDistance,result);
         if(centerLineValue >= directionValue)
         {
            result.copy(barrelDirection);
         }
      }
      
      private function method_523(numRays:int, angleStep:Number, maxDirectionValue:Number, shooter:name_271, barrelOrigin:name_194, barrelDirection:name_194, barrelLength:Number, gunElevationAxis:name_194, maxDistance:Number, result:name_194) : Number
      {
         var directionValue:Number = NaN;
         this.rotationMatrix.method_344(gunElevationAxis,angleStep);
         this.direction.copy(barrelDirection);
         for(var i:int = 0; i < numRays; )
         {
            this.direction.transform3(this.rotationMatrix);
            directionValue = this.method_522(shooter,barrelOrigin,this.direction,barrelLength,maxDistance);
            if(directionValue > maxDirectionValue)
            {
               maxDirectionValue = directionValue;
               result.copy(this.direction);
            }
            i++;
         }
         return maxDirectionValue;
      }
      
      private function method_522(shooter:name_271, barrelOrigin:name_194, barrelDirection:name_194, barrelLength:Number, maxDistance:Number) : Number
      {
         var body:name_271 = null;
         var distance:Number = NaN;
         var targetValue:Number = NaN;
         var directionValue:Number = 0;
         var firstTarget:Boolean = true;
         this.var_504.name_605 = new Dictionary();
         this.var_504.name_605[shooter] = true;
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
            targetValue = Number(this.targetEvaluator.name_541(body,distance));
            if(firstTarget)
            {
               if(targetValue < 0)
               {
                  break;
               }
               firstTarget = false;
            }
            directionValue += targetValue;
            this.var_504.name_605[body] = true;
            this.origin.copy(this.rayHit.position);
         }
         this.var_504.name_605 = null;
         return directionValue;
      }
   }
}

