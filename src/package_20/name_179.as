package package_20
{
   import alternativa.tanks.game.GameTask;
   import package_108.name_373;
   import package_108.name_374;
   
   public class name_179 extends GameTask implements name_56
   {
      private var eventQueue1:name_374;
      
      private var eventQueue2:name_374;
      
      private var var_213:Object;
      
      public function name_179(priority:int)
      {
         super(priority);
         this.eventQueue1 = new name_374();
         this.eventQueue2 = new name_374();
         this.var_213 = new Object();
      }
      
      public function addEventListener(eventType:String, listener:class_11) : void
      {
         var listeners:name_374 = this.var_213[eventType];
         if(listeners == null)
         {
            listeners = new name_374();
            this.var_213[eventType] = listeners;
         }
         listeners.add(listener);
      }
      
      public function removeEventListener(eventType:String, listener:class_11) : void
      {
         var listeners:name_374 = this.var_213[eventType];
         if(listeners != null)
         {
            listeners.remove(listener);
         }
      }
      
      public function dispatchEvent(eventType:String, eventData:*) : void
      {
         this.eventQueue1.add(name_476.create(eventType,eventData));
      }
      
      override public function run() : void
      {
         var event:name_476 = null;
         var listeners:name_374 = null;
         var iterator:name_373 = null;
         var listener:class_11 = null;
         var tmp:name_374 = this.eventQueue1;
         this.eventQueue1 = this.eventQueue2;
         for(this.eventQueue2 = tmp; (event = name_476(this.eventQueue2.poll())) != null; )
         {
            listeners = this.var_213[event.eventType];
            if(listeners != null)
            {
               iterator = listeners.listIterator();
               while(iterator.hasNext())
               {
                  listener = class_11(iterator.next());
                  listener.method_146(event.eventType,event.eventData);
               }
            }
            event.destroy();
         }
      }
   }
}

