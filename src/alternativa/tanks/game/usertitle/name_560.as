package alternativa.tanks.game.usertitle
{
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class name_560
   {
      private static var canvas:Shape = new Shape();
      
      private static var matrix:Matrix = new Matrix();
      
      private var maxValue:int;
      
      private var barWidth:int;
      
      private var skin:name_559;
      
      private var var_705:int;
      
      private var var_706:int;
      
      private var var_707:int;
      
      private var x:int;
      
      private var y:int;
      
      private var rect:Rectangle;
      
      public function name_560(x:int, y:int, maxValue:int, barWidth:int, skin:name_559)
      {
         super();
         this.x = x;
         this.y = y;
         this.maxValue = maxValue;
         this.barWidth = barWidth;
         this.name_564(skin);
         this.rect = new Rectangle(x,y,barWidth,this.var_706);
      }
      
      public function name_564(skin:name_559) : void
      {
         this.skin = skin;
         this.var_705 = skin.var_701.width;
         this.var_706 = skin.var_701.height;
      }
      
      public function get progress() : int
      {
         return this.var_707;
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
         this.var_707 = value;
      }
      
      public function draw(texture:BitmapData) : void
      {
         var bgStart:int = 0;
         var g:Graphics = canvas.graphics;
         g.clear();
         matrix.ty = 0;
         var displayWidth:int = this.barWidth * this.var_707 / this.maxValue;
         var w:int = this.barWidth - this.var_705;
         if(displayWidth >= this.var_705)
         {
            if(displayWidth == this.barWidth)
            {
               this.method_365(g,this.skin.var_699,this.skin.var_702,this.skin.var_703);
               bgStart = displayWidth;
            }
            else
            {
               g.beginBitmapFill(this.skin.var_699,null,false);
               g.drawRect(0,0,this.var_705,this.var_706);
               if(displayWidth > this.var_705)
               {
                  if(displayWidth > w)
                  {
                     displayWidth = w;
                  }
                  bgStart = displayWidth;
                  this.method_366(g,this.skin.var_703,this.var_705,displayWidth - this.var_705);
               }
               else
               {
                  bgStart = this.var_705;
               }
            }
         }
         if(bgStart == 0)
         {
            this.method_365(g,this.skin.var_701,this.skin.var_700,this.skin.var_704);
         }
         else if(bgStart < this.barWidth)
         {
            this.method_366(g,this.skin.var_704,bgStart,w - bgStart);
            matrix.tx = w;
            g.beginBitmapFill(this.skin.var_700,matrix,false);
            g.drawRect(w,0,this.var_705,this.var_706);
         }
         g.endFill();
         texture.fillRect(this.rect,0);
         matrix.tx = this.x;
         matrix.ty = this.y;
         texture.draw(canvas,matrix);
      }
      
      private function method_365(g:Graphics, leftTip:BitmapData, rightTip:BitmapData, center:BitmapData) : void
      {
         var w:int = this.barWidth - this.var_705;
         g.beginBitmapFill(leftTip,null,false);
         g.drawRect(0,0,this.var_705,this.var_706);
         matrix.tx = this.var_705;
         g.beginBitmapFill(center,matrix,true);
         g.drawRect(this.var_705,0,w - this.var_705,this.var_706);
         matrix.tx = w;
         g.beginBitmapFill(rightTip,matrix,false);
         g.drawRect(w,0,this.var_705,this.var_706);
      }
      
      private function method_366(g:Graphics, center:BitmapData, x:int, width:int) : void
      {
         matrix.tx = x;
         g.beginBitmapFill(center,matrix,true);
         g.drawRect(x,0,width,this.var_706);
      }
   }
}

