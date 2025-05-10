package commons
{
   public class A3DMatrix
   {
      private var name_Cw:Number;
      
      private var name_gS:Number;
      
      private var name_ne:Number;
      
      private var name_72:Number;
      
      private var name_mV:Number;
      
      private var _f:Number;
      
      private var name_eD:Number;
      
      private var name_ih:Number;
      
      private var name_Lu:Number;
      
      private var name_cJ:Number;
      
      private var name_SO:Number;
      
      private var name_UI:Number;
      
      public function A3DMatrix(a:Number, b:Number, c:Number, d:Number, e:Number, f:Number, g:Number, h:Number, i:Number, j:Number, k:Number, l:Number)
      {
         super();
         this.name_Cw = a;
         this.name_gS = b;
         this.name_ne = c;
         this.name_72 = d;
         this.name_mV = e;
         this._f = f;
         this.name_eD = g;
         this.name_ih = h;
         this.name_Lu = i;
         this.name_cJ = j;
         this.name_SO = k;
         this.name_UI = l;
      }
      
      public function get a() : Number
      {
         return this.name_Cw;
      }
      
      public function set a(value:Number) : void
      {
         this.name_Cw = value;
      }
      
      public function get b() : Number
      {
         return this.name_gS;
      }
      
      public function set b(value:Number) : void
      {
         this.name_gS = value;
      }
      
      public function get c() : Number
      {
         return this.name_ne;
      }
      
      public function set c(value:Number) : void
      {
         this.name_ne = value;
      }
      
      public function get d() : Number
      {
         return this.name_72;
      }
      
      public function set d(value:Number) : void
      {
         this.name_72 = value;
      }
      
      public function get e() : Number
      {
         return this.name_mV;
      }
      
      public function set e(value:Number) : void
      {
         this.name_mV = value;
      }
      
      public function get f() : Number
      {
         return this._f;
      }
      
      public function set f(value:Number) : void
      {
         this._f = value;
      }
      
      public function get g() : Number
      {
         return this.name_eD;
      }
      
      public function set g(value:Number) : void
      {
         this.name_eD = value;
      }
      
      public function get h() : Number
      {
         return this.name_ih;
      }
      
      public function set h(value:Number) : void
      {
         this.name_ih = value;
      }
      
      public function get i() : Number
      {
         return this.name_Lu;
      }
      
      public function set i(value:Number) : void
      {
         this.name_Lu = value;
      }
      
      public function get j() : Number
      {
         return this.name_cJ;
      }
      
      public function set j(value:Number) : void
      {
         this.name_cJ = value;
      }
      
      public function get k() : Number
      {
         return this.name_SO;
      }
      
      public function set k(value:Number) : void
      {
         this.name_SO = value;
      }
      
      public function get l() : Number
      {
         return this.name_UI;
      }
      
      public function set l(value:Number) : void
      {
         this.name_UI = value;
      }
      
      public function toString() : String
      {
         var result:String = "A3DMatrix [";
         result += "a = " + this.a + " ";
         result += "b = " + this.b + " ";
         result += "c = " + this.c + " ";
         result += "d = " + this.d + " ";
         result += "e = " + this.e + " ";
         result += "f = " + this.f + " ";
         result += "g = " + this.g + " ";
         result += "h = " + this.h + " ";
         result += "i = " + this.i + " ";
         result += "j = " + this.j + " ";
         result += "k = " + this.k + " ";
         result += "l = " + this.l + " ";
         return result + "]";
      }
   }
}

