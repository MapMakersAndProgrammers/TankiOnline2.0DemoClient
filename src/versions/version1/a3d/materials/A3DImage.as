package versions.version1.a3d.materials
{
   import commons.Id;
   
   public class A3DImage
   {
      private var §_-3I§:Id;
      
      private var §_-6D§:String;
      
      public function A3DImage(id:Id, url:String)
      {
         super();
         this.§_-3I§ = id;
         this.§_-6D§ = url;
      }
      
      public function get id() : Id
      {
         return this.§_-3I§;
      }
      
      public function set id(value:Id) : void
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
         var result:String = "A3DImage [";
         result += "id = " + this.id + " ";
         result += "url = " + this.url + " ";
         return result + "]";
      }
   }
}

