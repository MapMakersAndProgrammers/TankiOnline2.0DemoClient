package alternativa.protocol.info
{
   import flash.utils.getQualifiedClassName;
   
   public class TypeCodecInfo extends CodecInfo
   {
      private var name_hx:Class;
      
      public function TypeCodecInfo(type:Class, optional:Boolean)
      {
         super(optional);
         this.name_hx = type;
      }
      
      public function get type() : Class
      {
         return this.name_hx;
      }
      
      override public function toString() : String
      {
         return "[TypeCodecInfo " + super.toString() + " type=" + getQualifiedClassName(this.type);
      }
   }
}

