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
      
      private var name_9A:ICodec;
      
      private var name_hw:ICodec;
      
      private var name_2o:ICodec;
      
      private var name_Hu:ICodec;
      
      private var name_GK:ICodec;
      
      private var name_LZ:ICodec;
      
      private var name_bz:ICodec;
      
      private var name_FU:ICodec;
      
      public function CodecA3D2Material()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.name_9A = protocol.getCodec(new TypeCodecInfo(int,true));
         this.name_hw = protocol.getCodec(new TypeCodecInfo(int,true));
         this.name_2o = protocol.getCodec(new TypeCodecInfo(int,false));
         this.name_Hu = protocol.getCodec(new TypeCodecInfo(int,true));
         this.name_GK = protocol.getCodec(new TypeCodecInfo(int,true));
         this.name_LZ = protocol.getCodec(new TypeCodecInfo(int,true));
         this.name_bz = protocol.getCodec(new TypeCodecInfo(int,true));
         this.name_FU = protocol.getCodec(new TypeCodecInfo(int,true));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_diffuseMapId:int = int(this.name_9A.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Material","diffuseMapId",value_diffuseMapId);
         var value_glossinessMapId:int = int(this.name_hw.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Material","glossinessMapId",value_glossinessMapId);
         var value_id:int = int(this.name_2o.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Material","id",value_id);
         var value_lightMapId:int = int(this.name_Hu.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Material","lightMapId",value_lightMapId);
         var value_normalMapId:int = int(this.name_GK.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Material","normalMapId",value_normalMapId);
         var value_opacityMapId:int = int(this.name_LZ.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Material","opacityMapId",value_opacityMapId);
         var value_reflectionCubeMapId:int = int(this.name_bz.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Material","reflectionCubeMapId",value_reflectionCubeMapId);
         var value_specularMapId:int = int(this.name_FU.decode(protocolBuffer) as int);
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
         this.name_9A.encode(protocolBuffer,struct.diffuseMapId);
         this.name_hw.encode(protocolBuffer,struct.glossinessMapId);
         this.name_2o.encode(protocolBuffer,struct.id);
         this.name_Hu.encode(protocolBuffer,struct.lightMapId);
         this.name_GK.encode(protocolBuffer,struct.normalMapId);
         this.name_LZ.encode(protocolBuffer,struct.opacityMapId);
         this.name_bz.encode(protocolBuffer,struct.reflectionCubeMapId);
         this.name_FU.encode(protocolBuffer,struct.specularMapId);
      }
   }
}

