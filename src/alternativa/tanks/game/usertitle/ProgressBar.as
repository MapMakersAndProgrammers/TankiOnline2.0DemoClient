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
      
      private var name_oy:int;
      
      private var name_Da:int;
      
      private var name_H2:int;
      
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
         this.rect = new Rectangle(x,y,barWidth,this.name_Da);
      }
      
      public function setSkin(skin:ProgressBarSkin) : void
      {
         this.skin = skin;
         this.name_oy = skin.name_XU.width;
         this.name_Da = skin.name_XU.height;
      }
      
      public function get progress() : int
      {
         return this.name_H2;
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
         this.name_H2 = value;
      }
      
      public function draw(texture:BitmapData) : void
      {
         var bgStart:int = 0;
         var g:Graphics = canvas.graphics;
         g.clear();
         matrix.ty = 0;
         var displayWidth:int = this.barWidth * this.name_H2 / this.maxValue;
         var w:int = this.barWidth - this.name_oy;
         if(displayWidth >= this.name_oy)
         {
            if(displayWidth == this.barWidth)
            {
               this.drawFullBar(g,this.skin.name_9Y,this.skin.name_j2,this.skin.name_oU);
               bgStart = displayWidth;
            }
            else
            {
               g.beginBitmapFill(this.skin.name_9Y,null,false);
               g.drawRect(0,0,this.name_oy,this.name_Da);
               if(displayWidth > this.name_oy)
               {
                  if(displayWidth > w)
                  {
                     displayWidth = w;
                  }
                  bgStart = displayWidth;
                  this.drawCenter(g,this.skin.name_oU,this.name_oy,displayWidth - this.name_oy);
               }
               else
               {
                  bgStart = this.name_oy;
               }
            }
         }
         if(bgStart == 0)
         {
            this.drawFullBar(g,this.skin.name_XU,this.skin.name_GY,this.skin.name_py);
         }
         else if(bgStart < this.barWidth)
         {
            this.drawCenter(g,this.skin.name_py,bgStart,w - bgStart);
            matrix.tx = w;
            g.beginBitmapFill(this.skin.name_GY,matrix,false);
            g.drawRect(w,0,this.name_oy,this.name_Da);
         }
         g.endFill();
         texture.fillRect(this.rect,0);
         matrix.tx = this.x;
         matrix.ty = this.y;
         texture.draw(canvas,matrix);
      }
      
      private function drawFullBar(g:Graphics, leftTip:BitmapData, rightTip:BitmapData, center:BitmapData) : void
      {
         var w:int = this.barWidth - this.name_oy;
         g.beginBitmapFill(leftTip,null,false);
         g.drawRect(0,0,this.name_oy,this.name_Da);
         matrix.tx = this.name_oy;
         g.beginBitmapFill(center,matrix,true);
         g.drawRect(this.name_oy,0,w - this.name_oy,this.name_Da);
         matrix.tx = w;
         g.beginBitmapFill(rightTip,matrix,false);
         g.drawRect(w,0,this.name_oy,this.name_Da);
      }
      
      private function drawCenter(g:Graphics, center:BitmapData, x:int, width:int) : void
      {
         matrix.tx = x;
         g.beginBitmapFill(center,matrix,true);
         g.drawRect(x,0,width,this.name_Da);
      }
   }
}

