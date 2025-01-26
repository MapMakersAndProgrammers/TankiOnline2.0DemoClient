package package_76
{
   import package_46.Matrix4;
   import package_46.name_194;
   import package_90.name_386;
   import package_92.name_271;
   
   public class name_235
   {
      public static const BOX:int = 1;
      
      public static const PLANE:int = 2;
      
      public static const SPHERE:int = 4;
      
      public static const RECT:int = 8;
      
      public static const TRIANGLE:int = 16;
      
      public var type:int;
      
      public var collisionGroup:int;
      
      public var collisionMask:int;
      
      public var postCollisionFilter:name_485;
      
      public var body:name_271;
      
      public var localTransform:Matrix4;
      
      public var transform:Matrix4 = new Matrix4();
      
      public var aabb:name_386 = new name_386();
      
      public var timestamp:int;
      
      public function name_235(type:int, collisionGroup:int, collisionMask:int)
      {
         super();
         this.type = type;
         this.collisionGroup = collisionGroup;
         this.collisionMask = collisionMask;
      }
      
      public function method_373(body:name_271, localTransform:Matrix4 = null) : void
      {
         if(this.body == body)
         {
            return;
         }
         this.body = body;
         if(body != null)
         {
            if(localTransform != null)
            {
               if(this.localTransform == null)
               {
                  this.localTransform = new Matrix4();
               }
               this.localTransform.copy(localTransform);
            }
            else
            {
               this.localTransform = null;
            }
         }
      }
      
      public function calculateAABB() : name_386
      {
         return this.aabb;
      }
      
      public function raycast(origin:name_194, vector:name_194, epsilon:Number, normal:name_194) : Number
      {
         return -1;
      }
      
      public function clone() : name_235
      {
         var p:name_235 = this.createPrimitive();
         return p.copyFrom(this);
      }
      
      public function copyFrom(source:name_235) : name_235
      {
         if(source == null)
         {
            throw new ArgumentError("Parameter source cannot be null");
         }
         this.type = source.type;
         this.transform.copy(source.transform);
         this.collisionGroup = source.collisionGroup;
         this.method_373(source.body,source.localTransform);
         this.aabb.copyFrom(source.aabb);
         return this;
      }
      
      public function toString() : String
      {
         return "[CollisionPrimitive type=" + this.type + "]";
      }
      
      protected function createPrimitive() : name_235
      {
         return new name_235(this.type,this.collisionGroup,this.collisionMask);
      }
   }
}

