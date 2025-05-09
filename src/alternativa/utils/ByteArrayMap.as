package alternativa.utils
{
   import flash.utils.ByteArray;
   
   public class ByteArrayMap
   {
      private var §_-Bp§:Object;
      
      public function ByteArrayMap(data:Object = null)
      {
         super();
         this.§_-Bp§ = data == null ? {} : data;
      }
      
      public function get data() : Object
      {
         return this.§_-Bp§;
      }
      
      public function getValue(key:String) : ByteArray
      {
         return this.§_-Bp§[key];
      }
      
      public function putValue(key:String, value:ByteArray) : void
      {
         this.§_-Bp§[key] = value;
      }
   }
}

