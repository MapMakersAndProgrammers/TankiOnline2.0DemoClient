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
      
      private var §_-mC§:ICodec;
      
      private var §_-2o§:ICodec;
      
      private var §_-2N§:ICodec;
      
      private var §_-K5§:ICodec;
      
      private var §_-Q5§:ICodec;
      
      private var §_-WH§:ICodec;
      
      private var §_-kh§:ICodec;
      
      public function CodecA3DMap()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.§_-mC§ = protocol.getCodec(new TypeCodecInfo(UShort,false));
         this.§_-2o§ = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.§_-2N§ = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.§_-K5§ = protocol.getCodec(new TypeCodecInfo(Float,true));
         this.§_-Q5§ = protocol.getCodec(new TypeCodecInfo(Float,true));
         this.§_-WH§ = protocol.getCodec(new TypeCodecInfo(Float,true));
         this.§_-kh§ = protocol.getCodec(new TypeCodecInfo(Float,true));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_channel:uint = uint(this.§_-mC§.decode(protocolBuffer) as uint);
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMap","channel",value_channel);
         var value_id:Id = this.§_-2o§.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMap","id",value_id);
         var value_imageId:Id = this.§_-2N§.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMap","imageId",value_imageId);
         var value_uOffset:Number = Number(this.§_-K5§.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMap","uOffset",value_uOffset);
         var value_uScale:Number = Number(this.§_-Q5§.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMap","uScale",value_uScale);
         var value_vOffset:Number = Number(this.§_-WH§.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMap","vOffset",value_vOffset);
         var value_vScale:Number = Number(this.§_-kh§.decode(protocolBuffer) as Number);
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
         this.§_-mC§.encode(protocolBuffer,struct.channel);
         this.§_-2o§.encode(protocolBuffer,struct.id);
         this.§_-2N§.encode(protocolBuffer,struct.imageId);
         this.§_-K5§.encode(protocolBuffer,struct.uOffset);
         this.§_-Q5§.encode(protocolBuffer,struct.uScale);
         this.§_-WH§.encode(protocolBuffer,struct.vOffset);
         this.§_-kh§.encode(protocolBuffer,struct.vScale);
      }
   }
}

