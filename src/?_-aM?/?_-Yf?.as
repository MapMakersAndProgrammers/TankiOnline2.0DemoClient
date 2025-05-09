package §_-aM§
{
   import §_-V-§.§_-C1§;
   import §_-az§.§_-ps§;
   import flash.display.InteractiveObject;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class §_-Yf§ extends §_-ps§ implements §_-Lm§
   {
      private static const NUM_KEYS:int = 256;
      
      private var eventSource:InteractiveObject;
      
      private var §_-Pb§:§_-C1§;
      
      private var §_-FK§:Boolean;
      
      private var §_-PG§:Boolean;
      
      private var §_-Hv§:Boolean;
      
      private var §_-8e§:int;
      
      private var §_-dL§:int;
      
      private var mouseX:int;
      
      private var mouseY:int;
      
      private var §_-Sm§:int;
      
      private var §_-4F§:int;
      
      private var §_-HC§:int;
      
      private var §_-Jh§:CleanupTask;
      
      private var §_-CU§:Vector.<Vector.<Function>>;
      
      private var §_-ll§:Vector.<Vector.<Function>>;
      
      private var § use§:Vector.<Function>;
      
      private var §_-A4§:Vector.<Function>;
      
      private var §use §:KeybardEventQueue;
      
      public function §_-Yf§(priority:int, eventSource:InteractiveObject)
      {
         super(priority);
         this.eventSource = eventSource;
         this.§_-Pb§ = new §_-C1§(NUM_KEYS);
         this.§_-CU§ = new Vector.<Vector.<Function>>(NUM_KEYS);
         this.§_-ll§ = new Vector.<Vector.<Function>>(NUM_KEYS);
         this.§ use§ = new Vector.<Function>();
         this.§_-A4§ = new Vector.<Function>();
         this.§use § = new KeybardEventQueue();
      }
      
      public function §_-hn§(eventType:§_-X0§, listener:Function, keyCode:uint = 0) : void
      {
         switch(eventType)
         {
            case §_-X0§.KEY_DOWN:
               if(keyCode == 0)
               {
                  this.§_-3J§(this.§ use§,listener);
                  break;
               }
               this.§_-ft§(this.§_-CU§,keyCode,listener);
               break;
            case §_-X0§.KEY_UP:
               if(keyCode == 0)
               {
                  this.§_-3J§(this.§_-A4§,listener);
                  break;
               }
               this.§_-ft§(this.§_-ll§,keyCode,listener);
               break;
         }
      }
      
      public function §_-or§(eventType:§_-X0§, listener:Function, keyCode:uint = 0) : void
      {
         switch(eventType)
         {
            case §_-X0§.KEY_DOWN:
               if(keyCode == 0)
               {
                  this.§_-JO§(this.§ use§,listener);
                  break;
               }
               this.§_-7G§(this.§_-CU§,keyCode,listener);
               break;
            case §_-X0§.KEY_UP:
               if(keyCode == 0)
               {
                  this.§_-JO§(this.§_-A4§,listener);
                  break;
               }
               this.§_-7G§(this.§_-ll§,keyCode,listener);
               break;
         }
      }
      
      public function §_-OO§(keyCode:uint) : int
      {
         return this.§_-Pb§.§_-2C§(keyCode);
      }
      
      public function §_-IA§(keyCode:uint) : Boolean
      {
         return this.§_-Pb§.§_-2C§(keyCode) == 1;
      }
      
      private function §_-ft§(keyTypeListeners:Vector.<Vector.<Function>>, keyCode:uint, listener:Function) : void
      {
         var listeners:Vector.<Function> = keyTypeListeners[keyCode];
         if(listeners == null)
         {
            listeners = new Vector.<Function>(1);
            listeners[0] = listener;
            keyTypeListeners[keyCode] = listeners;
         }
         else if(listeners.indexOf(listener) < 0)
         {
            listeners.push(listener);
         }
      }
      
      private function §_-7G§(keyTypeListeners:Vector.<Vector.<Function>>, keyCode:uint, listener:Function) : void
      {
         var index:int = 0;
         var newLength:int = 0;
         var listeners:Vector.<Function> = keyTypeListeners[keyCode];
         if(listeners != null)
         {
            index = int(listeners.indexOf(listener));
            if(index >= 0)
            {
               newLength = listeners.length - 1;
               listeners[index] = listeners[newLength];
               listeners.length = newLength;
            }
         }
      }
      
      private function §_-3J§(listeners:Vector.<Function>, listener:Function) : void
      {
         if(listeners.indexOf(listener) < 0)
         {
            listeners.push(listener);
         }
      }
      
      private function §_-JO§(listeners:Vector.<Function>, listener:Function) : void
      {
         var newLength:int = 0;
         var index:int = int(listeners.indexOf(listener));
         if(index >= 0)
         {
            newLength = listeners.length - 1;
            listeners[index] = listeners[newLength];
            listeners.length = newLength;
         }
      }
      
      public function §_-an§() : Boolean
      {
         return this.§_-PG§;
      }
      
      public function §_-0T§() : Boolean
      {
         return this.§_-Hv§;
      }
      
      public function §_-ow§() : int
      {
         return this.§_-Sm§;
      }
      
      public function §_-ac§() : int
      {
         return this.§_-4F§;
      }
      
      public function §_-i9§() : int
      {
         return this.§_-HC§;
      }
      
      override public function start() : void
      {
         this.§_-Jh§ = new CleanupTask(int.MAX_VALUE,this);
         §_-Uw§.addTask(this.§_-Jh§);
         this.eventSource.addEventListener(KeyboardEvent.KEY_DOWN,this.§_-Ze§);
         this.eventSource.addEventListener(KeyboardEvent.KEY_UP,this.§_-Uf§);
         this.eventSource.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         this.eventSource.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
         this.eventSource.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this.eventSource.addEventListener(MouseEvent.MOUSE_UP,this.§_-4B§);
      }
      
      override public function stop() : void
      {
         §_-Uw§.killTask(this.§_-Jh§);
         this.eventSource.removeEventListener(KeyboardEvent.KEY_DOWN,this.§_-Ze§);
         this.eventSource.removeEventListener(KeyboardEvent.KEY_UP,this.§_-Uf§);
         this.eventSource.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         this.eventSource.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
         this.eventSource.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this.eventSource.removeEventListener(MouseEvent.MOUSE_UP,this.§_-4B§);
      }
      
      override public function run() : void
      {
         this.§_-Sm§ = this.mouseX - this.§_-8e§;
         this.§_-4F§ = this.mouseY - this.§_-dL§;
         this.§_-Db§();
      }
      
      private function §_-Db§() : void
      {
         var distinctListeners:Vector.<Function> = null;
         var listeners:Vector.<Function> = null;
         var event:KeyboardEventItem = null;
         var keyCode:uint = 0;
         var eventType:§_-X0§ = null;
         while(true)
         {
            event = this.§use §.poll();
            if(event == null)
            {
               break;
            }
            keyCode = event.keyCode;
            eventType = event.type;
            switch(eventType)
            {
               case §_-X0§.KEY_DOWN:
                  distinctListeners = this.§_-CU§[keyCode];
                  listeners = this.§ use§;
                  break;
               case §_-X0§.KEY_UP:
                  distinctListeners = this.§_-ll§[keyCode];
                  listeners = this.§_-A4§;
            }
            if(distinctListeners != null)
            {
               this.§_-np§(distinctListeners,eventType,keyCode);
            }
            if(listeners != null)
            {
               this.§_-np§(listeners,eventType,keyCode);
            }
            event.destroy();
         }
      }
      
      private function §_-np§(listeners:Vector.<Function>, eventType:§_-X0§, keyCode:uint) : void
      {
         var func:Function = null;
         var numListeners:int = int(listeners.length);
         for(var i:int = 0; i < numListeners; i++)
         {
            func = listeners[i];
            func.call(null,eventType,keyCode);
         }
      }
      
      public function §_-cM§() : void
      {
         this.§_-FK§ = this.§_-PG§;
         this.§_-Hv§ = false;
         this.§_-8e§ = this.mouseX;
         this.§_-dL§ = this.mouseY;
         this.§_-HC§ = 0;
      }
      
      private function §_-Ze§(event:KeyboardEvent) : void
      {
         var keyCode:uint = uint(event.keyCode);
         if(keyCode < NUM_KEYS)
         {
            if(this.§_-Pb§.§_-2C§(keyCode) == 0)
            {
               this.§_-Pb§.§_-Kg§(keyCode,true);
               this.§use §.add(keyCode,§_-X0§.KEY_DOWN);
            }
         }
      }
      
      private function §_-Uf§(event:KeyboardEvent) : void
      {
         var keyCode:uint = uint(event.keyCode);
         if(keyCode < NUM_KEYS)
         {
            if(this.§_-Pb§.§_-2C§(keyCode) == 1)
            {
               this.§_-Pb§.§_-Kg§(keyCode,false);
               this.§use §.add(keyCode,§_-X0§.KEY_UP);
            }
         }
      }
      
      private function onMouseMove(event:MouseEvent) : void
      {
         this.mouseX = event.stageX;
         this.mouseY = event.stageY;
      }
      
      private function onMouseWheel(event:MouseEvent) : void
      {
         this.§_-HC§ = event.delta;
      }
      
      private function onMouseDown(event:MouseEvent) : void
      {
         this.§_-PG§ = true;
         this.§_-Hv§ = true;
      }
      
      private function §_-4B§(event:MouseEvent) : void
      {
         this.§_-PG§ = false;
      }
   }
}

