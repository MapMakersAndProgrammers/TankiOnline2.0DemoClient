package alternativa.utils
{
   import flash.utils.ByteArray;
   
   public class ByteArrayMap
   {
      private var name_Bp:Object;
      
      public function ByteArrayMap(data:Object = null)
      {
         super();
         this.name_Bp = data == null ? {} : data;
      }
      
      public function get data() : Object
      {
         return this.name_Bp;
      }
      
      public function getValue(key:String) : ByteArray
      {
         return this.name_Bp[key];
      }
      
      public function putValue(key:String, value:ByteArray) : void
      {
         this.name_Bp[key] = value;
      }
   }
}

