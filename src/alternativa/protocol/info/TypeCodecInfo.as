package alternativa.protocol.info
{
   import flash.utils.getQualifiedClassName;
   
   public class TypeCodecInfo extends CodecInfo
   {
      private var var_184:Class;
      
      public function TypeCodecInfo(type:Class, optional:Boolean)
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

