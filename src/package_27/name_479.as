package package_27
{
   public class name_479
   {
      private var elements:Vector.<uint>;
      
      public function name_479(size:uint)
      {
         super();
         this.elements = new Vector.<uint>((size + 31) / 32);
      }
      
      public function name_480(bitIndex:uint, value:Boolean) : void
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
      
      public function name_478(bitIndex:uint) : int
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
      
      public function copyFrom(source:name_479) : void
      {
         var len:int = int(this.elements.length);
         for(var i:int = 0; i < len; i++)
         {
            this.elements[i] = source.elements[i];
         }
      }
   }
}

