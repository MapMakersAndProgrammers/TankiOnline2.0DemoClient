package package_71
{
   import flash.utils.Dictionary;
   import package_10.class_17;
   import package_10.name_17;
   import package_10.name_57;
   import package_20.class_11;
   
   public class name_278 extends class_17 implements class_11
   {
      private static var stateEvents:Dictionary;
      
      private var gameKernel:name_17;
      
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
      
      override public function addToGame(gameKernel:name_17) : void
      {
         this.gameKernel = gameKernel;
         gameKernel.name_61().addEventListener(name_57.BATTLE_FINISHED,this);
      }
      
      override public function removeFromGame(gameKernel:name_17) : void
      {
         gameKernel.name_61().removeEventListener(name_57.BATTLE_FINISHED,this);
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

