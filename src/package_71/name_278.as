package package_71
{
   import flash.utils.Dictionary;
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.GameEvents;
   import alternativa.tanks.game.subsystems.eventsystem.IGameEventListener;
   
   public class name_278 extends EntityComponent implements IGameEventListener
   {
      private static var stateEvents:Dictionary;
      
      private var gameKernel:GameKernel;
      
      public function name_278()
      {
         super();
         if(stateEvents == null)
         {
            stateEvents = new Dictionary();
            stateEvents[name_563.ACTIVATING] = name_252.SET_ACTIVATING_STATE;
            stateEvents[name_563.ACTIVE] = name_252.SET_ACTIVE_STATE;
            stateEvents[name_563.DEAD] = name_252.SET_DEAD_STATE;
            stateEvents[name_563.IN_RESPAWN] = name_252.SET_RESPAWN_STATE;
         }
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         this.gameKernel = gameKernel;
         gameKernel.name_61().addEventListener(GameEvents.BATTLE_FINISHED,this);
      }
      
      override public function removeFromGame(gameKernel:GameKernel) : void
      {
         gameKernel.name_61().removeEventListener(GameEvents.BATTLE_FINISHED,this);
      }
      
      public function method_470(state:name_563, data:* = undefined) : void
      {
         var eventType:String = stateEvents[state];
         if(Boolean(eventType))
         {
            entity.dispatchEvent(eventType,data);
         }
      }
      
      public function method_146(eventType:String, eventData:*) : void
      {
         entity.dispatchEvent(eventType,eventData);
      }
   }
}

