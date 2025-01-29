package alternativa.tanks.game.subsystems.rendersystem
{
   import package_21.name_78;
   import package_24.name_376;
   
   public class Lights
   {
      private var container:name_78;
      
      private var var_142:name_376;
      
      private var var_143:DirectionalLightList;
      
      private var var_144:OmniLightList;
      
      private var var_145:SpotLightList;
      
      public function Lights(container:name_78)
      {
         super();
         this.container = container;
         this.var_143 = new DirectionalLightList(container);
         this.var_144 = new OmniLightList(container);
         this.var_145 = new SpotLightList(container);
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
      
      public function get directionalLigths() : DirectionalLightList
      {
         return this.var_143;
      }
      
      public function get omniLigths() : OmniLightList
      {
         return this.var_144;
      }
      
      public function get spotLights() : SpotLightList
      {
         return this.var_145;
      }
   }
}

