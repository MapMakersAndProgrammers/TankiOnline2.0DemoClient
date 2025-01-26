package package_78
{
   import package_19.name_380;
   import package_46.name_194;
   import package_71.name_234;
   import package_71.name_333;
   
   public class name_731 extends name_258
   {
      public function name_731()
      {
         super();
      }
      
      override protected function createTankPart() : name_333
      {
         return new name_234();
      }
      
      override protected function getParsingFunctions() : Object
      {
         return {
            "turret":this.method_429,
            "fmnt":this.method_886,
            "box":this.method_887,
            "muzzle":this.method_885
         };
      }
      
      private function method_429(mesh:name_380, tankTurret:name_234) : void
      {
         tankTurret.geometry = mesh.geometry;
      }
      
      private function method_886(mesh:name_380, tankTurret:name_234) : void
      {
         tankTurret.var_423.reset(mesh.x,mesh.y,mesh.z);
      }
      
      private function method_887(mesh:name_380, tankTurret:name_234) : void
      {
         tankTurret.var_422.push(name_531.name_532(mesh));
      }
      
      private function method_885(mesh:name_380, tankTurret:name_234) : void
      {
         tankTurret.var_421.push(new name_194(mesh.x,mesh.y,mesh.z));
      }
   }
}

