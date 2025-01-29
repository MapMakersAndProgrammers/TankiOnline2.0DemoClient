package package_85
{
   import alternativa.tanks.game.subsystems.rendersystem.RenderSystem;
   import alternativa.tanks.game.subsystems.rendersystem.IShadowRendererConstructor;
   import package_21.name_78;
   import package_23.name_208;
   import package_24.DirectionalLight;
   
   public class name_596 implements IShadowRendererConstructor
   {
      private var object:name_78;
      
      private var renderSystem:RenderSystem;
      
      private var consumer:class_31;
      
      public function name_596(object:name_78, renderSystem:RenderSystem, consumer:class_31)
      {
         super();
         this.object = object;
         this.renderSystem = renderSystem;
         this.consumer = consumer;
      }
      
      public function name_111() : void
      {
         var worldSize:Number = NaN;
         var textureSize:int = 0;
         var pcfSize:int = 0;
         var directionalShadowRenderer:name_208 = null;
         var directionalLights:Vector.<DirectionalLight> = this.renderSystem.lights.directionalLigths.lights;
         if(directionalLights != null && directionalLights.length > 0)
         {
            worldSize = 1300;
            textureSize = 256;
            pcfSize = 4;
            directionalShadowRenderer = new name_208(this.renderSystem.method_42(),textureSize,worldSize,pcfSize);
            directionalShadowRenderer.var_235 = this.object;
            directionalShadowRenderer.method_371(directionalLights[0]);
            this.renderSystem.method_70(directionalShadowRenderer);
            this.consumer.method_496(directionalShadowRenderer);
         }
      }
   }
}

