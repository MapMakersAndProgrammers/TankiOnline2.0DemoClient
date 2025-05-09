package alternativa.protocol
{
   import flash.utils.ByteArray;
   
   public class OptionalMap
   {
      private var §_-bU§:int;
      
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
         this.§_-bU§ = 0;
      }
      
      public function getReadPosition() : int
      {
         return this.§_-bU§;
      }
      
      public function setReadPosition(value:int) : void
      {
         this.§_-bU§ = value;
      }
      
      public function reset() : void
      {
         this.§_-bU§ = 0;
      }
      
      public function clear() : void
      {
         this.size = 0;
         this.§_-bU§ = 0;
      }
      
      public function addBit(isNull:Boolean) : void
      {
         this.setBit(this.size,isNull);
         ++this.size;
      }
      
      public function hasNextBit() : Boolean
      {
         return this.§_-bU§ < this.size;
      }
      
      public function OptionalMap() : Boolean
      {
         if(this.§_-bU§ >= this.size)
         {
            throw new Error("Index out of bounds: " + this.§_-bU§);
         }
         var res:Boolean = this.getBit(this.§_-bU§);
         ++this.§_-bU§;
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
         var result:String = "readPosition: " + this.§_-bU§ + " size:" + this.getSize() + " mask:";
         var _readPosition:int = this.§_-bU§;
         for(var i:int = this.§_-bU§; i < this.getSize(); i++)
         {
            result += this.OptionalMap() ? "1" : "0";
         }
         this.§_-bU§ = _readPosition;
         return result;
      }
      
      public function clone() : alternativa.protocol.OptionalMap
      {
         var map:alternativa.protocol.OptionalMap = new alternativa.protocol.OptionalMap(this.size,this.map);
         map.§_-bU§ = this.§_-bU§;
         return map;
      }
   }
}

