package alternativa.tanks.utils
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class TextureUtils
   {
      public function TextureUtils()
      {
         super();
      }
      
      public static function parseImageStrip(param1:BitmapData, param2:int = 0) : Vector.<BitmapData>
      {
         var _loc8_:BitmapData = null;
         if(param2 == 0)
         {
            param2 = int(param1.height);
         }
         var _loc3_:int = param1.width / param2;
         var _loc4_:Vector.<BitmapData> = new Vector.<BitmapData>(_loc3_);
         var _loc5_:Point = new Point();
         var _loc6_:Rectangle = new Rectangle(0,0,param2,param1.height);
         var _loc7_:int = 0;
         while(_loc7_ < _loc3_)
         {
            _loc8_ = new BitmapData(param2,param1.height,param1.transparent,0);
            _loc4_[_loc7_] = _loc8_;
            _loc6_.x = _loc7_ * param2;
            _loc8_.copyPixels(param1,_loc6_,_loc5_);
            _loc7_++;
         }
         return _loc4_;
      }
   }
}

