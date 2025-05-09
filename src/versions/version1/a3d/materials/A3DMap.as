package versions.version1.a3d.materials
{
   import commons.Id;
   
   public class A3DMap
   {
      private var §_-9y§:uint;
      
      private var §_-3I§:Id;
      
      private var §_-JE§:Id;
      
      private var §_-0U§:Number;
      
      private var §_-5k§:Number;
      
      private var §_-JZ§:Number;
      
      private var §_-XP§:Number;
      
      public function A3DMap(channel:uint, id:Id, imageId:Id, uOffset:Number, uScale:Number, vOffset:Number, vScale:Number)
      {
         super();
         this.§_-9y§ = channel;
         this.§_-3I§ = id;
         this.§_-JE§ = imageId;
         this.§_-0U§ = uOffset;
         this.§_-5k§ = uScale;
         this.§_-JZ§ = vOffset;
         this.§_-XP§ = vScale;
      }
      
      public function get channel() : uint
      {
         return this.§_-9y§;
      }
      
      public function set channel(value:uint) : void
      {
         this.§_-9y§ = value;
      }
      
      public function get id() : Id
      {
         return this.§_-3I§;
      }
      
      public function set id(value:Id) : void
      {
         this.§_-3I§ = value;
      }
      
      public function get imageId() : Id
      {
         return this.§_-JE§;
      }
      
      public function set imageId(value:Id) : void
      {
         this.§_-JE§ = value;
      }
      
      public function get uOffset() : Number
      {
         return this.§_-0U§;
      }
      
      public function set uOffset(value:Number) : void
      {
         this.§_-0U§ = value;
      }
      
      public function get uScale() : Number
      {
         return this.§_-5k§;
      }
      
      public function set uScale(value:Number) : void
      {
         this.§_-5k§ = value;
      }
      
      public function get vOffset() : Number
      {
         return this.§_-JZ§;
      }
      
      public function set vOffset(value:Number) : void
      {
         this.§_-JZ§ = value;
      }
      
      public function get vScale() : Number
      {
         return this.§_-XP§;
      }
      
      public function set vScale(value:Number) : void
      {
         this.§_-XP§ = value;
      }
      
      public function toString() : String
      {
         var result:String = "A3DMap [";
         result += "channel = " + this.channel + " ";
         result += "id = " + this.id + " ";
         result += "imageId = " + this.imageId + " ";
         result += "uOffset = " + this.uOffset + " ";
         result += "uScale = " + this.uScale + " ";
         result += "vOffset = " + this.vOffset + " ";
         result += "vScale = " + this.vScale + " ";
         return result + "]";
      }
   }
}

