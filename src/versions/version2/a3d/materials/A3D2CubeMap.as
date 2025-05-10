package versions.version2.a3d.materials
{
   public class A3D2CubeMap
   {
      private var §_-0x§:int;
      
      private var §_-el§:int;
      
      private var §_-5I§:int;
      
      private var §_-3I§:int;
      
      private var §_-ML§:int;
      
      private var §_-K§:int;
      
      private var §_-pW§:int;
      
      public function A3D2CubeMap(backId:int, bottomId:int, frontId:int, id:int, leftId:int, rightId:int, topId:int)
      {
         super();
         this.§_-0x§ = backId;
         this.§_-el§ = bottomId;
         this.§_-5I§ = frontId;
         this.§_-3I§ = id;
         this.§_-ML§ = leftId;
         this.§_-K§ = rightId;
         this.§_-pW§ = topId;
      }
      
      public function get backId() : int
      {
         return this.§_-0x§;
      }
      
      public function set backId(value:int) : void
      {
         this.§_-0x§ = value;
      }
      
      public function get bottomId() : int
      {
         return this.§_-el§;
      }
      
      public function set bottomId(value:int) : void
      {
         this.§_-el§ = value;
      }
      
      public function get frontId() : int
      {
         return this.§_-5I§;
      }
      
      public function set frontId(value:int) : void
      {
         this.§_-5I§ = value;
      }
      
      public function get id() : int
      {
         return this.§_-3I§;
      }
      
      public function set id(value:int) : void
      {
         this.§_-3I§ = value;
      }
      
      public function get leftId() : int
      {
         return this.§_-ML§;
      }
      
      public function set leftId(value:int) : void
      {
         this.§_-ML§ = value;
      }
      
      public function get rightId() : int
      {
         return this.§_-K§;
      }
      
      public function set rightId(value:int) : void
      {
         this.§_-K§ = value;
      }
      
      public function get topId() : int
      {
         return this.§_-pW§;
      }
      
      public function set topId(value:int) : void
      {
         this.§_-pW§ = value;
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

