package package_15
{
   import flash.utils.ByteArray;
   
   public class name_55
   {
      private var var_102:Object;
      
      public function name_55(data:Object = null)
      {
         super();
         this.var_102 = data == null ? {} : data;
      }
      
      public function get data() : Object
      {
         return this.var_102;
      }
      
      public function name_248(key:String) : ByteArray
      {
         return this.var_102[key];
      }
      
      public function name_59(key:String, value:ByteArray) : void
      {
         this.var_102[key] = value;
      }
   }
}