import §_-az§.§_-ps§;

class CleanupTask extends §_-ps§
{
   private var inputSystem:§_-Yf§;
   
   public function CleanupTask(priority:int, inputSystem:§_-Yf§)
   {
      super(priority);
      this.inputSystem = inputSystem;
   }
   
   override public function run() : void
   {
      this.inputSystem.§_-cM§();
   }
}

class KeyboardEventItem
{
   private static var pool:KeyboardEventItem;
   
   public var type:§_-X0§;
   
   public var keyCode:uint;
   
   public var next:KeyboardEventItem;
   
   public function KeyboardEventItem()
   {
      super();
   }
   
   public static function create() : KeyboardEventItem
   {
      if(pool == null)
      {
         return new KeyboardEventItem();
      }
      var item:KeyboardEventItem = pool;
      pool = pool.next;
      item.next = null;
      return item;
   }
   
   public function destroy() : void
   {
      this.next = pool;
      pool = this;
   }
}

class KeybardEventQueue
{
   private var head:KeyboardEventItem;
   
   private var tail:KeyboardEventItem;
   
   public function KeybardEventQueue()
   {
      super();
   }
   
   public function add(keyCode:uint, type:§_-X0§) : void
   {
      var keyItem:KeyboardEventItem = KeyboardEventItem.create();
      keyItem.keyCode = keyCode;
      keyItem.type = type;
      if(this.head == null)
      {
         this.head = keyItem;
      }
      else
      {
         this.tail.next = keyItem;
      }
      this.tail = keyItem;
   }
   
