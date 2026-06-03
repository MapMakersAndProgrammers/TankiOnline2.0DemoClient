package platform.client.fp10.core.dispatcher
{
   import alternativa.types.Long;
   
   public class DispatcherItemId extends DispatcherItem
   {
      
      public var id:Long;
      
      public function DispatcherItemId(param1:int, param2:Long)
      {
         super(param1);
         this.id = param2;
      }
   }
}

