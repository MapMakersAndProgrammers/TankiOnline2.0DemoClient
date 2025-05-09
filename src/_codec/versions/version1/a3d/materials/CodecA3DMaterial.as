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
      
      private var var_381:ICodec;
      
      private var var_386:ICodec;
      
      private var var_243:ICodec;
      
      private var var_384:ICodec;
      
      private var var_383:ICodec;
      
      private var var_385:ICodec;
      
      private var var_382:ICodec;
      
      public function CodecA3DMaterial()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.var_381 = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.var_386 = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.var_243 = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.var_384 = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.var_383 = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.var_385 = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.var_382 = protocol.getCodec(new TypeCodecInfo(Id,true));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_diffuseMapId:Id = this.var_381.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMaterial","diffuseMapId",value_diffuseMapId);
         var value_glossinessMapId:Id = this.var_386.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMaterial","glossinessMapId",value_glossinessMapId);
         var value_id:Id = this.var_243.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMaterial","id",value_id);
         var value_lightMapId:Id = this.var_384.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMaterial","lightMapId",value_lightMapId);
         var value_normalMapId:Id = this.var_383.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMaterial","normalMapId",value_normalMapId);
         var value_opacityMapId:Id = this.var_385.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMaterial","opacityMapId",value_opacityMapId);
         var value_specularMapId:Id = this.var_382.decode(protocolBuffer) as Id;
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
         this.var_381.encode(protocolBuffer,struct.diffuseMapId);
         this.var_386.encode(protocolBuffer,struct.glossinessMapId);
         this.var_243.encode(protocolBuffer,struct.id);
         this.var_384.encode(protocolBuffer,struct.lightMapId);
         this.var_383.encode(protocolBuffer,struct.normalMapId);
         this.var_385.encode(protocolBuffer,struct.opacityMapId);
         this.var_382.encode(protocolBuffer,struct.specularMapId);
      }
   }
}

