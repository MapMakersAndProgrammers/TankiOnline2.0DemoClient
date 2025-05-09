package alternativa.tanks.game.subsystems.rendersystem
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.lights.AmbientLight;
   
   public class Lights
   {
      private var container:Object3D;
      
      private var var_142:AmbientLight;
      
      private var var_145:DirectionalLightList;
      
      private var var_143:OmniLightList;
      
      private var var_144:SpotLightList;
      
      public function Lights(container:Object3D)
      {
         super();
         this.container = container;
         this.var_145 = new DirectionalLightList(container);
         this.var_143 = new OmniLightList(container);
         this.var_144 = new SpotLightList(container);
      }
      
      public function set ambientLight(light:AmbientLight) : void
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
      
      public function get ambientLight() : AmbientLight
      {
         return this.var_142;
      }
      
      public function get directionalLigths() : DirectionalLightList
      {
         return this.var_145;
      }
      
      public function get omniLigths() : OmniLightList
      {
         return this.var_143;
      }
      
      public function get spotLights() : SpotLightList
      {
         return this.var_144;
      }
   }
}

