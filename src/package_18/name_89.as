package package_18
{
   import package_21.name_78;
   import package_24.name_376;
   
   public class name_89
   {
      private var container:name_78;
      
      private var var_142:name_376;
      
      private var var_143:name_423;
      
      private var var_144:name_424;
      
      private var var_145:name_422;
      
      public function name_89(container:name_78)
      {
         super();
         this.container = container;
         this.var_143 = new name_423(container);
         this.var_144 = new name_424(container);
         this.var_145 = new name_422(container);
      }
      
      public function set ambientLight(light:name_376) : void
      {
         if(this.var_142 != light)
         {
            if(this.var_142 != null)
            {
               this.container.removeChild(this.var_142);
            }
            this.var_142 = light;
            if(this.var_142 != null)
            {
               this.container.addChild(this.var_142);
            }
         }
      }
      
      public function get ambientLight() : name_376
      {
         return this.var_142;
      }
      
      public function get directionalLigths() : name_423
      {
         return this.var_143;
      }
      
      public function get omniLigths() : name_424
      {
         return this.var_144;
      }
      
      public function get spotLights() : name_422
      {
         return this.var_145;
      }
   }
}