   public function poll() : KeyboardEventItem
   {
      if(this.head == null)
      {
         return null;
      }
      var item:KeyboardEventItem = this.head;
      this.head = this.head.next;
      return item;
   }
}

class MouseEventItem
{
   private static var pool:MouseEventItem;
   
   public var leftButtonPressed:Boolean;
   
   public var next:MouseEventItem;
   
   public function MouseEventItem()
   {
      super();
   }
   
   public static function create() : MouseEventItem
   {
      if(pool == null)
      {
         return new MouseEventItem();
      }
      var item:MouseEventItem = pool;
      pool = pool.next;
      item.next = null;
      return item;
   }
   
   public function destroy() : void
   {
      this.next = pool;
      pool = this;
   }
}

class MouseEventQueue
{
   private var head:MouseEventItem;
   
   private var tail:MouseEventItem;
   
   public function MouseEventQueue()
   {
      super();
   }
   
   public function add(leftButtonPressed:Boolean) : void
   {
      var mouseEventItem:MouseEventItem = MouseEventItem.create();
      mouseEventItem.leftButtonPressed = leftButtonPressed;
      if(this.head == null)
      {
         this.head = mouseEventItem;
      }
      else
      {
         this.tail.next = mouseEventItem;
      }
      this.tail = mouseEventItem;
   }
   
   public function poll() : MouseEventItem
   {
      if(this.head == null)
      {
         return null;
      }
      var item:MouseEventItem = this.head;
      this.head = item.next;
      return item;
   }
}
