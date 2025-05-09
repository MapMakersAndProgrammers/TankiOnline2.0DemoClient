package alternativa.tanks.game.entities.tank
{
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameEvents;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.subsystems.eventsystem.IGameEventListener;
   import flash.utils.Dictionary;
   
   public class TankControlComponent extends EntityComponent implements IGameEventListener
   {
      private static var stateEvents:Dictionary;
      
      private var gameKernel:GameKernel;
      
      public function TankControlComponent()
      {
         super();
         if(stateEvents == null)
         {
            stateEvents = new Dictionary();
            stateEvents[TankGameState.ACTIVATING] = TankEvents.SET_ACTIVATING_STATE;
            stateEvents[TankGameState.ACTIVE] = TankEvents.SET_ACTIVE_STATE;
            stateEvents[TankGameState.DEAD] = TankEvents.SET_DEAD_STATE;
            stateEvents[TankGameState.IN_RESPAWN] = TankEvents.SET_RESPAWN_STATE;
         }
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         this.gameKernel = gameKernel;
         gameKernel.getEventSystem().addEventListener(GameEvents.BATTLE_FINISHED,this);
      }
      
      override public function removeFromGame(gameKernel:GameKernel) : void
      {
         gameKernel.getEventSystem().removeEventListener(GameEvents.BATTLE_FINISHED,this);
      }
      
      public function setState(state:TankGameState, data:* = undefined) : void
      {
         var eventType:String = stateEvents[state];
         if(Boolean(eventType))
         {
            entity.dispatchEvent(eventType,data);
         }
      }
      
      public function onGameEvent(eventType:String, eventData:*) : void
      {
         entity.dispatchEvent(eventType,eventData);
      }
   }
}

