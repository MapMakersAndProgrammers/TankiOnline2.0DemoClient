package platform.client.fp10.core.protocol.codec
{
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Byte;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.dispatcher.DispatcherItemId;
   import platform.client.fp10.core.network.command.ControlCommand;
   import platform.client.fp10.core.network.command.SpaceOpenedCommand;
   import platform.client.fp10.core.network.command.control.client.LoaderParamsCommandCodec;
   import platform.client.fp10.core.network.command.control.client.LogCommandCodec;
   import platform.client.fp10.core.network.command.control.server.HashResponceCommandCodec;
   import platform.client.fp10.core.network.command.control.server.LoadDependenciesCommandCodec;
   import platform.client.fp10.core.network.command.control.server.OpenSpaceCommandCodec;
   import platform.client.fp10.core.network.command.control.server.UnloadDependenciesCommandCodec;
   import platform.client.fp10.core.service.serverlog.IServerLog;
   import platform.client.fp10.core.service.serverlog.LogLevel;
   
   public class ControlRootCodec implements ICodec
   {
      
      [Inject]
      public static var clientLog:IClientLog;
      
      [Inject]
      public static var logger:IServerLog;
      
      private static const LOG_CHANNEL:String = "codec";
      
      private var byteCodec:ICodec;
      
      private var serverCommandCodecs:Dictionary = new Dictionary();
      
      private var clientCommandCodecs:Dictionary = new Dictionary();
      
      public function ControlRootCodec()
      {
         super();
      }
      
      public function init(param1:IProtocol) : void
      {
         this.byteCodec = param1.getCodec(new TypeCodecInfo(Byte,false));
         param1.registerCodec(new TypeCodecInfo(DispatcherItemId,false),new DispatcherItemIdCodec());
         param1.registerCodec(new TypeCodecInfo(SpaceOpenedCommand,false),new SpaceOpenedCommandCodec());
         this.serverCommandCodecs[ControlCommand.SV_HASH_RESPONCE] = new HashResponceCommandCodec(param1);
         this.serverCommandCodecs[ControlCommand.SV_OPEN_SPACE] = new OpenSpaceCommandCodec(param1);
         this.serverCommandCodecs[ControlCommand.SV_LOAD_DEPENDENCIES] = new LoadDependenciesCommandCodec(param1);
         this.serverCommandCodecs[ControlCommand.SV_UNLOAD_DEPENDENCIES] = new UnloadDependenciesCommandCodec(param1);
         this.clientCommandCodecs[ControlCommand.CL_PARAMS] = new LoaderParamsCommandCodec(param1);
         this.clientCommandCodecs[ControlCommand.CL_LOG] = new LogCommandCodec(param1);
      }
      
      public function encode(param1:ProtocolBuffer, param2:Object) : void
      {
         var _loc3_:ControlCommand = ControlCommand(param2);
         this.byteCodec.encode(param1,_loc3_.id);
         var _loc4_:ICodec = this.clientCommandCodecs[_loc3_.id];
         if(_loc4_ != null)
         {
            _loc4_.encode(param1,param2);
         }
      }
      
      public function decode(param1:ProtocolBuffer) : Object
      {
         var _loc4_:String = null;
         var _loc2_:int = int(this.byteCodec.decode(param1));
         var _loc3_:ICodec = this.serverCommandCodecs[_loc2_];
         if(_loc3_ == null)
         {
            _loc4_ = "ControlRootCodec::doDecode() No codec found for command id=" + _loc2_;
            clientLog.log(LOG_CHANNEL,_loc4_);
            logger.log(LogLevel.ERROR,_loc4_);
            return null;
         }
         return _loc3_.decode(param1);
      }
   }
}

