package platform.client.fp10.core.registry.impl
{
   import alternativa.osgi.service.display.IDisplay;
   import platform.client.fp10.core.service.loadingprogress.ILoadingProgressListener;
   
   public class DebugProgressIndicator implements ILoadingProgressListener
   {
      
      [Inject]
      public static var display:IDisplay;
      
      private var progressBar:ProgressBar = new ProgressBar();
      
      public function DebugProgressIndicator()
      {
         super();
      }
      
      public function onLoadingStart() : void
      {
         this.progressBar.setProgress(0,1);
         display.stage.addChild(this.progressBar);
         this.alignIndicator();
      }
      
      public function onLoadingStop() : void
      {
         if(this.progressBar.parent != null)
         {
            this.progressBar.parent.removeChild(this.progressBar);
         }
      }
      
      public function onLoadingProgress(param1:int, param2:int) : void
      {
         display.stage.addChild(this.progressBar);
         this.progressBar.setProgress(param1,param2);
         this.alignIndicator();
      }
      
      private function alignIndicator() : void
      {
         this.progressBar.x = display.stage.stageWidth - this.progressBar.width >> 1;
      }
   }
}

import flash.display.BlendMode;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Graphics;
import flash.display.InteractiveObject;
import flash.display.Sprite;
import flash.events.EventDispatcher;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

class ProgressBar extends Sprite
{
   
   private static const WIDTH:int = 200;
   
   private static const HEIGHT:int = 30;
   
   private static const BAR_MARGIN:int = 3;
   
   private static const BGCOLOR:uint = 3355443;
   
   private static const FGCOLOR:uint = 16777215;
   
   private var textField:TextField;
   
   public function ProgressBar()
   {
      super();
      this.textField = new TextField();
      this.textField.defaultTextFormat = new TextFormat("Tahoma",12,16777215);
      this.textField.autoSize = TextFieldAutoSize.LEFT;
      this.textField.x = 10;
      this.textField.y = 5;
      this.textField.blendMode = BlendMode.INVERT;
      addChild(this.textField);
   }
   
   public function setProgress(param1:int, param2:int) : void
   {
      this.textField.text = param1 + "/" + param2;
      var _loc3_:int = (WIDTH - 2 * BAR_MARGIN) * param1 / param2;
      var _loc4_:Graphics = graphics;
      _loc4_.clear();
      _loc4_.lineStyle(1,FGCOLOR);
      _loc4_.beginFill(BGCOLOR);
      _loc4_.drawRect(0,0,WIDTH - 1,HEIGHT - 1);
      _loc4_.lineStyle();
      _loc4_.beginFill(FGCOLOR);
      _loc4_.drawRect(BAR_MARGIN,BAR_MARGIN,_loc3_,HEIGHT - BAR_MARGIN - BAR_MARGIN);
      _loc4_.endFill();
   }
}
