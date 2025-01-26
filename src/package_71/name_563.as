package package_71
{
   public class name_563
   {
      public static const PAUSED:name_563 = new name_563("PAUSED");
      
      public static const DEAD:name_563 = new name_563("DEAD");
      
      public static const ACTIVATING:name_563 = new name_563("ACTIVATING");
      
      public static const ACTIVE:name_563 = new name_563("ACTIVE");
      
      public static const IN_RESPAWN:name_563 = new name_563("IN_RESPAWN");
      
      public static const DISABLED:name_563 = new name_563("DISABLED");
      
      private var stringValue:String;
      
      public function name_563(code:String)
      {
         super();
         this.stringValue = code;
      }
      
      public function toString() : String
      {
         return this.stringValue;
      }
   }
}

