package versions.version2.a3d.materials
{
   public class A3D2Image
   {
      private var §_-3I§:int;
      
      private var §_-6D§:String;
      
      public function A3D2Image(id:int, url:String)
      {
         super();
         this.§_-3I§ = id;
         this.§_-6D§ = url;
      }
      
      public function get id() : int
      {
         return this.§_-3I§;
      }
      
      public function set id(value:int) : void
      {
         this.§_-3I§ = value;
      }
      
      public function get url() : String
      {
         return this.§_-6D§;
      }
      
      public function set url(value:String) : void
      {
         this.§_-6D§ = value;
      }
      
      public function toString() : String
      {
         var result:String = "A3D2Image [";
         result += "id = " + this.id + " ";
         result += "url = " + this.url + " ";
         return result + "]";
      }
   }
}

