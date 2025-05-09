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
      
      private var §_-9A§:ICodec;
      
      private var §_-hw§:ICodec;
      
      private var §_-2o§:ICodec;
      
      private var §_-Hu§:ICodec;
      
      private var §_-GK§:ICodec;
      
      private var §_-LZ§:ICodec;
      
      private var §_-bz§:ICodec;
      
      private var §_-FU§:ICodec;
      
      public function CodecA3D2Material()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.§_-9A§ = protocol.getCodec(new TypeCodecInfo(int,true));
         this.§_-hw§ = protocol.getCodec(new TypeCodecInfo(int,true));
         this.§_-2o§ = protocol.getCodec(new TypeCodecInfo(int,false));
         this.§_-Hu§ = protocol.getCodec(new TypeCodecInfo(int,true));
         this.§_-GK§ = protocol.getCodec(new TypeCodecInfo(int,true));
         this.§_-LZ§ = protocol.getCodec(new TypeCodecInfo(int,true));
         this.§_-bz§ = protocol.getCodec(new TypeCodecInfo(int,true));
         this.§_-FU§ = protocol.getCodec(new TypeCodecInfo(int,true));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_diffuseMapId:int = int(this.§_-9A§.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Material","diffuseMapId",value_diffuseMapId);
         var value_glossinessMapId:int = int(this.§_-hw§.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Material","glossinessMapId",value_glossinessMapId);
         var value_id:int = int(this.§_-2o§.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Material","id",value_id);
         var value_lightMapId:int = int(this.§_-Hu§.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Material","lightMapId",value_lightMapId);
         var value_normalMapId:int = int(this.§_-GK§.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Material","normalMapId",value_normalMapId);
         var value_opacityMapId:int = int(this.§_-LZ§.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Material","opacityMapId",value_opacityMapId);
         var value_reflectionCubeMapId:int = int(this.§_-bz§.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Material","reflectionCubeMapId",value_reflectionCubeMapId);
         var value_specularMapId:int = int(this.§_-FU§.decode(protocolBuffer) as int);
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
         this.§_-9A§.encode(protocolBuffer,struct.diffuseMapId);
         this.§_-hw§.encode(protocolBuffer,struct.glossinessMapId);
         this.§_-2o§.encode(protocolBuffer,struct.id);
         this.§_-Hu§.encode(protocolBuffer,struct.lightMapId);
         this.§_-GK§.encode(protocolBuffer,struct.normalMapId);
         this.§_-LZ§.encode(protocolBuffer,struct.opacityMapId);
         this.§_-bz§.encode(protocolBuffer,struct.reflectionCubeMapId);
         this.§_-FU§.encode(protocolBuffer,struct.specularMapId);
      }
   }
}

