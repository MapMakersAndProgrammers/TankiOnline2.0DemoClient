package alternativa.tanks.game.entities
{
   import alternativa.tanks.game.Entity;
   
   public class EventStates
   {
      public var name_371:IComponentState;
      
      private var var_619:Object;
      
      public function EventStates()
      {
         super();
         this.var_619 = new Object();
      }
      
      public function setEventState(entity:Entity, eventType:String, eventState:IComponentState) : void
      {
         if(this.var_619[eventType] != null)
         {
            throw new Error("Duplicate event type: " + eventType);
         }
         this.var_619[eventType] = eventState;
         entity.addEventHandler(eventType,this.onEvent);
      }
      
      public function onEvent(eventName:String, data:*) : void
      {
         var newState:IComponentState = this.var_619[eventName];
         if(newState != this.name_371)
         {
            this.name_371.stop();
            this.name_371 = newState;
            this.name_371.start(data);
         }
      }
   }
}

