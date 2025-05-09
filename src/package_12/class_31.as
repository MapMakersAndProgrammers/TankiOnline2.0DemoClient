package package_12
{
   public class class_31 implements class_32
   {
      public var strings:Vector.<String>;
      
      public var var_665:int;
      
      public var var_664:int;
      
      private var var_666:int;
      
      public function class_31(capacity:int)
      {
         super();
         this.var_666 = capacity;
         this.strings = new Vector.<String>(this.var_666 + 1);
      }
      
      public function add(s:String) : void
      {
         this.strings[this.var_664] = s;
         this.var_664 = this.incIndex(this.var_664);
         if(this.var_664 == this.var_665)
         {
            this.var_665 = this.incIndex(this.var_665);
         }
      }
      
      public function clear() : void
      {
         this.var_665 = 0;
         this.var_664 = 0;
         var len:int = int(this.strings.length);
         for(var i:int = 0; i < len; i++)
         {
            this.strings[i] = null;
         }
      }
      
      public function get size() : int
      {
         var result:int = this.var_664 - this.var_665;
         if(result < 0)
         {
            result += this.strings.length;
         }
         return result;
      }
      
      public function get capacity() : int
      {
         return this.var_666;
      }
      
      public function method_326() : Vector.<String>
      {
         var result:Vector.<String> = new Vector.<String>();
         for(var i:int = this.var_665; i != this.var_664; i = this.incIndex(i))
         {
            result.push(this.strings[i]);
         }
         return result;
      }
      
      public function set capacity(value:int) : void
      {
         throw new Error("Unimplemented");
      }
      
      public function method_327(startIndex:int) : class_33
      {
         return new Iterator(this,startIndex);
      }
      
      private function incIndex(index:int) : int
      {
         return ++index >= this.strings.length ? 0 : index;
      }
   }
}

class Iterator implements class_33
{
   private var buffer:class_31;
   
   private var index:int;
   
   public function Iterator(buffer:class_31, startIndex:int)
   {
      super();
      if(startIndex < 0 || startIndex > buffer.size)
      {
         throw new Error("Index " + startIndex + " is out of range [0, " + buffer.size + "]");
      }
      this.buffer = buffer;
      var bufferLength:uint = uint(buffer.strings.length);
      this.index = buffer.var_665 + startIndex - 1;
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
      return this.incIndex(this.index) != this.buffer.var_664;
   }
   
   public function getNext() : String
   {
      this.index = this.incIndex(this.index);
      if(this.index == this.buffer.var_664)
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
