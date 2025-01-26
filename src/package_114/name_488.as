package package_114
{
   import alternativa.tanks.game.Entity;
   
   public class name_488
   {
      public var name_493:class_35;
      
      private var var_619:Object;
      
      public function name_488()
      {
         super();
         this.var_619 = new Object();
      }
      
      public function name_486(entity:Entity, eventType:String, eventState:class_35) : void
      {
         if(this.var_619[eventType] != null)
         {
            throw new Error("Duplicate event type: " + eventType);
         }
         this.var_619[eventType] = eventState;
         entity.addEventHandler(eventType,this.method_703);
      }
      
      public function method_703(eventName:String, data:*) : void
      {
         var newState:class_35 = this.var_619[eventName];
         if(newState != this.name_493)
         {
            this.name_493.stop();
            this.name_493 = newState;
            this.name_493.start(data);
         }
      }
   }
}

