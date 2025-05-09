package alternativa.protocol
{
   import flash.utils.ByteArray;
   
   public class OptionalMap
   {
      private var var_671:int;
      
      private var size:int;
      
      private var map:ByteArray;
      
      public function OptionalMap(size:int = 0, source:ByteArray = null)
      {
         super();
         this.map = new ByteArray();
         if(source != null)
         {
            this.map.writeBytes(source,0,this.convertSize(size));
         }
         this.size = size;
         this.var_671 = 0;
      }
      
      public function getReadPosition() : int
      {
         return this.var_671;
      }
      
      public function setReadPosition(value:int) : void
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
      
      public function addBit(isNull:Boolean) : void
      {
         this.setBit(this.size,isNull);
         ++this.size;
      }
      
      public function hasNextBit() : Boolean
      {
         return this.var_671 < this.size;
      }
      
      public function OptionalMap() : Boolean
      {
         if(this.var_671 >= this.size)
         {
            throw new Error("Index out of bounds: " + this.var_671);
         }
         var res:Boolean = this.getBit(this.var_671);
         ++this.var_671;
         return res;
      }
      
      public function getMap() : ByteArray
      {
         return this.map;
      }
      
      public function getSize() : int
      {
         return this.size;
      }
      
      private function getBit(position:int) : Boolean
      {
         var targetByte:int = position >> 3;
         var targetBit:int = 7 ^ position & 7;
         this.map.position = targetByte;
         return (this.map.readByte() & 1 << targetBit) != 0;
      }
      
      private function setBit(position:int, value:Boolean) : void
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
      
      private function convertSize(sizeInBits:int) : int
      {
         var i:int = sizeInBits >> 3;
         var add:int = (sizeInBits & 7) == 0 ? 0 : 1;
         return i + add;
      }
      
      public function toString() : String
      {
         var result:String = "readPosition: " + this.var_671 + " size:" + this.getSize() + " mask:";
         var _readPosition:int = this.var_671;
         for(var i:int = this.var_671; i < this.getSize(); i++)
         {
            result += this.OptionalMap() ? "1" : "0";
         }
         this.var_671 = _readPosition;
         return result;
      }
      
      public function clone() : alternativa.protocol.OptionalMap
      {
         var map:alternativa.protocol.OptionalMap = new alternativa.protocol.OptionalMap(this.size,this.map);
         map.var_671 = this.var_671;
         return map;
      }
   }
}

