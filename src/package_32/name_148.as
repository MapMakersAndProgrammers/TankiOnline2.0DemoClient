package package_32
{
   import flash.utils.getQualifiedClassName;
   
   public class name_148 extends class_20
   {
      private var var_184:Class;
      
      public function name_148(type:Class, optional:Boolean)
      {
         super(optional);
         this.var_184 = type;
      }
      
      public function get type() : Class
      {
         return this.var_184;
      }
      
      override public function toString() : String
      {
         return "[TypeCodecInfo " + super.toString() + " type=" + getQualifiedClassName(this.type);
      }
   }
}

