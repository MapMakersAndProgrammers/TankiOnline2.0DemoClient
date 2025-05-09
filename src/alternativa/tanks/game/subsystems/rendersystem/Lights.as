package alternativa.tanks.game.subsystems.rendersystem
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.lights.AmbientLight;
   
   public class Lights
   {
      private var container:Object3D;
      
      private var §_-e8§:AmbientLight;
      
      private var §_-qW§:DirectionalLightList;
      
      private var §_-hD§:OmniLightList;
      
      private var §_-pd§:SpotLightList;
      
      public function Lights(container:Object3D)
      {
         super();
         this.container = container;
         this.§_-qW§ = new DirectionalLightList(container);
         this.§_-hD§ = new OmniLightList(container);
         this.§_-pd§ = new SpotLightList(container);
      }
      
      public function set ambientLight(light:AmbientLight) : void
      {
         if(this.§_-e8§ != light)
         {
            if(this.§_-e8§ != null)
            {
               this.container.removeChild(this.§_-e8§);
            }
            this.§_-e8§ = light;
            if(this.§_-e8§ != null)
            {
               this.container.addChild(this.§_-e8§);
            }
         }
      }
      
      public function get ambientLight() : AmbientLight
      {
         return this.§_-e8§;
      }
      
      public function get directionalLigths() : DirectionalLightList
      {
         return this.§_-qW§;
      }
      
      public function get omniLigths() : OmniLightList
      {
         return this.§_-hD§;
      }
      
      public function get spotLights() : SpotLightList
      {
         return this.§_-pd§;
      }
   }
}

