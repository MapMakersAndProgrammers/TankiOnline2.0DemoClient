package versions.version2.a3d.materials
{
   public class A3D2CubeMap
   {
      private var name_0x:int;
      
      private var name_el:int;
      
      private var name_5I:int;
      
      private var name_3I:int;
      
      private var name_ML:int;
      
      private var name_K:int;
      
      private var name_pW:int;
      
      public function A3D2CubeMap(backId:int, bottomId:int, frontId:int, id:int, leftId:int, rightId:int, topId:int)
      {
         super();
         this.name_0x = backId;
         this.name_el = bottomId;
         this.name_5I = frontId;
         this.name_3I = id;
         this.name_ML = leftId;
         this.name_K = rightId;
         this.name_pW = topId;
      }
      
      public function get backId() : int
      {
         return this.name_0x;
      }
      
      public function set backId(value:int) : void
      {
         this.name_0x = value;
      }
      
      public function get bottomId() : int
      {
         return this.name_el;
      }
      
      public function set bottomId(value:int) : void
      {
         this.name_el = value;
      }
      
      public function get frontId() : int
      {
         return this.name_5I;
      }
      
      public function set frontId(value:int) : void
      {
         this.name_5I = value;
      }
      
      public function get id() : int
      {
         return this.name_3I;
      }
      
      public function set id(value:int) : void
      {
         this.name_3I = value;
      }
      
      public function get leftId() : int
      {
         return this.name_ML;
      }
      
      public function set leftId(value:int) : void
      {
         this.name_ML = value;
      }
      
      public function get rightId() : int
      {
         return this.name_K;
      }
      
      public function set rightId(value:int) : void
      {
         this.name_K = value;
      }
      
      public function get topId() : int
      {
         return this.name_pW;
      }
      
      public function set topId(value:int) : void
      {
         this.name_pW = value;
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

