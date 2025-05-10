package alternativa.tanks.game.usertitle
{
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class ProgressBar
   {
      private static var canvas:Shape = new Shape();
      
      private static var matrix:Matrix = new Matrix();
      
      private var maxValue:int;
      
      private var barWidth:int;
      
      private var skin:ProgressBarSkin;
      
      private var §_-oy§:int;
      
      private var §_-Da§:int;
      
      private var §_-H2§:int;
      
      private var x:int;
      
      private var y:int;
      
      private var rect:Rectangle;
      
      public function ProgressBar(x:int, y:int, maxValue:int, barWidth:int, skin:ProgressBarSkin)
      {
         super();
         this.x = x;
         this.y = y;
         this.maxValue = maxValue;
         this.barWidth = barWidth;
         this.setSkin(skin);
         this.rect = new Rectangle(x,y,barWidth,this.§_-Da§);
      }
      
      public function setSkin(skin:ProgressBarSkin) : void
      {
         this.skin = skin;
         this.§_-oy§ = skin.§_-XU§.width;
         this.§_-Da§ = skin.§_-XU§.height;
      }
      
      public function get progress() : int
      {
         return this.§_-H2§;
      }
      
      public function set progress(value:int) : void
      {
         if(value < 0)
         {
            value = 0;
         }
         else if(value > this.maxValue)
         {
            value = this.maxValue;
         }
         this.§_-H2§ = value;
      }
      
      public function draw(texture:BitmapData) : void
      {
         var bgStart:int = 0;
         var g:Graphics = canvas.graphics;
         g.clear();
         matrix.ty = 0;
         var displayWidth:int = this.barWidth * this.§_-H2§ / this.maxValue;
         var w:int = this.barWidth - this.§_-oy§;
         if(displayWidth >= this.§_-oy§)
         {
            if(displayWidth == this.barWidth)
            {
               this.drawFullBar(g,this.skin.§_-9Y§,this.skin.§_-j2§,this.skin.§_-oU§);
               bgStart = displayWidth;
            }
            else
            {
               g.beginBitmapFill(this.skin.§_-9Y§,null,false);
               g.drawRect(0,0,this.§_-oy§,this.§_-Da§);
               if(displayWidth > this.§_-oy§)
               {
                  if(displayWidth > w)
                  {
                     displayWidth = w;
                  }
                  bgStart = displayWidth;
                  this.drawCenter(g,this.skin.§_-oU§,this.§_-oy§,displayWidth - this.§_-oy§);
               }
               else
               {
                  bgStart = this.§_-oy§;
               }
            }
         }
         if(bgStart == 0)
         {
            this.drawFullBar(g,this.skin.§_-XU§,this.skin.§_-GY§,this.skin.§_-py§);
         }
         else if(bgStart < this.barWidth)
         {
            this.drawCenter(g,this.skin.§_-py§,bgStart,w - bgStart);
            matrix.tx = w;
            g.beginBitmapFill(this.skin.§_-GY§,matrix,false);
            g.drawRect(w,0,this.§_-oy§,this.§_-Da§);
         }
         g.endFill();
         texture.fillRect(this.rect,0);
         matrix.tx = this.x;
         matrix.ty = this.y;
         texture.draw(canvas,matrix);
      }
      
      private function drawFullBar(g:Graphics, leftTip:BitmapData, rightTip:BitmapData, center:BitmapData) : void
      {
         var w:int = this.barWidth - this.§_-oy§;
         g.beginBitmapFill(leftTip,null,false);
         g.drawRect(0,0,this.§_-oy§,this.§_-Da§);
         matrix.tx = this.§_-oy§;
         g.beginBitmapFill(center,matrix,true);
         g.drawRect(this.§_-oy§,0,w - this.§_-oy§,this.§_-Da§);
         matrix.tx = w;
         g.beginBitmapFill(rightTip,matrix,false);
         g.drawRect(w,0,this.§_-oy§,this.§_-Da§);
      }
      
      private function drawCenter(g:Graphics, center:BitmapData, x:int, width:int) : void
      {
         matrix.tx = x;
         g.beginBitmapFill(center,matrix,true);
         g.drawRect(x,0,width,this.§_-Da§);
      }
   }
}

