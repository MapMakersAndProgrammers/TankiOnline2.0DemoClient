package package_21
{
   import alternativa.engine3d.alternativa3d;
   
   use namespace alternativa3d;
   
   public class name_139
   {
      public var a:Number = 1;
      
      public var b:Number = 0;
      
      public var c:Number = 0;
      
      public var d:Number = 0;
      
      public var e:Number = 0;
      
      public var f:Number = 1;
      
      public var g:Number = 0;
      
      public var h:Number = 0;
      
      public var i:Number = 0;
      
      public var j:Number = 0;
      
      public var k:Number = 1;
      
      public var l:Number = 0;
      
      public function name_139()
      {
         super();
      }
      
      public function method_293() : void
      {
         this.a = 1;
         this.b = 0;
         this.c = 0;
         this.d = 0;
         this.e = 0;
         this.f = 1;
         this.g = 0;
         this.h = 0;
         this.i = 0;
         this.j = 0;
         this.k = 1;
         this.l = 0;
      }
      
      public function compose(x:Number, y:Number, z:Number, rotationX:Number, rotationY:Number, rotationZ:Number, scaleX:Number, scaleY:Number, scaleZ:Number) : void
      {
         var cosX:Number = Number(Math.cos(rotationX));
         var sinX:Number = Number(Math.sin(rotationX));
         var cosY:Number = Number(Math.cos(rotationY));
         var sinY:Number = Number(Math.sin(rotationY));
         var cosZ:Number = Number(Math.cos(rotationZ));
         var sinZ:Number = Number(Math.sin(rotationZ));
         var cosZsinY:Number = cosZ * sinY;
         var sinZsinY:Number = sinZ * sinY;
         var cosYscaleX:Number = cosY * scaleX;
         var sinXscaleY:Number = sinX * scaleY;
         var cosXscaleY:Number = cosX * scaleY;
         var cosXscaleZ:Number = cosX * scaleZ;
         var sinXscaleZ:Number = sinX * scaleZ;
         this.a = cosZ * cosYscaleX;
         this.b = cosZsinY * sinXscaleY - sinZ * cosXscaleY;
         this.c = cosZsinY * cosXscaleZ + sinZ * sinXscaleZ;
         this.d = x;
         this.e = sinZ * cosYscaleX;
         this.f = sinZsinY * sinXscaleY + cosZ * cosXscaleY;
         this.g = sinZsinY * cosXscaleZ - cosZ * sinXscaleZ;
         this.h = y;
         this.i = -sinY * scaleX;
         this.j = cosY * sinXscaleY;
         this.k = cosY * cosXscaleZ;
         this.l = z;
      }
      
      public function method_292(x:Number, y:Number, z:Number, rotationX:Number, rotationY:Number, rotationZ:Number, scaleX:Number, scaleY:Number, scaleZ:Number) : void
      {
         var cosX:Number = Number(Math.cos(rotationX));
         var sinX:Number = Number(Math.sin(-rotationX));
         var cosY:Number = Number(Math.cos(rotationY));
         var sinY:Number = Number(Math.sin(-rotationY));
         var cosZ:Number = Number(Math.cos(rotationZ));
         var sinZ:Number = Number(Math.sin(-rotationZ));
         var sinXsinY:Number = sinX * sinY;
         var cosYscaleX:Number = cosY / scaleX;
         var cosXscaleY:Number = cosX / scaleY;
         var sinXscaleZ:Number = sinX / scaleZ;
         var cosXscaleZ:Number = cosX / scaleZ;
         this.a = cosZ * cosYscaleX;
         this.b = -sinZ * cosYscaleX;
         this.c = sinY / scaleX;
         this.d = -this.a * x - this.b * y - this.c * z;
         this.e = sinZ * cosXscaleY + sinXsinY * cosZ / scaleY;
         this.f = cosZ * cosXscaleY - sinXsinY * sinZ / scaleY;
         this.g = -sinX * cosY / scaleY;
         this.h = -this.e * x - this.f * y - this.g * z;
         this.i = sinZ * sinXscaleZ - cosZ * sinY * cosXscaleZ;
         this.j = cosZ * sinXscaleZ + sinY * sinZ * cosXscaleZ;
         this.k = cosY * cosXscaleZ;
         this.l = -this.i * x - this.j * y - this.k * z;
      }
      
      public function invert() : void
      {
         var ta:Number = this.a;
         var tb:Number = this.b;
         var tc:Number = this.c;
         var td:Number = this.d;
         var te:Number = this.e;
         var tf:Number = this.f;
         var tg:Number = this.g;
         var th:Number = this.h;
         var ti:Number = this.i;
         var tj:Number = this.j;
         var tk:Number = this.k;
         var tl:Number = this.l;
         var det:Number = 1 / (-tc * tf * ti + tb * tg * ti + tc * te * tj - ta * tg * tj - tb * te * tk + ta * tf * tk);
         this.a = (-tg * tj + tf * tk) * det;
         this.b = (tc * tj - tb * tk) * det;
         this.c = (-tc * tf + tb * tg) * det;
         this.d = (td * tg * tj - tc * th * tj - td * tf * tk + tb * th * tk + tc * tf * tl - tb * tg * tl) * det;
         this.e = (tg * ti - te * tk) * det;
         this.f = (-tc * ti + ta * tk) * det;
         this.g = (tc * te - ta * tg) * det;
         this.h = (tc * th * ti - td * tg * ti + td * te * tk - ta * th * tk - tc * te * tl + ta * tg * tl) * det;
         this.i = (-tf * ti + te * tj) * det;
         this.j = (tb * ti - ta * tj) * det;
         this.k = (-tb * te + ta * tf) * det;
         this.l = (td * tf * ti - tb * th * ti - td * te * tj + ta * th * tj + tb * te * tl - ta * tf * tl) * det;
      }
      
      public function method_294(vector:Vector.<Number>) : void
      {
         this.a = vector[0];
         this.b = vector[1];
         this.c = vector[2];
         this.d = vector[3];
         this.e = vector[4];
         this.f = vector[5];
         this.g = vector[6];
         this.h = vector[7];
         this.i = vector[8];
         this.j = vector[9];
         this.k = vector[10];
         this.l = vector[11];
      }
      
      public function append(transform:name_139) : void
      {
         var ta:Number = this.a;
         var tb:Number = this.b;
         var tc:Number = this.c;
         var td:Number = this.d;
         var te:Number = this.e;
         var tf:Number = this.f;
         var tg:Number = this.g;
         var th:Number = this.h;
         var ti:Number = this.i;
         var tj:Number = this.j;
         var tk:Number = this.k;
         var tl:Number = this.l;
         this.a = transform.a * ta + transform.b * te + transform.c * ti;
         this.b = transform.a * tb + transform.b * tf + transform.c * tj;
         this.c = transform.a * tc + transform.b * tg + transform.c * tk;
         this.d = transform.a * td + transform.b * th + transform.c * tl + transform.d;
         this.e = transform.e * ta + transform.f * te + transform.g * ti;
         this.f = transform.e * tb + transform.f * tf + transform.g * tj;
         this.g = transform.e * tc + transform.f * tg + transform.g * tk;
         this.h = transform.e * td + transform.f * th + transform.g * tl + transform.h;
         this.i = transform.i * ta + transform.j * te + transform.k * ti;
         this.j = transform.i * tb + transform.j * tf + transform.k * tj;
         this.k = transform.i * tc + transform.j * tg + transform.k * tk;
         this.l = transform.i * td + transform.j * th + transform.k * tl + transform.l;
      }
      
      public function prepend(transform:name_139) : void
      {
         var ta:Number = this.a;
         var tb:Number = this.b;
         var tc:Number = this.c;
         var td:Number = this.d;
         var te:Number = this.e;
         var tf:Number = this.f;
         var tg:Number = this.g;
         var th:Number = this.h;
         var ti:Number = this.i;
         var tj:Number = this.j;
         var tk:Number = this.k;
         var tl:Number = this.l;
         this.a = ta * transform.a + tb * transform.e + tc * transform.i;
         this.b = ta * transform.b + tb * transform.f + tc * transform.j;
         this.c = ta * transform.c + tb * transform.g + tc * transform.k;
         this.d = ta * transform.d + tb * transform.h + tc * transform.l + td;
         this.e = te * transform.a + tf * transform.e + tg * transform.i;
         this.f = te * transform.b + tf * transform.f + tg * transform.j;
         this.g = te * transform.c + tf * transform.g + tg * transform.k;
         this.h = te * transform.d + tf * transform.h + tg * transform.l + th;
         this.i = ti * transform.a + tj * transform.e + tk * transform.i;
         this.j = ti * transform.b + tj * transform.f + tk * transform.j;
         this.k = ti * transform.c + tj * transform.g + tk * transform.k;
         this.l = ti * transform.d + tj * transform.h + tk * transform.l + tl;
      }
      
      public function combine(transformA:name_139, transformB:name_139) : void
      {
         this.a = transformA.a * transformB.a + transformA.b * transformB.e + transformA.c * transformB.i;
         this.b = transformA.a * transformB.b + transformA.b * transformB.f + transformA.c * transformB.j;
         this.c = transformA.a * transformB.c + transformA.b * transformB.g + transformA.c * transformB.k;
         this.d = transformA.a * transformB.d + transformA.b * transformB.h + transformA.c * transformB.l + transformA.d;
         this.e = transformA.e * transformB.a + transformA.f * transformB.e + transformA.g * transformB.i;
         this.f = transformA.e * transformB.b + transformA.f * transformB.f + transformA.g * transformB.j;
         this.g = transformA.e * transformB.c + transformA.f * transformB.g + transformA.g * transformB.k;
         this.h = transformA.e * transformB.d + transformA.f * transformB.h + transformA.g * transformB.l + transformA.h;
         this.i = transformA.i * transformB.a + transformA.j * transformB.e + transformA.k * transformB.i;
         this.j = transformA.i * transformB.b + transformA.j * transformB.f + transformA.k * transformB.j;
         this.k = transformA.i * transformB.c + transformA.j * transformB.g + transformA.k * transformB.k;
         this.l = transformA.i * transformB.d + transformA.j * transformB.h + transformA.k * transformB.l + transformA.l;
      }
      
      public function calculateInversion(source:name_139) : void
      {
         var ta:Number = source.a;
         var tb:Number = source.b;
         var tc:Number = source.c;
         var td:Number = source.d;
         var te:Number = source.e;
         var tf:Number = source.f;
         var tg:Number = source.g;
         var th:Number = source.h;
         var ti:Number = source.i;
         var tj:Number = source.j;
         var tk:Number = source.k;
         var tl:Number = source.l;
         var det:Number = 1 / (-tc * tf * ti + tb * tg * ti + tc * te * tj - ta * tg * tj - tb * te * tk + ta * tf * tk);
         this.a = (-tg * tj + tf * tk) * det;
         this.b = (tc * tj - tb * tk) * det;
         this.c = (-tc * tf + tb * tg) * det;
         this.d = (td * tg * tj - tc * th * tj - td * tf * tk + tb * th * tk + tc * tf * tl - tb * tg * tl) * det;
         this.e = (tg * ti - te * tk) * det;
         this.f = (-tc * ti + ta * tk) * det;
         this.g = (tc * te - ta * tg) * det;
         this.h = (tc * th * ti - td * tg * ti + td * te * tk - ta * th * tk - tc * te * tl + ta * tg * tl) * det;
         this.i = (-tf * ti + te * tj) * det;
         this.j = (tb * ti - ta * tj) * det;
         this.k = (-tb * te + ta * tf) * det;
         this.l = (td * tf * ti - tb * th * ti - td * te * tj + ta * th * tj + tb * te * tl - ta * tf * tl) * det;
      }
      
      public function copy(source:name_139) : void
      {
         this.a = source.a;
         this.b = source.b;
         this.c = source.c;
         this.d = source.d;
         this.e = source.e;
         this.f = source.f;
         this.g = source.g;
         this.h = source.h;
         this.i = source.i;
         this.j = source.j;
         this.k = source.k;
         this.l = source.l;
      }
      
      public function toString() : String
      {
         return "[Transform3D" + " a:" + this.a.toFixed(3) + " b:" + this.b.toFixed(3) + " c:" + this.a.toFixed(3) + " d:" + this.d.toFixed(3) + " e:" + this.e.toFixed(3) + " f:" + this.f.toFixed(3) + " g:" + this.a.toFixed(3) + " h:" + this.h.toFixed(3) + " i:" + this.i.toFixed(3) + " j:" + this.j.toFixed(3) + " k:" + this.a.toFixed(3) + " l:" + this.l.toFixed(3) + "]";
      }
   }
}

