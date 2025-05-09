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
      
      private var var_322:ICodec;
      
      private var var_243:ICodec;
      
      private var var_321:ICodec;
      
      public function CodecA3D2Map()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.var_322 = protocol.getCodec(new TypeCodecInfo(UShort,false));
         this.var_243 = protocol.getCodec(new TypeCodecInfo(int,false));
         this.var_321 = protocol.getCodec(new TypeCodecInfo(int,false));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_channel:uint = uint(this.var_322.decode(protocolBuffer) as uint);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Map","channel",value_channel);
         var value_id:int = int(this.var_243.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Map","id",value_id);
         var value_imageId:int = int(this.var_321.decode(protocolBuffer) as int);
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
         this.var_322.encode(protocolBuffer,struct.channel);
         this.var_243.encode(protocolBuffer,struct.id);
         this.var_321.encode(protocolBuffer,struct.imageId);
      }
   }
}

