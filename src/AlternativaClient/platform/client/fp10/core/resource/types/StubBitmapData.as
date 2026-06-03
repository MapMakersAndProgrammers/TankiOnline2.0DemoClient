package platform.client.fp10.core.resource.types
{
   import flash.display.BitmapData;
   
   public class StubBitmapData extends BitmapData
   {
      
      public function StubBitmapData(param1:uint, param2:uint = 20, param3:uint = 20)
      {
         var _loc5_:int = 0;
         super(param2,param3,false,0);
         var _loc4_:int = 0;
         while(_loc4_ < param2)
         {
            _loc5_ = 0;
            while(_loc5_ < param3)
            {
               setPixel(Boolean(_loc4_ % 2) ? _loc5_ : int(_loc5_ + 1),_loc4_,param1);
               _loc5_ += 2;
            }
            _loc4_++;
         }
      }
   }
}

