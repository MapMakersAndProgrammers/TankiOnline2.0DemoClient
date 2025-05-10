package versions.version2.a3d.materials
{
   public class A3D2Image
   {
      private var name_3I:int;
      
      private var name_6D:String;
      
      public function A3D2Image(id:int, url:String)
      {
         super();
         this.name_3I = id;
         this.name_6D = url;
      }
      
      public function get id() : int
      {
         return this.name_3I;
      }
      
      public function set id(value:int) : void
      {
         this.name_3I = value;
      }
      
      public function get url() : String
      {
         return this.name_6D;
      }
      
      public function set url(value:String) : void
      {
         this.name_6D = value;
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

