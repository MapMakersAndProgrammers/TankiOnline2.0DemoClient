package alternativa.tanks.utils
{
   public class XMLHelper
   {
      public function XMLHelper()
      {
         super();
      }
      
      public static function parseStringArray(param1:XML) : Array
      {
         if(param1 == null)
         {
            return [];
         }
         return param1.text().toString().split(/\s+/);
      }
   }
}

