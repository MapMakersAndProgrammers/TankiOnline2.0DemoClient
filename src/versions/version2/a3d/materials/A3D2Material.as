package versions.version2.a3d.materials
{
   public class A3D2Material
   {
      private var §_-9s§:int;
      
      private var §_-bl§:int;
      
      private var §_-3I§:int;
      
      private var §_-qf§:int;
      
      private var §_-QR§:int;
      
      private var §_-Jn§:int;
      
      private var §_-iG§:int;
      
      private var §_-LA§:int;
      
      public function A3D2Material(diffuseMapId:int, glossinessMapId:int, id:int, lightMapId:int, normalMapId:int, opacityMapId:int, reflectionCubeMapId:int, specularMapId:int)
      {
         super();
         this.§_-9s§ = diffuseMapId;
         this.§_-bl§ = glossinessMapId;
         this.§_-3I§ = id;
         this.§_-qf§ = lightMapId;
         this.§_-QR§ = normalMapId;
         this.§_-Jn§ = opacityMapId;
         this.§_-iG§ = reflectionCubeMapId;
         this.§_-LA§ = specularMapId;
      }
      
      public function get diffuseMapId() : int
      {
         return this.§_-9s§;
      }
      
      public function set diffuseMapId(value:int) : void
      {
         this.§_-9s§ = value;
      }
      
      public function get glossinessMapId() : int
      {
         return this.§_-bl§;
      }
      
      public function set glossinessMapId(value:int) : void
      {
         this.§_-bl§ = value;
      }
      
      public function get id() : int
      {
         return this.§_-3I§;
      }
      
      public function set id(value:int) : void
      {
         this.§_-3I§ = value;
      }
      
      public function get lightMapId() : int
      {
         return this.§_-qf§;
      }
      
      public function set lightMapId(value:int) : void
      {
         this.§_-qf§ = value;
      }
      
      public function get normalMapId() : int
      {
         return this.§_-QR§;
      }
      
      public function set normalMapId(value:int) : void
      {
         this.§_-QR§ = value;
      }
      
      public function get opacityMapId() : int
      {
         return this.§_-Jn§;
      }
      
      public function set opacityMapId(value:int) : void
      {
         this.§_-Jn§ = value;
      }
      
      public function get reflectionCubeMapId() : int
      {
         return this.§_-iG§;
      }
      
      public function set reflectionCubeMapId(value:int) : void
      {
         this.§_-iG§ = value;
      }
      
      public function get specularMapId() : int
      {
         return this.§_-LA§;
      }
      
      public function set specularMapId(value:int) : void
      {
         this.§_-LA§ = value;
      }
      
      public function toString() : String
      {
         var result:String = "A3D2Material [";
         result += "diffuseMapId = " + this.diffuseMapId + " ";
         result += "glossinessMapId = " + this.glossinessMapId + " ";
         result += "id = " + this.id + " ";
         result += "lightMapId = " + this.lightMapId + " ";
         result += "normalMapId = " + this.normalMapId + " ";
         result += "opacityMapId = " + this.opacityMapId + " ";
         result += "reflectionCubeMapId = " + this.reflectionCubeMapId + " ";
         result += "specularMapId = " + this.specularMapId + " ";
         return result + "]";
      }
   }
}

