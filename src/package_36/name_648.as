package package_36
{
   import flash.utils.ByteArray;
   
   public class name_648
   {
      private var var_671:int;
      
      private var size:int;
      
      private var map:ByteArray;
      
      public function name_648(size:int = 0, source:ByteArray = null)
      {
         super();
         this.map = new ByteArray();
         if(source != null)
         {
            this.map.writeBytes(source,0,this.method_814(size));
         }
         this.size = size;
         this.var_671 = 0;
      }
      
      public function method_816() : int
      {
         return this.var_671;
      }
      
      public function name_702(value:int) : void
      {
         this.var_671 = value;
      }
      
      public function reset() : void
      {
         this.var_671 = 0;
      }
      
      public function clear() : void
      {
         this.size = 0;
         this.var_671 = 0;
      }
      
      public function name_444(isNull:Boolean) : void
      {
         this.name_480(this.size,isNull);
         ++this.size;
      }
      
      public function method_815() : Boolean
      {
         return this.var_671 < this.size;
      }
      
      public function name_447() : Boolean
      {
         if(this.var_671 >= this.size)
         {
            throw new Error("Index out of bounds: " + this.var_671);
         }
         var res:Boolean = this.name_478(this.var_671);
         ++this.var_671;
         return res;
      }
      
      public function name_649() : ByteArray
      {
         return this.map;
      }
      
      public function name_650() : int
      {
         return this.size;
      }
      
      private function name_478(position:int) : Boolean
      {
         var targetByte:int = position >> 3;
         var targetBit:int = 7 ^ position & 7;
         this.map.position = targetByte;
         return (this.map.readByte() & 1 << targetBit) != 0;
      }
      
      private function name_480(position:int, value:Boolean) : void
      {
         var targetByte:int = position >> 3;
         var targetBit:int = 7 ^ position & 7;
         this.map.position = targetByte;
         if(value)
         {
            this.map.writeByte(int(this.map[targetByte] | 1 << targetBit));
         }
         else
         {
            this.map.writeByte(int(this.map[targetByte] & (0xFF ^ 1 << targetBit)));
         }
      }
      
      private function method_814(sizeInBits:int) : int
      {
         var i:int = sizeInBits >> 3;
         var add:int = (sizeInBits & 7) == 0 ? 0 : 1;
         return i + add;
      }
      
      public function toString() : String
      {
         var result:String = "readPosition: " + this.var_671 + " size:" + this.name_650() + " mask:";
         var _readPosition:int = this.var_671;
         for(var i:int = this.var_671; i < this.name_650(); i++)
         {
            result += this.name_447() ? "1" : "0";
         }
         this.var_671 = _readPosition;
         return result;
      }
      
      public function clone() : name_648
      {
         var map:name_648 = new name_648(this.size,this.map);
         map.var_671 = this.var_671;
         return map;
      }
   }
}

