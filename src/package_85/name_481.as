package package_85
{
   public class name_481
   {
      public static const NORMAL:name_481 = new name_481("NORMAL");
      
      public static const ACTIVATING:name_481 = new name_481("ACTIVATING");
      
      public static const DEAD:name_481 = new name_481("DEAD");
      
      private var stringValue:String;
      
      public function name_481(stringValue:String)
      {
         super();
         this.stringValue = stringValue;
      }
      
      public function toString() : String
      {
         return this.stringValue;
      }
   }
}

