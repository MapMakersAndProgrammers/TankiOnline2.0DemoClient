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
      private var name_VP:Vector.<A3D2AmbientLight>;
      
      private var name_qp:Vector.<A3D2AnimationClip>;
      
      private var name_Ib:Vector.<A3D2Track>;
      
      private var name_0:Vector.<A3D2Box>;
      
      private var name_fK:Vector.<A3D2CubeMap>;
      
      private var name_Gv:Vector.<A3D2Decal>;
      
      private var name_93:Vector.<A3D2DirectionalLight>;
      
      private var name_ce:Vector.<A3D2Image>;
      
      private var name_jm:Vector.<A3D2IndexBuffer>;
      
      private var name_26:Vector.<A3D2Joint>;
      
      private var name_XJ:Vector.<A3D2Map>;
      
      private var name_22:Vector.<A3D2Material>;
      
      private var name_jz:Vector.<A3D2Mesh>;
      
      private var name_Kq:Vector.<A3D2Object>;
      
      private var name_fM:Vector.<A3D2OmniLight>;
      
      private var name_G0:Vector.<A3D2Skin>;
      
      private var name_pd:Vector.<A3D2SpotLight>;
      
      private var name_Ke:Vector.<A3D2Sprite>;
      
      private var name_0B:Vector.<A3D2VertexBuffer>;
      
      public function A3D2(ambientLights:Vector.<A3D2AmbientLight>, animationClips:Vector.<A3D2AnimationClip>, animationTracks:Vector.<A3D2Track>, boxes:Vector.<A3D2Box>, cubeMaps:Vector.<A3D2CubeMap>, decals:Vector.<A3D2Decal>, directionalLights:Vector.<A3D2DirectionalLight>, images:Vector.<A3D2Image>, indexBuffers:Vector.<A3D2IndexBuffer>, joints:Vector.<A3D2Joint>, maps:Vector.<A3D2Map>, materials:Vector.<A3D2Material>, meshes:Vector.<A3D2Mesh>, objects:Vector.<A3D2Object>, omniLights:Vector.<A3D2OmniLight>, skins:Vector.<A3D2Skin>, spotLights:Vector.<A3D2SpotLight>, sprites:Vector.<A3D2Sprite>, vertexBuffers:Vector.<A3D2VertexBuffer>)
      {
         super();
         this.name_VP = ambientLights;
         this.name_qp = animationClips;
         this.name_Ib = animationTracks;
         this.name_0 = boxes;
         this.name_fK = cubeMaps;
         this.name_Gv = decals;
         this.name_93 = directionalLights;
         this.name_ce = images;
         this.name_jm = indexBuffers;
         this.name_26 = joints;
         this.name_XJ = maps;
         this.name_22 = materials;
         this.name_jz = meshes;
         this.name_Kq = objects;
         this.name_fM = omniLights;
         this.name_G0 = skins;
         this.name_pd = spotLights;
         this.name_Ke = sprites;
         this.name_0B = vertexBuffers;
      }
      
      public function get ambientLights() : Vector.<A3D2AmbientLight>
      {
         return this.name_VP;
      }
      
      public function set ambientLights(value:Vector.<A3D2AmbientLight>) : void
      {
         this.name_VP = value;
      }
      
      public function get animationClips() : Vector.<A3D2AnimationClip>
      {
         return this.name_qp;
      }
      
      public function set animationClips(value:Vector.<A3D2AnimationClip>) : void
      {
         this.name_qp = value;
      }
      
      public function get animationTracks() : Vector.<A3D2Track>
      {
         return this.name_Ib;
      }
      
      public function set animationTracks(value:Vector.<A3D2Track>) : void
      {
         this.name_Ib = value;
      }
      
      public function get boxes() : Vector.<A3D2Box>
      {
         return this.name_0;
      }
      
      public function set boxes(value:Vector.<A3D2Box>) : void
      {
         this.name_0 = value;
      }
      
      public function get cubeMaps() : Vector.<A3D2CubeMap>
      {
         return this.name_fK;
      }
      
      public function set cubeMaps(value:Vector.<A3D2CubeMap>) : void
      {
         this.name_fK = value;
      }
      
      public function get decals() : Vector.<A3D2Decal>
      {
         return this.name_Gv;
      }
      
      public function set decals(value:Vector.<A3D2Decal>) : void
      {
         this.name_Gv = value;
      }
      
      public function get directionalLights() : Vector.<A3D2DirectionalLight>
      {
         return this.name_93;
      }
      
      public function set directionalLights(value:Vector.<A3D2DirectionalLight>) : void
      {
         this.name_93 = value;
      }
      
      public function get images() : Vector.<A3D2Image>
      {
         return this.name_ce;
      }
      
      public function set images(value:Vector.<A3D2Image>) : void
      {
         this.name_ce = value;
      }
      
      public function get indexBuffers() : Vector.<A3D2IndexBuffer>
      {
         return this.name_jm;
      }
      
      public function set indexBuffers(value:Vector.<A3D2IndexBuffer>) : void
      {
         this.name_jm = value;
      }
      
      public function get joints() : Vector.<A3D2Joint>
      {
         return this.name_26;
      }
      
      public function set joints(value:Vector.<A3D2Joint>) : void
      {
         this.name_26 = value;
      }
      
      public function get maps() : Vector.<A3D2Map>
      {
         return this.name_XJ;
      }
      
      public function set maps(value:Vector.<A3D2Map>) : void
      {
         this.name_XJ = value;
      }
      
      public function get materials() : Vector.<A3D2Material>
      {
         return this.name_22;
      }
      
      public function set materials(value:Vector.<A3D2Material>) : void
      {
         this.name_22 = value;
      }
      
      public function get meshes() : Vector.<A3D2Mesh>
      {
         return this.name_jz;
      }
      
      public function set meshes(value:Vector.<A3D2Mesh>) : void
      {
         this.name_jz = value;
      }
      
      public function get objects() : Vector.<A3D2Object>
      {
         return this.name_Kq;
      }
      
      public function set objects(value:Vector.<A3D2Object>) : void
      {
         this.name_Kq = value;
      }
      
      public function get omniLights() : Vector.<A3D2OmniLight>
      {
         return this.name_fM;
      }
      
      public function set omniLights(value:Vector.<A3D2OmniLight>) : void
      {
         this.name_fM = value;
      }
      
      public function get skins() : Vector.<A3D2Skin>
      {
         return this.name_G0;
      }
      
      public function set skins(value:Vector.<A3D2Skin>) : void
      {
         this.name_G0 = value;
      }
      
      public function get spotLights() : Vector.<A3D2SpotLight>
      {
         return this.name_pd;
      }
      
      public function set spotLights(value:Vector.<A3D2SpotLight>) : void
      {
         this.name_pd = value;
      }
      
      public function get sprites() : Vector.<A3D2Sprite>
      {
         return this.name_Ke;
      }
      
      public function set sprites(value:Vector.<A3D2Sprite>) : void
      {
         this.name_Ke = value;
      }
      
      public function get vertexBuffers() : Vector.<A3D2VertexBuffer>
      {
         return this.name_0B;
      }
      
      public function set vertexBuffers(value:Vector.<A3D2VertexBuffer>) : void
      {
         this.name_0B = value;
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

