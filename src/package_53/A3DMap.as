package package_53
{
   import package_57.name_213;
   
   public class A3DMap
   {
      private var var_338:uint;
      
      private var var_101:name_213;
      
      private var var_337:name_213;
      
      private var var_414:Number;
      
      private var var_413:Number;
      
      private var var_415:Number;
      
      private var var_416:Number;
      
      public function A3DMap(channel:uint, id:name_213, imageId:name_213, uOffset:Number, uScale:Number, vOffset:Number, vScale:Number)
      {
         super();
         this.var_338 = channel;
         this.var_101 = id;
         this.var_337 = imageId;
         this.var_414 = uOffset;
         this.var_413 = uScale;
         this.var_415 = vOffset;
         this.var_416 = vScale;
      }
      
      public function get channel() : uint
      {
         return this.var_338;
      }
      
      public function set channel(value:uint) : void
      {
         this.var_338 = value;
      }
      
      public function get id() : name_213
      {
         return this.var_101;
      }
      
      public function set id(value:name_213) : void
      {
         this.var_101 = value;
      }
      
      public function get imageId() : name_213
      {
         return this.var_337;
      }
      
      public function set imageId(value:name_213) : void
      {
         this.var_337 = value;
      }
      
      public function get uOffset() : Number
      {
         return this.var_414;
      }
      
      public function set uOffset(value:Number) : void
      {
         this.var_414 = value;
      }
      
      public function get uScale() : Number
      {
         return this.var_413;
      }
      
      public function set uScale(value:Number) : void
      {
         this.var_413 = value;
      }
      
      public function get vOffset() : Number
      {
         return this.var_415;
      }
      
      public function set vOffset(value:Number) : void
      {
         this.var_415 = value;
      }
      
      public function get vScale() : Number
      {
         return this.var_416;
      }
      
      public function set vScale(value:Number) : void
      {
         this.var_416 = value;
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

