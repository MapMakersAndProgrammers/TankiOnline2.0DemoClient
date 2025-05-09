package _codec.commons
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import commons.Id;
   
   public class CodecId implements ICodec
   {
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var §_-2o§:ICodec;
      
      public function CodecId()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.§_-2o§ = protocol.getCodec(new TypeCodecInfo(uint,false));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_id:uint = uint(this.§_-2o§.decode(protocolBuffer) as uint);
         log.log("codec","struct %1 field %2 value %3","commons.Id","id",value_id);
         return new Id(value_id);
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:Id = Id(object);
         this.§_-2o§.encode(protocolBuffer,struct.id);
      }
   }
}

