package package_15
{
   public class name_718
   {
      public function name_718()
      {
         super();
      }
      
      public static function name_719(msg:String, ... args) : String
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

