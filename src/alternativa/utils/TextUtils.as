package alternativa.utils
{
   public class TextUtils
   {
      public function TextUtils()
      {
         super();
      }
      
      public static function replaceVars(msg:String, ... args) : String
      {
         var len:int = int(args.length);
         for(var i:int = 0; i < len; i++)
         {
            msg = msg.replace(new RegExp("%" + (i + 1),"g"),args[i]);
         }
         return msg;
      }
   }
}

