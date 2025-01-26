package package_79
{
   import package_46.Matrix3;
   import package_46.name_194;
   import package_76.name_256;
   import package_86.name_257;
   import package_86.name_540;
   import package_90.name_273;
   import package_92.name_271;
   
   public class name_280 implements name_622
   {
      private static const RICOCHET_NORMAL_OFFSET:Number = 0.01;
      
      private static var COLLISION_MASK:int = name_257.STATIC | name_257.WEAPON;
      
      private static var direction:name_194 = new name_194();
      
      private static var currDirection:name_194 = new name_194();
      
      private static var currOrigin:name_194 = new name_194();
      
      private var angleUp:Number;
      
      private var numRaysUp:int;
      
      private var angleDown:Number;
      
      private var numRaysDown:int;
      
      private var collisionDetector:name_256;
      
      private var maxRicochets:int;
      
      private var targetEvaluator:name_326;
      
      private var rayHit:name_273 = new name_273();
      
      private var filter:name_540 = new name_540();
      
      private var matrix:Matrix3 = new Matrix3();
      
      private var var_509:Number;
      
      public function name_280(angleUp:Number, numRaysUp:int, angleDown:Number, numRaysDown:int, maxRicochets:int, collisionDetector:name_256, targetValidator:name_326)
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
      
      public function name_310(collisionDetector:name_256) : void
      {
         this.collisionDetector = collisionDetector;
      }
      
      public function name_303(validator:name_326) : void
      {
         this.targetEvaluator = validator;
      }
      
      public function name_624(shooter:name_271, muzzlePosition:name_194, barrelDirection:name_194, gunElevationAxis:name_194, maxDistance:Number, result:name_194) : void
      {
         this.var_509 = 0;
         this.method_431(shooter,muzzlePosition,barrelDirection,maxDistance,0,result);
         this.method_466(shooter,muzzlePosition,barrelDirection,gunElevationAxis,maxDistance,this.angleUp / this.numRaysUp,this.numRaysUp,result);
         this.method_466(shooter,muzzlePosition,barrelDirection,gunElevationAxis,maxDistance,-this.angleDown / this.numRaysDown,this.numRaysDown,result);
         this.filter.body = null;
         if(this.var_509 == 0)
         {
            result.copy(barrelDirection);
         }
      }
      
      private function method_431(shooter:name_271, origin:name_194, direction:name_194, maxDistance:Number, angle:Number, result:name_194) : void
      {
         var body:name_271 = null;
         var distance:Number = NaN;
         var targetPriority:Number = NaN;
         var normal:name_194 = null;
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
               targetPriority = Number(this.targetEvaluator.name_541(shooter,body,distance,angle));
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
            normal = this.rayHit.normal;
            currDirection.method_362(-2 * currDirection.dot(normal),normal);
            currOrigin.copy(this.rayHit.position).method_362(RICOCHET_NORMAL_OFFSET,normal);
         }
      }
      
      private function method_466(shooter:name_271, origin:name_194, gunDirection:name_194, gunElevationAxis:name_194, maxDistance:Number, angleStep:Number, numRays:int, result:name_194) : void
      {
         direction.copy(gunDirection);
         this.matrix.method_344(gunElevationAxis,angleStep);
         if(angleStep < 0)
         {
            angleStep = -angleStep;
         }
         var angle:Number = angleStep;
         for(var i:int = 0; i < numRays; i++,angle += angleStep)
         {
            direction.transform3(this.matrix);
            this.method_431(shooter,origin,direction,maxDistance,angle,result);
         }
      }
   }
}

