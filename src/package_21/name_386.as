package package_21
{
   import alternativa.engine3d.alternativa3d;
   import flash.geom.Vector3D;
   
   use namespace alternativa3d;
   
   public class name_386
   {
      public var minX:Number = 1e+22;
      
      public var minY:Number = 1e+22;
      
      public var minZ:Number = 1e+22;
      
      public var maxX:Number = -1e+22;
      
      public var maxY:Number = -1e+22;
      
      public var maxZ:Number = -1e+22;
      
      public function name_386()
      {
         super();
      }
      
      public function reset() : void
      {
         this.minX = 1e+22;
         this.minY = 1e+22;
         this.minZ = 1e+22;
         this.maxX = -1e+22;
         this.maxY = -1e+22;
         this.maxZ = -1e+22;
      }
      
      alternativa3d function name_393(frustum:name_429, culling:int) : int
      {
         var side:int = 1;
         for(var plane:name_429 = frustum; plane != null; plane = plane.next)
         {
            if(Boolean(culling & side))
            {
               if(plane.x >= 0)
               {
                  if(plane.y >= 0)
                  {
                     if(plane.z >= 0)
                     {
                        if(this.maxX * plane.x + this.maxY * plane.y + this.maxZ * plane.z <= plane.offset)
                        {
                           return -1;
                        }
                        if(this.minX * plane.x + this.minY * plane.y + this.minZ * plane.z > plane.offset)
                        {
                           culling &= 0x3F & ~side;
                        }
                     }
                     else
                     {
                        if(this.maxX * plane.x + this.maxY * plane.y + this.minZ * plane.z <= plane.offset)
                        {
                           return -1;
                        }
                        if(this.minX * plane.x + this.minY * plane.y + this.maxZ * plane.z > plane.offset)
                        {
                           culling &= 0x3F & ~side;
                        }
                     }
                  }
                  else if(plane.z >= 0)
                  {
                     if(this.maxX * plane.x + this.minY * plane.y + this.maxZ * plane.z <= plane.offset)
                     {
                        return -1;
                     }
                     if(this.minX * plane.x + this.maxY * plane.y + this.minZ * plane.z > plane.offset)
                     {
                        culling &= 0x3F & ~side;
                     }
                  }
                  else
                  {
                     if(this.maxX * plane.x + this.minY * plane.y + this.minZ * plane.z <= plane.offset)
                     {
                        return -1;
                     }
                     if(this.minX * plane.x + this.maxY * plane.y + this.maxZ * plane.z > plane.offset)
                     {
                        culling &= 0x3F & ~side;
                     }
                  }
               }
               else if(plane.y >= 0)
               {
                  if(plane.z >= 0)
                  {
                     if(this.minX * plane.x + this.maxY * plane.y + this.maxZ * plane.z <= plane.offset)
                     {
                        return -1;
                     }
                     if(this.maxX * plane.x + this.minY * plane.y + this.minZ * plane.z > plane.offset)
                     {
                        culling &= 0x3F & ~side;
                     }
                  }
                  else
                  {
                     if(this.minX * plane.x + this.maxY * plane.y + this.minZ * plane.z <= plane.offset)
                     {
                        return -1;
                     }
                     if(this.maxX * plane.x + this.minY * plane.y + this.maxZ * plane.z > plane.offset)
                     {
                        culling &= 0x3F & ~side;
                     }
                  }
               }
               else if(plane.z >= 0)
               {
                  if(this.minX * plane.x + this.minY * plane.y + this.maxZ * plane.z <= plane.offset)
                  {
                     return -1;
                  }
                  if(this.maxX * plane.x + this.maxY * plane.y + this.minZ * plane.z > plane.offset)
                  {
                     culling &= 0x3F & ~side;
                  }
               }
               else
               {
                  if(this.minX * plane.x + this.minY * plane.y + this.minZ * plane.z <= plane.offset)
                  {
                     return -1;
                  }
                  if(this.maxX * plane.x + this.maxY * plane.y + this.maxZ * plane.z > plane.offset)
                  {
                     culling &= 0x3F & ~side;
                  }
               }
            }
            side <<= 1;
         }
         return culling;
      }
      
      alternativa3d function name_392(camera:name_124, object:name_78, occlusion:name_429 = null) : Boolean
      {
         return true;
      }
      
      alternativa3d function name_391(origins:Vector.<Vector3D>, directions:Vector.<Vector3D>, raysLength:int) : Boolean
      {
         var origin:Vector3D = null;
         var direction:Vector3D = null;
         var a:Number = NaN;
         var b:Number = NaN;
         var c:Number = NaN;
         var d:Number = NaN;
         var threshold:Number = NaN;
         for(var i:int = 0; i < raysLength; )
         {
            origin = origins[i];
            direction = directions[i];
            if(origin.x >= this.minX && origin.x <= this.maxX && origin.y >= this.minY && origin.y <= this.maxY && origin.z >= this.minZ && origin.z <= this.maxZ)
            {
               return true;
            }
            if(!(origin.x < this.minX && direction.x <= 0 || origin.x > this.maxX && direction.x >= 0 || origin.y < this.minY && direction.y <= 0 || origin.y > this.maxY && direction.y >= 0 || origin.z < this.minZ && direction.z <= 0 || origin.z > this.maxZ && direction.z >= 0))
            {
               threshold = 0.000001;
               if(direction.x > threshold)
               {
                  a = (this.minX - origin.x) / direction.x;
                  b = (this.maxX - origin.x) / direction.x;
               }
               else if(direction.x < -threshold)
               {
                  a = (this.maxX - origin.x) / direction.x;
                  b = (this.minX - origin.x) / direction.x;
               }
               else
               {
                  a = 0;
                  b = 1e+22;
               }
               if(direction.y > threshold)
               {
                  c = (this.minY - origin.y) / direction.y;
                  d = (this.maxY - origin.y) / direction.y;
               }
               else if(direction.y < -threshold)
               {
                  c = (this.maxY - origin.y) / direction.y;
                  d = (this.minY - origin.y) / direction.y;
               }
               else
               {
                  c = 0;
                  d = 1e+22;
               }
               if(!(c >= b || d <= a))
               {
                  if(c < a)
                  {
                     if(d < b)
                     {
                        b = d;
                     }
                  }
                  else
                  {
                     a = c;
                     if(d < b)
                     {
                        b = d;
                     }
                  }
                  if(direction.z > threshold)
                  {
                     c = (this.minZ - origin.z) / direction.z;
                     d = (this.maxZ - origin.z) / direction.z;
                  }
                  else if(direction.z < -threshold)
                  {
                     c = (this.maxZ - origin.z) / direction.z;
                     d = (this.minZ - origin.z) / direction.z;
                  }
                  else
                  {
                     c = 0;
                     d = 1e+22;
                  }
                  if(!(c >= b || d <= a))
                  {
                     return true;
                  }
               }
            }
            i++;
         }
         return false;
      }
      
      alternativa3d function name_395(sphere:Vector3D) : Boolean
      {
         return sphere.x + sphere.w > this.minX && sphere.x - sphere.w < this.maxX && sphere.y + sphere.w > this.minY && sphere.y - sphere.w < this.maxY && sphere.z + sphere.w > this.minZ && sphere.z - sphere.w < this.maxZ;
      }
      
      public function intersectRay(origin:Vector3D, direction:Vector3D) : Boolean
      {
         var a:Number = NaN;
         var b:Number = NaN;
         var c:Number = NaN;
         var d:Number = NaN;
         if(origin.x >= this.minX && origin.x <= this.maxX && origin.y >= this.minY && origin.y <= this.maxY && origin.z >= this.minZ && origin.z <= this.maxZ)
         {
            return true;
         }
         if(origin.x < this.minX && direction.x <= 0)
         {
            return false;
         }
         if(origin.x > this.maxX && direction.x >= 0)
         {
            return false;
         }
         if(origin.y < this.minY && direction.y <= 0)
         {
            return false;
         }
         if(origin.y > this.maxY && direction.y >= 0)
         {
            return false;
         }
         if(origin.z < this.minZ && direction.z <= 0)
         {
            return false;
         }
         if(origin.z > this.maxZ && direction.z >= 0)
         {
            return false;
         }
         if(direction.x > 0.000001)
         {
            a = (this.minX - origin.x) / direction.x;
            b = (this.maxX - origin.x) / direction.x;
         }
         else if(direction.x < -0.000001)
         {
            a = (this.maxX - origin.x) / direction.x;
            b = (this.minX - origin.x) / direction.x;
         }
         else
         {
            a = -1e+22;
            b = 1e+22;
         }
         if(direction.y > 0.000001)
         {
            c = (this.minY - origin.y) / direction.y;
            d = (this.maxY - origin.y) / direction.y;
         }
         else if(direction.y < -0.000001)
         {
            c = (this.maxY - origin.y) / direction.y;
            d = (this.minY - origin.y) / direction.y;
         }
         else
         {
            c = -1e+22;
            d = 1e+22;
         }
         if(c >= b || d <= a)
         {
            return false;
         }
         if(c < a)
         {
            if(d < b)
            {
               b = d;
            }
         }
         else
         {
            a = c;
            if(d < b)
            {
               b = d;
            }
         }
         if(direction.z > 0.000001)
         {
            c = (this.minZ - origin.z) / direction.z;
            d = (this.maxZ - origin.z) / direction.z;
         }
         else if(direction.z < -0.000001)
         {
            c = (this.maxZ - origin.z) / direction.z;
            d = (this.minZ - origin.z) / direction.z;
         }
         else
         {
            c = -1e+22;
            d = 1e+22;
         }
         if(c >= b || d <= a)
         {
            return false;
         }
         return true;
      }
      
      public function clone() : name_386
      {
         var res:name_386 = new name_386();
         res.minX = this.minX;
         res.minY = this.minY;
         res.minZ = this.minZ;
         res.maxX = this.maxX;
         res.maxY = this.maxY;
         res.maxZ = this.maxZ;
         return res;
      }
      
      public function toString() : String
      {
         return "[BoundBox " + "X:[" + this.minX.toFixed(2) + ", " + this.maxX.toFixed(2) + "] Y:[" + this.minY.toFixed(2) + ", " + this.maxY.toFixed(2) + "] Z:[" + this.minZ.toFixed(2) + ", " + this.maxZ.toFixed(2) + "]]";
      }
   }
}

