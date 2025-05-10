package versions.version1.a3d.materials
{
   import commons.Id;
   
   public class A3DMap
   {
      private var name_9y:uint;
      
      private var name_3I:Id;
      
      private var name_JE:Id;
      
      private var name_0U:Number;
      
      private var name_5k:Number;
      
      private var name_JZ:Number;
      
      private var name_XP:Number;
      
      public function A3DMap(channel:uint, id:Id, imageId:Id, uOffset:Number, uScale:Number, vOffset:Number, vScale:Number)
      {
         super();
         this.name_9y = channel;
         this.name_3I = id;
         this.name_JE = imageId;
         this.name_0U = uOffset;
         this.name_5k = uScale;
         this.name_JZ = vOffset;
         this.name_XP = vScale;
      }
      
      public function get channel() : uint
      {
         return this.name_9y;
      }
      
      public function set channel(value:uint) : void
      {
         this.name_9y = value;
      }
      
      public function get id() : Id
      {
         return this.name_3I;
      }
      
      public function set id(value:Id) : void
      {
         this.name_3I = value;
      }
      
      public function get imageId() : Id
      {
         return this.name_JE;
      }
      
      public function set imageId(value:Id) : void
      {
         this.name_JE = value;
      }
      
      public function get uOffset() : Number
      {
         return this.name_0U;
      }
      
      public function set uOffset(value:Number) : void
      {
         this.name_0U = value;
      }
      
      public function get uScale() : Number
      {
         return this.name_5k;
      }
      
      public function set uScale(value:Number) : void
      {
         this.name_5k = value;
      }
      
      public function get vOffset() : Number
      {
         return this.name_JZ;
      }
      
      public function set vOffset(value:Number) : void
      {
         this.name_JZ = value;
      }
      
      public function get vScale() : Number
      {
         return this.name_XP;
      }
      
      public function set vScale(value:Number) : void
      {
         this.name_XP = value;
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

