package _codec.versions.version1.a3d.materials
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Float;
   import alternativa.types.UShort;
   import commons.Id;
   import versions.version1.a3d.materials.A3DMap;
   
   public class CodecA3DMap implements ICodec
   {
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var var_322:ICodec;
      
      private var var_243:ICodec;
      
      private var var_321:ICodec;
      
      private var var_407:ICodec;
      
      private var var_408:ICodec;
      
      private var var_409:ICodec;
      
      private var var_410:ICodec;
      
      public function CodecA3DMap()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.var_322 = protocol.getCodec(new TypeCodecInfo(UShort,false));
         this.var_243 = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.var_321 = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.var_407 = protocol.getCodec(new TypeCodecInfo(Float,true));
         this.var_408 = protocol.getCodec(new TypeCodecInfo(Float,true));
         this.var_409 = protocol.getCodec(new TypeCodecInfo(Float,true));
         this.var_410 = protocol.getCodec(new TypeCodecInfo(Float,true));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_channel:uint = uint(this.var_322.decode(protocolBuffer) as uint);
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMap","channel",value_channel);
         var value_id:Id = this.var_243.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMap","id",value_id);
         var value_imageId:Id = this.var_321.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMap","imageId",value_imageId);
         var value_uOffset:Number = Number(this.var_407.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMap","uOffset",value_uOffset);
         var value_uScale:Number = Number(this.var_408.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMap","uScale",value_uScale);
         var value_vOffset:Number = Number(this.var_409.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMap","vOffset",value_vOffset);
         var value_vScale:Number = Number(this.var_410.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMap","vScale",value_vScale);
         return new A3DMap(value_channel,value_id,value_imageId,value_uOffset,value_uScale,value_vOffset,value_vScale);
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3DMap = A3DMap(object);
         this.var_322.encode(protocolBuffer,struct.channel);
         this.var_243.encode(protocolBuffer,struct.id);
         this.var_321.encode(protocolBuffer,struct.imageId);
         this.var_407.encode(protocolBuffer,struct.uOffset);
         this.var_408.encode(protocolBuffer,struct.uScale);
         this.var_409.encode(protocolBuffer,struct.vOffset);
         this.var_410.encode(protocolBuffer,struct.vScale);
      }
   }
}

