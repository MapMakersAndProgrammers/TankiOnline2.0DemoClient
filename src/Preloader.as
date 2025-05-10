package
{
   import alternativa.engine3d.resources.BitmapTextureResource;
   import alternativa.engine3d.resources.ExternalTextureResource;
   import alternativa.engine3d.resources.TextureResource;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.display3D.Context3D;
   import flash.events.Event;
   
   public class Preloader extends Sprite
   {
      private static const EmbedPreloader:Class = Preloader_EmbedPreloader;
      
      private static const EmbedPreloaderA:Class = Preloader_EmbedPreloaderA;
      
      private static const EmbedProgress:Class = Preloader_EmbedProgress;
      
      private var area:Shape = new Shape();
      
      private var name_1q:Bitmap = new EmbedPreloader();
      
      private var name_Za:Bitmap = new EmbedPreloaderA();
      
      private var progress:Bitmap = new EmbedProgress();
      
      private var context:Context3D;
      
      public var maps:Vector.<ExternalTextureResource>;
      
      private var name_dH:int;
      
      private var counter:int;
      
      private var baseURL:String;
      
      private var name_m:TextureResource = new BitmapTextureResource(new BitmapData(1,1,false,8355711));
      
      private var name_UB:Number = 0.09803921568627451;
      
      public function Preloader()
      {
         super();
         addChild(this.area);
         this.area.alpha = 1;
         this.progress.alpha = 1;
         this.name_1q.alpha = 1;
         addChild(this.name_1q);
         addChild(this.name_Za);
         addChild(this.progress);
         addEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStage);
         this.progress.scaleX = 0.025;
      }
      
      public function setProgress(param1:Number) : void
      {
         this.progress.scaleX = param1;
         if(this.progress.scaleX >= 1)
         {
            this.onComplete();
         }
      }
      
      private function onComplete() : void
      {
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function addProgress(param1:Number) : void
      {
         this.progress.scaleX += param1;
         if(this.progress.scaleX > 0.5)
         {
            addEventListener(Event.ENTER_FRAME,this.onEnterFrameSwitch);
         }
         if(this.progress.scaleX >= 1)
         {
            this.onComplete();
         }
      }
      
      private function onAddToStage(param1:Event) : void
      {
         stage.addEventListener(Event.RESIZE,this.onResize);
         this.onResize();
      }
      
      private function onRemoveFromStage(param1:Event) : void
      {
         stage.removeEventListener(Event.RESIZE,this.onResize);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         this.area.alpha -= this.name_UB;
         this.name_1q.alpha -= this.name_UB;
         this.progress.alpha -= this.name_UB;
         if(this.area.alpha <= 0)
         {
            removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            if(parent != null)
            {
               parent.removeChild(this);
               dispatchEvent(new Event(Event.COMPLETE));
            }
         }
      }
      
      private function onEnterFrameSwitch(param1:Event) : void
      {
         this.name_Za.alpha -= this.name_UB * 1.5;
         if(this.name_Za.alpha <= 0)
         {
            removeEventListener(Event.ENTER_FRAME,this.onEnterFrameSwitch);
         }
      }
      
      private function onResize(param1:Event = null) : void
      {
         this.area.graphics.clear();
         this.name_1q.x = Math.round(stage.stageWidth / 2 - this.name_1q.width / 2);
         this.name_1q.y = Math.round(stage.stageHeight / 2 - this.name_1q.height / 2) - 30;
         this.name_Za.x = this.name_1q.x;
         this.name_Za.y = this.name_1q.y;
         this.progress.x = this.name_1q.x + 2;
         this.progress.y = this.name_1q.y + 221;
         this.area.graphics.beginFill(0);
         this.area.graphics.drawRect(0,0,this.name_1q.x,stage.stageHeight);
         this.area.graphics.drawRect(this.name_1q.x,0,this.name_1q.width,this.name_1q.y);
         this.area.graphics.drawRect(this.name_1q.x + this.name_1q.width,0,stage.stageWidth - this.name_1q.width - this.name_1q.x,stage.stageHeight);
         this.area.graphics.drawRect(this.name_1q.x,this.name_1q.y + this.name_1q.height,this.name_1q.width,stage.stageHeight - this.name_1q.height - this.name_1q.y);
      }
   }
}

