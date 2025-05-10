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
      
      private var §_-8X§:ICodec;
      
      private var §_-Fa§:ICodec;
      
      private var §_-Aj§:ICodec;
      
      private var §_-EA§:ICodec;
      
      private var §_-lJ§:ICodec;
      
      private var §_-9f§:ICodec;
      
      private var §_-GC§:ICodec;
      
      private var §_-Sd§:ICodec;
      
      private var §_-76§:ICodec;
      
      private var §_-3f§:ICodec;
      
      private var §_-dB§:ICodec;
      
      private var §_-77§:ICodec;
      
      private var §_-PJ§:ICodec;
      
      private var §_-1x§:ICodec;
      
      private var §_-aP§:ICodec;
      
      private var §_-e9§:ICodec;
      
      private var §_-3y§:ICodec;
      
      private var §_-E2§:ICodec;
      
      private var §_-U9§:ICodec;
      
      public function CodecA3D2()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.§_-8X§ = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2AmbientLight,false),true,1));
         this.§_-Fa§ = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2AnimationClip,false),true,1));
         this.§_-Aj§ = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Track,false),true,1));
         this.§_-EA§ = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Box,false),true,1));
         this.§_-lJ§ = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2CubeMap,false),true,1));
         this.§_-9f§ = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Decal,false),true,1));
         this.§_-GC§ = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2DirectionalLight,false),true,1));
         this.§_-Sd§ = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Image,false),true,1));
         this.§_-76§ = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2IndexBuffer,false),true,1));
         this.§_-3f§ = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Joint,false),true,1));
         this.§_-dB§ = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Map,false),true,1));
         this.§_-77§ = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Material,false),true,1));
         this.§_-PJ§ = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Mesh,false),true,1));
         this.§_-1x§ = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Object,false),true,1));
         this.§_-aP§ = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2OmniLight,false),true,1));
         this.§_-e9§ = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Skin,false),true,1));
         this.§_-3y§ = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2SpotLight,false),true,1));
         this.§_-E2§ = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Sprite,false),true,1));
         this.§_-U9§ = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2VertexBuffer,false),true,1));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_ambientLights:Vector.<A3D2AmbientLight> = this.§_-8X§.decode(protocolBuffer) as Vector.<A3D2AmbientLight>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","ambientLights",value_ambientLights);
         var value_animationClips:Vector.<A3D2AnimationClip> = this.§_-Fa§.decode(protocolBuffer) as Vector.<A3D2AnimationClip>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","animationClips",value_animationClips);
         var value_animationTracks:Vector.<A3D2Track> = this.§_-Aj§.decode(protocolBuffer) as Vector.<A3D2Track>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","animationTracks",value_animationTracks);
         var value_boxes:Vector.<A3D2Box> = this.§_-EA§.decode(protocolBuffer) as Vector.<A3D2Box>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","boxes",value_boxes);
         var value_cubeMaps:Vector.<A3D2CubeMap> = this.§_-lJ§.decode(protocolBuffer) as Vector.<A3D2CubeMap>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","cubeMaps",value_cubeMaps);
         var value_decals:Vector.<A3D2Decal> = this.§_-9f§.decode(protocolBuffer) as Vector.<A3D2Decal>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","decals",value_decals);
         var value_directionalLights:Vector.<A3D2DirectionalLight> = this.§_-GC§.decode(protocolBuffer) as Vector.<A3D2DirectionalLight>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","directionalLights",value_directionalLights);
         var value_images:Vector.<A3D2Image> = this.§_-Sd§.decode(protocolBuffer) as Vector.<A3D2Image>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","images",value_images);
         var value_indexBuffers:Vector.<A3D2IndexBuffer> = this.§_-76§.decode(protocolBuffer) as Vector.<A3D2IndexBuffer>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","indexBuffers",value_indexBuffers);
         var value_joints:Vector.<A3D2Joint> = this.§_-3f§.decode(protocolBuffer) as Vector.<A3D2Joint>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","joints",value_joints);
         var value_maps:Vector.<A3D2Map> = this.§_-dB§.decode(protocolBuffer) as Vector.<A3D2Map>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","maps",value_maps);
         var value_materials:Vector.<A3D2Material> = this.§_-77§.decode(protocolBuffer) as Vector.<A3D2Material>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","materials",value_materials);
         var value_meshes:Vector.<A3D2Mesh> = this.§_-PJ§.decode(protocolBuffer) as Vector.<A3D2Mesh>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","meshes",value_meshes);
         var value_objects:Vector.<A3D2Object> = this.§_-1x§.decode(protocolBuffer) as Vector.<A3D2Object>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","objects",value_objects);
         var value_omniLights:Vector.<A3D2OmniLight> = this.§_-aP§.decode(protocolBuffer) as Vector.<A3D2OmniLight>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","omniLights",value_omniLights);
         var value_skins:Vector.<A3D2Skin> = this.§_-e9§.decode(protocolBuffer) as Vector.<A3D2Skin>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","skins",value_skins);
         var value_spotLights:Vector.<A3D2SpotLight> = this.§_-3y§.decode(protocolBuffer) as Vector.<A3D2SpotLight>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","spotLights",value_spotLights);
         var value_sprites:Vector.<A3D2Sprite> = this.§_-E2§.decode(protocolBuffer) as Vector.<A3D2Sprite>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","sprites",value_sprites);
         var value_vertexBuffers:Vector.<A3D2VertexBuffer> = this.§_-U9§.decode(protocolBuffer) as Vector.<A3D2VertexBuffer>;
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
         this.§_-8X§.encode(protocolBuffer,struct.ambientLights);
         this.§_-Fa§.encode(protocolBuffer,struct.animationClips);
         this.§_-Aj§.encode(protocolBuffer,struct.animationTracks);
         this.§_-EA§.encode(protocolBuffer,struct.boxes);
         this.§_-lJ§.encode(protocolBuffer,struct.cubeMaps);
         this.§_-9f§.encode(protocolBuffer,struct.decals);
         this.§_-GC§.encode(protocolBuffer,struct.directionalLights);
         this.§_-Sd§.encode(protocolBuffer,struct.images);
         this.§_-76§.encode(protocolBuffer,struct.indexBuffers);
         this.§_-3f§.encode(protocolBuffer,struct.joints);
         this.§_-dB§.encode(protocolBuffer,struct.maps);
         this.§_-77§.encode(protocolBuffer,struct.materials);
         this.§_-PJ§.encode(protocolBuffer,struct.meshes);
         this.§_-1x§.encode(protocolBuffer,struct.objects);
         this.§_-aP§.encode(protocolBuffer,struct.omniLights);
         this.§_-e9§.encode(protocolBuffer,struct.skins);
         this.§_-3y§.encode(protocolBuffer,struct.spotLights);
         this.§_-E2§.encode(protocolBuffer,struct.sprites);
         this.§_-U9§.encode(protocolBuffer,struct.vertexBuffers);
      }
   }
}

