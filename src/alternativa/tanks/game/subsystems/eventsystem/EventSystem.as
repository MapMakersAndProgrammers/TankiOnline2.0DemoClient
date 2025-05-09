package alternativa.tanks.game.subsystems.eventsystem
{
   import alternativa.tanks.game.GameTask;
   import alternativa.tanks.game.utils.list.List;
   import alternativa.tanks.game.utils.list.ListIterator;
   
   public class EventSystem extends GameTask implements IEventSystem
   {
      private var eventQueue1:List;
      
      private var eventQueue2:List;
      
      private var §_-iZ§:Object;
      
      public function EventSystem(priority:int)
      {
         super(priority);
         this.eventQueue1 = new List();
         this.eventQueue2 = new List();
         this.§_-iZ§ = new Object();
      }
      
      public function addEventListener(eventType:String, listener:IGameEventListener) : void
      {
         var listeners:List = this.§_-iZ§[eventType];
         if(listeners == null)
         {
            listeners = new List();
            this.§_-iZ§[eventType] = listeners;
         }
         listeners.add(listener);
      }
      
      public function removeEventListener(eventType:String, listener:IGameEventListener) : void
      {
         var listeners:List = this.§_-iZ§[eventType];
         if(listeners != null)
         {
            listeners.remove(listener);
         }
      }
      
      public function dispatchEvent(eventType:String, eventData:*) : void
      {
         this.eventQueue1.add(GameEvent.create(eventType,eventData));
      }
      
      override public function run() : void
      {
         var event:GameEvent = null;
         var listeners:List = null;
         var iterator:ListIterator = null;
         var listener:IGameEventListener = null;
         var tmp:List = this.eventQueue1;
         this.eventQueue1 = this.eventQueue2;
         for(this.eventQueue2 = tmp; (event = GameEvent(this.eventQueue2.poll())) != null; )
         {
            listeners = this.§_-iZ§[event.eventType];
            if(listeners != null)
            {
               iterator = listeners.listIterator();
               while(iterator.hasNext())
               {
                  listener = IGameEventListener(iterator.next());
                  listener.onGameEvent(event.eventType,event.eventData);
               }
            }
            event.destroy();
         }
      }
   }
}

