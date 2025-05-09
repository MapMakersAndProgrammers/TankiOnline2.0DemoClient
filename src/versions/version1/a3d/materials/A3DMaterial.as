package versions.version1.a3d.materials
{
   import commons.Id;
   
   public class A3DMaterial
   {
      private var var_339:Id;
      
      private var var_343:Id;
      
      private var var_101:Id;
      
      private var var_345:Id;
      
      private var var_342:Id;
      
      private var var_340:Id;
      
      private var var_341:Id;
      
      public function A3DMaterial(diffuseMapId:Id, glossinessMapId:Id, id:Id, lightMapId:Id, normalMapId:Id, opacityMapId:Id, specularMapId:Id)
      {
         super();
         this.var_339 = diffuseMapId;
         this.var_343 = glossinessMapId;
         this.var_101 = id;
         this.var_345 = lightMapId;
         this.var_342 = normalMapId;
         this.var_340 = opacityMapId;
         this.var_341 = specularMapId;
      }
      
      public function get diffuseMapId() : Id
      {
         return this.var_339;
      }
      
      public function set diffuseMapId(value:Id) : void
      {
         this.var_339 = value;
      }
      
      public function get glossinessMapId() : Id
      {
         return this.var_343;
      }
      
      public function set glossinessMapId(value:Id) : void
      {
         this.var_343 = value;
      }
      
      public function get id() : Id
      {
         return this.var_101;
      }
      
      public function set id(value:Id) : void
      {
         this.var_101 = value;
      }
      
      public function get lightMapId() : Id
      {
         return this.var_345;
      }
      
      public function set lightMapId(value:Id) : void
      {
         this.var_345 = value;
      }
      
      public function get normalMapId() : Id
      {
         return this.var_342;
      }
      
      public function set normalMapId(value:Id) : void
      {
         this.var_342 = value;
      }
      
      public function get opacityMapId() : Id
      {
         return this.var_340;
      }
      
      public function set opacityMapId(value:Id) : void
      {
         this.var_340 = value;
      }
      
      public function get specularMapId() : Id
      {
         return this.var_341;
      }
      
      public function set specularMapId(value:Id) : void
      {
         this.var_341 = value;
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

