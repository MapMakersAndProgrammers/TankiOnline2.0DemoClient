package alternativa.tanks.game.utils
{
   public class BitVector
   {
      private var elements:Vector.<uint>;
      
      public function BitVector(size:uint)
      {
         super();
         this.elements = new Vector.<uint>((size + 31) / 32);
      }
      
      public function setBit(bitIndex:uint, value:Boolean) : void
      {
         var elementIndex:uint = uint(bitIndex >>> 5);
         var element:uint = this.elements[elementIndex];
         bitIndex &= 31;
         if(value)
         {
            element |= 1 << bitIndex;
         }
         else
         {
            element &= ~(1 << bitIndex);
         }
         this.elements[elementIndex] = element;
      }
      
      public function getBit(bitIndex:uint) : int
      {
         var elementIndex:uint = uint(bitIndex >>> 5);
         bitIndex &= 31;
         return this.elements[elementIndex] >> bitIndex & 1;
      }
      
      public function clear() : void
      {
         var len:int = int(this.elements.length);
         for(var i:int = 0; i < len; i++)
         {
            this.elements[i] = 0;
         }
      }
      
      public function copyFrom(source:BitVector) : void
      {
         var len:int = int(this.elements.length);
         for(var i:int = 0; i < len; i++)
         {
            this.elements[i] = source.elements[i];
         }
      }
   }
}

