package package_32
{
   import package_36.class_19;
   
   public class class_20 implements class_19
   {
      private var optional:Boolean;
      
      public function class_20(optional:Boolean)
      {
         super();
         this.optional = optional;
      }
      
      public function method_297() : Boolean
      {
         return this.optional;
      }
      
      public function toString() : String
      {
         return "[CodecInfo optional = " + this.optional + "]";
      }
   }
}

