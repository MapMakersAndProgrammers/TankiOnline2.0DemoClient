package platform.client.fp10.core.network.command.control.server
{
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import platform.client.fp10.core.dispatcher.DispatcherItem;
   
   public class LoadDependenciesCommandCodec implements ICodec
   {
      
      [Inject]
      public static var clientLog:IClientLog;
      
      private static const LOG_CHANNEL:String = "codec";
      
      private var intCodec:ICodec;
      
      private var dispatcherItemCodec:ICodec;
      
      public function LoadDependenciesCommandCodec(param1:IProtocol)
      {
         super();
         this.init(param1);
      }
      
      public function init(param1:IProtocol) : void
      {
         this.intCodec = param1.getCodec(new TypeCodecInfo(int,false));
         this.dispatcherItemCodec = param1.getCodec(new TypeCodecInfo(DispatcherItem,false));
      }
      
      public function encode(param1:ProtocolBuffer, param2:Object) : void
      {
      }
      
      public function decode(param1:ProtocolBuffer) : Object
      {
         var _loc2_:int = int(this.intCodec.decode(param1));
         var _loc3_:Vector.<DispatcherItem> = new Vector.<DispatcherItem>(_loc2_);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_[_loc4_] = DispatcherItem(this.dispatcherItemCodec.decode(param1));
            _loc4_++;
         }
         return new LoadDependenciesCommand(_loc3_);
      }
   }
}

