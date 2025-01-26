package package_128
{
   import flash.events.Event;
   import package_124.name_751;
   
   public class name_788 extends Event
   {
      public static const NOTIFY:String = "notify";
      
      public function name_788(notify:name_751)
      {
         super(NOTIFY);
      }
      
      public function get notify() : name_751
      {
         return name_751(target);
      }
   }
}

