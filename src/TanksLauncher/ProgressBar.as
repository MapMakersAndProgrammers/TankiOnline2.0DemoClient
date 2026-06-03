package
{
   import flash.display.BlendMode;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class ProgressBar extends Sprite
   {
      
      private static const WIDTH:int = 300;
      
      private static const HEIGHT:int = 30;
      
      private static const BAR_MARGIN:int = 3;
      
      private static const BGCOLOR:uint = 3355443;
      
      private static const FGCOLOR:uint = 16777215;
      
      public var text:String;
      
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
         this.setProgress(0,1);
      }
      
      public function setProgress(value:int, maxValue:int) : void
      {
         var textProgress:String = value + "/" + maxValue;
         if(Boolean(this.text))
         {
            this.textField.text = this.text + textProgress;
         }
         else
         {
            this.textField.text = textProgress;
         }
         var barWidth:int = (WIDTH - 2 * BAR_MARGIN) * value / maxValue;
         var g:Graphics = graphics;
         g.lineStyle(1,FGCOLOR);
         g.beginFill(BGCOLOR);
         g.drawRect(0,0,WIDTH - 1,HEIGHT - 1);
         g.lineStyle();
         g.beginFill(FGCOLOR);
         g.drawRect(BAR_MARGIN,BAR_MARGIN,barWidth,HEIGHT - BAR_MARGIN - BAR_MARGIN);
         g.endFill();
      }
      
      public function align() : void
      {
         x = stage.stageWidth - width >> 1;
      }
   }
}

