package alternativa.tanks.game.usertitle
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class §_-ml§
   {
      public var left:BitmapData;
      
      public var right:BitmapData;
      
      public var center:BitmapData;
      
      public function §_-ml§(bar:BitmapData, tipWidth:int)
      {
         super();
         var h:int = int(bar.height);
         var point:Point = new Point();
         this.left = new BitmapData(tipWidth,h,true,0);
         this.left.copyPixels(bar,new Rectangle(0,0,tipWidth,h),point);
         this.right = new BitmapData(tipWidth,h,true,0);
         this.right.copyPixels(bar,new Rectangle(bar.width - tipWidth,0,tipWidth,h),point);
         this.center = new BitmapData(1,h,true,0);
         this.center.copyPixels(bar,new Rectangle(tipWidth,0,1,h),point);
      }
   }
}

