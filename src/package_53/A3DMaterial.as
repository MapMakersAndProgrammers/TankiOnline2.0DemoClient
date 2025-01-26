package package_53
{
   import package_57.name_213;
   
   public class A3DMaterial
   {
      private var var_345:name_213;
      
      private var var_342:name_213;
      
      private var var_101:name_213;
      
      private var var_343:name_213;
      
      private var var_339:name_213;
      
      private var var_341:name_213;
      
      private var var_340:name_213;
      
      public function A3DMaterial(diffuseMapId:name_213, glossinessMapId:name_213, id:name_213, lightMapId:name_213, normalMapId:name_213, opacityMapId:name_213, specularMapId:name_213)
      {
         super();
         this.var_345 = diffuseMapId;
         this.var_342 = glossinessMapId;
         this.var_101 = id;
         this.var_343 = lightMapId;
         this.var_339 = normalMapId;
         this.var_341 = opacityMapId;
         this.var_340 = specularMapId;
      }
      
      public function get diffuseMapId() : name_213
      {
         return this.var_345;
      }
      
      public function set diffuseMapId(value:name_213) : void
      {
         this.var_345 = value;
      }
      
      public function get glossinessMapId() : name_213
      {
         return this.var_342;
      }
      
      public function set glossinessMapId(value:name_213) : void
      {
         this.var_342 = value;
      }
      
      public function get id() : name_213
      {
         return this.var_101;
      }
      
      public function set id(value:name_213) : void
      {
         this.var_101 = value;
      }
      
      public function get lightMapId() : name_213
      {
         return this.var_343;
      }
      
      public function set lightMapId(value:name_213) : void
      {
         this.var_343 = value;
      }
      
      public function get normalMapId() : name_213
      {
         return this.var_339;
      }
      
      public function set normalMapId(value:name_213) : void
      {
         this.var_339 = value;
      }
      
      public function get opacityMapId() : name_213
      {
         return this.var_341;
      }
      
      public function set opacityMapId(value:name_213) : void
      {
         this.var_341 = value;
      }
      
      public function get specularMapId() : name_213
      {
         return this.var_340;
      }
      
      public function set specularMapId(value:name_213) : void
      {
         this.var_340 = value;
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

