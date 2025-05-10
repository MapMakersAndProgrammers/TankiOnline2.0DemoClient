package versions.version1.a3d.materials
{
   import commons.Id;
   
   public class A3DMaterial
   {
      private var name_9s:Id;
      
      private var name_bl:Id;
      
      private var name_3I:Id;
      
      private var name_qf:Id;
      
      private var name_QR:Id;
      
      private var name_Jn:Id;
      
      private var name_LA:Id;
      
      public function A3DMaterial(diffuseMapId:Id, glossinessMapId:Id, id:Id, lightMapId:Id, normalMapId:Id, opacityMapId:Id, specularMapId:Id)
      {
         super();
         this.name_9s = diffuseMapId;
         this.name_bl = glossinessMapId;
         this.name_3I = id;
         this.name_qf = lightMapId;
         this.name_QR = normalMapId;
         this.name_Jn = opacityMapId;
         this.name_LA = specularMapId;
      }
      
      public function get diffuseMapId() : Id
      {
         return this.name_9s;
      }
      
      public function set diffuseMapId(value:Id) : void
      {
         this.name_9s = value;
      }
      
      public function get glossinessMapId() : Id
      {
         return this.name_bl;
      }
      
      public function set glossinessMapId(value:Id) : void
      {
         this.name_bl = value;
      }
      
      public function get id() : Id
      {
         return this.name_3I;
      }
      
      public function set id(value:Id) : void
      {
         this.name_3I = value;
      }
      
      public function get lightMapId() : Id
      {
         return this.name_qf;
      }
      
      public function set lightMapId(value:Id) : void
      {
         this.name_qf = value;
      }
      
      public function get normalMapId() : Id
      {
         return this.name_QR;
      }
      
      public function set normalMapId(value:Id) : void
      {
         this.name_QR = value;
      }
      
      public function get opacityMapId() : Id
      {
         return this.name_Jn;
      }
      
      public function set opacityMapId(value:Id) : void
      {
         this.name_Jn = value;
      }
      
      public function get specularMapId() : Id
      {
         return this.name_LA;
      }
      
      public function set specularMapId(value:Id) : void
      {
         this.name_LA = value;
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

