package package_53
{
   import package_57.name_213;
   
   public class A3DImage
   {
      private var var_101:name_213;
      
      private var var_274:String;
      
      public function A3DImage(id:name_213, url:String)
      {
         super();
         this.var_101 = id;
         this.var_274 = url;
      }
      
      public function get id() : name_213
      {
         return this.var_101;
      }
      
      public function set id(value:name_213) : void
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

