package package_79
{
   import package_46.Matrix3;
   import package_46.name_194;
   import package_74.name_524;
   import package_76.name_256;
   import package_86.name_257;
   import package_86.name_540;
   import package_90.name_273;
   import package_92.name_271;
   
   public class name_261 implements name_524
   {
      private static var collisionMask:int = name_257.STATIC | name_257.WEAPON;
      
      private static var rayDirection:name_194 = new name_194();
      
      private var var_469:Number;
      
      private var var_470:name_194 = new name_194();
      
      private var matrix:Matrix3 = new Matrix3();
      
      private var rayHit:name_273 = new name_273();
      
      private var filter:name_540 = new name_540();
      
      private var angleUp:Number;
      
      private var numRaysUp:int;
      
      private var angleDown:Number;
      
      private var numRaysDown:int;
      
      private var collisionDetector:name_256;
      
      private var targetValidator:name_326;
      
      public function name_261(angleUp:Number, numRaysUp:int, angleDown:Number, numRaysDown:int, collisionDetector:name_256, targetValidator:name_326)
      {
         super();
         this.angleUp = angleUp;
         this.numRaysUp = numRaysUp;
         this.angleDown = angleDown;
         this.numRaysDown = numRaysDown;
         this.collisionDetector = collisionDetector;
         this.targetValidator = targetValidator;
      }
      
      public function name_303(validator:name_326) : void
      {
         this.targetValidator = validator;
      }
      
      public function name_310(collisionDetector:name_256) : void
      {
         this.collisionDetector = collisionDetector;
      }
      
      public function name_527(shooter:name_271, muzzlePosition:name_194, barrelOrigin:name_194, barrelDirection:name_194, barrelLength:Number, gunElevationAxis:name_194, maxDistance:Number, result:name_194) : void
      {
         var body:name_271 = null;
         this.filter.body = shooter;
         this.var_469 = maxDistance + 1;
         if(this.collisionDetector.raycast(barrelOrigin,barrelDirection,collisionMask,maxDistance,this.filter,this.rayHit))
         {
            this.var_469 = this.rayHit.t;
            body = this.rayHit.primitive.body;
            if(body == null)
            {
               if(this.rayHit.t < barrelLength)
               {
                  result.copy(barrelDirection);
                  return;
               }
            }
            this.var_470.copy(barrelDirection);
         }
         if(this.numRaysUp > 0)
         {
            this.method_466(shooter,barrelOrigin,barrelDirection,gunElevationAxis,this.numRaysUp,this.angleUp / this.numRaysUp,maxDistance);
         }
         if(this.numRaysDown > 0)
         {
            this.method_466(shooter,barrelOrigin,barrelDirection,gunElevationAxis,this.numRaysDown,-this.angleDown / this.numRaysDown,maxDistance);
         }
         this.filter.body = null;
         if(this.var_469 > maxDistance)
         {
            result.copy(barrelDirection);
         }
         else
         {
            result.copy(this.var_470);
         }
      }
      
      private function method_466(shooter:name_271, origin:name_194, barrelDirection:name_194, gunElevationAxis:name_194, numRays:int, angleStep:Number, maxDistance:Number) : void
      {
         var targetBody:name_271 = null;
         this.matrix.method_344(gunElevationAxis,angleStep);
         rayDirection.copy(barrelDirection);
         for(var i:int = 1; i <= numRays; )
         {
            rayDirection.transform3(this.matrix);
            if(Boolean(this.collisionDetector.raycast(origin,rayDirection,collisionMask,maxDistance,this.filter,this.rayHit)) && this.rayHit.t < this.var_469)
            {
               targetBody = this.rayHit.primitive.body;
               if(targetBody != null && this.targetValidator.name_541(shooter,targetBody,0,0) > 0)
               {
                  this.var_469 = this.rayHit.t;
                  this.var_470.copy(rayDirection);
               }
            }
            i++;
         }
      }
   }
}

