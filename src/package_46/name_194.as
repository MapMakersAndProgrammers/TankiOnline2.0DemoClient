package package_46
{
   import flash.geom.Vector3D;
   
   public class name_194
   {
      public static const ZERO:name_194 = new name_194(0,0,0);
      
      public static const X_AXIS:name_194 = new name_194(1,0,0);
      
      public static const Y_AXIS:name_194 = new name_194(0,1,0);
      
      public static const Z_AXIS:name_194 = new name_194(0,0,1);
      
      public static const RIGHT:name_194 = new name_194(1,0,0);
      
      public static const LEFT:name_194 = new name_194(-1,0,0);
      
      public static const FORWARD:name_194 = new name_194(0,1,0);
      
      public static const BACK:name_194 = new name_194(0,-1,0);
      
      public static const UP:name_194 = new name_194(0,0,1);
      
      public static const DOWN:name_194 = new name_194(0,0,-1);
      
      public var x:Number;
      
      public var y:Number;
      
      public var z:Number;
      
      public function name_194(x:Number = 0, y:Number = 0, z:Number = 0)
      {
         super();
         this.x = x;
         this.y = y;
         this.z = z;
      }
      
      public function length() : Number
      {
         return Math.sqrt(this.x * this.x + this.y * this.y + this.z * this.z);
      }
      
      public function method_365() : Number
      {
         return this.x * this.x + this.y * this.y + this.z * this.z;
      }
      
      public function method_358(length:Number) : name_194
      {
         var k:Number = NaN;
         var d:Number = this.x * this.x + this.y * this.y + this.z * this.z;
         if(d == 0)
         {
            this.x = length;
         }
         else
         {
            k = length / Math.sqrt(this.x * this.x + this.y * this.y + this.z * this.z);
            this.x *= k;
            this.y *= k;
            this.z *= k;
         }
         return this;
      }
      
      public function normalize() : name_194
      {
         var d:Number = this.x * this.x + this.y * this.y + this.z * this.z;
         if(d == 0)
         {
            this.x = 1;
         }
         else
         {
            d = Number(Math.sqrt(d));
            this.x /= d;
            this.y /= d;
            this.z /= d;
         }
         return this;
      }
      
      public function add(v:name_194) : name_194
      {
         this.x += v.x;
         this.y += v.y;
         this.z += v.z;
         return this;
      }
      
      public function method_362(k:Number, v:name_194) : name_194
      {
         this.x += k * v.x;
         this.y += k * v.y;
         this.z += k * v.z;
         return this;
      }
      
      public function subtract(v:name_194) : name_194
      {
         this.x -= v.x;
         this.y -= v.y;
         this.z -= v.z;
         return this;
      }
      
      public function sum(a:name_194, b:name_194) : name_194
      {
         this.x = a.x + b.x;
         this.y = a.y + b.y;
         this.z = a.z + b.z;
         return this;
      }
      
      public function method_366(a:name_194, b:name_194) : name_194
      {
         this.x = a.x - b.x;
         this.y = a.y - b.y;
         this.z = a.z - b.z;
         return this;
      }
      
      public function scale(k:Number) : name_194
      {
         this.x *= k;
         this.y *= k;
         this.z *= k;
         return this;
      }
      
      public function reverse() : name_194
      {
         this.x = -this.x;
         this.y = -this.y;
         this.z = -this.z;
         return this;
      }
      
      public function dot(v:name_194) : Number
      {
         return this.x * v.x + this.y * v.y + this.z * v.z;
      }
      
      public function method_360(v:name_194) : name_194
      {
         var xx:Number = this.y * v.z - this.z * v.y;
         var yy:Number = this.z * v.x - this.x * v.z;
         var zz:Number = this.x * v.y - this.y * v.x;
         this.x = xx;
         this.y = yy;
         this.z = zz;
         return this;
      }
      
      public function cross2(a:name_194, b:name_194) : name_194
      {
         this.x = a.y * b.z - a.z * b.y;
         this.y = a.z * b.x - a.x * b.z;
         this.z = a.x * b.y - a.y * b.x;
         return this;
      }
      
      public function transform3(m:Matrix3) : name_194
      {
         var xx:Number = this.x;
         var yy:Number = this.y;
         var zz:Number = this.z;
         this.x = m.a * xx + m.b * yy + m.c * zz;
         this.y = m.e * xx + m.f * yy + m.g * zz;
         this.z = m.i * xx + m.j * yy + m.k * zz;
         return this;
      }
      
      public function transformTransposed3(m:Matrix3) : name_194
      {
         var xx:Number = this.x;
         var yy:Number = this.y;
         var zz:Number = this.z;
         this.x = m.a * xx + m.e * yy + m.i * zz;
         this.y = m.b * xx + m.f * yy + m.j * zz;
         this.z = m.c * xx + m.g * yy + m.k * zz;
         return this;
      }
      
      public function transform4(m:Matrix4) : name_194
      {
         var xx:Number = this.x;
         var yy:Number = this.y;
         var zz:Number = this.z;
         this.x = m.a * xx + m.b * yy + m.c * zz + m.d;
         this.y = m.e * xx + m.f * yy + m.g * zz + m.h;
         this.z = m.i * xx + m.j * yy + m.k * zz + m.l;
         return this;
      }
      
      public function transformTransposed4(m:Matrix4) : name_194
      {
         var xx:Number = this.x - m.d;
         var yy:Number = this.y - m.h;
         var zz:Number = this.z - m.l;
         this.x = m.a * xx + m.e * yy + m.i * zz;
         this.y = m.b * xx + m.f * yy + m.j * zz;
         this.z = m.c * xx + m.g * yy + m.k * zz;
         return this;
      }
      
      public function method_359(m:Matrix4) : name_194
      {
         var xx:Number = this.x;
         var yy:Number = this.y;
         var zz:Number = this.z;
         this.x = m.a * xx + m.b * yy + m.c * zz;
         this.y = m.e * xx + m.f * yy + m.g * zz;
         this.z = m.i * xx + m.j * yy + m.k * zz;
         return this;
      }
      
      public function reset(x:Number = 0, y:Number = 0, z:Number = 0) : name_194
      {
         this.x = x;
         this.y = y;
         this.z = z;
         return this;
      }
      
      public function copy(v:name_194) : name_194
      {
         this.x = v.x;
         this.y = v.y;
         this.z = v.z;
         return this;
      }
      
      public function clone() : name_194
      {
         return new name_194(this.x,this.y,this.z);
      }
      
      public function method_363(result:Vector3D) : Vector3D
      {
         result.x = this.x;
         result.y = this.y;
         result.z = this.z;
         return result;
      }
      
      public function method_361(source:Vector3D) : name_194
      {
         this.x = source.x;
         this.y = source.y;
         this.z = source.z;
         return this;
      }
      
      public function method_364(v:name_194) : Number
      {
         var dx:Number = this.x - v.x;
         var dy:Number = this.y - v.y;
         var dz:Number = this.z - v.z;
         return Math.sqrt(dx * dx + dy * dy + dz * dz);
      }
      
      public function toString() : String
      {
         return "Vector3(" + this.x + ", " + this.y + ", " + this.z + ")";
      }
   }
}

