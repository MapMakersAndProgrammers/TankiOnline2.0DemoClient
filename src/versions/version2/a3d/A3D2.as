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
      private var §_-VP§:Vector.<A3D2AmbientLight>;
      
      private var §_-qp§:Vector.<A3D2AnimationClip>;
      
      private var §_-Ib§:Vector.<A3D2Track>;
      
      private var §_-0§:Vector.<A3D2Box>;
      
      private var §_-fK§:Vector.<A3D2CubeMap>;
      
      private var §_-Gv§:Vector.<A3D2Decal>;
      
      private var §_-93§:Vector.<A3D2DirectionalLight>;
      
      private var §_-ce§:Vector.<A3D2Image>;
      
      private var §_-jm§:Vector.<A3D2IndexBuffer>;
      
      private var §_-26§:Vector.<A3D2Joint>;
      
      private var §_-XJ§:Vector.<A3D2Map>;
      
      private var §_-22§:Vector.<A3D2Material>;
      
      private var §_-jz§:Vector.<A3D2Mesh>;
      
      private var §_-Kq§:Vector.<A3D2Object>;
      
      private var §_-fM§:Vector.<A3D2OmniLight>;
      
      private var §_-G0§:Vector.<A3D2Skin>;
      
      private var §_-pd§:Vector.<A3D2SpotLight>;
      
      private var §_-Ke§:Vector.<A3D2Sprite>;
      
      private var §_-0B§:Vector.<A3D2VertexBuffer>;
      
      public function A3D2(ambientLights:Vector.<A3D2AmbientLight>, animationClips:Vector.<A3D2AnimationClip>, animationTracks:Vector.<A3D2Track>, boxes:Vector.<A3D2Box>, cubeMaps:Vector.<A3D2CubeMap>, decals:Vector.<A3D2Decal>, directionalLights:Vector.<A3D2DirectionalLight>, images:Vector.<A3D2Image>, indexBuffers:Vector.<A3D2IndexBuffer>, joints:Vector.<A3D2Joint>, maps:Vector.<A3D2Map>, materials:Vector.<A3D2Material>, meshes:Vector.<A3D2Mesh>, objects:Vector.<A3D2Object>, omniLights:Vector.<A3D2OmniLight>, skins:Vector.<A3D2Skin>, spotLights:Vector.<A3D2SpotLight>, sprites:Vector.<A3D2Sprite>, vertexBuffers:Vector.<A3D2VertexBuffer>)
      {
         super();
         this.§_-VP§ = ambientLights;
         this.§_-qp§ = animationClips;
         this.§_-Ib§ = animationTracks;
         this.§_-0§ = boxes;
         this.§_-fK§ = cubeMaps;
         this.§_-Gv§ = decals;
         this.§_-93§ = directionalLights;
         this.§_-ce§ = images;
         this.§_-jm§ = indexBuffers;
         this.§_-26§ = joints;
         this.§_-XJ§ = maps;
         this.§_-22§ = materials;
         this.§_-jz§ = meshes;
         this.§_-Kq§ = objects;
         this.§_-fM§ = omniLights;
         this.§_-G0§ = skins;
         this.§_-pd§ = spotLights;
         this.§_-Ke§ = sprites;
         this.§_-0B§ = vertexBuffers;
      }
      
      public function get ambientLights() : Vector.<A3D2AmbientLight>
      {
         return this.§_-VP§;
      }
      
      public function set ambientLights(value:Vector.<A3D2AmbientLight>) : void
      {
         this.§_-VP§ = value;
      }
      
      public function get animationClips() : Vector.<A3D2AnimationClip>
      {
         return this.§_-qp§;
      }
      
      public function set animationClips(value:Vector.<A3D2AnimationClip>) : void
      {
         this.§_-qp§ = value;
      }
      
      public function get animationTracks() : Vector.<A3D2Track>
      {
         return this.§_-Ib§;
      }
      
      public function set animationTracks(value:Vector.<A3D2Track>) : void
      {
         this.§_-Ib§ = value;
      }
      
      public function get boxes() : Vector.<A3D2Box>
      {
         return this.§_-0§;
      }
      
      public function set boxes(value:Vector.<A3D2Box>) : void
      {
         this.§_-0§ = value;
      }
      
      public function get cubeMaps() : Vector.<A3D2CubeMap>
      {
         return this.§_-fK§;
      }
      
      public function set cubeMaps(value:Vector.<A3D2CubeMap>) : void
      {
         this.§_-fK§ = value;
      }
      
      public function get decals() : Vector.<A3D2Decal>
      {
         return this.§_-Gv§;
      }
      
      public function set decals(value:Vector.<A3D2Decal>) : void
      {
         this.§_-Gv§ = value;
      }
      
      public function get directionalLights() : Vector.<A3D2DirectionalLight>
      {
         return this.§_-93§;
      }
      
      public function set directionalLights(value:Vector.<A3D2DirectionalLight>) : void
      {
         this.§_-93§ = value;
      }
      
      public function get images() : Vector.<A3D2Image>
      {
         return this.§_-ce§;
      }
      
      public function set images(value:Vector.<A3D2Image>) : void
      {
         this.§_-ce§ = value;
      }
      
      public function get indexBuffers() : Vector.<A3D2IndexBuffer>
      {
         return this.§_-jm§;
      }
      
      public function set indexBuffers(value:Vector.<A3D2IndexBuffer>) : void
      {
         this.§_-jm§ = value;
      }
      
      public function get joints() : Vector.<A3D2Joint>
      {
         return this.§_-26§;
      }
      
      public function set joints(value:Vector.<A3D2Joint>) : void
      {
         this.§_-26§ = value;
      }
      
      public function get maps() : Vector.<A3D2Map>
      {
         return this.§_-XJ§;
      }
      
      public function set maps(value:Vector.<A3D2Map>) : void
      {
         this.§_-XJ§ = value;
      }
      
      public function get materials() : Vector.<A3D2Material>
      {
         return this.§_-22§;
      }
      
      public function set materials(value:Vector.<A3D2Material>) : void
      {
         this.§_-22§ = value;
      }
      
      public function get meshes() : Vector.<A3D2Mesh>
      {
         return this.§_-jz§;
      }
      
      public function set meshes(value:Vector.<A3D2Mesh>) : void
      {
         this.§_-jz§ = value;
      }
      
      public function get objects() : Vector.<A3D2Object>
      {
         return this.§_-Kq§;
      }
      
      public function set objects(value:Vector.<A3D2Object>) : void
      {
         this.§_-Kq§ = value;
      }
      
      public function get omniLights() : Vector.<A3D2OmniLight>
      {
         return this.§_-fM§;
      }
      
      public function set omniLights(value:Vector.<A3D2OmniLight>) : void
      {
         this.§_-fM§ = value;
      }
      
      public function get skins() : Vector.<A3D2Skin>
      {
         return this.§_-G0§;
      }
      
      public function set skins(value:Vector.<A3D2Skin>) : void
      {
         this.§_-G0§ = value;
      }
      
      public function get spotLights() : Vector.<A3D2SpotLight>
      {
         return this.§_-pd§;
      }
      
      public function set spotLights(value:Vector.<A3D2SpotLight>) : void
      {
         this.§_-pd§ = value;
      }
      
      public function get sprites() : Vector.<A3D2Sprite>
      {
         return this.§_-Ke§;
      }
      
      public function set sprites(value:Vector.<A3D2Sprite>) : void
      {
         this.§_-Ke§ = value;
      }
      
      public function get vertexBuffers() : Vector.<A3D2VertexBuffer>
      {
         return this.§_-0B§;
      }
      
      public function set vertexBuffers(value:Vector.<A3D2VertexBuffer>) : void
      {
         this.§_-0B§ = value;
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

