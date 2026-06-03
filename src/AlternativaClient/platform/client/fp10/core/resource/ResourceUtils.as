package platform.client.fp10.core.resource
{
   import flash.display.BitmapData;
   import flash.display.BitmapDataChannel;
   import flash.display.BlendMode;
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   public class ResourceUtils
   {
      
      public function ResourceUtils()
      {
         super();
      }
      
      public static function mergeBitmapAlpha(param1:BitmapData, param2:BitmapData, param3:Boolean = false) : BitmapData
      {
         var _loc6_:BitmapData = null;
         var _loc4_:BitmapData = new BitmapData(param1.width,param1.height);
         var _loc5_:Point = new Point();
         _loc4_.copyPixels(param1,param1.rect,_loc5_);
         if(param1.width != param2.width || param1.height != param2.height)
         {
            _loc6_ = param2;
            param2 = new BitmapData(param1.width,param1.height);
            param2.draw(_loc6_,new Matrix(param1.width / _loc6_.width,0,0,param1.height / _loc6_.height),null,BlendMode.NORMAL,null,true);
         }
         _loc4_.copyChannel(param2,param2.rect,_loc5_,BitmapDataChannel.RED,BitmapDataChannel.ALPHA);
         if(_loc6_ != null)
         {
            param2.dispose();
            param2 = _loc6_;
         }
         if(param3)
         {
            param1.dispose();
            param2.dispose();
         }
         return _loc4_;
      }
   }
}

