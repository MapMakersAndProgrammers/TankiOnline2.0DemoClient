package package_33
{
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public final class name_155
   {
      private static var longMap:Dictionary = new Dictionary();
      
      private var var_188:int;
      
      private var var_187:int;
      
      public function name_155(high:int, low:int)
      {
         super();
         this.var_187 = high;
         this.var_188 = low;
      }
      
      public static function method_298(high:int, low:int) : name_155
      {
         var value:name_155 = null;
         var highToLong:Dictionary = longMap[low];
         if(highToLong != null)
         {
            value = highToLong[high];
            if(value == null)
            {
               value = new name_155(high,low);
               highToLong[high] = value;
            }
         }
         else
         {
            longMap[low] = new Dictionary();
            value = new name_155(high,low);
            longMap[low][high] = value;
         }
         return value;
      }
      
      public static function method_301(s:String) : name_155
      {
         var len:int = int(s.length);
         if(len <= 8)
         {
            return method_298(0,int("0x" + s));
         }
         return method_298(int("0x" + s.substr(0,len - 8)),int("0x" + s.substr(len - 8)));
      }
      
      public static function method_300(value:int) : name_155
      {
         if(value < 0)
         {
            return method_298(4294967295,value);
         }
         return method_298(0,value);
      }
      
      public function get low() : int
      {
         return this.var_188;
      }
      
      public function get high() : int
      {
         return this.var_187;
      }
      
      public function toString() : String
      {
         return this.method_299(this.var_187) + this.method_299(this.var_188);
      }
      
      public function method_302(result:ByteArray = null) : ByteArray
      {
         if(result == null)
         {
            result = new ByteArray();
         }
         result.position = 0;
         result.writeInt(this.var_187);
         result.writeInt(this.var_188);
         result.position = 0;
         return result;
      }
      
      private function method_299(value:int) : String
      {
         var result:String = null;
         var numZeros:int = 0;
         if(value >= 0)
         {
            result = value.toString(16);
            for(numZeros = 8 - result.length; numZeros > 0; )
            {
               result = "0" + result;
               numZeros--;
            }
         }
         else
         {
            result = uint(value).toString(16);
         }
         return result;
      }
   }
}

