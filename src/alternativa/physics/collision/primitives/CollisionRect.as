package alternativa.physics.collision.primitives
{
   import alternativa.math.Matrix4;
   import alternativa.math.Vector3;
   import alternativa.physics.collision.CollisionPrimitive;
   import alternativa.physics.collision.types.BoundBox;
   
   public class CollisionRect extends CollisionPrimitive
   {
      private static const EPSILON:Number = 0.005;
      
      public var hs:Vector3 = new Vector3();
      
      public var §_-ng§:Boolean = true;
      
      public function CollisionRect(hs:Vector3, collisionGroup:int, collisionMask:int)
      {
         super(RECT,collisionGroup,collisionMask);
         this.hs.copy(hs);
      }
      
      override public function calculateAABB() : BoundBox
      {
         var t:Matrix4 = null;
         t = transform;
         var xx:Number = t.a < 0 ? -t.a : t.a;
         var yy:Number = t.b < 0 ? -t.b : t.b;
         var zz:Number = t.c < 0 ? -t.c : t.c;
         aabb.maxX = this.hs.x * xx + this.hs.y * yy + EPSILON * zz;
         aabb.minX = -aabb.maxX;
         xx = t.e < 0 ? -t.e : t.e;
         yy = t.f < 0 ? -t.f : t.f;
         zz = t.g < 0 ? -t.g : t.g;
         aabb.maxY = this.hs.x * xx + this.hs.y * yy + EPSILON * zz;
         aabb.minY = -aabb.maxY;
         xx = t.i < 0 ? -t.i : t.i;
         yy = t.j < 0 ? -t.j : t.j;
         zz = t.k < 0 ? -t.k : t.k;
         aabb.maxZ = this.hs.x * xx + this.hs.y * yy + EPSILON * zz;
         aabb.minZ = -aabb.maxZ;
         aabb.minX += t.d;
         aabb.maxX += t.d;
         aabb.minY += t.h;
         aabb.maxY += t.h;
         aabb.minZ += t.l;
         aabb.maxZ += t.l;
         return aabb;
      }
      
      override public function copyFrom(source:CollisionPrimitive) : CollisionPrimitive
      {
         var rect:CollisionRect = source as CollisionRect;
         if(rect == null)
         {
            return this;
         }
         super.copyFrom(rect);
         this.hs.copy(rect.hs);
         return this;
      }
      
      override public function toString() : String
      {
         return "[CollisionRect hs=" + this.hs + "]";
      }
      
      override protected function createPrimitive() : CollisionPrimitive
      {
         return new CollisionRect(this.hs,collisionGroup,collisionMask);
      }
      
      override public function raycast(origin:Vector3, vector:Vector3, threshold:Number, normal:Vector3) : Number
      {
         var t:Number = NaN;
         var vx:Number = origin.x - transform.d;
         var vy:Number = origin.y - transform.h;
         var vz:Number = origin.z - transform.l;
         var ox:Number = transform.a * vx + transform.e * vy + transform.i * vz;
         var oy:Number = transform.b * vx + transform.f * vy + transform.j * vz;
         var oz:Number = transform.c * vx + transform.g * vy + transform.k * vz;
         vx = transform.a * vector.x + transform.e * vector.y + transform.i * vector.z;
         vy = transform.b * vector.x + transform.f * vector.y + transform.j * vector.z;
         vz = transform.c * vector.x + transform.g * vector.y + transform.k * vector.z;
         if(vz > -threshold && vz < threshold)
         {
            return -1;
         }
         t = -oz / vz;
         if(t < 0)
         {
            return -1;
         }
         ox += vx * t;
         oy += vy * t;
         oz = 0;
         if(ox < -this.hs.x - threshold || ox > this.hs.x + threshold || oy < -this.hs.y - threshold || oy > this.hs.y + threshold)
         {
            return -1;
         }
         normal.x = transform.c;
         normal.y = transform.g;
         normal.z = transform.k;
         return t;
      }
   }
}

