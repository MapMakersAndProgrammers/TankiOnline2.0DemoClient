package package_68
{
   import package_32.name_148;
   import package_32.name_149;
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   import package_39.name_160;
   import package_48.A3D2AmbientLight;
   import package_48.A3D2Box;
   import package_48.A3D2Decal;
   import package_48.A3D2DirectionalLight;
   import package_48.A3D2Joint;
   import package_48.A3D2Mesh;
   import package_48.A3D2Object;
   import package_48.A3D2OmniLight;
   import package_48.A3D2Skin;
   import package_48.A3D2SpotLight;
   import package_48.A3D2Sprite;
   import alternativa.osgi.OSGi;
   import package_51.A3D2CubeMap;
   import package_51.A3D2Image;
   import package_51.A3D2Map;
   import package_51.A3D2Material;
   import package_52.A3D2IndexBuffer;
   import package_52.A3D2VertexBuffer;
   import package_55.A3D2AnimationClip;
   import package_55.A3D2Track;
   import package_66.name_211;
   
   public class name_218 implements name_152
   {
      public static var log:name_160 = name_160(OSGi.name_8().name_30(name_160));
      
      private var var_351:name_152;
      
      private var var_365:name_152;
      
      private var var_364:name_152;
      
      private var var_356:name_152;
      
      private var var_352:name_152;
      
      private var var_353:name_152;
      
      private var var_359:name_152;
      
      private var var_355:name_152;
      
      private var var_358:name_152;
      
      private var var_251:name_152;
      
      private var var_366:name_152;
      
      private var var_361:name_152;
      
      private var var_362:name_152;
      
      private var var_360:name_152;
      
      private var var_354:name_152;
      
      private var var_363:name_152;
      
      private var var_357:name_152;
      
      private var var_367:name_152;
      
      private var var_248:name_152;
      
      public function name_218()
      {
         super();
      }
      
      public function init(protocol:name_163) : void
      {
         this.var_351 = protocol.name_448(new name_149(new name_148(A3D2AmbientLight,false),true,1));
         this.var_365 = protocol.name_448(new name_149(new name_148(A3D2AnimationClip,false),true,1));
         this.var_364 = protocol.name_448(new name_149(new name_148(A3D2Track,false),true,1));
         this.var_356 = protocol.name_448(new name_149(new name_148(A3D2Box,false),true,1));
         this.var_352 = protocol.name_448(new name_149(new name_148(A3D2CubeMap,false),true,1));
         this.var_353 = protocol.name_448(new name_149(new name_148(A3D2Decal,false),true,1));
         this.var_359 = protocol.name_448(new name_149(new name_148(A3D2DirectionalLight,false),true,1));
         this.var_355 = protocol.name_448(new name_149(new name_148(A3D2Image,false),true,1));
         this.var_358 = protocol.name_448(new name_149(new name_148(A3D2IndexBuffer,false),true,1));
         this.var_251 = protocol.name_448(new name_149(new name_148(A3D2Joint,false),true,1));
         this.var_366 = protocol.name_448(new name_149(new name_148(A3D2Map,false),true,1));
         this.var_361 = protocol.name_448(new name_149(new name_148(A3D2Material,false),true,1));
         this.var_362 = protocol.name_448(new name_149(new name_148(A3D2Mesh,false),true,1));
         this.var_360 = protocol.name_448(new name_149(new name_148(A3D2Object,false),true,1));
         this.var_354 = protocol.name_448(new name_149(new name_148(A3D2OmniLight,false),true,1));
         this.var_363 = protocol.name_448(new name_149(new name_148(A3D2Skin,false),true,1));
         this.var_357 = protocol.name_448(new name_149(new name_148(A3D2SpotLight,false),true,1));
         this.var_367 = protocol.name_448(new name_149(new name_148(A3D2Sprite,false),true,1));
         this.var_248 = protocol.name_448(new name_149(new name_148(A3D2VertexBuffer,false),true,1));
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         log = name_160(OSGi.name_8().name_30(name_160));
         var value_ambientLights:Vector.<A3D2AmbientLight> = this.var_351.method_296(protocolBuffer) as Vector.<A3D2AmbientLight>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","ambientLights",value_ambientLights);
         var value_animationClips:Vector.<A3D2AnimationClip> = this.var_365.method_296(protocolBuffer) as Vector.<A3D2AnimationClip>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","animationClips",value_animationClips);
         var value_animationTracks:Vector.<A3D2Track> = this.var_364.method_296(protocolBuffer) as Vector.<A3D2Track>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","animationTracks",value_animationTracks);
         var value_boxes:Vector.<A3D2Box> = this.var_356.method_296(protocolBuffer) as Vector.<A3D2Box>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","boxes",value_boxes);
         var value_cubeMaps:Vector.<A3D2CubeMap> = this.var_352.method_296(protocolBuffer) as Vector.<A3D2CubeMap>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","cubeMaps",value_cubeMaps);
         var value_decals:Vector.<A3D2Decal> = this.var_353.method_296(protocolBuffer) as Vector.<A3D2Decal>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","decals",value_decals);
         var value_directionalLights:Vector.<A3D2DirectionalLight> = this.var_359.method_296(protocolBuffer) as Vector.<A3D2DirectionalLight>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","directionalLights",value_directionalLights);
         var value_images:Vector.<A3D2Image> = this.var_355.method_296(protocolBuffer) as Vector.<A3D2Image>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","images",value_images);
         var value_indexBuffers:Vector.<A3D2IndexBuffer> = this.var_358.method_296(protocolBuffer) as Vector.<A3D2IndexBuffer>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","indexBuffers",value_indexBuffers);
         var value_joints:Vector.<A3D2Joint> = this.var_251.method_296(protocolBuffer) as Vector.<A3D2Joint>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","joints",value_joints);
         var value_maps:Vector.<A3D2Map> = this.var_366.method_296(protocolBuffer) as Vector.<A3D2Map>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","maps",value_maps);
         var value_materials:Vector.<A3D2Material> = this.var_361.method_296(protocolBuffer) as Vector.<A3D2Material>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","materials",value_materials);
         var value_meshes:Vector.<A3D2Mesh> = this.var_362.method_296(protocolBuffer) as Vector.<A3D2Mesh>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","meshes",value_meshes);
         var value_objects:Vector.<A3D2Object> = this.var_360.method_296(protocolBuffer) as Vector.<A3D2Object>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","objects",value_objects);
         var value_omniLights:Vector.<A3D2OmniLight> = this.var_354.method_296(protocolBuffer) as Vector.<A3D2OmniLight>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","omniLights",value_omniLights);
         var value_skins:Vector.<A3D2Skin> = this.var_363.method_296(protocolBuffer) as Vector.<A3D2Skin>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","skins",value_skins);
         var value_spotLights:Vector.<A3D2SpotLight> = this.var_357.method_296(protocolBuffer) as Vector.<A3D2SpotLight>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","spotLights",value_spotLights);
         var value_sprites:Vector.<A3D2Sprite> = this.var_367.method_296(protocolBuffer) as Vector.<A3D2Sprite>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","sprites",value_sprites);
         var value_vertexBuffers:Vector.<A3D2VertexBuffer> = this.var_248.method_296(protocolBuffer) as Vector.<A3D2VertexBuffer>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.A3D2","vertexBuffers",value_vertexBuffers);
         return new name_211(value_ambientLights,value_animationClips,value_animationTracks,value_boxes,value_cubeMaps,value_decals,value_directionalLights,value_images,value_indexBuffers,value_joints,value_maps,value_materials,value_meshes,value_objects,value_omniLights,value_skins,value_spotLights,value_sprites,value_vertexBuffers);
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:name_211 = name_211(object);
         this.var_351.method_295(protocolBuffer,struct.ambientLights);
         this.var_365.method_295(protocolBuffer,struct.animationClips);
         this.var_364.method_295(protocolBuffer,struct.animationTracks);
         this.var_356.method_295(protocolBuffer,struct.boxes);
         this.var_352.method_295(protocolBuffer,struct.cubeMaps);
         this.var_353.method_295(protocolBuffer,struct.decals);
         this.var_359.method_295(protocolBuffer,struct.directionalLights);
         this.var_355.method_295(protocolBuffer,struct.images);
         this.var_358.method_295(protocolBuffer,struct.indexBuffers);
         this.var_251.method_295(protocolBuffer,struct.joints);
         this.var_366.method_295(protocolBuffer,struct.maps);
         this.var_361.method_295(protocolBuffer,struct.materials);
         this.var_362.method_295(protocolBuffer,struct.meshes);
         this.var_360.method_295(protocolBuffer,struct.objects);
         this.var_354.method_295(protocolBuffer,struct.omniLights);
         this.var_363.method_295(protocolBuffer,struct.skins);
         this.var_357.method_295(protocolBuffer,struct.spotLights);
         this.var_367.method_295(protocolBuffer,struct.sprites);
         this.var_248.method_295(protocolBuffer,struct.vertexBuffers);
      }
   }
}

