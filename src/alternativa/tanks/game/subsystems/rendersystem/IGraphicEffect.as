package alternativa.tanks.game.subsystems.rendersystem
{
   public interface IGraphicEffect
   {
      function addedToRenderSystem(param1:RenderSystem) : void;
      
      function play(param1:GameCamera) : Boolean;
      
      function destroy() : void;
   }
}

