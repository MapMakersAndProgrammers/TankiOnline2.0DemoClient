package alternativa.tanks.game.utils
{
   public class BitFlags
   {
      public var flags:int;
      
      public function BitFlags()
      {
         super();
      }
      
      public function setMask(mask:int) : void
      {
         this.flags |= mask;
      }
      
      public function clearMask(mask:int) : void
      {
         this.flags &= ~mask;
      }
      
      public function hasAny(mask:int) : Boolean
      {
         return (this.flags & mask) != 0;
      }
      
      public function hasAll(mask:int) : Boolean
      {
         return (this.flags & mask) == mask;
      }
   }
}

