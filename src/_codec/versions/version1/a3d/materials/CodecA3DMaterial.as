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
      
      private var name_9A:ICodec;
      
      private var name_hw:ICodec;
      
      private var name_2o:ICodec;
      
      private var name_Hu:ICodec;
      
      private var name_GK:ICodec;
      
      private var name_LZ:ICodec;
      
      private var name_FU:ICodec;
      
      public function CodecA3DMaterial()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.name_9A = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.name_hw = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.name_2o = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.name_Hu = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.name_GK = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.name_LZ = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.name_FU = protocol.getCodec(new TypeCodecInfo(Id,true));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_diffuseMapId:Id = this.name_9A.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMaterial","diffuseMapId",value_diffuseMapId);
         var value_glossinessMapId:Id = this.name_hw.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMaterial","glossinessMapId",value_glossinessMapId);
         var value_id:Id = this.name_2o.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMaterial","id",value_id);
         var value_lightMapId:Id = this.name_Hu.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMaterial","lightMapId",value_lightMapId);
         var value_normalMapId:Id = this.name_GK.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMaterial","normalMapId",value_normalMapId);
         var value_opacityMapId:Id = this.name_LZ.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMaterial","opacityMapId",value_opacityMapId);
         var value_specularMapId:Id = this.name_FU.decode(protocolBuffer) as Id;
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
         this.name_9A.encode(protocolBuffer,struct.diffuseMapId);
         this.name_hw.encode(protocolBuffer,struct.glossinessMapId);
         this.name_2o.encode(protocolBuffer,struct.id);
         this.name_Hu.encode(protocolBuffer,struct.lightMapId);
         this.name_GK.encode(protocolBuffer,struct.normalMapId);
         this.name_LZ.encode(protocolBuffer,struct.opacityMapId);
         this.name_FU.encode(protocolBuffer,struct.specularMapId);
      }
   }
}

