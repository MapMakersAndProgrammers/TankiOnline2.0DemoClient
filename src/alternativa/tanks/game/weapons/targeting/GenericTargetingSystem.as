package alternativa.tanks.game.weapons.targeting
{
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.physics.collision.ICollisionDetector;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.game.physics.CollisionGroup;
   import alternativa.tanks.game.physics.SimpleRaycastFilter;
   import alternativa.tanks.game.weapons.IGenericTargetingSystem;
   
   public class GenericTargetingSystem implements IGenericTargetingSystem
   {
      private static var collisionMask:int = CollisionGroup.STATIC | CollisionGroup.WEAPON;
      
      private static var rayDirection:Vector3 = new Vector3();
      
      private var var_469:Number;
      
      private var var_470:Vector3 = new Vector3();
      
      private var matrix:Matrix3 = new Matrix3();
      
      private var rayHit:RayHit = new RayHit();
      
      private var filter:SimpleRaycastFilter = new SimpleRaycastFilter();
      
      private var angleUp:Number;
      
      private var numRaysUp:int;
      
      private var angleDown:Number;
      
      private var numRaysDown:int;
      
      private var collisionDetector:ICollisionDetector;
      
      private var targetValidator:IGenericTargetEvaluator;
      
      public function GenericTargetingSystem(angleUp:Number, numRaysUp:int, angleDown:Number, numRaysDown:int, collisionDetector:ICollisionDetector, targetValidator:IGenericTargetEvaluator)
      {
         super();
         this.angleUp = angleUp;
         this.numRaysUp = numRaysUp;
         this.angleDown = angleDown;
         this.numRaysDown = numRaysDown;
         this.collisionDetector = collisionDetector;
         this.targetValidator = targetValidator;
      }
      
      public function setTargetValidator(validator:IGenericTargetEvaluator) : void
      {
         this.targetValidator = validator;
      }
      
      public function setCollisionDetector(collisionDetector:ICollisionDetector) : void
      {
         this.collisionDetector = collisionDetector;
      }
      
      public function calculateShotDirection(shooter:Body, muzzlePosition:Vector3, barrelOrigin:Vector3, barrelDirection:Vector3, barrelLength:Number, gunElevationAxis:Vector3, maxDistance:Number, result:Vector3) : void
      {
         var body:Body = null;
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
            this.checkSector(shooter,barrelOrigin,barrelDirection,gunElevationAxis,this.numRaysUp,this.angleUp / this.numRaysUp,maxDistance);
         }
         if(this.numRaysDown > 0)
         {
            this.checkSector(shooter,barrelOrigin,barrelDirection,gunElevationAxis,this.numRaysDown,-this.angleDown / this.numRaysDown,maxDistance);
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
      
      private function checkSector(shooter:Body, origin:Vector3, barrelDirection:Vector3, gunElevationAxis:Vector3, numRays:int, angleStep:Number, maxDistance:Number) : void
      {
         var targetBody:Body = null;
         this.matrix.fromAxisAngle(gunElevationAxis,angleStep);
         rayDirection.copy(barrelDirection);
         for(var i:int = 1; i <= numRays; )
         {
            rayDirection.transform3(this.matrix);
            if(Boolean(this.collisionDetector.raycast(origin,rayDirection,collisionMask,maxDistance,this.filter,this.rayHit)) && this.rayHit.t < this.var_469)
            {
               targetBody = this.rayHit.primitive.body;
               if(targetBody != null && this.targetValidator.getTargetPriority(shooter,targetBody,0,0) > 0)
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

