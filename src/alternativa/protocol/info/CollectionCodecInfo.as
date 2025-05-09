package alternativa.protocol.info
{
   import alternativa.protocol.ICodecInfo;
   
   public class CollectionCodecInfo extends CodecInfo
   {
      private var var_186:ICodecInfo;
      
      private var var_185:int;
      
      public function CollectionCodecInfo(elementCodec:ICodecInfo, optional:Boolean, level:int)
      {
         super(optional);
         this.var_186 = elementCodec;
         this.var_185 = level;
      }
      
      public function get level() : int
      {
         return this.var_185;
      }
      
      public function get elementCodec() : ICodecInfo
      {
         return this.var_186;
      }
      
      override public function toString() : String
      {
         return "[CollectionCodecInfo " + super.toString() + " element=" + this.elementCodec.toString() + " level=" + this.level + "]";
      }
   }
}

