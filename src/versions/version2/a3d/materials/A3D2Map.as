package versions.version2.a3d.materials
{
   public class A3D2Map
   {
      private var var_337:uint;
      
      private var var_101:int;
      
      private var var_338:int;
      
      public function A3D2Map(channel:uint, id:int, imageId:int)
      {
         super();
         this.var_337 = channel;
         this.var_101 = id;
         this.var_338 = imageId;
      }
      
      public function get channel() : uint
      {
         return this.var_337;
      }
      
      public function set channel(value:uint) : void
      {
         this.var_337 = value;
      }
      
      public function get id() : int
      {
         return this.var_101;
      }
      
      public function set id(value:int) : void
      {
         this.var_101 = value;
      }
      
      public function get imageId() : int
      {
         return this.var_338;
      }
      
      public function set imageId(value:int) : void
      {
         this.var_338 = value;
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

