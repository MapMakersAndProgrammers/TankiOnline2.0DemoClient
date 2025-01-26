package package_109
{
   import package_46.name_194;
   import package_76.name_235;
   import package_90.name_386;
   
   public class name_378 extends name_235
   {
      public var v0:name_194 = new name_194();
      
      public var v1:name_194 = new name_194();
      
      public var v2:name_194 = new name_194();
      
      public var e0:name_194 = new name_194();
      
      public var e1:name_194 = new name_194();
      
      public var e2:name_194 = new name_194();
      
      public function name_378(v0:name_194, v1:name_194, v2:name_194, collisionGroup:int, collisionMask:int)
      {
         super(TRIANGLE,collisionGroup,collisionMask);
         this.method_630(v0,v1,v2);
      }
      
      override public function calculateAABB() : name_386
      {
         var a:Number = NaN;
         var b:Number = NaN;
         var aa:int = 0;
         var eps_c:Number = 0.005 * transform.c;
         var eps_g:Number = 0.005 * transform.g;
         var eps_k:Number = 0.005 * transform.k;
         a = this.v0.x * transform.a + this.v0.y * transform.b;
         aabb.minX = aabb.maxX = a + eps_c;
         b = a - eps_c;
         if(b > aabb.maxX)
         {
            aabb.maxX = b;
         }
         else if(b < aabb.minX)
         {
            aabb.minX = b;
         }
         a = this.v0.x * transform.e + this.v0.y * transform.f;
         aabb.minY = aabb.maxY = a + eps_g;
         b = a - eps_g;
         if(b > aabb.maxY)
         {
            aabb.maxY = b;
         }
         else if(b < aabb.minY)
         {
            aabb.minY = b;
         }
         a = this.v0.x * transform.i + this.v0.y * transform.j;
         aabb.minZ = aabb.maxZ = a + eps_k;
         b = a - eps_k;
         if(b > aabb.maxZ)
         {
            aabb.maxZ = b;
         }
         else if(b < aabb.minZ)
         {
            aabb.minZ = b;
         }
         a = this.v1.x * transform.a + this.v1.y * transform.b;
         b = a + eps_c;
         if(b > aabb.maxX)
         {
            aabb.maxX = b;
         }
         else if(b < aabb.minX)
         {
            aabb.minX = b;
         }
         b = a - eps_c;
         if(b > aabb.maxX)
         {
            aabb.maxX = b;
         }
         else if(b < aabb.minX)
         {
            aabb.minX = b;
         }
         a = this.v1.x * transform.e + this.v1.y * transform.f;
         b = a + eps_g;
         if(b > aabb.maxY)
         {
            aabb.maxY = b;
         }
         else if(b < aabb.minY)
         {
            aabb.minY = b;
         }
         b = a - eps_g;
         if(b > aabb.maxY)
         {
            aabb.maxY = b;
         }
         else if(b < aabb.minY)
         {
            aabb.minY = b;
         }
         a = this.v1.x * transform.i + this.v1.y * transform.j;
         b = a + eps_k;
         if(b > aabb.maxZ)
         {
            aabb.maxZ = b;
         }
         else if(b < aabb.minZ)
         {
            aabb.minZ = b;
         }
         b = a - eps_k;
         if(b > aabb.maxZ)
         {
            aabb.maxZ = b;
         }
         else if(b < aabb.minZ)
         {
            aabb.minZ = b;
         }
         a = this.v2.x * transform.a + this.v2.y * transform.b;
         b = a + eps_c;
         if(b > aabb.maxX)
         {
            aabb.maxX = b;
         }
         else if(b < aabb.minX)
         {
            aabb.minX = b;
         }
         b = a - eps_c;
         if(b > aabb.maxX)
         {
            aabb.maxX = b;
         }
         else if(b < aabb.minX)
         {
            aabb.minX = b;
         }
         a = this.v2.x * transform.e + this.v2.y * transform.f;
         b = a + eps_g;
         if(b > aabb.maxY)
         {
            aabb.maxY = b;
         }
         else if(b < aabb.minY)
         {
            aabb.minY = b;
         }
         b = a - eps_g;
         if(b > aabb.maxY)
         {
            aabb.maxY = b;
         }
         else if(b < aabb.minY)
         {
            aabb.minY = b;
         }
         a = this.v2.x * transform.i + this.v2.y * transform.j;
         b = a + eps_k;
         if(b > aabb.maxZ)
         {
            aabb.maxZ = b;
         }
         else if(b < aabb.minZ)
         {
            aabb.minZ = b;
         }
         b = a - eps_k;
         if(b > aabb.maxZ)
         {
            aabb.maxZ = b;
         }
         else if(b < aabb.minZ)
         {
            aabb.minZ = b;
         }
         aabb.minX += transform.d;
         aabb.maxX += transform.d;
         aabb.minY += transform.h;
         aabb.maxY += transform.h;
         aabb.minZ += transform.l;
         aabb.maxZ += transform.l;
         if(Boolean(isNaN(aabb.minX)) || Boolean(isNaN(aabb.minY)) || Boolean(isNaN(aabb.minZ)) || Boolean(isNaN(aabb.maxX)) || Boolean(isNaN(aabb.maxY)) || Boolean(isNaN(aabb.maxZ)))
         {
            aa = 1;
            trace(aabb);
         }
         return aabb;
      }
      
      override public function raycast(origin:name_194, vector:name_194, epsilon:Number, normal:name_194) : Number
      {
         var t:Number = NaN;
         var vz:Number = vector.x * transform.c + vector.y * transform.g + vector.z * transform.k;
         if(vz < epsilon && vz > -epsilon)
         {
            return -1;
         }
         var tx:Number = origin.x - transform.d;
         var ty:Number = origin.y - transform.h;
         var tz:Number = origin.z - transform.l;
         var oz:Number = tx * transform.c + ty * transform.g + tz * transform.k;
         t = -oz / vz;
         if(t < 0)
         {
            return -1;
         }
         var ox:Number = tx * transform.a + ty * transform.e + tz * transform.i;
         var oy:Number = tx * transform.b + ty * transform.f + tz * transform.j;
         tx = ox + t * (vector.x * transform.a + vector.y * transform.e + vector.z * transform.i);
         ty = oy + t * (vector.x * transform.b + vector.y * transform.f + vector.z * transform.j);
         tz = oz + t * vz;
         if(this.e0.x * (ty - this.v0.y) - this.e0.y * (tx - this.v0.x) < 0 || this.e1.x * (ty - this.v1.y) - this.e1.y * (tx - this.v1.x) < 0 || this.e2.x * (ty - this.v2.y) - this.e2.y * (tx - this.v2.x) < 0)
         {
            return -1;
         }
         normal.x = transform.c;
         normal.y = transform.g;
         normal.z = transform.k;
         return t;
      }
      
      override public function copyFrom(source:name_235) : name_235
      {
         super.copyFrom(source);
         var tri:name_378 = source as name_378;
         if(tri != null)
         {
            this.v0.copy(tri.v0);
            this.v1.copy(tri.v1);
            this.v2.copy(tri.v2);
            this.e0.copy(tri.e0);
            this.e1.copy(tri.e1);
            this.e2.copy(tri.e2);
         }
         return this;
      }
      
      override public function toString() : String
      {
         return "[CollisionTriangle v0=" + this.v0 + ", v1=" + this.v1 + ", v2=" + this.v2 + "]";
      }
      
      override protected function createPrimitive() : name_235
      {
         return new name_378(this.v0,this.v1,this.v2,collisionGroup,collisionMask);
      }
      
      private function method_630(v0:name_194, v1:name_194, v2:name_194) : void
      {
         this.v0.copy(v0);
         this.v1.copy(v1);
         this.v2.copy(v2);
         this.e0.method_366(v1,v0);
         this.e0.normalize();
         this.e1.method_366(v2,v1);
         this.e1.normalize();
         this.e2.method_366(v0,v2);
         this.e2.normalize();
      }
   }
}

