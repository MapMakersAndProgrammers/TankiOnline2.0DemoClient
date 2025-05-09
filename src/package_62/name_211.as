package package_62
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import package_15.class_1;
   
   public class name_211 extends class_1
   {
      private static const MESSAGE_SPACING_Y:int = 19;
      
      private static const MESSAGE_LIFE_TIME:int = 5000;
      
      private var maxMessagesNumber:int;
      
      private var var_436:Sprite;
      
      private var var_435:Vector.<Message>;
      
      private var timer:Timer;
      
      public function name_211(priority:int, maxMessagesNumber:int, container:DisplayObjectContainer, messagesX:int, messagesY:int)
      {
         super(priority);
         this.maxMessagesNumber = maxMessagesNumber;
         this.var_436 = new Sprite();
         this.var_436.x = messagesX;
         this.var_436.y = messagesY;
         container.addChild(this.var_436);
         this.var_435 = new Vector.<Message>();
         this.timer = new Timer(1000);
         this.timer.addEventListener(TimerEvent.TIMER,this.method_163);
      }
      
      public function set messagesX(value:int) : void
      {
         this.var_436.x = value;
      }
      
      public function set messagesY(value:int) : void
      {
         this.var_436.y = value;
      }
      
      public function name_223(text:String, color:uint) : void
      {
         var message:Message = new Message(text,color,MESSAGE_LIFE_TIME);
         this.var_435.push(message);
         this.var_436.addChild(message);
         if(this.var_435.length > this.maxMessagesNumber)
         {
            this.method_161(0);
         }
         this.method_162();
         this.method_160();
      }
      
      override public function stop() : void
      {
         this.var_436.parent.removeChild(this.var_436);
         this.timer.stop();
      }
      
      private function method_160() : void
      {
         if(this.var_435.length > 0)
         {
            if(!this.timer.running)
            {
               this.timer.start();
            }
         }
         else if(this.timer.running)
         {
            this.timer.stop();
         }
      }
      
      private function method_162() : void
      {
         var message:Message = null;
         for(var i:int = 0; i < this.var_435.length; i++)
         {
            message = this.var_435[i];
            message.y = i * MESSAGE_SPACING_Y;
         }
      }
      
      private function method_163(event:TimerEvent) : void
      {
         this.method_164(getTimer());
         this.method_162();
         this.method_160();
      }
      
      private function method_164(time:int) : void
      {
         if(this.var_435.length > 0)
         {
            if(Message(this.var_435[0]).expirationTime <= time)
            {
               this.method_161(0);
            }
         }
      }
      
      private function method_161(i:int) : void
      {
         this.var_436.removeChild(this.var_435[i]);
         this.var_435.splice(i,1);
      }
   }
}

import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.events.EventDispatcher;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.utils.getTimer;

class Message extends TextField
{
   private static const DEFAULT_TEXT_FORMAT:TextFormat = new TextFormat("Tahoma",12);
   
   public var expirationTime:int;
   
   public function Message(text:String, color:uint, lifeTime:int)
   {
      super();
      autoSize = TextFieldAutoSize.LEFT;
      defaultTextFormat = DEFAULT_TEXT_FORMAT;
      textColor = color;
      this.text = text;
      this.expirationTime = getTimer() + lifeTime;
      background = true;
      backgroundColor = 0;
   }
}
