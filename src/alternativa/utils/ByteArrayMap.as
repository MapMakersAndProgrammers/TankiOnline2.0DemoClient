package alternativa.utils
{
   import flash.utils.ByteArray;
   
   public class ByteArrayMap
   {
      private var var_102:Object;
      
      public function ByteArrayMap(data:Object = null)
      {
         super();
         this.var_102 = data == null ? {} : data;
      }
      
      public function get data() : Object
      {
         return this.var_102;
      }
      
      public function getValue(key:String) : ByteArray
      {
         return this.var_102[key];
      }
      
      public function putValue(key:String, value:ByteArray) : void
      {
         this.var_102[key] = value;
      }
   }
}

