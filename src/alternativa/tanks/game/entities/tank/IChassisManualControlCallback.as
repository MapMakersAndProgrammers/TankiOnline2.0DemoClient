package alternativa.tanks.game.entities.tank
{
   public interface IChassisManualControlCallback
   {
      function onControlChanged(param1:int, param2:int, param3:Boolean) : void;
      
      function onSync() : void;
   }
}

