package alternativa.tanks.game.entities.tank.graphics
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.lights.DirectionalLight;
   import alternativa.engine3d.shadows.DirectionalShadowRenderer;
   import alternativa.tanks.game.subsystems.rendersystem.IShadowRendererConstructor;
   import alternativa.tanks.game.subsystems.rendersystem.RenderSystem;
   
   public class DirectionalShadowRendererConstructor implements IShadowRendererConstructor
   {
      private var object:Object3D;
      
      private var renderSystem:RenderSystem;
      
      private var consumer:IDirectionalShadowRendererConsumer;
      
      public function DirectionalShadowRendererConstructor(object:Object3D, renderSystem:RenderSystem, consumer:IDirectionalShadowRendererConsumer)
      {
         super();
         this.object = object;
         this.renderSystem = renderSystem;
         this.consumer = consumer;
      }
      
      public function createShadowRenderer() : void
      {
         var worldSize:Number = NaN;
         var textureSize:int = 0;
         var pcfSize:int = 0;
         var directionalShadowRenderer:DirectionalShadowRenderer = null;
         var directionalLights:Vector.<DirectionalLight> = this.renderSystem.lights.directionalLigths.lights;
         if(directionalLights != null && directionalLights.length > 0)
         {
            worldSize = 1300;
            textureSize = 256;
            pcfSize = 4;
            directionalShadowRenderer = new DirectionalShadowRenderer(this.renderSystem.getContext3D(),textureSize,worldSize,pcfSize);
            directionalShadowRenderer.name_qg = this.object;
            directionalShadowRenderer.setLight(directionalLights[0]);
            this.renderSystem.addShadowRenderer(directionalShadowRenderer);
            this.consumer.setShadowRenderer(directionalShadowRenderer);
         }
      }
   }
}

