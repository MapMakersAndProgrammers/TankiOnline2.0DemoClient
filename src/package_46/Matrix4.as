package package_46
{
   public class Matrix4
   {
      public static const IDENTITY:Matrix4 = new Matrix4();
      
      public var a:Number;
      
      public var b:Number;
      
      public var c:Number;
      
      public var d:Number;
      
      public var e:Number;
      
      public var f:Number;
      
      public var g:Number;
      
      public var h:Number;
      
      public var i:Number;
      
      public var j:Number;
      
      public var k:Number;
      
      public var l:Number;
      
      public function Matrix4(a:Number = 1, b:Number = 0, c:Number = 0, d:Number = 0, e:Number = 0, f:Number = 1, g:Number = 0, h:Number = 0, i:Number = 0, j:Number = 0, k:Number = 1, l:Number = 0)
      {
         super();
         this.a = a;
         this.b = b;
         this.c = c;
         this.d = d;
         this.e = e;
         this.f = f;
         this.g = g;
         this.h = h;
         this.i = i;
         this.j = j;
         this.k = k;
         this.l = l;
      }
      
      public function method_347() : Matrix4
      {
         this.a = this.f = this.k = 1;
         this.b = this.c = this.e = this.g = this.i = this.j = this.d = this.h = this.l = 0;
         return this;
      }
      
      public function invert() : Matrix4
      {
         var aa:Number = this.a;
         var bb:Number = this.b;
         var cc:Number = this.c;
         var dd:Number = this.d;
         var ee:Number = this.e;
         var ff:Number = this.f;
         var gg:Number = this.g;
         var hh:Number = this.h;
         var ii:Number = this.i;
         var jj:Number = this.j;
         var kk:Number = this.k;
         var ll:Number = this.l;
         var det:Number = -cc * ff * ii + bb * gg * ii + cc * ee * jj - aa * gg * jj - bb * ee * kk + aa * ff * kk;
         this.a = (-gg * jj + ff * kk) / det;
         this.b = (cc * jj - bb * kk) / det;
         this.c = (-cc * ff + bb * gg) / det;
         this.d = (dd * gg * jj - cc * hh * jj - dd * ff * kk + bb * hh * kk + cc * ff * ll - bb * gg * ll) / det;
         this.e = (gg * ii - ee * kk) / det;
         this.f = (-cc * ii + aa * kk) / det;
         this.g = (cc * ee - aa * gg) / det;
         this.h = (cc * hh * ii - dd * gg * ii + dd * ee * kk - aa * hh * kk - cc * ee * ll + aa * gg * ll) / det;
         this.i = (-ff * ii + ee * jj) / det;
         this.j = (bb * ii - aa * jj) / det;
         this.k = (-bb * ee + aa * ff) / det;
         this.l = (dd * ff * ii - bb * hh * ii - dd * ee * jj + aa * hh * jj + bb * ee * ll - aa * ff * ll) / det;
         return this;
      }
      
      public function append(m:Matrix4) : Matrix4
      {
         var aa:Number = this.a;
         var bb:Number = this.b;
         var cc:Number = this.c;
         var dd:Number = this.d;
         var ee:Number = this.e;
         var ff:Number = this.f;
         var gg:Number = this.g;
         var hh:Number = this.h;
         var ii:Number = this.i;
         var jj:Number = this.j;
         var kk:Number = this.k;
         var ll:Number = this.l;
         this.a = m.a * aa + m.b * ee + m.c * ii;
         this.b = m.a * bb + m.b * ff + m.c * jj;
         this.c = m.a * cc + m.b * gg + m.c * kk;
         this.d = m.a * dd + m.b * hh + m.c * ll + m.d;
         this.e = m.e * aa + m.f * ee + m.g * ii;
         this.f = m.e * bb + m.f * ff + m.g * jj;
         this.g = m.e * cc + m.f * gg + m.g * kk;
         this.h = m.e * dd + m.f * hh + m.g * ll + m.h;
         this.i = m.i * aa + m.j * ee + m.k * ii;
         this.j = m.i * bb + m.j * ff + m.k * jj;
         this.k = m.i * cc + m.j * gg + m.k * kk;
         this.l = m.i * dd + m.j * hh + m.k * ll + m.l;
         return this;
      }
      
      public function prepend(m:Matrix4) : Matrix4
      {
         var aa:Number = this.a;
         var bb:Number = this.b;
         var cc:Number = this.c;
         var dd:Number = this.d;
         var ee:Number = this.e;
         var ff:Number = this.f;
         var gg:Number = this.g;
         var hh:Number = this.h;
         var ii:Number = this.i;
         var jj:Number = this.j;
         var kk:Number = this.k;
         var ll:Number = this.l;
         this.a = aa * m.a + bb * m.e + cc * m.i;
         this.b = aa * m.b + bb * m.f + cc * m.j;
         this.c = aa * m.c + bb * m.g + cc * m.k;
         this.d = aa * m.d + bb * m.h + cc * m.l + dd;
         this.e = ee * m.a + ff * m.e + gg * m.i;
         this.f = ee * m.b + ff * m.f + gg * m.j;
         this.g = ee * m.c + ff * m.g + gg * m.k;
         this.h = ee * m.d + ff * m.h + gg * m.l + hh;
         this.i = ii * m.a + jj * m.e + kk * m.i;
         this.j = ii * m.b + jj * m.f + kk * m.j;
         this.k = ii * m.c + jj * m.g + kk * m.k;
         this.l = ii * m.d + jj * m.h + kk * m.l + ll;
         return this;
      }
      
      public function add(m:Matrix4) : Matrix4
      {
         this.a += m.a;
         this.b += m.b;
         this.c += m.c;
         this.d += m.d;
         this.e += m.e;
         this.f += m.f;
         this.g += m.g;
         this.h += m.h;
         this.i += m.i;
         this.j += m.j;
         this.k += m.k;
         this.l += m.l;
         return this;
      }
      
      public function subtract(m:Matrix4) : Matrix4
      {
         this.a -= m.a;
         this.b -= m.b;
         this.c -= m.c;
         this.d -= m.d;
         this.e -= m.e;
         this.f -= m.f;
         this.g -= m.g;
         this.h -= m.h;
         this.i -= m.i;
         this.j -= m.j;
         this.k -= m.k;
         this.l -= m.l;
         return this;
      }
      
      public function method_353(vin:name_194, vout:name_194) : void
      {
         vout.x = this.a * vin.x + this.b * vin.y + this.c * vin.z + this.d;
         vout.y = this.e * vin.x + this.f * vin.y + this.g * vin.z + this.h;
         vout.z = this.i * vin.x + this.j * vin.y + this.k * vin.z + this.l;
      }
      
      public function transformPointTransposed(vin:name_194, vout:name_194) : void
      {
         var xx:Number = vin.x - this.d;
         var yy:Number = vin.y - this.h;
         var zz:Number = vin.z - this.l;
         vout.x = this.a * xx + this.e * yy + this.i * zz;
         vout.y = this.b * xx + this.f * yy + this.j * zz;
         vout.z = this.c * xx + this.g * yy + this.k * zz;
      }
      
      public function method_354(arrin:Vector.<name_194>, arrout:Vector.<name_194>) : void
      {
         var vin:name_194 = null;
         var vout:name_194 = null;
         var len:int = int(arrin.length);
         for(var idx:int = 0; idx < len; idx++)
         {
            vin = arrin[idx];
            vout = arrout[idx];
            vout.x = this.a * vin.x + this.b * vin.y + this.c * vin.z + this.d;
            vout.y = this.e * vin.x + this.f * vin.y + this.g * vin.z + this.h;
            vout.z = this.i * vin.x + this.j * vin.y + this.k * vin.z + this.l;
         }
      }
      
      public function method_357(arrin:Vector.<name_194>, arrout:Vector.<name_194>, len:int) : void
      {
         var vin:name_194 = null;
         var vout:name_194 = null;
         for(var idx:int = 0; idx < len; idx++)
         {
            vin = arrin[idx];
            vout = arrout[idx];
            vout.x = this.a * vin.x + this.b * vin.y + this.c * vin.z + this.d;
            vout.y = this.e * vin.x + this.f * vin.y + this.g * vin.z + this.h;
            vout.z = this.i * vin.x + this.j * vin.y + this.k * vin.z + this.l;
         }
      }
      
      public function method_351(arrin:Vector.<name_194>, arrout:Vector.<name_194>) : void
      {
         var vin:name_194 = null;
         var vout:name_194 = null;
         var xx:Number = NaN;
         var yy:Number = NaN;
         var zz:Number = NaN;
         var len:int = int(arrin.length);
         for(var idx:int = 0; idx < len; idx++)
         {
            vin = arrin[idx];
            vout = arrout[idx];
            xx = vin.x - this.d;
            yy = vin.y - this.h;
            zz = vin.z - this.l;
            vout.x = this.a * xx + this.e * yy + this.i * zz;
            vout.y = this.b * xx + this.f * yy + this.j * zz;
            vout.z = this.c * xx + this.g * yy + this.k * zz;
         }
      }
      
      public function method_352(arrin:Vector.<name_194>, arrout:Vector.<name_194>, len:int) : void
      {
         var vin:name_194 = null;
         var vout:name_194 = null;
         var xx:Number = NaN;
         var yy:Number = NaN;
         var zz:Number = NaN;
         for(var idx:int = 0; idx < len; idx++)
         {
            vin = arrin[idx];
            vout = arrout[idx];
            xx = vin.x - this.d;
            yy = vin.y - this.h;
            zz = vin.z - this.l;
            vout.x = this.a * xx + this.e * yy + this.i * zz;
            vout.y = this.b * xx + this.f * yy + this.j * zz;
            vout.z = this.c * xx + this.g * yy + this.k * zz;
         }
      }
      
      public function getAxis(idx:int, axis:name_194) : void
      {
         switch(idx)
         {
            case 0:
               axis.x = this.a;
               axis.y = this.e;
               axis.z = this.i;
               return;
            case 1:
               axis.x = this.b;
               axis.y = this.f;
               axis.z = this.j;
               return;
            case 2:
               axis.x = this.c;
               axis.y = this.g;
               axis.z = this.k;
               return;
            case 3:
               axis.x = this.d;
               axis.y = this.h;
               axis.z = this.l;
               return;
            default:
               return;
         }
      }
      
      public function method_356(xAxis:name_194, yAxis:name_194, zAxis:name_194, pos:name_194) : void
      {
         this.a = xAxis.x;
         this.e = xAxis.y;
         this.i = xAxis.z;
         this.b = yAxis.x;
         this.f = yAxis.y;
         this.j = yAxis.z;
         this.c = zAxis.x;
         this.g = zAxis.y;
         this.k = zAxis.z;
         this.d = pos.x;
         this.h = pos.y;
         this.l = pos.z;
      }
      
      public function method_345(vin:name_194, vout:name_194) : void
      {
         vout.x = this.a * vin.x + this.b * vin.y + this.c * vin.z;
         vout.y = this.e * vin.x + this.f * vin.y + this.g * vin.z;
         vout.z = this.i * vin.x + this.j * vin.y + this.k * vin.z;
      }
      
      public function method_346(vin:name_194, vout:name_194) : void
      {
         vout.x = this.a * vin.x + this.e * vin.y + this.i * vin.z;
         vout.y = this.b * vin.x + this.f * vin.y + this.j * vin.z;
         vout.z = this.c * vin.x + this.g * vin.y + this.k * vin.z;
      }
      
      public function copy(m:Matrix4) : Matrix4
      {
         this.a = m.a;
         this.b = m.b;
         this.c = m.c;
         this.d = m.d;
         this.e = m.e;
         this.f = m.f;
         this.g = m.g;
         this.h = m.h;
         this.i = m.i;
         this.j = m.j;
         this.k = m.k;
         this.l = m.l;
         return this;
      }
      
      public function method_350(m:Matrix3, offset:name_194) : Matrix4
      {
         this.a = m.a;
         this.b = m.b;
         this.c = m.c;
         this.d = offset.x;
         this.e = m.e;
         this.f = m.f;
         this.g = m.g;
         this.h = offset.y;
         this.i = m.i;
         this.j = m.j;
         this.k = m.k;
         this.l = offset.z;
         return this;
      }
      
      public function method_355(m:Matrix3) : Matrix4
      {
         this.a = m.a;
         this.b = m.b;
         this.c = m.c;
         this.e = m.e;
         this.f = m.f;
         this.g = m.g;
         this.i = m.i;
         this.j = m.j;
         this.k = m.k;
         return this;
      }
      
      public function name_341(angles:name_194) : void
      {
         if(-1 < this.i && this.i < 1)
         {
            angles.x = Math.atan2(this.j,this.k);
            angles.y = -Math.asin(this.i);
            angles.z = Math.atan2(this.e,this.a);
         }
         else
         {
            angles.x = 0;
            angles.y = this.i <= -1 ? Number(Math.PI) : -Math.PI;
            angles.y *= 0.5;
            angles.z = Math.atan2(-this.b,this.f);
         }
      }
      
      public function name_201(pos:name_194) : void
      {
         this.d = pos.x;
         this.h = pos.y;
         this.l = pos.z;
      }
      
      public function name_75(x:Number, y:Number, z:Number) : void
      {
         this.d = x;
         this.h = y;
         this.l = z;
      }
      
      public function clone() : Matrix4
      {
         return new Matrix4(this.a,this.b,this.c,this.d,this.e,this.f,this.g,this.h,this.i,this.j,this.k,this.l);
      }
      
      public function toString() : String
      {
         return "[Matrix4 [" + this.a.toFixed(3) + " " + this.b.toFixed(3) + " " + this.c.toFixed(3) + " " + this.d.toFixed(3) + "] [" + this.e.toFixed(3) + " " + this.f.toFixed(3) + " " + this.g.toFixed(3) + " " + this.h.toFixed(3) + "] [" + this.i.toFixed(3) + " " + this.j.toFixed(3) + " " + this.k.toFixed(3) + " " + this.l.toFixed(3) + "]]";
      }
      
      public function name_196(rx:Number, ry:Number, rz:Number) : void
      {
         var cosX:Number = Number(Math.cos(rx));
         var sinX:Number = Number(Math.sin(rx));
         var cosY:Number = Number(Math.cos(ry));
         var sinY:Number = Number(Math.sin(ry));
         var cosZ:Number = Number(Math.cos(rz));
         var sinZ:Number = Number(Math.sin(rz));
         var cosZsinY:Number = cosZ * sinY;
         var sinZsinY:Number = sinZ * sinY;
         this.a = cosZ * cosY;
         this.b = cosZsinY * sinX - sinZ * cosX;
         this.c = cosZsinY * cosX + sinZ * sinX;
         this.e = sinZ * cosY;
         this.f = sinZsinY * sinX + cosZ * cosX;
         this.g = sinZsinY * cosX - cosZ * sinX;
         this.i = -sinY;
         this.j = cosY * sinX;
         this.k = cosY * cosX;
      }
      
      public function setMatrix(x:Number, y:Number, z:Number, rx:Number, ry:Number, rz:Number) : void
      {
         this.d = x;
         this.h = y;
         this.l = z;
         var cosX:Number = Number(Math.cos(rx));
         var sinX:Number = Number(Math.sin(rx));
         var cosY:Number = Number(Math.cos(ry));
         var sinY:Number = Number(Math.sin(ry));
         var cosZ:Number = Number(Math.cos(rz));
         var sinZ:Number = Number(Math.sin(rz));
         var cosZsinY:Number = cosZ * sinY;
         var sinZsinY:Number = sinZ * sinY;
         this.a = cosZ * cosY;
         this.b = cosZsinY * sinX - sinZ * cosX;
         this.c = cosZsinY * cosX + sinZ * sinX;
         this.e = sinZ * cosY;
         this.f = sinZsinY * sinX + cosZ * cosX;
         this.g = sinZsinY * cosX - cosZ * sinX;
         this.i = -sinY;
         this.j = cosY * sinX;
         this.k = cosY * cosX;
      }
      
      public function method_344(axis:name_194, angle:Number) : void
      {
         var c1:Number = Number(Math.cos(angle));
         var s:Number = Number(Math.sin(angle));
         var t:Number = 1 - c1;
         var x:Number = axis.x;
         var y:Number = axis.y;
         var z:Number = axis.z;
         this.a = t * x * x + c1;
         this.b = t * x * y - z * s;
         this.c = t * x * z + y * s;
         this.e = t * x * y + z * s;
         this.f = t * y * y + c1;
         this.g = t * y * z - x * s;
         this.i = t * x * z - y * s;
         this.j = t * y * z + x * s;
         this.k = t * z * z + c1;
      }
   }
}

