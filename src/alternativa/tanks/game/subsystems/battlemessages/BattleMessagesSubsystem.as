package alternativa.tanks.game.subsystems.battlemessages
{
   import alternativa.tanks.game.GameTask;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class BattleMessagesSubsystem extends GameTask
   {
      private static const MESSAGE_SPACING_Y:int = 19;
      
      private static const MESSAGE_LIFE_TIME:int = 5000;
      
      private var maxMessagesNumber:int;
      
      private var §_-pQ§:Sprite;
      
      private var §_-cd§:Vector.<Message>;
      
      private var timer:Timer;
      
      public function BattleMessagesSubsystem(priority:int, maxMessagesNumber:int, container:DisplayObjectContainer, messagesX:int, messagesY:int)
      {
         super(priority);
         this.maxMessagesNumber = maxMessagesNumber;
         this.§_-pQ§ = new Sprite();
         this.§_-pQ§.x = messagesX;
         this.§_-pQ§.y = messagesY;
         container.addChild(this.§_-pQ§);
         this.§_-cd§ = new Vector.<Message>();
         this.timer = new Timer(1000);
         this.timer.addEventListener(TimerEvent.TIMER,this.onTimer);
      }
      
      public function set messagesX(value:int) : void
      {
         this.§_-pQ§.x = value;
      }
      
      public function set messagesY(value:int) : void
      {
         this.§_-pQ§.y = value;
      }
      
      public function addMessage(text:String, color:uint) : void
      {
         var message:Message = new Message(text,color,MESSAGE_LIFE_TIME);
         this.§_-cd§.push(message);
         this.§_-pQ§.addChild(message);
         if(this.§_-cd§.length > this.maxMessagesNumber)
         {
            this.removeMessage(0);
         }
         this.updateMessagesPositions();
         this.updateTimerState();
      }
      
      override public function stop() : void
      {
         this.§_-pQ§.parent.removeChild(this.§_-pQ§);
         this.timer.stop();
      }
      
      private function updateTimerState() : void
      {
         if(this.§_-cd§.length > 0)
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
      
      private function updateMessagesPositions() : void
      {
         var message:Message = null;
         for(var i:int = 0; i < this.§_-cd§.length; i++)
         {
            message = this.§_-cd§[i];
            message.y = i * MESSAGE_SPACING_Y;
         }
      }
      
      private function onTimer(event:TimerEvent) : void
      {
         this.removeExpiredMessages(getTimer());
         this.updateMessagesPositions();
         this.updateTimerState();
      }
      
      private function removeExpiredMessages(time:int) : void
      {
         if(this.§_-cd§.length > 0)
         {
            if(Message(this.§_-cd§[0]).expirationTime <= time)
            {
               this.removeMessage(0);
            }
         }
      }
      
      private function removeMessage(i:int) : void
      {
         this.§_-pQ§.removeChild(this.§_-cd§[i]);
         this.§_-cd§.splice(i,1);
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
