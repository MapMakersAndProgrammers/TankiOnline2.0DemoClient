package package_13
{
   public class name_459
   {
      public function name_459()
      {
         super();
      }
      
      public static function name_460(param1:String) : String
      {
         if(Boolean(param1) && param1.charAt(param1.length - 1) != "/")
         {
            return param1 + "/";
         }
         return param1;
      }
   }
}

