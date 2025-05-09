package §_-pe§
{
   import §_-1e§.§_-Nh§;
   import §_-KA§.§_-FW§;
   import §_-nl§.Matrix4;
   import §_-nl§.§_-bj§;
   
   public class §_-m3§ extends §_-Nh§
   {
      public var hs:§_-bj§ = new §_-bj§();
      
      public function §_-m3§(hs:§_-bj§, collisionGroup:int, collisionMask:int)
      {
         super(BOX,collisionGroup,collisionMask);
         this.hs.copy(hs);
      }
      
      override public function calculateAABB() : §_-FW§
      {
         var t:Matrix4 = null;
         var xx:Number = NaN;
         var yy:Number = NaN;
         var zz:Number = NaN;
         t = transform;
         xx = t.a < 0 ? -t.a : Number(t.a);
         yy = t.b < 0 ? -t.b : Number(t.b);
         zz = t.c < 0 ? -t.c : Number(t.c);
         aabb.maxX = this.hs.x * xx + this.hs.y * yy + this.hs.z * zz;
         aabb.minX = -aabb.maxX;
         xx = t.e < 0 ? -t.e : Number(t.e);
         yy = t.f < 0 ? -t.f : Number(t.f);
         zz = t.g < 0 ? -t.g : Number(t.g);
         aabb.maxY = this.hs.x * xx + this.hs.y * yy + this.hs.z * zz;
         aabb.minY = -aabb.maxY;
         xx = t.i < 0 ? -t.i : Number(t.i);
         yy = t.j < 0 ? -t.j : Number(t.j);
         zz = t.k < 0 ? -t.k : Number(t.k);
         aabb.maxZ = this.hs.x * xx + this.hs.y * yy + this.hs.z * zz;
         aabb.minZ = -aabb.maxZ;
         aabb.minX += t.d;
         aabb.maxX += t.d;
         aabb.minY += t.h;
         aabb.maxY += t.h;
         aabb.minZ += t.l;
         aabb.maxZ += t.l;
         return aabb;
      }
      
      override public function copyFrom(source:§_-Nh§) : §_-Nh§
      {
         var box:§_-m3§ = source as §_-m3§;
         if(box == null)
         {
            return this;
         }
         super.copyFrom(box);
         this.hs.copy(box.hs);
         return this;
      }
      
      override protected function createPrimitive() : §_-Nh§
      {
         return new §_-m3§(this.hs,collisionGroup,collisionMask);
      }
      
      override public function raycast(origin:§_-bj§, vector:§_-bj§, epsilon:Number, normal:§_-bj§) : Number
      {
         var t1:Number = NaN;
         var t2:Number = NaN;
         var vx:Number = NaN;
         var tMin:Number = -1;
         var tMax:Number = 1e+308;
         vx = origin.x - transform.d;
         var vy:Number = origin.y - transform.h;
         var vz:Number = origin.z - transform.l;
         var ox:Number = transform.a * vx + transform.e * vy + transform.i * vz;
         var oy:Number = transform.b * vx + transform.f * vy + transform.j * vz;
         var oz:Number = transform.c * vx + transform.g * vy + transform.k * vz;
         vx = transform.a * vector.x + transform.e * vector.y + transform.i * vector.z;
         vy = transform.b * vector.x + transform.f * vector.y + transform.j * vector.z;
         vz = transform.c * vector.x + transform.g * vector.y + transform.k * vector.z;
         if(vx < epsilon && vx > -epsilon)
         {
            if(ox < -this.hs.x || ox > this.hs.x)
            {
               return -1;
            }
         }
         else
         {
            t1 = (-this.hs.x - ox) / vx;
            t2 = (this.hs.x - ox) / vx;
            if(t1 < t2)
            {
               if(t1 > tMin)
               {
                  tMin = t1;
                  normal.x = -1;
                  normal.y = normal.z = 0;
               }
               if(t2 < tMax)
               {
                  tMax = t2;
               }
            }
            else
            {
               if(t2 > tMin)
               {
                  tMin = t2;
                  normal.x = 1;
                  normal.y = normal.z = 0;
               }
               if(t1 < tMax)
               {
                  tMax = t1;
               }
            }
            if(tMax < tMin)
            {
               return -1;
            }
         }
         if(vy < epsilon && vy > -epsilon)
         {
            if(oy < -this.hs.y || oy > this.hs.y)
            {
               return -1;
            }
         }
         else
         {
            t1 = (-this.hs.y - oy) / vy;
            t2 = (this.hs.y - oy) / vy;
            if(t1 < t2)
            {
               if(t1 > tMin)
               {
                  tMin = t1;
                  normal.y = -1;
                  normal.x = normal.z = 0;
               }
               if(t2 < tMax)
               {
                  tMax = t2;
               }
            }
            else
            {
               if(t2 > tMin)
               {
                  tMin = t2;
                  normal.y = 1;
                  normal.x = normal.z = 0;
               }
               if(t1 < tMax)
               {
                  tMax = t1;
               }
            }
            if(tMax < tMin)
            {
               return -1;
            }
         }
         if(vz < epsilon && vz > -epsilon)
         {
            if(oz < -this.hs.z || oz > this.hs.z)
            {
               return -1;
            }
         }
         else
         {
            t1 = (-this.hs.z - oz) / vz;
            t2 = (this.hs.z - oz) / vz;
            if(t1 < t2)
            {
               if(t1 > tMin)
               {
                  tMin = t1;
                  normal.z = -1;
                  normal.x = normal.y = 0;
               }
               if(t2 < tMax)
               {
                  tMax = t2;
               }
            }
            else
            {
               if(t2 > tMin)
               {
                  tMin = t2;
                  normal.z = 1;
                  normal.x = normal.y = 0;
               }
               if(t1 < tMax)
               {
                  tMax = t1;
               }
            }
            if(tMax < tMin)
            {
               return -1;
            }
         }
         vx = Number(normal.x);
         vy = Number(normal.y);
         vz = Number(normal.z);
         normal.x = transform.a * vx + transform.b * vy + transform.c * vz;
         normal.y = transform.e * vx + transform.f * vy + transform.g * vz;
         normal.z = transform.i * vx + transform.j * vy + transform.k * vz;
         return tMin;
      }
      
      override public function toString() : String
      {
         return "[CollisionBox hs=" + this.hs + "]";
      }
   }
}

