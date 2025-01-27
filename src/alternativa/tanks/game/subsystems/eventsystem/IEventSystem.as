package alternativa.tanks.game.subsystems.eventsystem
{
   public interface IEventSystem
   {
      function addEventListener(param1:String, param2:IGameEventListener) : void;
      
      function removeEventListener(param1:String, param2:IGameEventListener) : void;
      
      function dispatchEvent(param1:String, param2:*) : void;
   }
}

