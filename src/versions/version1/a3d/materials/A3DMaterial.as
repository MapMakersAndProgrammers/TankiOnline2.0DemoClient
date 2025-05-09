package versions.version1.a3d.materials
{
   import commons.Id;
   
   public class A3DMaterial
   {
      private var §_-9s§:Id;
      
      private var §_-bl§:Id;
      
      private var §_-3I§:Id;
      
      private var §_-qf§:Id;
      
      private var §_-QR§:Id;
      
      private var §_-Jn§:Id;
      
      private var §_-LA§:Id;
      
      public function A3DMaterial(diffuseMapId:Id, glossinessMapId:Id, id:Id, lightMapId:Id, normalMapId:Id, opacityMapId:Id, specularMapId:Id)
      {
         super();
         this.§_-9s§ = diffuseMapId;
         this.§_-bl§ = glossinessMapId;
         this.§_-3I§ = id;
         this.§_-qf§ = lightMapId;
         this.§_-QR§ = normalMapId;
         this.§_-Jn§ = opacityMapId;
         this.§_-LA§ = specularMapId;
      }
      
      public function get diffuseMapId() : Id
      {
         return this.§_-9s§;
      }
      
      public function set diffuseMapId(value:Id) : void
      {
         this.§_-9s§ = value;
      }
      
      public function get glossinessMapId() : Id
      {
         return this.§_-bl§;
      }
      
      public function set glossinessMapId(value:Id) : void
      {
         this.§_-bl§ = value;
      }
      
      public function get id() : Id
      {
         return this.§_-3I§;
      }
      
      public function set id(value:Id) : void
      {
         this.§_-3I§ = value;
      }
      
      public function get lightMapId() : Id
      {
         return this.§_-qf§;
      }
      
      public function set lightMapId(value:Id) : void
      {
         this.§_-qf§ = value;
      }
      
      public function get normalMapId() : Id
      {
         return this.§_-QR§;
      }
      
      public function set normalMapId(value:Id) : void
      {
         this.§_-QR§ = value;
      }
      
      public function get opacityMapId() : Id
      {
         return this.§_-Jn§;
      }
      
      public function set opacityMapId(value:Id) : void
      {
         this.§_-Jn§ = value;
      }
      
      public function get specularMapId() : Id
      {
         return this.§_-LA§;
      }
      
      public function set specularMapId(value:Id) : void
      {
         this.§_-LA§ = value;
      }
      
      public function toString() : String
      {
         var result:String = "A3DMaterial [";
         result += "diffuseMapId = " + this.diffuseMapId + " ";
         result += "glossinessMapId = " + this.glossinessMapId + " ";
         result += "id = " + this.id + " ";
         result += "lightMapId = " + this.lightMapId + " ";
         result += "normalMapId = " + this.normalMapId + " ";
         result += "opacityMapId = " + this.opacityMapId + " ";
         result += "specularMapId = " + this.specularMapId + " ";
         return result + "]";
      }
   }
}

