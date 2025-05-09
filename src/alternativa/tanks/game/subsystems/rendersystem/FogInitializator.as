package alternativa.tanks.game.subsystems.rendersystem
{
   import flash.display.BitmapData;
   import flash.display.Stage3D;
   
   public class FogInitializator implements IDeferredAction
   {
      private var fogBitmap:BitmapData;
      
      private var renderSystem:RenderSystem;
      
      public function FogInitializator(fogBitmap:BitmapData, renderSystem:RenderSystem)
      {
         super();
         this.fogBitmap = fogBitmap;
         this.renderSystem = renderSystem;
      }
      
      public function execute(stage3d:Stage3D) : void
      {
         this.renderSystem.setFogTexture(this.fogBitmap);
      }
   }
}

