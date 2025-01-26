package
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.display3D.Context3D;
   import flash.events.Event;
   import package_28.name_129;
   import package_28.name_167;
   import package_28.name_93;
   
   public class Preloader extends Sprite
   {
      private static const EmbedPreloader:Class = name_166;
      
      private static const EmbedPreloaderA:Class = name_165;
      
      private static const EmbedProgress:Class = name_164;
      
      private var area:Shape = new Shape();
      
      private var var_27:Bitmap = new EmbedPreloader();
      
      private var var_28:Bitmap = new EmbedPreloaderA();
      
      private var progress:Bitmap = new EmbedProgress();
      
      private var context:Context3D;
      
      public var maps:Vector.<name_167>;
      
      private var var_31:int;
      
      private var counter:int;
      
      private var baseURL:String;
      
      private var var_30:name_129 = new name_93(new BitmapData(1,1,false,8355711));
      
      private var var_29:Number = 0.09803921568627451;
      
      public function Preloader()
      {
         super();
         addChild(this.area);
         this.area.alpha = 1;
         this.progress.alpha = 1;
         this.var_27.alpha = 1;
         addChild(this.var_27);
         addChild(this.var_28);
         addChild(this.progress);
         addEventListener(Event.ADDED_TO_STAGE,this.method_80);
         addEventListener(Event.REMOVED_FROM_STAGE,this.method_81);
         this.progress.scaleX = 0.025;
      }
      
      public function name_69(param1:Number) : void
      {
         this.progress.scaleX = param1;
         if(this.progress.scaleX >= 1)
         {
            this.method_78();
         }
      }
      
      private function method_78() : void
      {
         addEventListener(Event.ENTER_FRAME,this.method_12);
      }
      
      public function method_82(param1:Number) : void
      {
         this.progress.scaleX += param1;
         if(this.progress.scaleX > 0.5)
         {
            addEventListener(Event.ENTER_FRAME,this.method_79);
         }
         if(this.progress.scaleX >= 1)
         {
            this.method_78();
         }
      }
      
      private function method_80(param1:Event) : void
      {
         stage.addEventListener(Event.RESIZE,this.method_4);
         this.method_4();
      }
      
      private function method_81(param1:Event) : void
      {
         stage.removeEventListener(Event.RESIZE,this.method_4);
      }
      
      private function method_12(param1:Event) : void
      {
         this.area.alpha -= this.var_29;
         this.var_27.alpha -= this.var_29;
         this.progress.alpha -= this.var_29;
         if(this.area.alpha <= 0)
         {
            removeEventListener(Event.ENTER_FRAME,this.method_12);
            if(parent != null)
            {
               parent.removeChild(this);
               dispatchEvent(new Event(Event.COMPLETE));
            }
         }
      }
      
      private function method_79(param1:Event) : void
      {
         this.var_28.alpha -= this.var_29 * 1.5;
         if(this.var_28.alpha <= 0)
         {
            removeEventListener(Event.ENTER_FRAME,this.method_79);
         }
      }
      
      private function method_4(param1:Event = null) : void
      {
         this.area.graphics.clear();
         this.var_27.x = Math.round(stage.stageWidth / 2 - this.var_27.width / 2);
         this.var_27.y = Math.round(stage.stageHeight / 2 - this.var_27.height / 2) - 30;
         this.var_28.x = this.var_27.x;
         this.var_28.y = this.var_27.y;
         this.progress.x = this.var_27.x + 2;
         this.progress.y = this.var_27.y + 221;
         this.area.graphics.beginFill(0);
         this.area.graphics.drawRect(0,0,this.var_27.x,stage.stageHeight);
         this.area.graphics.drawRect(this.var_27.x,0,this.var_27.width,this.var_27.y);
         this.area.graphics.drawRect(this.var_27.x + this.var_27.width,0,stage.stageWidth - this.var_27.width - this.var_27.x,stage.stageHeight);
         this.area.graphics.drawRect(this.var_27.x,this.var_27.y + this.var_27.height,this.var_27.width,stage.stageHeight - this.var_27.height - this.var_27.y);
      }
   }
}

