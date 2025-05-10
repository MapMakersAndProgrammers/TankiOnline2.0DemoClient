package alternativa.tanks.game.entities
{
   import alternativa.tanks.game.Entity;
   
   public class EventStates
   {
      public var §_-Ah§:IComponentState;
      
      private var §_-eB§:Object;
      
      public function EventStates()
      {
         super();
         this.§_-eB§ = new Object();
      }
      
      public function setEventState(entity:Entity, eventType:String, eventState:IComponentState) : void
      {
         if(this.§_-eB§[eventType] != null)
         {
            throw new Error("Duplicate event type: " + eventType);
         }
         this.§_-eB§[eventType] = eventState;
         entity.addEventHandler(eventType,this.onEvent);
      }
      
      public function onEvent(eventName:String, data:*) : void
      {
         var newState:IComponentState = this.§_-eB§[eventName];
         if(newState != this.§_-Ah§)
         {
            this.§_-Ah§.stop();
            this.§_-Ah§ = newState;
            this.§_-Ah§.start(data);
         }
      }
   }
}

