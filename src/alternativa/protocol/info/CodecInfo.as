package alternativa.protocol.info
{
   import alternativa.protocol.ICodecInfo;
   
   public class CodecInfo implements ICodecInfo
   {
      private var optional:Boolean;
      
      public function CodecInfo(optional:Boolean)
      {
         super();
         this.optional = optional;
      }
      
      public function isOptional() : Boolean
      {
         return this.optional;
      }
      
      public function toString() : String
      {
         return "[CodecInfo optional = " + this.optional + "]";
      }
   }
}

