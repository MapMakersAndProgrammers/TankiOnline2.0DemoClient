package _codec.versions.version1.a3d.materials
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import commons.Id;
   import versions.version1.a3d.materials.A3DImage;
   
   public class CodecA3DImage implements ICodec
   {
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var §_-2o§:ICodec;
      
      private var §_-aV§:ICodec;
      
      public function CodecA3DImage()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.§_-2o§ = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.§_-aV§ = protocol.getCodec(new TypeCodecInfo(String,true));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_id:Id = this.§_-2o§.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DImage","id",value_id);
         var value_url:String = this.§_-aV§.decode(protocolBuffer) as String;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DImage","url",value_url);
         return new A3DImage(value_id,value_url);
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3DImage = A3DImage(object);
         this.§_-2o§.encode(protocolBuffer,struct.id);
         this.§_-aV§.encode(protocolBuffer,struct.url);
      }
   }
}

