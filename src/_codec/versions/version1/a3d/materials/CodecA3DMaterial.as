package _codec.versions.version1.a3d.materials
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import commons.Id;
   import versions.version1.a3d.materials.A3DMaterial;
   
   public class CodecA3DMaterial implements ICodec
   {
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var §_-9A§:ICodec;
      
      private var §_-hw§:ICodec;
      
      private var §_-2o§:ICodec;
      
      private var §_-Hu§:ICodec;
      
      private var §_-GK§:ICodec;
      
      private var §_-LZ§:ICodec;
      
      private var §_-FU§:ICodec;
      
      public function CodecA3DMaterial()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.§_-9A§ = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.§_-hw§ = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.§_-2o§ = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.§_-Hu§ = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.§_-GK§ = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.§_-LZ§ = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.§_-FU§ = protocol.getCodec(new TypeCodecInfo(Id,true));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_diffuseMapId:Id = this.§_-9A§.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMaterial","diffuseMapId",value_diffuseMapId);
         var value_glossinessMapId:Id = this.§_-hw§.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMaterial","glossinessMapId",value_glossinessMapId);
         var value_id:Id = this.§_-2o§.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMaterial","id",value_id);
         var value_lightMapId:Id = this.§_-Hu§.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMaterial","lightMapId",value_lightMapId);
         var value_normalMapId:Id = this.§_-GK§.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMaterial","normalMapId",value_normalMapId);
         var value_opacityMapId:Id = this.§_-LZ§.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMaterial","opacityMapId",value_opacityMapId);
         var value_specularMapId:Id = this.§_-FU§.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMaterial","specularMapId",value_specularMapId);
         return new A3DMaterial(value_diffuseMapId,value_glossinessMapId,value_id,value_lightMapId,value_normalMapId,value_opacityMapId,value_specularMapId);
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3DMaterial = A3DMaterial(object);
         this.§_-9A§.encode(protocolBuffer,struct.diffuseMapId);
         this.§_-hw§.encode(protocolBuffer,struct.glossinessMapId);
         this.§_-2o§.encode(protocolBuffer,struct.id);
         this.§_-Hu§.encode(protocolBuffer,struct.lightMapId);
         this.§_-GK§.encode(protocolBuffer,struct.normalMapId);
         this.§_-LZ§.encode(protocolBuffer,struct.opacityMapId);
         this.§_-FU§.encode(protocolBuffer,struct.specularMapId);
      }
   }
}

