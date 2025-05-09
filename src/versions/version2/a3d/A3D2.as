package versions.version2.a3d
{
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
   
   public class A3D2
   {
      private var var_401:Vector.<A3D2AmbientLight>;
      
      private var var_406:Vector.<A3D2AnimationClip>;
      
      private var var_399:Vector.<A3D2Track>;
      
      private var var_346:Vector.<A3D2Box>;
      
      private var var_402:Vector.<A3D2CubeMap>;
      
      private var var_398:Vector.<A3D2Decal>;
      
      private var var_396:Vector.<A3D2DirectionalLight>;
      
      private var var_350:Vector.<A3D2Image>;
      
      private var var_404:Vector.<A3D2IndexBuffer>;
      
      private var var_390:Vector.<A3D2Joint>;
      
      private var var_349:Vector.<A3D2Map>;
      
      private var var_347:Vector.<A3D2Material>;
      
      private var var_405:Vector.<A3D2Mesh>;
      
      private var var_348:Vector.<A3D2Object>;
      
      private var var_403:Vector.<A3D2OmniLight>;
      
      private var var_397:Vector.<A3D2Skin>;
      
      private var var_144:Vector.<A3D2SpotLight>;
      
      private var var_400:Vector.<A3D2Sprite>;
      
      private var var_276:Vector.<A3D2VertexBuffer>;
      
      public function A3D2(ambientLights:Vector.<A3D2AmbientLight>, animationClips:Vector.<A3D2AnimationClip>, animationTracks:Vector.<A3D2Track>, boxes:Vector.<A3D2Box>, cubeMaps:Vector.<A3D2CubeMap>, decals:Vector.<A3D2Decal>, directionalLights:Vector.<A3D2DirectionalLight>, images:Vector.<A3D2Image>, indexBuffers:Vector.<A3D2IndexBuffer>, joints:Vector.<A3D2Joint>, maps:Vector.<A3D2Map>, materials:Vector.<A3D2Material>, meshes:Vector.<A3D2Mesh>, objects:Vector.<A3D2Object>, omniLights:Vector.<A3D2OmniLight>, skins:Vector.<A3D2Skin>, spotLights:Vector.<A3D2SpotLight>, sprites:Vector.<A3D2Sprite>, vertexBuffers:Vector.<A3D2VertexBuffer>)
      {
         super();
         this.var_401 = ambientLights;
         this.var_406 = animationClips;
         this.var_399 = animationTracks;
         this.var_346 = boxes;
         this.var_402 = cubeMaps;
         this.var_398 = decals;
         this.var_396 = directionalLights;
         this.var_350 = images;
         this.var_404 = indexBuffers;
         this.var_390 = joints;
         this.var_349 = maps;
         this.var_347 = materials;
         this.var_405 = meshes;
         this.var_348 = objects;
         this.var_403 = omniLights;
         this.var_397 = skins;
         this.var_144 = spotLights;
         this.var_400 = sprites;
         this.var_276 = vertexBuffers;
      }
      
      public function get ambientLights() : Vector.<A3D2AmbientLight>
      {
         return this.var_401;
      }
      
      public function set ambientLights(value:Vector.<A3D2AmbientLight>) : void
      {
         this.var_401 = value;
      }
      
      public function get animationClips() : Vector.<A3D2AnimationClip>
      {
         return this.var_406;
      }
      
      public function set animationClips(value:Vector.<A3D2AnimationClip>) : void
      {
         this.var_406 = value;
      }
      
      public function get animationTracks() : Vector.<A3D2Track>
      {
         return this.var_399;
      }
      
      public function set animationTracks(value:Vector.<A3D2Track>) : void
      {
         this.var_399 = value;
      }
      
      public function get boxes() : Vector.<A3D2Box>
      {
         return this.var_346;
      }
      
      public function set boxes(value:Vector.<A3D2Box>) : void
      {
         this.var_346 = value;
      }
      
      public function get cubeMaps() : Vector.<A3D2CubeMap>
      {
         return this.var_402;
      }
      
      public function set cubeMaps(value:Vector.<A3D2CubeMap>) : void
      {
         this.var_402 = value;
      }
      
      public function get decals() : Vector.<A3D2Decal>
      {
         return this.var_398;
      }
      
      public function set decals(value:Vector.<A3D2Decal>) : void
      {
         this.var_398 = value;
      }
      
      public function get directionalLights() : Vector.<A3D2DirectionalLight>
      {
         return this.var_396;
      }
      
      public function set directionalLights(value:Vector.<A3D2DirectionalLight>) : void
      {
         this.var_396 = value;
      }
      
      public function get images() : Vector.<A3D2Image>
      {
         return this.var_350;
      }
      
      public function set images(value:Vector.<A3D2Image>) : void
      {
         this.var_350 = value;
      }
      
      public function get indexBuffers() : Vector.<A3D2IndexBuffer>
      {
         return this.var_404;
      }
      
      public function set indexBuffers(value:Vector.<A3D2IndexBuffer>) : void
      {
         this.var_404 = value;
      }
      
      public function get joints() : Vector.<A3D2Joint>
      {
         return this.var_390;
      }
      
      public function set joints(value:Vector.<A3D2Joint>) : void
      {
         this.var_390 = value;
      }
      
      public function get maps() : Vector.<A3D2Map>
      {
         return this.var_349;
      }
      
      public function set maps(value:Vector.<A3D2Map>) : void
      {
         this.var_349 = value;
      }
      
      public function get materials() : Vector.<A3D2Material>
      {
         return this.var_347;
      }
      
      public function set materials(value:Vector.<A3D2Material>) : void
      {
         this.var_347 = value;
      }
      
      public function get meshes() : Vector.<A3D2Mesh>
      {
         return this.var_405;
      }
      
      public function set meshes(value:Vector.<A3D2Mesh>) : void
      {
         this.var_405 = value;
      }
      
      public function get objects() : Vector.<A3D2Object>
      {
         return this.var_348;
      }
      
      public function set objects(value:Vector.<A3D2Object>) : void
      {
         this.var_348 = value;
      }
      
      public function get omniLights() : Vector.<A3D2OmniLight>
      {
         return this.var_403;
      }
      
      public function set omniLights(value:Vector.<A3D2OmniLight>) : void
      {
         this.var_403 = value;
      }
      
      public function get skins() : Vector.<A3D2Skin>
      {
         return this.var_397;
      }
      
      public function set skins(value:Vector.<A3D2Skin>) : void
      {
         this.var_397 = value;
      }
      
      public function get spotLights() : Vector.<A3D2SpotLight>
      {
         return this.var_144;
      }
      
      public function set spotLights(value:Vector.<A3D2SpotLight>) : void
      {
         this.var_144 = value;
      }
      
      public function get sprites() : Vector.<A3D2Sprite>
      {
         return this.var_400;
      }
      
      public function set sprites(value:Vector.<A3D2Sprite>) : void
      {
         this.var_400 = value;
      }
      
      public function get vertexBuffers() : Vector.<A3D2VertexBuffer>
      {
         return this.var_276;
      }
      
      public function set vertexBuffers(value:Vector.<A3D2VertexBuffer>) : void
      {
         this.var_276 = value;
      }
      
      public function toString() : String
      {
         var result:String = "A3D2 [";
         result += "ambientLights = " + this.ambientLights + " ";
         result += "animationClips = " + this.animationClips + " ";
         result += "animationTracks = " + this.animationTracks + " ";
         result += "boxes = " + this.boxes + " ";
         result += "cubeMaps = " + this.cubeMaps + " ";
         result += "decals = " + this.decals + " ";
         result += "directionalLights = " + this.directionalLights + " ";
         result += "images = " + this.images + " ";
         result += "indexBuffers = " + this.indexBuffers + " ";
         result += "joints = " + this.joints + " ";
         result += "maps = " + this.maps + " ";
         result += "materials = " + this.materials + " ";
         result += "meshes = " + this.meshes + " ";
         result += "objects = " + this.objects + " ";
         result += "omniLights = " + this.omniLights + " ";
         result += "skins = " + this.skins + " ";
         result += "spotLights = " + this.spotLights + " ";
         result += "sprites = " + this.sprites + " ";
         result += "vertexBuffers = " + this.vertexBuffers + " ";
         return result + "]";
      }
   }
}

