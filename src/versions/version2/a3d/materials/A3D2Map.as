package versions.version2.a3d.materials
{
   public class A3D2Map
   {
      private var §_-9y§:uint;
      
      private var §_-3I§:int;
      
      private var §_-JE§:int;
      
      public function A3D2Map(channel:uint, id:int, imageId:int)
      {
         super();
         this.§_-9y§ = channel;
         this.§_-3I§ = id;
         this.§_-JE§ = imageId;
      }
      
      public function get channel() : uint
      {
         return this.§_-9y§;
      }
      
      public function set channel(value:uint) : void
      {
         this.§_-9y§ = value;
      }
      
      public function get id() : int
      {
         return this.§_-3I§;
      }
      
      public function set id(value:int) : void
      {
         this.§_-3I§ = value;
      }
      
      public function get imageId() : int
      {
         return this.§_-JE§;
      }
      
      public function set imageId(value:int) : void
      {
         this.§_-JE§ = value;
      }
      
      public function toString() : String
      {
         var result:String = "A3D2Map [";
         result += "channel = " + this.channel + " ";
         result += "id = " + this.id + " ";
         result += "imageId = " + this.imageId + " ";
         return result + "]";
      }
   }
}

