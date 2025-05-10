package _codec.versions.version1.a3d.id
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import versions.version1.a3d.id.ParentId;
   
   public class CodecParentId implements ICodec
   {
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var name_2o:ICodec;
      
      public function CodecParentId()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.name_2o = protocol.getCodec(new TypeCodecInfo(uint,false));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_id:uint = uint(this.name_2o.decode(protocolBuffer) as uint);
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.id.ParentId","id",value_id);
         return new ParentId(value_id);
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:ParentId = ParentId(object);
         this.name_2o.encode(protocolBuffer,struct.id);
      }
   }
}

