package alternativa.protocol.info
{
   import alternativa.protocol.ICodecInfo;
   
   public class CollectionCodecInfo extends CodecInfo
   {
      private var name_jo:ICodecInfo;
      
      private var name_fp:int;
      
      public function CollectionCodecInfo(elementCodec:ICodecInfo, optional:Boolean, level:int)
      {
         super(optional);
         this.name_jo = elementCodec;
         this.name_fp = level;
      }
      
      public function get level() : int
      {
         return this.name_fp;
      }
      
      public function get elementCodec() : ICodecInfo
      {
         return this.name_jo;
      }
      
      override public function toString() : String
      {
         return "[CollectionCodecInfo " + super.toString() + " element=" + this.elementCodec.toString() + " level=" + this.level + "]";
      }
   }
}

