package package_88
{
   import alternativa.engine3d.alternativa3d;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.geom.Vector3D;
   import package_18.name_44;
   import package_18.name_85;
   import package_18.name_90;
   import package_21.name_78;
   import package_26.class_18;
   import package_26.name_402;
   import package_45.name_182;
   
   use namespace alternativa3d;
   
   public class name_268 extends class_18 implements name_85
   {
      private static var vector1:Vector3D = new Vector3D();
      
      private static var vector2:Vector3D = new Vector3D();
      
      private var messageLifeTime:int;
      
      private var var_435:Vector.<Message>;
      
      private var anchor:name_78;
      
      private var var_466:DisplayObjectContainer;
      
      private var var_467:Function;
      
      public function name_268(objectPool:name_402)
      {
         super(objectPool);
         this.var_435 = new Vector.<Message>();
         this.var_466 = new Sprite();
      }
      
      public function init(messageLifeTime:int, anchor:name_78, destuctionCallback:Function) : void
      {
         this.messageLifeTime = messageLifeTime;
         this.anchor = anchor;
         this.var_467 = destuctionCallback;
      }
      
      public function name_305(text:String, color:uint) : void
      {
         var message:Message = Message.create();
         message.color = color;
         message.text = text;
         message.lifeTime = 0;
         this.var_435.push(message);
         this.var_466.addChild(message);
      }
      
      public function addedToRenderSystem(system:name_44) : void
      {
         system.method_41("debug_messages").addChild(this.var_466);
      }
      
      public function play(camera:name_90) : Boolean
      {
         var i:int = 0;
         var message:Message = null;
         var timeDelta:int = name_182.timeDelta;
         for(i = 0; i < this.var_435.length; )
         {
            message = this.var_435[i];
            message.lifeTime += timeDelta;
            if(message.lifeTime >= this.messageLifeTime)
            {
               message.destroy();
               this.var_435.shift();
               i--;
            }
            i++;
         }
         if(this.var_435.length == 0)
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
            this.var_466.visible = true;
            this.var_466.x = int(vector2.x);
            this.var_466.y = int(vector2.y);
         }
         else
         {
            this.var_466.visible = false;
         }
         var messageY:int = 0;
         for(i = this.var_435.length - 1; i >= 0; i--)
         {
            message = this.var_435[i];
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
         if(this.var_466.parent != null)
         {
            this.var_466.parent.removeChild(this.var_466);
         }
         for each(message in this.var_435)
         {
            message.destroy();
         }
         this.var_435.length = 0;
         if(this.var_467 != null)
         {
            func = this.var_467;
            this.var_467 = null;
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
