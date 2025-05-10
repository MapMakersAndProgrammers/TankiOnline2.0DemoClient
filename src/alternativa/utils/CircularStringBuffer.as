package alternativa.utils
{
   public class CircularStringBuffer implements ICircularStringBuffer
   {
      public var strings:Vector.<String>;
      
      public var name_Uh:int;
      
      public var name_1A:int;
      
      private var name_9W:int;
      
      public function CircularStringBuffer(capacity:int)
      {
         super();
         this.name_9W = capacity;
         this.strings = new Vector.<String>(this.name_9W + 1);
      }
      
      public function add(s:String) : void
      {
         this.strings[this.name_1A] = s;
         this.name_1A = this.incIndex(this.name_1A);
         if(this.name_1A == this.name_Uh)
         {
            this.name_Uh = this.incIndex(this.name_Uh);
         }
      }
      
      public function clear() : void
      {
         this.name_Uh = 0;
         this.name_1A = 0;
         var len:int = int(this.strings.length);
         for(var i:int = 0; i < len; i++)
         {
            this.strings[i] = null;
         }
      }
      
      public function get size() : int
      {
         var result:int = this.name_1A - this.name_Uh;
         if(result < 0)
         {
            result += this.strings.length;
         }
         return result;
      }
      
      public function get capacity() : int
      {
         return this.name_9W;
      }
      
      public function getStrings() : Vector.<String>
      {
         var result:Vector.<String> = new Vector.<String>();
         for(var i:int = this.name_Uh; i != this.name_1A; i = this.incIndex(i))
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

import alternativa.utils.IStringBufferIterator;
import alternativa.utils.CircularStringBuffer;

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
      this.index = buffer.name_Uh + startIndex - 1;
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
      return this.incIndex(this.index) != this.buffer.name_1A;
   }
   
   public function getNext() : String
   {
      this.index = this.incIndex(this.index);
      if(this.index == this.buffer.name_1A)
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
