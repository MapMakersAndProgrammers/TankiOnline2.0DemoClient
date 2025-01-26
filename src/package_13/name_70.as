package package_13
{
   public class name_70
   {
      private var groups:Object;
      
      public function name_70()
      {
         super();
         this.groups = new Object();
      }
      
      public function get method_215() : Vector.<String>
      {
         var _loc2_:String = null;
         var _loc1_:Vector.<String> = new Vector.<String>();
         for(_loc2_ in this.groups)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function name_62(param1:String) : name_58
      {
         return this.groups[param1];
      }
      
      public function method_214(param1:String, param2:name_58) : void
      {
         this.groups[param1] = param2;
      }
   }
}

