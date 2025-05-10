package alternativa.utils
{
   public class CircularStringBuffer implements ICircularStringBuffer
   {
      public var strings:Vector.<String>;
      
      public var §_-Uh§:int;
      
      public var §_-1A§:int;
      
      private var §_-9W§:int;
      
      public function CircularStringBuffer(capacity:int)
      {
         super();
         this.§_-9W§ = capacity;
         this.strings = new Vector.<String>(this.§_-9W§ + 1);
      }
      
      public function add(s:String) : void
      {
         this.strings[this.§_-1A§] = s;
         this.§_-1A§ = this.incIndex(this.§_-1A§);
         if(this.§_-1A§ == this.§_-Uh§)
         {
            this.§_-Uh§ = this.incIndex(this.§_-Uh§);
         }
      }
      
      public function clear() : void
      {
         this.§_-Uh§ = 0;
         this.§_-1A§ = 0;
         var len:int = int(this.strings.length);
         for(var i:int = 0; i < len; i++)
         {
            this.strings[i] = null;
         }
      }
      
      public function get size() : int
      {
         var result:int = this.§_-1A§ - this.§_-Uh§;
         if(result < 0)
         {
            result += this.strings.length;
         }
         return result;
      }
      
      public function get capacity() : int
      {
         return this.§_-9W§;
      }
      
      public function getStrings() : Vector.<String>
      {
         var result:Vector.<String> = new Vector.<String>();
         for(var i:int = this.§_-Uh§; i != this.§_-1A§; i = this.incIndex(i))
         {
            result.push(this.strings[i]);
         }
         return result;
      }
      
      public function set capacity(value:int) : void
      {
         throw new Error("Unimplemented");
      }
      
      public function getIterator(startIndex:int) : IStringBufferIterator
      {
         return new Iterator(this,startIndex);
      }
      
      private function incIndex(index:int) : int
      {
         return ++index >= this.strings.length ? 0 : index;
      }
   }
}

class Iterator implements IStringBufferIterator
{
   private var buffer:CircularStringBuffer;
   
   private var index:int;
   
   public function Iterator(buffer:CircularStringBuffer, startIndex:int)
   {
      super();
      if(startIndex < 0 || startIndex > buffer.size)
      {
         throw new Error("Index " + startIndex + " is out of range [0, " + buffer.size + "]");
      }
      this.buffer = buffer;
      var bufferLength:uint = uint(buffer.strings.length);
      this.index = buffer.§_-Uh§ + startIndex - 1;
      if(this.index < 0)
      {
         this.index = bufferLength - 1;
      }
      if(this.index >= bufferLength)
      {
         this.index -= bufferLength;
      }
   }
   
   public function hasNext() : Boolean
   {
      return this.incIndex(this.index) != this.buffer.§_-1A§;
   }
   
   public function getNext() : String
   {
      this.index = this.incIndex(this.index);
      if(this.index == this.buffer.§_-1A§)
      {
         throw new Error("End of buffer");
      }
      return this.buffer.strings[this.index];
   }
   
   private function incIndex(index:int) : int
   {
      return ++index >= this.buffer.strings.length ? 0 : index;
   }
}
