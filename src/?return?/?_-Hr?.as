package §return§
{
   import flash.utils.ByteArray;
   
   public class §_-Hr§
   {
      private var §_-Bp§:Object;
      
      public function §_-Hr§(param1:ByteArray)
      {
         super();
         if(param1 != null)
         {
            this.§_-Om§(param1);
         }
      }
      
      public function §_-Om§(param1:ByteArray) : void
      {
         var _loc4_:int = 0;
         var _loc5_:ByteArray = null;
         var _loc6_:FileInfo = null;
         var _loc2_:int = int(param1.readInt());
         var _loc3_:Vector.<FileInfo> = new Vector.<FileInfo>(_loc2_);
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_[_loc4_] = new FileInfo(param1.readUTF(),param1.readInt());
            _loc4_++;
         }
         this.§_-Bp§ = {};
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc5_ = new ByteArray();
            _loc6_ = _loc3_[_loc4_];
            param1.readBytes(_loc5_,0,_loc6_.size);
            this.§_-Bp§[_loc6_.name] = _loc5_;
            _loc4_++;
         }
      }
      
      public function get data() : Object
      {
         return this.§_-Bp§;
      }
      
      public function §_-lv§(param1:String) : ByteArray
      {
         if(this.§_-Bp§ == null)
         {
            return null;
         }
         return ByteArray(this.§_-Bp§[param1]);
      }
   }
}

class FileInfo
{
   public var name:String;
   
   public var size:int;
   
   public function FileInfo(param1:String, param2:int)
   {
      super();
      this.name = param1;
      this.size = param2;
   }
}
