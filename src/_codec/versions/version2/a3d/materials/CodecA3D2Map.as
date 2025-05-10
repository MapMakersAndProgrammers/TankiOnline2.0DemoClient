package _codec.versions.version2.a3d.materials
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.UShort;
   import versions.version2.a3d.materials.A3D2Map;
   
   public class CodecA3D2Map implements ICodec
   {
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var name_mC:ICodec;
      
      private var name_2o:ICodec;
      
      private var name_2N:ICodec;
      
      public function CodecA3D2Map()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.name_mC = protocol.getCodec(new TypeCodecInfo(UShort,false));
         this.name_2o = protocol.getCodec(new TypeCodecInfo(int,false));
         this.name_2N = protocol.getCodec(new TypeCodecInfo(int,false));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_channel:uint = uint(this.name_mC.decode(protocolBuffer) as uint);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Map","channel",value_channel);
         var value_id:int = int(this.name_2o.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Map","id",value_id);
         var value_imageId:int = int(this.name_2N.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Map","imageId",value_imageId);
         return new A3D2Map(value_channel,value_id,value_imageId);
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3D2Map = A3D2Map(object);
         this.name_mC.encode(protocolBuffer,struct.channel);
         this.name_2o.encode(protocolBuffer,struct.id);
         this.name_2N.encode(protocolBuffer,struct.imageId);
      }
   }
}

