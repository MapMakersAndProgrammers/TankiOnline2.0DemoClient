package package_40
{
   public class name_564
   {
      public function name_564()
      {
         super();
      }
      
      public static function name_565(param1:XML) : Array
      {
         if(param1 == null)
         {
            return [];
         }
         return param1.text().toString().split(/\s+/);
      }
   }
}

