package alternativa.types
{
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public final class Long
   {
      private static var longMap:Dictionary = new Dictionary();
      
      private var name_Ec:int;
      
      private var name_Ti:int;
      
      public function Long(high:int, low:int)
      {
         super();
         this.name_Ti = high;
         this.name_Ec = low;
      }
      
      public static function getLong(high:int, low:int) : Long
      {
         var value:Long = null;
         var highToLong:Dictionary = longMap[low];
         if(highToLong != null)
         {
            value = highToLong[high];
            if(value == null)
            {
               value = new Long(high,low);
               highToLong[high] = value;
            }
         }
         else
         {
            longMap[low] = new Dictionary();
            value = new Long(high,low);
            longMap[low][high] = value;
         }
         return value;
      }
      
      public static function fromHexString(s:String) : Long
      {
         var len:int = int(s.length);
         if(len <= 8)
         {
            return getLong(0,int("0x" + s));
         }
         return getLong(int("0x" + s.substr(0,len - 8)),int("0x" + s.substr(len - 8)));
      }
      
      public static function fromInt(value:int) : Long
      {
         if(value < 0)
         {
            return getLong(4294967295,value);
         }
         return getLong(0,value);
      }
      
      public function get low() : int
      {
         return this.name_Ec;
      }
      
      public function get high() : int
      {
         return this.name_Ti;
      }
      
      public function toString() : String
      {
         return this.intToUhex(this.name_Ti) + this.intToUhex(this.name_Ec);
      }
      
      public function toByteArray(result:ByteArray = null) : ByteArray
      {
         if(result == null)
         {
            result = new ByteArray();
         }
         result.position = 0;
         result.writeInt(this.name_Ti);
         result.writeInt(this.name_Ec);
         result.position = 0;
         return result;
      }
      
      private function intToUhex(value:int) : String
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

