package _codec.versions.version2.a3d
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.CollectionCodecInfo;
   import alternativa.protocol.info.TypeCodecInfo;
   import versions.version2.a3d.A3D2;
   import versions.version2.a3d.animation.A3D2AnimationClip;
   import versions.version2.a3d.animation.A3D2Track;
   import versions.version2.a3d.geometry.A3D2IndexBuffer;
   import versions.version2.a3d.geometry.A3D2VertexBuffer;
   import versions.version2.a3d.materials.A3D2CubeMap;
   import versions.version2.a3d.materials.A3D2Image;
   import versions.version2.a3d.materials.A3D2Map;
   import versions.version2.a3d.materials.A3D2Material;
   import versions.version2.a3d.objects.A3D2AmbientLight;
   import versions.version2.a3d.objects.A3D2Box;
   import versions.version2.a3d.objects.A3D2Decal;
   import versions.version2.a3d.objects.A3D2DirectionalLight;
   import versions.version2.a3d.objects.A3D2Joint;
   import versions.version2.a3d.objects.A3D2Mesh;
   import versions.version2.a3d.objects.A3D2Object;
   import versions.version2.a3d.objects.A3D2OmniLight;
   import versions.version2.a3d.objects.A3D2Skin;
   import versions.version2.a3d.objects.A3D2SpotLight;
   import versions.version2.a3d.objects.A3D2Sprite;
   
   public class CodecA3D2 implements ICodec
   {
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var name_8X:ICodec;
      
      private var name_Fa:ICodec;
      
      private var name_Aj:ICodec;
      
      private var name_EA:ICodec;
      
      private var name_lJ:ICodec;
      
      private var name_9f:ICodec;
      
      private var name_GC:ICodec;
      
      private var name_Sd:ICodec;
      
      private var name_76:ICodec;
      
      private var name_3f:ICodec;
      
      private var name_dB:ICodec;
      
      private var name_77:ICodec;
      
      private var name_PJ:ICodec;
      
      private var name_1x:ICodec;
      
      private var name_aP:ICodec;
      
      private var name_e9:ICodec;
      
      private var name_3y:ICodec;
      
      private var name_E2:ICodec;
      
      private var name_U9:ICodec;
      
      public function CodecA3D2()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.name_8X = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2AmbientLight,false),true,1));
         this.name_Fa = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2AnimationClip,false),true,1));
         this.name_Aj = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Track,false),true,1));
         this.name_EA = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Box,false),true,1));
         this.name_lJ = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2CubeMap,false),true,1));
         this.name_9f = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Decal,false),true,1));
         this.name_GC = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2DirectionalLight,false),true,1));
         this.name_Sd = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Image,false),true,1));
         this.name_76 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2IndexBuffer,false),true,1));
         this.name_3f = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Joint,false),true,1));
         this.name_dB = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Map,false),true,1));
         this.name_77 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Material,false),true,1));
         this.name_PJ = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Mesh,false),true,1));
         this.name_1x = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Object,false),true,1));
         this.name_aP = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2OmniLight,false),true,1));
         this.name_e9 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Skin,false),true,1));
         this.name_3y = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2SpotLight,false),true,1));
         this.name_E2 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Sprite,false),true,1));
         this.name_U9 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2VertexBuffer,false),true,1));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_ambientLights:Vector.<A3D2AmbientLight> = this.name_8X.decode(protocolBuffer) as Vector.<A3D2AmbientLight>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","ambientLights",value_ambientLights);
         var value_animationClips:Vector.<A3D2AnimationClip> = this.name_Fa.decode(protocolBuffer) as Vector.<A3D2AnimationClip>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","animationClips",value_animationClips);
         var value_animationTracks:Vector.<A3D2Track> = this.name_Aj.decode(protocolBuffer) as Vector.<A3D2Track>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","animationTracks",value_animationTracks);
         var value_boxes:Vector.<A3D2Box> = this.name_EA.decode(protocolBuffer) as Vector.<A3D2Box>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","boxes",value_boxes);
         var value_cubeMaps:Vector.<A3D2CubeMap> = this.name_lJ.decode(protocolBuffer) as Vector.<A3D2CubeMap>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","cubeMaps",value_cubeMaps);
         var value_decals:Vector.<A3D2Decal> = this.name_9f.decode(protocolBuffer) as Vector.<A3D2Decal>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","decals",value_decals);
         var value_directionalLights:Vector.<A3D2DirectionalLight> = this.name_GC.decode(protocolBuffer) as Vector.<A3D2DirectionalLight>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","directionalLights",value_directionalLights);
         var value_images:Vector.<A3D2Image> = this.name_Sd.decode(protocolBuffer) as Vector.<A3D2Image>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","images",value_images);
         var value_indexBuffers:Vector.<A3D2IndexBuffer> = this.name_76.decode(protocolBuffer) as Vector.<A3D2IndexBuffer>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","indexBuffers",value_indexBuffers);
         var value_joints:Vector.<A3D2Joint> = this.name_3f.decode(protocolBuffer) as Vector.<A3D2Joint>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","joints",value_joints);
         var value_maps:Vector.<A3D2Map> = this.name_dB.decode(protocolBuffer) as Vector.<A3D2Map>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","maps",value_maps);
         var value_materials:Vector.<A3D2Material> = this.name_77.decode(protocolBuffer) as Vector.<A3D2Material>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","materials",value_materials);
         var value_meshes:Vector.<A3D2Mesh> = this.name_PJ.decode(protocolBuffer) as Vector.<A3D2Mesh>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","meshes",value_meshes);
         var value_objects:Vector.<A3D2Object> = this.name_1x.decode(protocolBuffer) as Vector.<A3D2Object>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","objects",value_objects);
         var value_omniLights:Vector.<A3D2OmniLight> = this.name_aP.decode(protocolBuffer) as Vector.<A3D2OmniLight>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","omniLights",value_omniLights);
         var value_skins:Vector.<A3D2Skin> = this.name_e9.decode(protocolBuffer) as Vector.<A3D2Skin>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","skins",value_skins);
         var value_spotLights:Vector.<A3D2SpotLight> = this.name_3y.decode(protocolBuffer) as Vector.<A3D2SpotLight>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","spotLights",value_spotLights);
         var value_sprites:Vector.<A3D2Sprite> = this.name_E2.decode(protocolBuffer) as Vector.<A3D2Sprite>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","sprites",value_sprites);
         var value_vertexBuffers:Vector.<A3D2VertexBuffer> = this.name_U9.decode(protocolBuffer) as Vector.<A3D2VertexBuffer>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","vertexBuffers",value_vertexBuffers);
         return new A3D2(value_ambientLights,value_animationClips,value_animationTracks,value_boxes,value_cubeMaps,value_decals,value_directionalLights,value_images,value_indexBuffers,value_joints,value_maps,value_materials,value_meshes,value_objects,value_omniLights,value_skins,value_spotLights,value_sprites,value_vertexBuffers);
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3D2 = A3D2(object);
         this.name_8X.encode(protocolBuffer,struct.ambientLights);
         this.name_Fa.encode(protocolBuffer,struct.animationClips);
         this.name_Aj.encode(protocolBuffer,struct.animationTracks);
         this.name_EA.encode(protocolBuffer,struct.boxes);
         this.name_lJ.encode(protocolBuffer,struct.cubeMaps);
         this.name_9f.encode(protocolBuffer,struct.decals);
         this.name_GC.encode(protocolBuffer,struct.directionalLights);
         this.name_Sd.encode(protocolBuffer,struct.images);
         this.name_76.encode(protocolBuffer,struct.indexBuffers);
         this.name_3f.encode(protocolBuffer,struct.joints);
         this.name_dB.encode(protocolBuffer,struct.maps);
         this.name_77.encode(protocolBuffer,struct.materials);
         this.name_PJ.encode(protocolBuffer,struct.meshes);
         this.name_1x.encode(protocolBuffer,struct.objects);
         this.name_aP.encode(protocolBuffer,struct.omniLights);
         this.name_e9.encode(protocolBuffer,struct.skins);
         this.name_3y.encode(protocolBuffer,struct.spotLights);
         this.name_E2.encode(protocolBuffer,struct.sprites);
         this.name_U9.encode(protocolBuffer,struct.vertexBuffers);
      }
   }
}

