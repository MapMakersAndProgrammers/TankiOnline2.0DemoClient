package alternativa.tanks.services.background
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.DisplayObjectContainer;
   import flash.display.PixelSnapping;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.BlurFilter;
   import flash.geom.Rectangle;
   
   public class BackgroundService implements IBackgroundService
   {
      
      private static const bitmapBg:Class = BackgroundService_bitmapBg;
      
      private static const bgBd:BitmapData = new bitmapBg().bitmapData;
      
      private var stage:Stage;
      
      private var bgLayer:DisplayObjectContainer;
      
      private var bg:Shape;
      
      private var battleOutlineThickness:int = 1;
      
      private var battleOutline:Shape;
      
      private var battleShadow:Shape;
      
      private var bgCropRect:Rectangle;
      
      private var noiseBitmap:Bitmap;
      
      private var bgVisible:Boolean;
      
      public function BackgroundService(stage:Stage)
      {
         super();
         this.stage = stage;
         this.bgLayer = new Sprite();
         this.bgLayer.mouseEnabled = false;
         this.bgLayer.tabEnabled = false;
         stage.addChildAt(this.bgLayer,0);
         this.bg = new Shape();
         this.battleOutline = new Shape();
         this.battleShadow = new Shape();
         this.battleShadow.filters = [new BlurFilter(10,10,BitmapFilterQuality.MEDIUM)];
         var noiseBitmapBd:BitmapData = new BitmapData(600,600,true,0);
         noiseBitmapBd.noise(666,100,255,7,true);
         this.noiseBitmap = new Bitmap(noiseBitmapBd,PixelSnapping.AUTO,true);
         this.noiseBitmap.alpha = 0.85;
         this.noiseBitmap.blendMode = BlendMode.MULTIPLY;
      }
      
      public function showBg() : void
      {
         this.bgVisible = true;
         if(!this.bgLayer.contains(this.bg))
         {
            this.bgLayer.addChild(this.bg);
            this.bgLayer.addChild(this.noiseBitmap);
            this.stage.addEventListener(Event.RESIZE,this.resizeBg);
            this.resizeBg();
         }
      }
      
      public function hideBg() : void
      {
         this.bgVisible = false;
         if(this.bgLayer.contains(this.bg))
         {
            this.stage.removeEventListener(Event.RESIZE,this.resizeBg);
            this.bgLayer.removeChild(this.bg);
            this.bgLayer.removeChild(this.noiseBitmap);
         }
      }
      
      public function setBgLayer(layer:DisplayObjectContainer) : void
      {
         if(this.bgVisible)
         {
            this.hideBg();
            this.bgLayer = layer;
            this.showBg();
         }
         else
         {
            this.bgLayer = layer;
         }
      }
      
      public function drawBattleBg(cropRect:Rectangle = null) : void
      {
      }
      
      private function resizeBg(e:Event = null) : void
      {
         this.redrawBg();
      }
      
      private function redrawBg(e:Event = null) : void
      {
         this.bg.graphics.clear();
         this.bg.graphics.beginBitmapFill(bgBd);
         this.bg.graphics.drawRect(0,0,this.stage.stageWidth,this.stage.stageHeight);
         this.noiseBitmap.width = this.stage.stageWidth;
         this.noiseBitmap.height = this.stage.stageHeight;
      }
   }
}

