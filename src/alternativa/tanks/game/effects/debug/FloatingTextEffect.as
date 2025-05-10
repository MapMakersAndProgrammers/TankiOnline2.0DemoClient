package alternativa.tanks.game.effects.debug
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.Object3D;
   import alternativa.tanks.game.subsystems.rendersystem.GameCamera;
   import alternativa.tanks.game.subsystems.rendersystem.IGraphicEffect;
   import alternativa.tanks.game.subsystems.rendersystem.RenderSystem;
   import alternativa.tanks.game.subsystems.timesystem.TimeSystem;
   import alternativa.tanks.game.utils.objectpool.ObjectPool;
   import alternativa.tanks.game.utils.objectpool.PooledObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.geom.Vector3D;
   
   use namespace alternativa3d;
   
   public class FloatingTextEffect extends PooledObject implements IGraphicEffect
   {
      private static var vector1:Vector3D = new Vector3D();
      
      private static var vector2:Vector3D = new Vector3D();
      
      private var messageLifeTime:int;
      
      private var name_cd:Vector.<Message>;
      
      private var anchor:Object3D;
      
      private var name_1R:DisplayObjectContainer;
      
      private var name_Cx:Function;
      
      public function FloatingTextEffect(objectPool:ObjectPool)
      {
         super(objectPool);
         this.name_cd = new Vector.<Message>();
         this.name_1R = new Sprite();
      }
      
      public function init(messageLifeTime:int, anchor:Object3D, destuctionCallback:Function) : void
      {
         this.messageLifeTime = messageLifeTime;
         this.anchor = anchor;
         this.name_Cx = destuctionCallback;
      }
      
      public function addMessage(text:String, color:uint) : void
      {
         var message:Message = Message.create();
         message.color = color;
         message.text = text;
         message.lifeTime = 0;
         this.name_cd.push(message);
         this.name_1R.addChild(message);
      }
      
      public function addedToRenderSystem(system:RenderSystem) : void
      {
         system.getOverlay("debug_messages").addChild(this.name_1R);
      }
      
      public function play(camera:GameCamera) : Boolean
      {
         var i:int = 0;
         var message:Message = null;
         var timeDelta:int = TimeSystem.timeDelta;
         for(i = 0; i < this.name_cd.length; )
         {
            message = this.name_cd[i];
            message.lifeTime += timeDelta;
            if(message.lifeTime >= this.messageLifeTime)
            {
               message.destroy();
               this.name_cd.shift();
               i--;
            }
            i++;
         }
         if(this.name_cd.length == 0)
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
            this.name_1R.visible = true;
            this.name_1R.x = int(vector2.x);
            this.name_1R.y = int(vector2.y);
         }
         else
         {
            this.name_1R.visible = false;
         }
         var messageY:int = 0;
         for(i = this.name_cd.length - 1; i >= 0; i--)
         {
            message = this.name_cd[i];
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
         if(this.name_1R.parent != null)
         {
            this.name_1R.parent.removeChild(this.name_1R);
         }
         for each(message in this.name_cd)
         {
            message.destroy();
         }
         this.name_cd.length = 0;
         if(this.name_Cx != null)
         {
            func = this.name_Cx;
            this.name_Cx = null;
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
