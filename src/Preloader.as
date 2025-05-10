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
      
      private var §_-1q§:Bitmap = new EmbedPreloader();
      
      private var §_-Za§:Bitmap = new EmbedPreloaderA();
      
      private var progress:Bitmap = new EmbedProgress();
      
      private var context:Context3D;
      
      public var maps:Vector.<ExternalTextureResource>;
      
      private var §_-dH§:int;
      
      private var counter:int;
      
      private var baseURL:String;
      
      private var §_-m§:TextureResource = new BitmapTextureResource(new BitmapData(1,1,false,8355711));
      
      private var §_-UB§:Number = 0.09803921568627451;
      
      public function Preloader()
      {
         super();
         addChild(this.area);
         this.area.alpha = 1;
         this.progress.alpha = 1;
         this.§_-1q§.alpha = 1;
         addChild(this.§_-1q§);
         addChild(this.§_-Za§);
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
         this.area.alpha -= this.§_-UB§;
         this.§_-1q§.alpha -= this.§_-UB§;
         this.progress.alpha -= this.§_-UB§;
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
         this.§_-Za§.alpha -= this.§_-UB§ * 1.5;
         if(this.§_-Za§.alpha <= 0)
         {
            removeEventListener(Event.ENTER_FRAME,this.onEnterFrameSwitch);
         }
      }
      
      private function onResize(param1:Event = null) : void
      {
         this.area.graphics.clear();
         this.§_-1q§.x = Math.round(stage.stageWidth / 2 - this.§_-1q§.width / 2);
         this.§_-1q§.y = Math.round(stage.stageHeight / 2 - this.§_-1q§.height / 2) - 30;
         this.§_-Za§.x = this.§_-1q§.x;
         this.§_-Za§.y = this.§_-1q§.y;
         this.progress.x = this.§_-1q§.x + 2;
         this.progress.y = this.§_-1q§.y + 221;
         this.area.graphics.beginFill(0);
         this.area.graphics.drawRect(0,0,this.§_-1q§.x,stage.stageHeight);
         this.area.graphics.drawRect(this.§_-1q§.x,0,this.§_-1q§.width,this.§_-1q§.y);
         this.area.graphics.drawRect(this.§_-1q§.x + this.§_-1q§.width,0,stage.stageWidth - this.§_-1q§.width - this.§_-1q§.x,stage.stageHeight);
         this.area.graphics.drawRect(this.§_-1q§.x,this.§_-1q§.y + this.§_-1q§.height,this.§_-1q§.width,stage.stageHeight - this.§_-1q§.height - this.§_-1q§.y);
      }
   }
}

