package versions.version1.a3d.materials
{
   import commons.Id;
   
   public class A3DImage
   {
      private var name_3I:Id;
      
      private var name_6D:String;
      
      public function A3DImage(id:Id, url:String)
      {
         super();
         this.name_3I = id;
         this.name_6D = url;
      }
      
      public function get id() : Id
      {
         return this.name_3I;
      }
      
      public function set id(value:Id) : void
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
         var result:String = "A3DImage [";
         result += "id = " + this.id + " ";
         result += "url = " + this.url + " ";
         return result + "]";
      }
   }
}

