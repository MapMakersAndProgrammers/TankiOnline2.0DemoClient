package alternativa.tanks.game.subsystems.eventsystem
{
   public class GameEvent
   {
      private static var pool:GameEvent;
      
      public var eventType:String;
      
      public var eventData:*;
      
      public var next:GameEvent;
      
      public function GameEvent(eventType:String, eventData:*)
      {
         super();
         this.eventType = eventType;
         this.eventData = eventData;
      }
      
      public static function create(eventType:String, eventData:*) : GameEvent
      {
         if(pool == null)
         {
            return new GameEvent(eventType,eventData);
         }
         var item:GameEvent = pool;
         pool = item.next;
         item.next = null;
         item.eventType = eventType;
         item.eventData = eventData;
         return item;
      }
      
      public function destroy() : void
      {
         this.eventType = null;
         this.eventData = null;
         this.next = pool;
         pool = this;
      }
   }
}

