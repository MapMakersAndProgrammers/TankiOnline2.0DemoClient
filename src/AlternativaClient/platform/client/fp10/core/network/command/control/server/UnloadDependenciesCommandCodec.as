package platform.client.fp10.core.network.command.control.server
{
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.CollectionCodecInfo;
   import alternativa.protocol.info.TypeCodecInfo;
   import platform.client.fp10.core.dispatcher.DispatcherItem;
   import platform.client.fp10.core.dispatcher.DispatcherItemId;
   
   public class UnloadDependenciesCommandCodec implements ICodec
   {
      
      private var arrayCodec:ICodec;
      
      public function UnloadDependenciesCommandCodec(param1:IProtocol)
      {
         super();
         this.init(param1);
      }
      
      public function init(param1:IProtocol) : void
      {
         this.arrayCodec = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(DispatcherItem,false),false,1));
      }
      
      public function encode(param1:ProtocolBuffer, param2:Object) : void
      {
      }
      
      public function decode(param1:ProtocolBuffer) : Object
      {
         var _loc2_:Vector.<DispatcherItemId> = Vector.<DispatcherItemId>(this.arrayCodec.decode(param1));
         return new UnloadDependenciesCommand(Vector.<DispatcherItemId>(_loc2_));
      }
   }
}

