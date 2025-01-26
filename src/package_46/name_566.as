package package_46
{
   import flash.geom.Vector3D;
   
   public class name_566
   {
      public static const IDENTITY:name_566 = new name_566();
      
      private static var _q:name_566 = new name_566();
      
      public var w:Number;
      
      public var x:Number;
      
      public var y:Number;
      
      public var z:Number;
      
      public function name_566(w:Number = 1, x:Number = 0, y:Number = 0, z:Number = 0)
      {
         super();
         this.w = w;
         this.x = x;
         this.y = y;
         this.z = z;
      }
      
      public static function method_552(q1:name_566, q2:name_566, result:name_566) : void
      {
         result.w = q1.w * q2.w - q1.x * q2.x - q1.y * q2.y - q1.z * q2.z;
         result.x = q1.w * q2.x + q1.x * q2.w + q1.y * q2.z - q1.z * q2.y;
         result.y = q1.w * q2.y + q1.y * q2.w + q1.z * q2.x - q1.x * q2.z;
         result.z = q1.w * q2.z + q1.z * q2.w + q1.x * q2.y - q1.y * q2.x;
      }
      
      public static function method_771(axis:name_194, angle:Number) : name_566
      {
         var q:name_566 = new name_566();
         q.method_764(axis,angle);
         return q;
      }
      
      public static function method_765(x:Number, y:Number, z:Number, angle:Number) : name_566
      {
         var q:name_566 = new name_566();
         q.method_763(x,y,z,angle);
         return q;
      }
      
      public static function method_767(x:Number, y:Number, z:Number) : name_566
      {
         var q:name_566 = new name_566();
         q.method_763(1,0,0,x);
         _q.method_763(0,1,0,y);
         q.append(_q);
         q.normalize();
         _q.method_763(0,0,1,z);
         q.append(_q);
         q.normalize();
         return q;
      }
      
      public function reset(w:Number = 1, x:Number = 0, y:Number = 0, z:Number = 0) : name_566
      {
         this.w = w;
         this.x = x;
         this.y = y;
         this.z = z;
         return this;
      }
      
      public function normalize() : name_566
      {
         var d:Number = this.w * this.w + this.x * this.x + this.y * this.y + this.z * this.z;
         if(d == 0)
         {
            this.w = 1;
         }
         else
         {
            d = 1 / Math.sqrt(d);
            this.w *= d;
            this.x *= d;
            this.y *= d;
            this.z *= d;
         }
         return this;
      }
      
      public function prepend(q:name_566) : name_566
      {
         var ww:Number = this.w * q.w - this.x * q.x - this.y * q.y - this.z * q.z;
         var xx:Number = this.w * q.x + this.x * q.w + this.y * q.z - this.z * q.y;
         var yy:Number = this.w * q.y + this.y * q.w + this.z * q.x - this.x * q.z;
         var zz:Number = this.w * q.z + this.z * q.w + this.x * q.y - this.y * q.x;
         this.w = ww;
         this.x = xx;
         this.y = yy;
         this.z = zz;
         return this;
      }
      
      public function append(q:name_566) : name_566
      {
         var ww:Number = q.w * this.w - q.x * this.x - q.y * this.y - q.z * this.z;
         var xx:Number = q.w * this.x + q.x * this.w + q.y * this.z - q.z * this.y;
         var yy:Number = q.w * this.y + q.y * this.w + q.z * this.x - q.x * this.z;
         var zz:Number = q.w * this.z + q.z * this.w + q.x * this.y - q.y * this.x;
         this.w = ww;
         this.x = xx;
         this.y = yy;
         this.z = zz;
         return this;
      }
      
      public function method_772(v:name_194) : name_566
      {
         var ww:Number = -v.x * this.x - v.y * this.y - v.z * this.z;
         var xx:Number = v.x * this.w + v.y * this.z - v.z * this.y;
         var yy:Number = v.y * this.w + v.z * this.x - v.x * this.z;
         var zz:Number = v.z * this.w + v.x * this.y - v.y * this.x;
         this.w = ww;
         this.x = xx;
         this.y = yy;
         this.z = zz;
         return this;
      }
      
      public function name_603(v:name_194, scale:Number) : name_566
      {
         var vx:Number = v.x * scale;
         var vy:Number = v.y * scale;
         var vz:Number = v.z * scale;
         var ww:Number = -this.x * vx - this.y * vy - this.z * vz;
         var xx:Number = vx * this.w + vy * this.z - vz * this.y;
         var yy:Number = vy * this.w + vz * this.x - vx * this.z;
         var zz:Number = vz * this.w + vx * this.y - vy * this.x;
         this.w += 0.5 * ww;
         this.x += 0.5 * xx;
         this.y += 0.5 * yy;
         this.z += 0.5 * zz;
         var d:Number = this.w * this.w + this.x * this.x + this.y * this.y + this.z * this.z;
         if(d == 0)
         {
            this.w = 1;
         }
         else
         {
            d = 1 / Math.sqrt(d);
            this.w *= d;
            this.x *= d;
            this.y *= d;
            this.z *= d;
         }
         return this;
      }
      
      public function toMatrix3(m:Matrix3) : name_566
      {
         var xx2:Number = NaN;
         var yy2:Number = NaN;
         var zz2:Number = NaN;
         var yz2:Number = NaN;
         var zx2:Number = NaN;
         var wx2:Number = NaN;
         xx2 = 2 * this.x * this.x;
         yy2 = 2 * this.y * this.y;
         zz2 = 2 * this.z * this.z;
         var xy2:Number = 2 * this.x * this.y;
         yz2 = 2 * this.y * this.z;
         zx2 = 2 * this.z * this.x;
         wx2 = 2 * this.w * this.x;
         var wy2:Number = 2 * this.w * this.y;
         var wz2:Number = 2 * this.w * this.z;
         m.a = 1 - yy2 - zz2;
         m.b = xy2 - wz2;
         m.c = zx2 + wy2;
         m.e = xy2 + wz2;
         m.f = 1 - xx2 - zz2;
         m.g = yz2 - wx2;
         m.i = zx2 - wy2;
         m.j = yz2 + wx2;
         m.k = 1 - xx2 - yy2;
         return this;
      }
      
      public function toMatrix4(m:Matrix4) : name_566
      {
         var zz2:Number = NaN;
         var xy2:Number = NaN;
         var yz2:Number = NaN;
         var wx2:Number = NaN;
         var wy2:Number = NaN;
         var xx2:Number = 2 * this.x * this.x;
         var yy2:Number = 2 * this.y * this.y;
         zz2 = 2 * this.z * this.z;
         xy2 = 2 * this.x * this.y;
         yz2 = 2 * this.y * this.z;
         var zx2:Number = 2 * this.z * this.x;
         wx2 = 2 * this.w * this.x;
         wy2 = 2 * this.w * this.y;
         var wz2:Number = 2 * this.w * this.z;
         m.a = 1 - yy2 - zz2;
         m.b = xy2 - wz2;
         m.c = zx2 + wy2;
         m.e = xy2 + wz2;
         m.f = 1 - xx2 - zz2;
         m.g = yz2 - wx2;
         m.i = zx2 - wy2;
         m.j = yz2 + wx2;
         m.k = 1 - xx2 - yy2;
         return this;
      }
      
      public function length() : Number
      {
         return Math.sqrt(this.w * this.w + this.x * this.x + this.y * this.y + this.z * this.z);
      }
      
      public function method_365() : Number
      {
         return this.w * this.w + this.x * this.x + this.y * this.y + this.z * this.z;
      }
      
      public function method_764(axis:name_194, angle:Number) : name_566
      {
         this.w = Math.cos(0.5 * angle);
         var k:Number = Math.sin(0.5 * angle) / Math.sqrt(axis.x * axis.x + axis.y * axis.y + axis.z * axis.z);
         this.x = axis.x * k;
         this.y = axis.y * k;
         this.z = axis.z * k;
         return this;
      }
      
      public function method_763(x:Number, y:Number, z:Number, angle:Number) : name_566
      {
         this.w = Math.cos(0.5 * angle);
         var k:Number = Math.sin(0.5 * angle) / Math.sqrt(x * x + y * y + z * z);
         this.x = x * k;
         this.y = y * k;
         this.z = z * k;
         return this;
      }
      
      public function method_770(v:name_194 = null) : name_194
      {
         var angle:Number = NaN;
         var coeff:Number = NaN;
         if(this.w < -1 || this.w > 1)
         {
            this.normalize();
         }
         if(v == null)
         {
            v = new name_194();
         }
         if(this.w > -1 && this.w < 1)
         {
            if(this.w == 0)
            {
               v.x = this.x;
               v.y = this.y;
               v.z = this.z;
            }
            else
            {
               angle = 2 * Math.acos(this.w);
               coeff = 1 / Math.sqrt(1 - this.w * this.w);
               v.x = this.x * coeff * angle;
               v.y = this.y * coeff * angle;
               v.z = this.z * coeff * angle;
            }
         }
         else
         {
            v.x = 0;
            v.y = 0;
            v.z = 0;
         }
         return v;
      }
      
      public function name_341(angles:name_194) : name_194
      {
         var qi2:Number = 2 * this.x * this.x;
         var qj2:Number = 2 * this.y * this.y;
         var qk2:Number = 2 * this.z * this.z;
         var qij:Number = 2 * this.x * this.y;
         var qjk:Number = 2 * this.y * this.z;
         var qki:Number = 2 * this.z * this.x;
         var qri:Number = 2 * this.w * this.x;
         var qrj:Number = 2 * this.w * this.y;
         var qrk:Number = 2 * this.w * this.z;
         var aa:Number = 1 - qj2 - qk2;
         var bb:Number = qij - qrk;
         var ee:Number = qij + qrk;
         var ff:Number = 1 - qi2 - qk2;
         var ii:Number = qki - qrj;
         var jj:Number = qjk + qri;
         var kk:Number = 1 - qi2 - qj2;
         if(-1 < ii && ii < 1)
         {
            if(angles == null)
            {
               angles = new name_194(Math.atan2(jj,kk),-Math.asin(ii),Math.atan2(ee,aa));
            }
            else
            {
               angles.x = Math.atan2(jj,kk);
               angles.y = -Math.asin(ii);
               angles.z = Math.atan2(ee,aa);
            }
         }
         else if(angles == null)
         {
            angles = new name_194(0,0.5 * (ii <= -1 ? Math.PI : -Math.PI),Math.atan2(-bb,ff));
         }
         else
         {
            angles.x = 0;
            angles.y = ii <= -1 ? Number(Math.PI) : -Math.PI;
            angles.y *= 0.5;
            angles.z = Math.atan2(-bb,ff);
         }
         return angles;
      }
      
      public function method_768(x:Number, y:Number, z:Number) : void
      {
         this.method_763(1,0,0,x);
         _q.method_763(0,1,0,y);
         this.append(_q);
         this.normalize();
         _q.method_763(0,0,1,z);
         this.append(_q);
         this.normalize();
      }
      
      public function method_769() : void
      {
         this.x = -this.x;
         this.y = -this.y;
         this.z = -this.z;
      }
      
      public function method_766(q1:name_566, q2:name_566, t:Number) : name_566
      {
         var d:Number = 1 - t;
         this.w = q1.w * d + q2.w * t;
         this.x = q1.x * d + q2.x * t;
         this.y = q1.y * d + q2.y * t;
         this.z = q1.z * d + q2.z * t;
         d = this.w * this.w + this.x * this.x + this.y * this.y + this.z * this.z;
         if(d == 0)
         {
            this.w = 1;
         }
         else
         {
            d = 1 / Math.sqrt(d);
            this.w *= d;
            this.x *= d;
            this.y *= d;
            this.z *= d;
         }
         return this;
      }
      
      public function subtract(q:name_566) : name_566
      {
         this.w -= q.w;
         this.x -= q.x;
         this.y -= q.y;
         this.z -= q.z;
         return this;
      }
      
      public function method_366(q1:name_566, q2:name_566) : name_566
      {
         this.w = q2.w - q1.w;
         this.x = q2.x - q1.x;
         this.y = q2.y - q1.y;
         this.z = q2.z - q1.z;
         return this;
      }
      
      public function copy(q:name_566) : name_566
      {
         this.w = q.w;
         this.x = q.x;
         this.y = q.y;
         this.z = q.z;
         return this;
      }
      
      public function method_363(result:Vector3D) : Vector3D
      {
         result.x = this.x;
         result.y = this.y;
         result.z = this.z;
         result.w = this.w;
         return result;
      }
      
      public function clone() : name_566
      {
         return new name_566(this.w,this.x,this.y,this.z);
      }
      
      public function toString() : String
      {
         return "[" + this.w + ", " + this.x + ", " + this.y + ", " + this.z + "]";
      }
      
      public function name_602(a:name_566, b:name_566, t:Number) : name_566
      {
         var k1:Number = NaN;
         var k2:Number = NaN;
         var theta:Number = NaN;
         var sine:Number = NaN;
         var beta:Number = NaN;
         var alpha:Number = NaN;
         var flip:Number = 1;
         var cosine:Number = a.w * b.w + a.x * b.x + a.y * b.y + a.z * b.z;
         if(cosine < 0)
         {
            cosine = -cosine;
            flip = -1;
         }
         if(1 - cosine < 0.001)
         {
            k1 = 1 - t;
            k2 = t * flip;
            this.w = a.w * k1 + b.w * k2;
            this.x = a.x * k1 + b.x * k2;
            this.y = a.y * k1 + b.y * k2;
            this.z = a.z * k1 + b.z * k2;
            this.normalize();
         }
         else
         {
            theta = Number(Math.acos(cosine));
            sine = Number(Math.sin(theta));
            beta = Math.sin((1 - t) * theta) / sine;
            alpha = Math.sin(t * theta) / sine * flip;
            this.w = a.w * beta + b.w * alpha;
            this.x = a.x * beta + b.x * alpha;
            this.y = a.y * beta + b.y * alpha;
            this.z = a.z * beta + b.z * alpha;
         }
         return this;
      }
   }
}

