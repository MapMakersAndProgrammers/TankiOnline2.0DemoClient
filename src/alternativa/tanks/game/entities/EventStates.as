package alternativa.tanks.game.entities
{
   import alternativa.tanks.game.Entity;
   
   public class EventStates
   {
      public var name_Ah:IComponentState;
      
      private var name_eB:Object;
      
      public function EventStates()
      {
         super();
         this.name_eB = new Object();
      }
      
      public function setEventState(entity:Entity, eventType:String, eventState:IComponentState) : void
      {
         if(this.name_eB[eventType] != null)
         {
            throw new Error("Duplicate event type: " + eventType);
         }
         this.name_eB[eventType] = eventState;
         entity.addEventHandler(eventType,this.onEvent);
      }
      
      public function onEvent(eventName:String, data:*) : void
      {
         var newState:IComponentState = this.name_eB[eventName];
         if(newState != this.name_Ah)
         {
            this.name_Ah.stop();
            this.name_Ah = newState;
            this.name_Ah.start(data);
         }
      }
   }
}

