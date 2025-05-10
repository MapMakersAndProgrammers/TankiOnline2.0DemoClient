package versions.version2.a3d.materials
{
   public class A3D2Map
   {
      private var name_9y:uint;
      
      private var name_3I:int;
      
      private var name_JE:int;
      
      public function A3D2Map(channel:uint, id:int, imageId:int)
      {
         super();
         this.name_9y = channel;
         this.name_3I = id;
         this.name_JE = imageId;
      }
      
      public function get channel() : uint
      {
         return this.name_9y;
      }
      
      public function set channel(value:uint) : void
      {
         this.name_9y = value;
      }
      
      public function get id() : int
      {
         return this.name_3I;
      }
      
      public function set id(value:int) : void
      {
         this.name_3I = value;
      }
      
      public function get imageId() : int
      {
         return this.name_JE;
      }
      
      public function set imageId(value:int) : void
      {
         this.name_JE = value;
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

