package commons
{
   public class A3DMatrix
   {
      private var §_-Cw§:Number;
      
      private var §_-gS§:Number;
      
      private var §_-ne§:Number;
      
      private var §_-72§:Number;
      
      private var §_-mV§:Number;
      
      private var _f:Number;
      
      private var §_-eD§:Number;
      
      private var §_-ih§:Number;
      
      private var §_-Lu§:Number;
      
      private var §_-cJ§:Number;
      
      private var §_-SO§:Number;
      
      private var §_-UI§:Number;
      
      public function A3DMatrix(a:Number, b:Number, c:Number, d:Number, e:Number, f:Number, g:Number, h:Number, i:Number, j:Number, k:Number, l:Number)
      {
         super();
         this.§_-Cw§ = a;
         this.§_-gS§ = b;
         this.§_-ne§ = c;
         this.§_-72§ = d;
         this.§_-mV§ = e;
         this._f = f;
         this.§_-eD§ = g;
         this.§_-ih§ = h;
         this.§_-Lu§ = i;
         this.§_-cJ§ = j;
         this.§_-SO§ = k;
         this.§_-UI§ = l;
      }
      
      public function get a() : Number
      {
         return this.§_-Cw§;
      }
      
      public function set a(value:Number) : void
      {
         this.§_-Cw§ = value;
      }
      
      public function get b() : Number
      {
         return this.§_-gS§;
      }
      
      public function set b(value:Number) : void
      {
         this.§_-gS§ = value;
      }
      
      public function get c() : Number
      {
         return this.§_-ne§;
      }
      
      public function set c(value:Number) : void
      {
         this.§_-ne§ = value;
      }
      
      public function get d() : Number
      {
         return this.§_-72§;
      }
      
      public function set d(value:Number) : void
      {
         this.§_-72§ = value;
      }
      
      public function get e() : Number
      {
         return this.§_-mV§;
      }
      
      public function set e(value:Number) : void
      {
         this.§_-mV§ = value;
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
         return this.§_-eD§;
      }
      
      public function set g(value:Number) : void
      {
         this.§_-eD§ = value;
      }
      
      public function get h() : Number
      {
         return this.§_-ih§;
      }
      
      public function set h(value:Number) : void
      {
         this.§_-ih§ = value;
      }
      
      public function get i() : Number
      {
         return this.§_-Lu§;
      }
      
      public function set i(value:Number) : void
      {
         this.§_-Lu§ = value;
      }
      
      public function get j() : Number
      {
         return this.§_-cJ§;
      }
      
      public function set j(value:Number) : void
      {
         this.§_-cJ§ = value;
      }
      
      public function get k() : Number
      {
         return this.§_-SO§;
      }
      
      public function set k(value:Number) : void
      {
         this.§_-SO§ = value;
      }
      
      public function get l() : Number
      {
         return this.§_-UI§;
      }
      
      public function set l(value:Number) : void
      {
         this.§_-UI§ = value;
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

