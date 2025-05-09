package
{
   import §_-1z§.§_-b1§;
   import §_-1z§.§_-n4§;
   import §_-1z§.§_-pi§;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.display3D.Context3D;
   import flash.events.Event;
   
   public class Preloader extends Sprite
   {
      private static const EmbedPreloader:Class = §_-Lz§;
      
      private static const EmbedPreloaderA:Class = §_-9C§;
      
      private static const EmbedProgress:Class = §_-M9§;
      
      private var area:Shape = new Shape();
      
      private var §_-1q§:Bitmap = new EmbedPreloader();
      
      private var §_-Za§:Bitmap = new EmbedPreloaderA();
      
      private var progress:Bitmap = new EmbedProgress();
      
      private var context:Context3D;
      
      public var maps:Vector.<§_-n4§>;
      
      private var §_-dH§:int;
      
      private var counter:int;
      
      private var baseURL:String;
      
      private var §_-m§:§_-pi§ = new §_-b1§(new BitmapData(1,1,false,8355711));
      
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
         addEventListener(Event.ADDED_TO_STAGE,this.§_-Id§);
         addEventListener(Event.REMOVED_FROM_STAGE,this.§_-99§);
         this.progress.scaleX = 0.025;
      }
      
      public function §_-QU§(param1:Number) : void
      {
         this.progress.scaleX = param1;
         if(this.progress.scaleX >= 1)
         {
            this.§_-Dq§();
         }
      }
      
      private function §_-Dq§() : void
      {
         addEventListener(Event.ENTER_FRAME,this.§_-ba§);
      }
      
      public function §_-fE§(param1:Number) : void
      {
         this.progress.scaleX += param1;
         if(this.progress.scaleX > 0.5)
         {
            addEventListener(Event.ENTER_FRAME,this.§_-MO§);
         }
         if(this.progress.scaleX >= 1)
         {
            this.§_-Dq§();
         }
      }
      
      private function §_-Id§(param1:Event) : void
      {
         stage.addEventListener(Event.RESIZE,this.§_-7B§);
         this.§_-7B§();
      }
      
      private function §_-99§(param1:Event) : void
      {
         stage.removeEventListener(Event.RESIZE,this.§_-7B§);
      }
      
      private function §_-ba§(param1:Event) : void
      {
         this.area.alpha -= this.§_-UB§;
         this.§_-1q§.alpha -= this.§_-UB§;
         this.progress.alpha -= this.§_-UB§;
         if(this.area.alpha <= 0)
         {
            removeEventListener(Event.ENTER_FRAME,this.§_-ba§);
            if(parent != null)
            {
               parent.removeChild(this);
               dispatchEvent(new Event(Event.COMPLETE));
            }
         }
      }
      
      private function §_-MO§(param1:Event) : void
      {
         this.§_-Za§.alpha -= this.§_-UB§ * 1.5;
         if(this.§_-Za§.alpha <= 0)
         {
            removeEventListener(Event.ENTER_FRAME,this.§_-MO§);
         }
      }
      
      private function §_-7B§(param1:Event = null) : void
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

