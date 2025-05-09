package alternativa.tanks.game.subsystems.physicssystem
{
   public interface IPhysicsController
   {
      function updateBeforeSimulation(param1:int) : void;
      
      function updateAfterSimulation(param1:int) : void;
      
      function interpolate(param1:Number) : void;
   }
}

