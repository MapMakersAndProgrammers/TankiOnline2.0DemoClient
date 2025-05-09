package alternativa.protocol.info
{
   import alternativa.protocol.ICodecInfo;
   
   public class CollectionCodecInfo extends CodecInfo
   {
      private var §_-jo§:ICodecInfo;
      
      private var §_-fp§:int;
      
      public function CollectionCodecInfo(elementCodec:ICodecInfo, optional:Boolean, level:int)
      {
         super(optional);
         this.§_-jo§ = elementCodec;
         this.§_-fp§ = level;
      }
      
      public function get level() : int
      {
         return this.§_-fp§;
      }
      
      public function get elementCodec() : ICodecInfo
      {
         return this.§_-jo§;
      }
      
      override public function toString() : String
      {
         return "[CollectionCodecInfo " + super.toString() + " element=" + this.elementCodec.toString() + " level=" + this.level + "]";
      }
   }
}

