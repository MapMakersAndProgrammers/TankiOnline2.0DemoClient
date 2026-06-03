package platform.client.fp10.core.service.messagebox
{
   public class MessageBoxButton
   {
      
      public static const OK:int = 1;
      
      public static const CANCEL:int = 1 << 1;
      
      public static const CLOSE:int = 1 << 2;
      
      public static const YES:int = 1 << 3;
      
      public static const YES_TO_ALL:int = 1 << 4;
      
      public static const NO:int = 1 << 5;
      
      public static const NO_TO_ALL:int = 1 << 6;
      
      public static const USER_TYPE_BEGIN:int = 1 << 7;
      
      public function MessageBoxButton()
      {
         super();
      }
   }
}

