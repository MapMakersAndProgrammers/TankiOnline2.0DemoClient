package §_-K8§
{
   import §_-8D§.§_-OX§;
   import §_-RQ§.§_-HE§;
   import §_-RQ§.§_-Va§;
   import §_-e6§.§_-1I§;
   import §_-e6§.§_-RE§;
   import §_-e6§.§_-fX§;
   import §_-lS§.§_-h2§;
   import alternativa.engine3d.alternativa3d;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.geom.Vector3D;
   
   use namespace alternativa3d;
   
   public class §_-e5§ extends §_-HE§ implements §_-fX§
   {
      private static var vector1:Vector3D = new Vector3D();
      
      private static var vector2:Vector3D = new Vector3D();
      
      private var messageLifeTime:int;
      
      private var §_-cd§:Vector.<Message>;
      
      private var anchor:§_-OX§;
      
      private var §_-1R§:DisplayObjectContainer;
      
      private var §_-Cx§:Function;
      
      public function §_-e5§(objectPool:§_-Va§)
      {
         super(objectPool);
         this.§_-cd§ = new Vector.<Message>();
         this.§_-1R§ = new Sprite();
      }
      
      public function init(messageLifeTime:int, anchor:§_-OX§, destuctionCallback:Function) : void
      {
         this.messageLifeTime = messageLifeTime;
         this.anchor = anchor;
         this.§_-Cx§ = destuctionCallback;
      }
      
      public function §_-U8§(text:String, color:uint) : void
      {
         var message:Message = Message.create();
         message.color = color;
         message.text = text;
         message.lifeTime = 0;
         this.§_-cd§.push(message);
         this.§_-1R§.addChild(message);
      }
      
      public function addedToRenderSystem(system:§_-1I§) : void
      {
         system.§_-S4§("debug_messages").addChild(this.§_-1R§);
      }
      
      public function play(camera:§_-RE§) : Boolean
      {
         var i:int = 0;
         var message:Message = null;
         var timeDelta:int = int(§_-h2§.timeDelta);
         for(i = 0; i < this.§_-cd§.length; )
         {
            message = this.§_-cd§[i];
            message.lifeTime += timeDelta;
            if(message.lifeTime >= this.messageLifeTime)
            {
               message.destroy();
               this.§_-cd§.shift();
               i--;
            }
            i++;
         }
         if(this.§_-cd§.length == 0)
         {
            return false;
         }
         vector1.x = 0;
         vector1.y = 0;
         vector1.z = 0;
         var vector2:Vector3D = camera.projectGlobal(this.anchor.localToGlobal(vector1));
         vector2.x -= camera.view.width / 2;
         vector2.y -= camera.view.height / 2;
         if(vector2.z > 0.01 && vector2.z > camera.nearClipping)
         {
            this.§_-1R§.visible = true;
            this.§_-1R§.x = int(vector2.x);
            this.§_-1R§.y = int(vector2.y);
         }
         else
         {
            this.§_-1R§.visible = false;
         }
         var messageY:int = 0;
         for(i = this.§_-cd§.length - 1; i >= 0; i--)
         {
            message = this.§_-cd§[i];
            message.y = messageY;
            message.x = -int(message.textWidth / 2);
            messageY -= 20;
         }
         return true;
      }
      
      public function destroy() : void
      {
         var message:Message = null;
         var func:Function = null;
         if(this.§_-1R§.parent != null)
         {
            this.§_-1R§.parent.removeChild(this.§_-1R§);
         }
         for each(message in this.§_-cd§)
         {
            message.destroy();
         }
         this.§_-cd§.length = 0;
         if(this.§_-Cx§ != null)
         {
            func = this.§_-Cx§;
            this.§_-Cx§ = null;
            func.call();
         }
      }
   }
}

import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.events.EventDispatcher;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

class Message extends TextField
{
   private static var poolSize:int;
   
   private static const DEFAULT_TEXT_FORMAT:TextFormat = new TextFormat("Tahoma",12);
   
   private static var pool:Vector.<Message> = new Vector.<Message>();
   
   public var lifeTime:int;
   
   public function Message()
   {
      super();
      autoSize = TextFieldAutoSize.LEFT;
      defaultTextFormat = DEFAULT_TEXT_FORMAT;
      background = true;
      backgroundColor = 0;
   }
   
   public static function create() : Message
   {
      if(poolSize == 0)
      {
         return new Message();
      }
      return pool[--poolSize];
   }
   
   public function set color(value:uint) : void
   {
      var textFormat:TextFormat = defaultTextFormat;
      textFormat.color = value;
      defaultTextFormat = textFormat;
   }
   
   public function destroy() : void
   {
      if(parent != null)
      {
         parent.removeChild(this);
      }
      text = "";
      var _loc1_:* = poolSize++;
      pool[_loc1_] = this;
   }
}
