package _codec.versions.version2.a3d.materials
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import versions.version2.a3d.materials.A3D2Material;
   
   public class CodecA3D2Material implements ICodec
   {
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var var_381:ICodec;
      
      private var var_386:ICodec;
      
      private var var_243:ICodec;
      
      private var var_384:ICodec;
      
      private var var_383:ICodec;
      
      private var var_385:ICodec;
      
      private var var_418:ICodec;
      
      private var var_382:ICodec;
      
      public function CodecA3D2Material()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.var_381 = protocol.getCodec(new TypeCodecInfo(int,true));
         this.var_386 = protocol.getCodec(new TypeCodecInfo(int,true));
         this.var_243 = protocol.getCodec(new TypeCodecInfo(int,false));
         this.var_384 = protocol.getCodec(new TypeCodecInfo(int,true));
         this.var_383 = protocol.getCodec(new TypeCodecInfo(int,true));
         this.var_385 = protocol.getCodec(new TypeCodecInfo(int,true));
         this.var_418 = protocol.getCodec(new TypeCodecInfo(int,true));
         this.var_382 = protocol.getCodec(new TypeCodecInfo(int,true));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_diffuseMapId:int = int(this.var_381.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Material","diffuseMapId",value_diffuseMapId);
         var value_glossinessMapId:int = int(this.var_386.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Material","glossinessMapId",value_glossinessMapId);
         var value_id:int = int(this.var_243.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Material","id",value_id);
         var value_lightMapId:int = int(this.var_384.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Material","lightMapId",value_lightMapId);
         var value_normalMapId:int = int(this.var_383.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Material","normalMapId",value_normalMapId);
         var value_opacityMapId:int = int(this.var_385.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Material","opacityMapId",value_opacityMapId);
         var value_reflectionCubeMapId:int = int(this.var_418.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Material","reflectionCubeMapId",value_reflectionCubeMapId);
         var value_specularMapId:int = int(this.var_382.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Material","specularMapId",value_specularMapId);
         return new A3D2Material(value_diffuseMapId,value_glossinessMapId,value_id,value_lightMapId,value_normalMapId,value_opacityMapId,value_reflectionCubeMapId,value_specularMapId);
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3D2Material = A3D2Material(object);
         this.var_381.encode(protocolBuffer,struct.diffuseMapId);
         this.var_386.encode(protocolBuffer,struct.glossinessMapId);
         this.var_243.encode(protocolBuffer,struct.id);
         this.var_384.encode(protocolBuffer,struct.lightMapId);
         this.var_383.encode(protocolBuffer,struct.normalMapId);
         this.var_385.encode(protocolBuffer,struct.opacityMapId);
         this.var_418.encode(protocolBuffer,struct.reflectionCubeMapId);
         this.var_382.encode(protocolBuffer,struct.specularMapId);
      }
   }
}

