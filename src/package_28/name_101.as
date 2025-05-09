package package_28
{
   import flash.display.InteractiveObject;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import package_15.class_1;
   import package_29.name_369;
   
   public class name_101 extends class_1 implements name_112
   {
      private static const NUM_KEYS:int = 256;
      
      private var eventSource:InteractiveObject;
      
      private var var_216:name_369;
      
      private var var_230:Boolean;
      
      private var var_221:Boolean;
      
      private var var_225:Boolean;
      
      private var var_227:int;
      
      private var var_226:int;
      
      private var mouseX:int;
      
      private var mouseY:int;
      
      private var var_229:int;
      
      private var var_228:int;
      
      private var var_223:int;
      
      private var var_224:CleanupTask;
      
      private var var_220:Vector.<Vector.<Function>>;
      
      private var var_217:Vector.<Vector.<Function>>;
      
      private var var_219:Vector.<Function>;
      
      private var var_218:Vector.<Function>;
      
      private var var_222:KeybardEventQueue;
      
      public function name_101(priority:int, eventSource:InteractiveObject)
      {
         super(priority);
         this.eventSource = eventSource;
         this.var_216 = new name_369(NUM_KEYS);
         this.var_220 = new Vector.<Vector.<Function>>(NUM_KEYS);
         this.var_217 = new Vector.<Vector.<Function>>(NUM_KEYS);
         this.var_219 = new Vector.<Function>();
         this.var_218 = new Vector.<Function>();
         this.var_222 = new KeybardEventQueue();
      }
      
      public function name_262(eventType:name_201, listener:Function, keyCode:uint = 0) : void
      {
         switch(eventType)
         {
            case name_201.KEY_DOWN:
               if(keyCode == 0)
               {
                  this.method_142(this.var_219,listener);
                  break;
               }
               this.method_144(this.var_220,keyCode,listener);
               break;
            case name_201.KEY_UP:
               if(keyCode == 0)
               {
                  this.method_142(this.var_218,listener);
                  break;
               }
               this.method_144(this.var_217,keyCode,listener);
               break;
         }
      }
      
      public function method_151(eventType:name_201, listener:Function, keyCode:uint = 0) : void
      {
         switch(eventType)
         {
            case name_201.KEY_DOWN:
               if(keyCode == 0)
               {
                  this.method_146(this.var_219,listener);
                  break;
               }
               this.method_141(this.var_220,keyCode,listener);
               break;
            case name_201.KEY_UP:
               if(keyCode == 0)
               {
                  this.method_146(this.var_218,listener);
                  break;
               }
               this.method_141(this.var_217,keyCode,listener);
               break;
         }
      }
      
      public function method_153(keyCode:uint) : int
      {
         return this.var_216.name_368(keyCode);
      }
      
      public function name_272(keyCode:uint) : Boolean
      {
         return this.var_216.name_368(keyCode) == 1;
      }
      
      private function method_144(keyTypeListeners:Vector.<Vector.<Function>>, keyCode:uint, listener:Function) : void
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
      
      private function method_141(keyTypeListeners:Vector.<Vector.<Function>>, keyCode:uint, listener:Function) : void
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
      
      private function method_142(listeners:Vector.<Function>, listener:Function) : void
      {
         if(listeners.indexOf(listener) < 0)
         {
            listeners.push(listener);
         }
      }
      
      private function method_146(listeners:Vector.<Function>, listener:Function) : void
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
      
      public function method_154() : Boolean
      {
         return this.var_221;
      }
      
      public function method_155() : Boolean
      {
         return this.var_225;
      }
      
      public function method_150() : int
      {
         return this.var_229;
      }
      
      public function method_149() : int
      {
         return this.var_228;
      }
      
      public function method_152() : int
      {
         return this.var_223;
      }
      
      override public function start() : void
      {
         this.var_224 = new CleanupTask(int.MAX_VALUE,this);
         var_4.addTask(this.var_224);
         this.eventSource.addEventListener(KeyboardEvent.KEY_DOWN,this.method_14);
         this.eventSource.addEventListener(KeyboardEvent.KEY_UP,this.method_111);
         this.eventSource.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         this.eventSource.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
         this.eventSource.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this.eventSource.addEventListener(MouseEvent.MOUSE_UP,this.method_145);
      }
      
      override public function stop() : void
      {
         var_4.killTask(this.var_224);
         this.eventSource.removeEventListener(KeyboardEvent.KEY_DOWN,this.method_14);
         this.eventSource.removeEventListener(KeyboardEvent.KEY_UP,this.method_111);
         this.eventSource.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         this.eventSource.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
         this.eventSource.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this.eventSource.removeEventListener(MouseEvent.MOUSE_UP,this.method_145);
      }
      
      override public function run() : void
      {
         this.var_229 = this.mouseX - this.var_227;
         this.var_228 = this.mouseY - this.var_226;
         this.method_147();
      }
      
      private function method_147() : void
      {
         var distinctListeners:Vector.<Function> = null;
         var listeners:Vector.<Function> = null;
         var event:KeyboardEventItem = null;
         var keyCode:uint = 0;
         var eventType:name_201 = null;
         while(true)
         {
            event = this.var_222.poll();
            if(event == null)
            {
               break;
            }
            keyCode = event.keyCode;
            eventType = event.type;
            switch(eventType)
            {
               case name_201.KEY_DOWN:
                  distinctListeners = this.var_220[keyCode];
                  listeners = this.var_219;
                  break;
               case name_201.KEY_UP:
                  distinctListeners = this.var_217[keyCode];
                  listeners = this.var_218;
            }
            if(distinctListeners != null)
            {
               this.method_143(distinctListeners,eventType,keyCode);
            }
            if(listeners != null)
            {
               this.method_143(listeners,eventType,keyCode);
            }
            event.destroy();
         }
      }
      
      private function method_143(listeners:Vector.<Function>, eventType:name_201, keyCode:uint) : void
      {
         var func:Function = null;
         var numListeners:int = int(listeners.length);
         for(var i:int = 0; i < numListeners; i++)
         {
            func = listeners[i];
            func.call(null,eventType,keyCode);
         }
      }
      
      public function method_148() : void
      {
         this.var_230 = this.var_221;
         this.var_225 = false;
         this.var_227 = this.mouseX;
         this.var_226 = this.mouseY;
         this.var_223 = 0;
      }
      
      private function method_14(event:KeyboardEvent) : void
      {
         var keyCode:uint = uint(event.keyCode);
         if(keyCode < NUM_KEYS)
         {
            if(this.var_216.name_368(keyCode) == 0)
            {
               this.var_216.name_370(keyCode,true);
               this.var_222.add(keyCode,name_201.KEY_DOWN);
            }
         }
      }
      
      private function method_111(event:KeyboardEvent) : void
      {
         var keyCode:uint = uint(event.keyCode);
         if(keyCode < NUM_KEYS)
         {
            if(this.var_216.name_368(keyCode) == 1)
            {
               this.var_216.name_370(keyCode,false);
               this.var_222.add(keyCode,name_201.KEY_UP);
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
         this.var_223 = event.delta;
      }
      
      private function onMouseDown(event:MouseEvent) : void
      {
         this.var_221 = true;
         this.var_225 = true;
      }
      
      private function method_145(event:MouseEvent) : void
      {
         this.var_221 = false;
      }
   }
}

import package_15.class_1;

class CleanupTask extends class_1
{
   private var inputSystem:name_101;
   
   public function CleanupTask(priority:int, inputSystem:name_101)
   {
      super(priority);
      this.inputSystem = inputSystem;
   }
   
   override public function run() : void
   {
      this.inputSystem.method_148();
   }
}

class KeyboardEventItem
{
   private static var pool:KeyboardEventItem;
   
   public var type:name_201;
   
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
   
   public function add(keyCode:uint, type:name_201) : void
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
