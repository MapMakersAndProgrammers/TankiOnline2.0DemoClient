package versions.version2.a3d.materials
{
   public class A3D2Material
   {
      private var name_9s:int;
      
      private var name_bl:int;
      
      private var name_3I:int;
      
      private var name_qf:int;
      
      private var name_QR:int;
      
      private var name_Jn:int;
      
      private var name_iG:int;
      
      private var name_LA:int;
      
      public function A3D2Material(diffuseMapId:int, glossinessMapId:int, id:int, lightMapId:int, normalMapId:int, opacityMapId:int, reflectionCubeMapId:int, specularMapId:int)
      {
         super();
         this.name_9s = diffuseMapId;
         this.name_bl = glossinessMapId;
         this.name_3I = id;
         this.name_qf = lightMapId;
         this.name_QR = normalMapId;
         this.name_Jn = opacityMapId;
         this.name_iG = reflectionCubeMapId;
         this.name_LA = specularMapId;
      }
      
      public function get diffuseMapId() : int
      {
         return this.name_9s;
      }
      
      public function set diffuseMapId(value:int) : void
      {
         this.name_9s = value;
      }
      
      public function get glossinessMapId() : int
      {
         return this.name_bl;
      }
      
      public function set glossinessMapId(value:int) : void
      {
         this.name_bl = value;
      }
      
      public function get id() : int
      {
         return this.name_3I;
      }
      
      public function set id(value:int) : void
      {
         this.name_3I = value;
      }
      
      public function get lightMapId() : int
      {
         return this.name_qf;
      }
      
      public function set lightMapId(value:int) : void
      {
         this.name_qf = value;
      }
      
      public function get normalMapId() : int
      {
         return this.name_QR;
      }
      
      public function set normalMapId(value:int) : void
      {
         this.name_QR = value;
      }
      
      public function get opacityMapId() : int
      {
         return this.name_Jn;
      }
      
      public function set opacityMapId(value:int) : void
      {
         this.name_Jn = value;
      }
      
      public function get reflectionCubeMapId() : int
      {
         return this.name_iG;
      }
      
      public function set reflectionCubeMapId(value:int) : void
      {
         this.name_iG = value;
      }
      
      public function get specularMapId() : int
      {
         return this.name_LA;
      }
      
      public function set specularMapId(value:int) : void
      {
         this.name_LA = value;
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

