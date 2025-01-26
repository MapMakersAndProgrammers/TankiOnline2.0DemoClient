package package_51
{
   public class A3D2Image
   {
      private var var_101:int;
      
      private var var_274:String;
      
      public function A3D2Image(id:int, url:String)
      {
         super();
         this.var_101 = id;
         this.var_274 = url;
      }
      
      public function get id() : int
      {
         return this.var_101;
      }
      
      public function set id(value:int) : void
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
         var result:String = "A3D2Image [";
         result += "id = " + this.id + " ";
         result += "url = " + this.url + " ";
         return result + "]";
      }
   }
}

