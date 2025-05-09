package versions.version1.a3d.materials
{
   import commons.Id;
   
   public class A3DImage
   {
      private var var_101:Id;
      
      private var var_274:String;
      
      public function A3DImage(id:Id, url:String)
      {
         super();
         this.var_101 = id;
         this.var_274 = url;
      }
      
      public function get id() : Id
      {
         return this.var_101;
      }
      
      public function set id(value:Id) : void
      {
         this.var_101 = value;
      }
      
      public function get url() : String
      {
         return this.var_274;
      }
      
      public function set url(value:String) : void
      {
         this.var_274 = value;
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

