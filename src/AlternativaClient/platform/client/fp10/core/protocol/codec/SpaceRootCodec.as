package platform.client.fp10.core.protocol.codec
{
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Long;
   import flash.utils.ByteArray;
   import platform.client.fp10.core.network.command.SpaceCommand;
   import platform.client.fp10.core.network.command.SpaceOpenedCommand;
   
   public class SpaceRootCodec implements ICodec
   {
      
      [Inject]
      public static var clientLog:IClientLog;
      
      public static const LOG_CHANNEL:String = "connection";
      
      private var spaceOpenedCommandCodec:ICodec;
      
      private var longCodec:ICodec;
      
      public function SpaceRootCodec()
      {
         super();
      }
      
      public function init(param1:IProtocol) : void
      {
         this.spaceOpenedCommandCodec = param1.getCodec(new TypeCodecInfo(SpaceOpenedCommand,false));
         this.longCodec = param1.getCodec(new TypeCodecInfo(Long,false));
      }
      
      public function encode(param1:ProtocolBuffer, param2:Object) : void
      {
         var _loc3_:SpaceCommand = null;
         var _loc4_:ByteArray = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(param2 is SpaceOpenedCommand)
         {
            this.spaceOpenedCommandCodec.encode(param1,param2);
         }
         else
         {
            if(!(param2 is SpaceCommand))
            {
               throw new Error("Unknown space command");
            }
            _loc3_ = SpaceCommand(param2);
            this.longCodec.encode(param1,_loc3_.objectId);
            this.longCodec.encode(param1,_loc3_.methodId);
            _loc4_ = ByteArray(_loc3_.protocolBuffer.reader);
            _loc4_.position = 0;
            while(Boolean(_loc4_.bytesAvailable))
            {
               _loc6_ = _loc4_.readByte();
               param1.writer.writeByte(_loc6_);
            }
            _loc3_.protocolBuffer.optionalMap.reset();
            _loc5_ = 0;
            while(_loc5_ < _loc3_.protocolBuffer.optionalMap.getSize())
            {
               param1.optionalMap.addBit(_loc3_.protocolBuffer.optionalMap.get());
               _loc5_++;
            }
         }
      }
      
      public function decode(param1:ProtocolBuffer) : Object
      {
         return param1;
      }
   }
}

