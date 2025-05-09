package alternativa.protocol.info
{
   public class EnumCodecInfo extends TypeCodecInfo
   {
      public function EnumCodecInfo(type:Class, optional:Boolean)
      {
         super(type,optional);
      }
      
      override public function toString() : String
      {
         return "[EnumCodec " + super.toString() + " type=" + type.toString();
      }
   }
}

