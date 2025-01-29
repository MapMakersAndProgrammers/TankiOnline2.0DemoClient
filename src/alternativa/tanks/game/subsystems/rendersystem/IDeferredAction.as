package alternativa.tanks.game.subsystems.rendersystem
{
   import flash.display.Stage3D;
   
   public interface IDeferredAction
   {
      function execute(param1:Stage3D) : void;
   }
}

