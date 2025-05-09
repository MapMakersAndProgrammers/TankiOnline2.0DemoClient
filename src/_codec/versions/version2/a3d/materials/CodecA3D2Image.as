package _codec.versions.version2.a3d.materials
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import versions.version2.a3d.materials.A3D2Image;
   
   public class CodecA3D2Image implements ICodec
   {
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var §_-2o§:ICodec;
      
      private var §_-aV§:ICodec;
      
      public function CodecA3D2Image()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.§_-2o§ = protocol.getCodec(new TypeCodecInfo(int,false));
         this.§_-aV§ = protocol.getCodec(new TypeCodecInfo(String,false));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_id:int = int(this.§_-2o§.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Image","id",value_id);
         var value_url:String = this.§_-aV§.decode(protocolBuffer) as String;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Image","url",value_url);
         return new A3D2Image(value_id,value_url);
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3D2Image = A3D2Image(object);
         this.§_-2o§.encode(protocolBuffer,struct.id);
         this.§_-aV§.encode(protocolBuffer,struct.url);
      }
   }
}

