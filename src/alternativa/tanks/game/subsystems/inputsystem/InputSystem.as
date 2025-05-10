package alternativa.tanks.game.subsystems.inputsystem
{
   import alternativa.tanks.game.GameTask;
   import alternativa.tanks.game.utils.BitVector;
   import flash.display.InteractiveObject;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class InputSystem extends GameTask implements IInput
   {
      private static const NUM_KEYS:int = 256;
      
      private var eventSource:InteractiveObject;
      
      private var name_Pb:BitVector;
      
      private var name_FK:Boolean;
      
      private var name_PG:Boolean;
      
      private var name_Hv:Boolean;
      
      private var name_8e:int;
      
      private var name_dL:int;
      
      private var mouseX:int;
      
      private var mouseY:int;
      
      private var name_Sm:int;
      
      private var name_4F:int;
      
      private var name_HC:int;
      
      private var name_Jh:CleanupTask;
      
      private var name_CU:Vector.<Vector.<Function>>;
      
      private var name_ll:Vector.<Vector.<Function>>;
      
      private var name_use1:Vector.<Function>;
      
      private var name_A4:Vector.<Function>;
      
      private var name_use2:KeybardEventQueue;
      
      public function InputSystem(priority:int, eventSource:InteractiveObject)
      {
         super(priority);
         this.eventSource = eventSource;
         this.name_Pb = new BitVector(NUM_KEYS);
         this.name_CU = new Vector.<Vector.<Function>>(NUM_KEYS);
         this.name_ll = new Vector.<Vector.<Function>>(NUM_KEYS);
         this.name_use1 = new Vector.<Function>();
         this.name_A4 = new Vector.<Function>();
         this.name_use2 = new KeybardEventQueue();
      }
      
      public function addKeyboardListener(eventType:KeyboardEventType, listener:Function, keyCode:uint = 0) : void
      {
         switch(eventType)
         {
            case KeyboardEventType.KEY_DOWN:
               if(keyCode == 0)
               {
                  this.addKeyListener(this.name_use1,listener);
                  break;
               }
               this.addDistinctKeyListener(this.name_CU,keyCode,listener);
               break;
            case KeyboardEventType.KEY_UP:
               if(keyCode == 0)
               {
                  this.addKeyListener(this.name_A4,listener);
                  break;
               }
               this.addDistinctKeyListener(this.name_ll,keyCode,listener);
               break;
         }
      }
      
      public function removeKeyboardListener(eventType:KeyboardEventType, listener:Function, keyCode:uint = 0) : void
      {
         switch(eventType)
         {
            case KeyboardEventType.KEY_DOWN:
               if(keyCode == 0)
               {
                  this.removeKeyListener(this.name_use1,listener);
                  break;
               }
               this.removeDistinctKeyListener(this.name_CU,keyCode,listener);
               break;
            case KeyboardEventType.KEY_UP:
               if(keyCode == 0)
               {
                  this.removeKeyListener(this.name_A4,listener);
                  break;
               }
               this.removeDistinctKeyListener(this.name_ll,keyCode,listener);
               break;
         }
      }
      
      public function getKeyState(keyCode:uint) : int
      {
         return this.name_Pb.getBit(keyCode);
      }
      
      public function keyPressed(keyCode:uint) : Boolean
      {
         return this.name_Pb.getBit(keyCode) == 1;
      }
      
      private function addDistinctKeyListener(keyTypeListeners:Vector.<Vector.<Function>>, keyCode:uint, listener:Function) : void
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
      
      private function removeDistinctKeyListener(keyTypeListeners:Vector.<Vector.<Function>>, keyCode:uint, listener:Function) : void
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
      
      private function addKeyListener(listeners:Vector.<Function>, listener:Function) : void
      {
         if(listeners.indexOf(listener) < 0)
         {
            listeners.push(listener);
         }
      }
      
      private function removeKeyListener(listeners:Vector.<Function>, listener:Function) : void
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
      
      public function mouseButtonPressed() : Boolean
      {
         return this.name_PG;
      }
      
      public function wasMouseButtonPressed() : Boolean
      {
         return this.name_Hv;
      }
      
      public function getMouseDeltaX() : int
      {
         return this.name_Sm;
      }
      
      public function getMouseDeltaY() : int
      {
         return this.name_4F;
      }
      
      public function getMouseWheelDelta() : int
      {
         return this.name_HC;
      }
      
      override public function start() : void
      {
         this.name_Jh = new CleanupTask(int.MAX_VALUE,this);
         name_Uw.addTask(this.name_Jh);
         this.eventSource.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         this.eventSource.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         this.eventSource.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         this.eventSource.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
         this.eventSource.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this.eventSource.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
      }
      
      override public function stop() : void
      {
         name_Uw.killTask(this.name_Jh);
         this.eventSource.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         this.eventSource.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         this.eventSource.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         this.eventSource.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
         this.eventSource.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this.eventSource.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
      }
      
      override public function run() : void
      {
         this.name_Sm = this.mouseX - this.name_8e;
         this.name_4F = this.mouseY - this.name_dL;
         this.dispatchKeyboardEvents();
      }
      
      private function dispatchKeyboardEvents() : void
      {
         var distinctListeners:Vector.<Function> = null;
         var listeners:Vector.<Function> = null;
         var event:KeyboardEventItem = null;
         var keyCode:uint = 0;
         var eventType:KeyboardEventType = null;
         while(true)
         {
            event = this.name_use2.poll();
            if(event == null)
            {
               break;
            }
            keyCode = event.keyCode;
            eventType = event.type;
            switch(eventType)
            {
               case KeyboardEventType.KEY_DOWN:
                  distinctListeners = this.name_CU[keyCode];
                  listeners = this.name_use1;
                  break;
               case KeyboardEventType.KEY_UP:
                  distinctListeners = this.name_ll[keyCode];
                  listeners = this.name_A4;
            }
            if(distinctListeners != null)
            {
               this.dispatchKeyboardEvent(distinctListeners,eventType,keyCode);
            }
            if(listeners != null)
            {
               this.dispatchKeyboardEvent(listeners,eventType,keyCode);
            }
            event.destroy();
         }
      }
      
      private function dispatchKeyboardEvent(listeners:Vector.<Function>, eventType:KeyboardEventType, keyCode:uint) : void
      {
         var func:Function = null;
         var numListeners:int = int(listeners.length);
         for(var i:int = 0; i < numListeners; i++)
         {
            func = listeners[i];
            func.call(null,eventType,keyCode);
         }
      }
      
      public function cleanup() : void
      {
         this.name_FK = this.name_PG;
         this.name_Hv = false;
         this.name_8e = this.mouseX;
         this.name_dL = this.mouseY;
         this.name_HC = 0;
      }
      
      private function onKeyDown(event:KeyboardEvent) : void
      {
         var keyCode:uint = uint(event.keyCode);
         if(keyCode < NUM_KEYS)
         {
            if(this.name_Pb.getBit(keyCode) == 0)
            {
               this.name_Pb.setBit(keyCode,true);
               this.name_use2.add(keyCode,KeyboardEventType.KEY_DOWN);
            }
         }
      }
      
      private function onKeyUp(event:KeyboardEvent) : void
      {
         var keyCode:uint = uint(event.keyCode);
         if(keyCode < NUM_KEYS)
         {
            if(this.name_Pb.getBit(keyCode) == 1)
            {
               this.name_Pb.setBit(keyCode,false);
               this.name_use2.add(keyCode,KeyboardEventType.KEY_UP);
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
         this.name_HC = event.delta;
      }
      
      private function onMouseDown(event:MouseEvent) : void
      {
         this.name_PG = true;
         this.name_Hv = true;
      }
      
      private function onMouseUp(event:MouseEvent) : void
      {
         this.name_PG = false;
      }
   }
}

import alternativa.tanks.game.GameTask;
import alternativa.tanks.game.subsystems.inputsystem.InputSystem;
import alternativa.tanks.game.subsystems.inputsystem.KeyboardEventType;

class CleanupTask extends GameTask
{
   private var inputSystem:InputSystem;
   
   public function CleanupTask(priority:int, inputSystem:InputSystem)
   {
      super(priority);
      this.inputSystem = inputSystem;
   }
   
   override public function run() : void
   {
      this.inputSystem.cleanup();
   }
}

class KeyboardEventItem
{
   private static var pool:KeyboardEventItem;
   
   public var type:KeyboardEventType;
   
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
   
   public function add(keyCode:uint, type:KeyboardEventType) : void
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
