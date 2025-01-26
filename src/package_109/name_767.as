package package_109
{
   import package_46.name_194;
   import package_76.name_235;
   import package_90.name_386;
   
   public class name_767 extends name_235
   {
      public var r:Number = 0;
      
      public function name_767(r:Number, collisionGroup:int, collisionMask:int)
      {
         super(SPHERE,collisionGroup,collisionMask);
         this.r = r;
      }
      
      override public function calculateAABB() : name_386
      {
         aabb.maxX = transform.d + this.r;
         aabb.minX = transform.d - this.r;
         aabb.maxY = transform.h + this.r;
         aabb.minY = transform.h - this.r;
         aabb.maxZ = transform.l + this.r;
         aabb.minZ = transform.l - this.r;
         return aabb;
      }
      
      override public function raycast(origin:name_194, vector:name_194, threshold:Number, normal:name_194) : Number
      {
         var px:Number = origin.x - transform.d;
         var py:Number = origin.y - transform.h;
         var pz:Number = origin.z - transform.l;
         var k:Number = vector.x * px + vector.y * py + vector.z * pz;
         if(k > 0)
         {
            return -1;
         }
         var a:Number = vector.x * vector.x + vector.y * vector.y + vector.z * vector.z;
         var D:Number = k * k - a * (px * px + py * py + pz * pz - this.r * this.r);
         if(D < 0)
         {
            return -1;
         }
         return -(k + Math.sqrt(D)) / a;
      }
      
      override public function copyFrom(source:name_235) : name_235
      {
         var sphere:name_767 = source as name_767;
         if(sphere == null)
         {
            return this;
         }
         super.copyFrom(sphere);
         this.r = sphere.r;
         return this;
      }
      
      override protected function createPrimitive() : name_235
      {
         return new name_767(this.r,collisionGroup,collisionMask);
      }
   }
}

