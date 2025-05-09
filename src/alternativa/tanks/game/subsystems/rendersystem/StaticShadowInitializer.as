package alternativa.tanks.game.subsystems.rendersystem
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.lights.DirectionalLight;
   import alternativa.engine3d.shadows.StaticShadowRenderer;
   import flash.display3D.Context3D;
   
   public class StaticShadowInitializer
   {
      private var staticShadowRenderer:StaticShadowRenderer;
      
      private var container:Object3D;
      
      private var light:DirectionalLight;
      
      public function StaticShadowInitializer(staticShadowRenderer:StaticShadowRenderer, container:Object3D, light:DirectionalLight)
      {
         super();
         this.staticShadowRenderer = staticShadowRenderer;
         this.container = container;
         this.light = light;
      }
      
      public function execute(context3D:Context3D) : void
      {
         context3D.configureBackBuffer(50,50,0);
         this.staticShadowRenderer.calculateShadows(this.container,this.light,5,3,1000);
         this.light.shadow = this.staticShadowRenderer;
      }
   }
}

