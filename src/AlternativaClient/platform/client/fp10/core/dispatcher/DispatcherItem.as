package platform.client.fp10.core.dispatcher
{
   public class DispatcherItem
   {
      
      public static const CLASS:int = 1;
      
      public static const RESOURCE:int = 2;
      
      public static const LEVEL_SEPARATOR:int = 3;
      
      public var type:int;
      
      public function DispatcherItem(param1:int)
      {
         super();
         this.type = param1;
      }
      
      public function toString() : String
      {
         return "[Separator]";
      }
   }
}

