package package_32
{
   import package_36.class_19;
   
   public class name_149 extends class_20
   {
      private var var_186:class_19;
      
      private var var_185:int;
      
      public function name_149(elementCodec:class_19, optional:Boolean, level:int)
      {
         super(optional);
         this.var_186 = elementCodec;
         this.var_185 = level;
      }
      
      public function get level() : int
      {
         return this.var_185;
      }
      
      public function get elementCodec() : class_19
      {
         return this.var_186;
      }
      
      override public function toString() : String
      {
         return "[CollectionCodecInfo " + super.toString() + " element=" + this.elementCodec.toString() + " level=" + this.level + "]";
      }
   }
}

