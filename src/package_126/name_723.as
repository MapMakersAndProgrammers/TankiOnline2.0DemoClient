package package_126
{
   public class name_723
   {
      public static const NONE:name_723 = new name_723("NONE");
      
      public static const RED:name_723 = new name_723("RED");
      
      public static const BLUE:name_723 = new name_723("BLUE");
      
      private var value:String;
      
      public function name_723(value:String)
      {
         super();
         this.value = value;
      }
      
      public function toString() : String
      {
         return this.value;
      }
   }
}

