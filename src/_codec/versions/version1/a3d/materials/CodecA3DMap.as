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
      
      private var name_mC:ICodec;
      
      private var name_2o:ICodec;
      
      private var name_2N:ICodec;
      
      private var name_K5:ICodec;
      
      private var name_Q5:ICodec;
      
      private var name_WH:ICodec;
      
      private var name_kh:ICodec;
      
      public function CodecA3DMap()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.name_mC = protocol.getCodec(new TypeCodecInfo(UShort,false));
         this.name_2o = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.name_2N = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.name_K5 = protocol.getCodec(new TypeCodecInfo(Float,true));
         this.name_Q5 = protocol.getCodec(new TypeCodecInfo(Float,true));
         this.name_WH = protocol.getCodec(new TypeCodecInfo(Float,true));
         this.name_kh = protocol.getCodec(new TypeCodecInfo(Float,true));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_channel:uint = uint(this.name_mC.decode(protocolBuffer) as uint);
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMap","channel",value_channel);
         var value_id:Id = this.name_2o.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMap","id",value_id);
         var value_imageId:Id = this.name_2N.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMap","imageId",value_imageId);
         var value_uOffset:Number = Number(this.name_K5.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMap","uOffset",value_uOffset);
         var value_uScale:Number = Number(this.name_Q5.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMap","uScale",value_uScale);
         var value_vOffset:Number = Number(this.name_WH.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMap","vOffset",value_vOffset);
         var value_vScale:Number = Number(this.name_kh.decode(protocolBuffer) as Number);
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
         this.name_mC.encode(protocolBuffer,struct.channel);
         this.name_2o.encode(protocolBuffer,struct.id);
         this.name_2N.encode(protocolBuffer,struct.imageId);
         this.name_K5.encode(protocolBuffer,struct.uOffset);
         this.name_Q5.encode(protocolBuffer,struct.uScale);
         this.name_WH.encode(protocolBuffer,struct.vOffset);
         this.name_kh.encode(protocolBuffer,struct.vScale);
      }
   }
}

