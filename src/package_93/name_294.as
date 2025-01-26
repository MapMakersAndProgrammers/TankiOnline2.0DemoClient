package package_93
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import alternativa.tanks.game.GameTask;
   
   public class name_294 extends GameTask
   {
      private static const MESSAGE_SPACING_Y:int = 19;
      
      private static const MESSAGE_LIFE_TIME:int = 5000;
      
      private var maxMessagesNumber:int;
      
      private var var_436:Sprite;
      
      private var var_435:Vector.<Message>;
      
      private var timer:Timer;
      
      public function name_294(priority:int, maxMessagesNumber:int, container:DisplayObjectContainer, messagesX:int, messagesY:int)
      {
         super(priority);
         this.maxMessagesNumber = maxMessagesNumber;
         this.var_436 = new Sprite();
         this.var_436.x = messagesX;
         this.var_436.y = messagesY;
         container.addChild(this.var_436);
         this.var_435 = new Vector.<Message>();
         this.timer = new Timer(1000);
         this.timer.addEventListener(TimerEvent.TIMER,this.method_391);
      }
      
      public function set messagesX(value:int) : void
      {
         this.var_436.x = value;
      }
      
      public function set messagesY(value:int) : void
      {
         this.var_436.y = value;
      }
      
      public function name_305(text:String, color:uint) : void
      {
         var message:Message = new Message(text,color,MESSAGE_LIFE_TIME);
         this.var_435.push(message);
         this.var_436.addChild(message);
         if(this.var_435.length > this.maxMessagesNumber)
         {
            this.method_389(0);
         }
         this.method_390();
         this.method_388();
      }
      
      override public function stop() : void
      {
         this.var_436.parent.removeChild(this.var_436);
         this.timer.stop();
      }
      
      private function method_388() : void
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
      
      private function method_390() : void
      {
         var message:Message = null;
         for(var i:int = 0; i < this.var_435.length; i++)
         {
            message = this.var_435[i];
            message.y = i * MESSAGE_SPACING_Y;
         }
      }
      
      private function method_391(event:TimerEvent) : void
      {
         this.method_392(getTimer());
         this.method_390();
         this.method_388();
      }
      
      private function method_392(time:int) : void
      {
         if(this.var_435.length > 0)
         {
            if(Message(this.var_435[0]).expirationTime <= time)
            {
               this.method_389(0);
            }
         }
      }
      
      private function method_389(i:int) : void
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
