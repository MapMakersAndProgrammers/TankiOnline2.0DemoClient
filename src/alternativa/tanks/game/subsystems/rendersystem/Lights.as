package alternativa.tanks.game.subsystems.rendersystem
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.lights.AmbientLight;
   
   public class Lights
   {
      private var container:Object3D;
      
      private var name_e8:AmbientLight;
      
      private var name_qW:DirectionalLightList;
      
      private var name_hD:OmniLightList;
      
      private var name_pd:SpotLightList;
      
      public function Lights(container:Object3D)
      {
         super();
         this.container = container;
         this.name_qW = new DirectionalLightList(container);
         this.name_hD = new OmniLightList(container);
         this.name_pd = new SpotLightList(container);
      }
      
      public function set ambientLight(light:AmbientLight) : void
      {
         if(this.name_e8 != light)
         {
            if(this.name_e8 != null)
            {
               this.container.removeChild(this.name_e8);
            }
            this.name_e8 = light;
            if(this.name_e8 != null)
            {
               this.container.addChild(this.name_e8);
            }
         }
      }
      
      public function get ambientLight() : AmbientLight
      {
         return this.name_e8;
      }
      
      public function get directionalLigths() : DirectionalLightList
      {
         return this.name_qW;
      }
      
      public function get omniLigths() : OmniLightList
      {
         return this.name_hD;
      }
      
      public function get spotLights() : SpotLightList
      {
         return this.name_pd;
      }
   }
}

