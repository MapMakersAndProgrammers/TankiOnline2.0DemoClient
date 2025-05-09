package versions.version2.a3d.materials
{
   public class A3D2Material
   {
      private var var_339:int;
      
      private var var_343:int;
      
      private var var_101:int;
      
      private var var_345:int;
      
      private var var_342:int;
      
      private var var_340:int;
      
      private var var_344:int;
      
      private var var_341:int;
      
      public function A3D2Material(diffuseMapId:int, glossinessMapId:int, id:int, lightMapId:int, normalMapId:int, opacityMapId:int, reflectionCubeMapId:int, specularMapId:int)
      {
         super();
         this.var_339 = diffuseMapId;
         this.var_343 = glossinessMapId;
         this.var_101 = id;
         this.var_345 = lightMapId;
         this.var_342 = normalMapId;
         this.var_340 = opacityMapId;
         this.var_344 = reflectionCubeMapId;
         this.var_341 = specularMapId;
      }
      
      public function get diffuseMapId() : int
      {
         return this.var_339;
      }
      
      public function set diffuseMapId(value:int) : void
      {
         this.var_339 = value;
      }
      
      public function get glossinessMapId() : int
      {
         return this.var_343;
      }
      
      public function set glossinessMapId(value:int) : void
      {
         this.var_343 = value;
      }
      
      public function get id() : int
      {
         return this.var_101;
      }
      
      public function set id(value:int) : void
      {
         this.var_101 = value;
      }
      
      public function get lightMapId() : int
      {
         return this.var_345;
      }
      
      public function set lightMapId(value:int) : void
      {
         this.var_345 = value;
      }
      
      public function get normalMapId() : int
      {
         return this.var_342;
      }
      
      public function set normalMapId(value:int) : void
      {
         this.var_342 = value;
      }
      
      public function get opacityMapId() : int
      {
         return this.var_340;
      }
      
      public function set opacityMapId(value:int) : void
      {
         this.var_340 = value;
      }
      
      public function get reflectionCubeMapId() : int
      {
         return this.var_344;
      }
      
      public function set reflectionCubeMapId(value:int) : void
      {
         this.var_344 = value;
      }
      
      public function get specularMapId() : int
      {
         return this.var_341;
      }
      
      public function set specularMapId(value:int) : void
      {
         this.var_341 = value;
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

