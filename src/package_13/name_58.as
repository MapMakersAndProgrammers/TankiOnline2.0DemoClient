package package_13
{
   import flash.utils.ByteArray;
   
   public class name_58
   {
      private var blobs:Object;
      
      public function name_58()
      {
         super();
         this.blobs = new Object();
      }
      
      public function get method_219() : Vector.<String>
      {
         var _loc2_:String = null;
         var _loc1_:Vector.<String> = new Vector.<String>();
         for(_loc2_ in this.blobs)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function name_65(param1:String) : ByteArray
      {
         return this.blobs[param1];
      }
      
      public function method_218(param1:String, param2:ByteArray) : void
      {
         this.blobs[param1] = param2;
      }
   }
}

