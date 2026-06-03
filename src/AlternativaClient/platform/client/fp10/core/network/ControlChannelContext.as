package platform.client.fp10.core.network
{
   import alternativa.protocol.IProtocol;
   import flash.utils.ByteArray;
   import platform.client.fp10.core.dispatcher.Dispatcher;
   
   public class ControlChannelContext
   {
      
      public var hash:ByteArray;
      
      public var spaceProtocol:IProtocol;
      
      public var dispatcher:Dispatcher;
      
      public function ControlChannelContext()
      {
         super();
      }
   }
}

