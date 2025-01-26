package package_51
{
   public class A3D2CubeMap
   {
      private var var_279:int;
      
      private var var_283:int;
      
      private var var_280:int;
      
      private var var_101:int;
      
      private var var_278:int;
      
      private var var_281:int;
      
      private var var_282:int;
      
      public function A3D2CubeMap(backId:int, bottomId:int, frontId:int, id:int, leftId:int, rightId:int, topId:int)
      {
         super();
         this.var_279 = backId;
         this.var_283 = bottomId;
         this.var_280 = frontId;
         this.var_101 = id;
         this.var_278 = leftId;
         this.var_281 = rightId;
         this.var_282 = topId;
      }
      
      public function get backId() : int
      {
         return this.var_279;
      }
      
      public function set backId(value:int) : void
      {
         this.var_279 = value;
      }
      
      public function get bottomId() : int
      {
         return this.var_283;
      }
      
      public function set bottomId(value:int) : void
      {
         this.var_283 = value;
      }
      
      public function get frontId() : int
      {
         return this.var_280;
      }
      
      public function set frontId(value:int) : void
      {
         this.var_280 = value;
      }
      
      public function get id() : int
      {
         return this.var_101;
      }
      
      public function set id(value:int) : void
      {
         this.var_101 = value;
      }
      
      public function get leftId() : int
      {
         return this.var_278;
      }
      
      public function set leftId(value:int) : void
      {
         this.var_278 = value;
      }
      
      public function get rightId() : int
      {
         return this.var_281;
      }
      
      public function set rightId(value:int) : void
      {
         this.var_281 = value;
      }
      
      public function get topId() : int
      {
         return this.var_282;
      }
      
      public function set topId(value:int) : void
      {
         this.var_282 = value;
      }
      
      public function toString() : String
      {
         var result:String = "A3D2CubeMap [";
         result += "backId = " + this.backId + " ";
         result += "bottomId = " + this.bottomId + " ";
         result += "frontId = " + this.frontId + " ";
         result += "id = " + this.id + " ";
         result += "leftId = " + this.leftId + " ";
         result += "rightId = " + this.rightId + " ";
         result += "topId = " + this.topId + " ";
         return result + "]";
      }
   }
}

