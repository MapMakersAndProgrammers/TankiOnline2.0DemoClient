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
      
      private var var_355:ICodec;
      
      private var var_360:ICodec;
      
      private var var_357:ICodec;
      
      private var var_359:ICodec;
      
      private var var_367:ICodec;
      
      private var var_356:ICodec;
      
      private var var_361:ICodec;
      
      private var var_363:ICodec;
      
      private var var_353:ICodec;
      
      private var var_244:ICodec;
      
      private var var_365:ICodec;
      
      private var var_354:ICodec;
      
      private var var_362:ICodec;
      
      private var var_351:ICodec;
      
      private var var_364:ICodec;
      
      private var var_366:ICodec;
      
      private var var_352:ICodec;
      
      private var var_358:ICodec;
      
      private var var_250:ICodec;
      
      public function CodecA3D2()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.var_355 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2AmbientLight,false),true,1));
         this.var_360 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2AnimationClip,false),true,1));
         this.var_357 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Track,false),true,1));
         this.var_359 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Box,false),true,1));
         this.var_367 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2CubeMap,false),true,1));
         this.var_356 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Decal,false),true,1));
         this.var_361 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2DirectionalLight,false),true,1));
         this.var_363 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Image,false),true,1));
         this.var_353 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2IndexBuffer,false),true,1));
         this.var_244 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Joint,false),true,1));
         this.var_365 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Map,false),true,1));
         this.var_354 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Material,false),true,1));
         this.var_362 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Mesh,false),true,1));
         this.var_351 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Object,false),true,1));
         this.var_364 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2OmniLight,false),true,1));
         this.var_366 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Skin,false),true,1));
         this.var_352 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2SpotLight,false),true,1));
         this.var_358 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Sprite,false),true,1));
         this.var_250 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2VertexBuffer,false),true,1));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_ambientLights:Vector.<A3D2AmbientLight> = this.var_355.decode(protocolBuffer) as Vector.<A3D2AmbientLight>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","ambientLights",value_ambientLights);
         var value_animationClips:Vector.<A3D2AnimationClip> = this.var_360.decode(protocolBuffer) as Vector.<A3D2AnimationClip>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","animationClips",value_animationClips);
         var value_animationTracks:Vector.<A3D2Track> = this.var_357.decode(protocolBuffer) as Vector.<A3D2Track>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","animationTracks",value_animationTracks);
         var value_boxes:Vector.<A3D2Box> = this.var_359.decode(protocolBuffer) as Vector.<A3D2Box>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","boxes",value_boxes);
         var value_cubeMaps:Vector.<A3D2CubeMap> = this.var_367.decode(protocolBuffer) as Vector.<A3D2CubeMap>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","cubeMaps",value_cubeMaps);
         var value_decals:Vector.<A3D2Decal> = this.var_356.decode(protocolBuffer) as Vector.<A3D2Decal>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","decals",value_decals);
         var value_directionalLights:Vector.<A3D2DirectionalLight> = this.var_361.decode(protocolBuffer) as Vector.<A3D2DirectionalLight>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","directionalLights",value_directionalLights);
         var value_images:Vector.<A3D2Image> = this.var_363.decode(protocolBuffer) as Vector.<A3D2Image>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","images",value_images);
         var value_indexBuffers:Vector.<A3D2IndexBuffer> = this.var_353.decode(protocolBuffer) as Vector.<A3D2IndexBuffer>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","indexBuffers",value_indexBuffers);
         var value_joints:Vector.<A3D2Joint> = this.var_244.decode(protocolBuffer) as Vector.<A3D2Joint>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","joints",value_joints);
         var value_maps:Vector.<A3D2Map> = this.var_365.decode(protocolBuffer) as Vector.<A3D2Map>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","maps",value_maps);
         var value_materials:Vector.<A3D2Material> = this.var_354.decode(protocolBuffer) as Vector.<A3D2Material>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","materials",value_materials);
         var value_meshes:Vector.<A3D2Mesh> = this.var_362.decode(protocolBuffer) as Vector.<A3D2Mesh>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","meshes",value_meshes);
         var value_objects:Vector.<A3D2Object> = this.var_351.decode(protocolBuffer) as Vector.<A3D2Object>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","objects",value_objects);
         var value_omniLights:Vector.<A3D2OmniLight> = this.var_364.decode(protocolBuffer) as Vector.<A3D2OmniLight>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","omniLights",value_omniLights);
         var value_skins:Vector.<A3D2Skin> = this.var_366.decode(protocolBuffer) as Vector.<A3D2Skin>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","skins",value_skins);
         var value_spotLights:Vector.<A3D2SpotLight> = this.var_352.decode(protocolBuffer) as Vector.<A3D2SpotLight>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","spotLights",value_spotLights);
         var value_sprites:Vector.<A3D2Sprite> = this.var_358.decode(protocolBuffer) as Vector.<A3D2Sprite>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","sprites",value_sprites);
         var value_vertexBuffers:Vector.<A3D2VertexBuffer> = this.var_250.decode(protocolBuffer) as Vector.<A3D2VertexBuffer>;
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
         this.var_355.encode(protocolBuffer,struct.ambientLights);
         this.var_360.encode(protocolBuffer,struct.animationClips);
         this.var_357.encode(protocolBuffer,struct.animationTracks);
         this.var_359.encode(protocolBuffer,struct.boxes);
         this.var_367.encode(protocolBuffer,struct.cubeMaps);
         this.var_356.encode(protocolBuffer,struct.decals);
         this.var_361.encode(protocolBuffer,struct.directionalLights);
         this.var_363.encode(protocolBuffer,struct.images);
         this.var_353.encode(protocolBuffer,struct.indexBuffers);
         this.var_244.encode(protocolBuffer,struct.joints);
         this.var_365.encode(protocolBuffer,struct.maps);
         this.var_354.encode(protocolBuffer,struct.materials);
         this.var_362.encode(protocolBuffer,struct.meshes);
         this.var_351.encode(protocolBuffer,struct.objects);
         this.var_364.encode(protocolBuffer,struct.omniLights);
         this.var_366.encode(protocolBuffer,struct.skins);
         this.var_352.encode(protocolBuffer,struct.spotLights);
         this.var_358.encode(protocolBuffer,struct.sprites);
         this.var_250.encode(protocolBuffer,struct.vertexBuffers);
      }
   }
}

