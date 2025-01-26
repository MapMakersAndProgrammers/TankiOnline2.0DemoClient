package package_27
{
   public class name_95
   {
      public var flags:int;
      
      public function name_95()
      {
         super();
      }
      
      public function method_268(mask:int) : void
      {
         this.flags |= mask;
      }
      
      public function method_270(mask:int) : void
      {
         this.flags &= ~mask;
      }
      
      public function method_269(mask:int) : Boolean
      {
         return (this.flags & mask) != 0;
      }
      
      public function method_271(mask:int) : Boolean
      {
         return (this.flags & mask) == mask;
      }
   }
}

