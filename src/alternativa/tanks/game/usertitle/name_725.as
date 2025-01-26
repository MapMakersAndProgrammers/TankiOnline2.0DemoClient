package alternativa.tanks.game.usertitle
{
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class name_725
   {
      private static var canvas:Shape = new Shape();
      
      private static var matrix:Matrix = new Matrix();
      
      private var maxValue:int;
      
      private var barWidth:int;
      
      private var skin:name_724;
      
      private var var_706:int;
      
      private var var_707:int;
      
      private var var_708:int;
      
      private var x:int;
      
      private var y:int;
      
      private var rect:Rectangle;
      
      public function name_725(x:int, y:int, maxValue:int, barWidth:int, skin:name_724)
      {
         super();
         this.x = x;
         this.y = y;
         this.maxValue = maxValue;
         this.barWidth = barWidth;
         this.name_727(skin);
         this.rect = new Rectangle(x,y,barWidth,this.var_707);
      }
      
      public function name_727(skin:name_724) : void
      {
         this.skin = skin;
         this.var_706 = skin.var_704.width;
         this.var_707 = skin.var_704.height;
      }
      
      public function get progress() : int
      {
         return this.var_708;
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
         this.var_708 = value;
      }
      
      public function draw(texture:BitmapData) : void
      {
         var bgStart:int = 0;
         var g:Graphics = canvas.graphics;
         g.clear();
         matrix.ty = 0;
         var displayWidth:int = this.barWidth * this.var_708 / this.maxValue;
         var w:int = this.barWidth - this.var_706;
         if(displayWidth >= this.var_706)
         {
            if(displayWidth == this.barWidth)
            {
               this.method_883(g,this.skin.var_703,this.skin.var_705,this.skin.var_702);
               bgStart = displayWidth;
            }
            else
            {
               g.beginBitmapFill(this.skin.var_703,null,false);
               g.drawRect(0,0,this.var_706,this.var_707);
               if(displayWidth > this.var_706)
               {
                  if(displayWidth > w)
                  {
                     displayWidth = w;
                  }
                  bgStart = displayWidth;
                  this.method_882(g,this.skin.var_702,this.var_706,displayWidth - this.var_706);
               }
               else
               {
                  bgStart = this.var_706;
               }
            }
         }
         if(bgStart == 0)
         {
            this.method_883(g,this.skin.var_704,this.skin.var_701,this.skin.var_700);
         }
         else if(bgStart < this.barWidth)
         {
            this.method_882(g,this.skin.var_700,bgStart,w - bgStart);
            matrix.tx = w;
            g.beginBitmapFill(this.skin.var_701,matrix,false);
            g.drawRect(w,0,this.var_706,this.var_707);
         }
         g.endFill();
         texture.fillRect(this.rect,0);
         matrix.tx = this.x;
         matrix.ty = this.y;
         texture.draw(canvas,matrix);
      }
      
      private function method_883(g:Graphics, leftTip:BitmapData, rightTip:BitmapData, center:BitmapData) : void
      {
         var w:int = this.barWidth - this.var_706;
         g.beginBitmapFill(leftTip,null,false);
         g.drawRect(0,0,this.var_706,this.var_707);
         matrix.tx = this.var_706;
         g.beginBitmapFill(center,matrix,true);
         g.drawRect(this.var_706,0,w - this.var_706,this.var_707);
         matrix.tx = w;
         g.beginBitmapFill(rightTip,matrix,false);
         g.drawRect(w,0,this.var_706,this.var_707);
      }
      
      private function method_882(g:Graphics, center:BitmapData, x:int, width:int) : void
      {
         matrix.tx = x;
         g.beginBitmapFill(center,matrix,true);
         g.drawRect(x,0,width,this.var_707);
      }
   }
}

