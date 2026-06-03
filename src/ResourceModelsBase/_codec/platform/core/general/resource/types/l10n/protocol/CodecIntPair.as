package _codec.platform.core.general.resource.types.l10n.protocol
{
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import platform.core.general.resource.types.l10n.protocol.IntPair;
   
   public class CodecIntPair implements ICodec
   {
      
      private var codec_key:ICodec;
      
      private var codec_value:ICodec;
      
      public function CodecIntPair()
      {
         super();
      }
      
      public function init(param1:IProtocol) : void
      {
         this.codec_key = param1.getCodec(new TypeCodecInfo(String,false));
         this.codec_value = param1.getCodec(new TypeCodecInfo(int,false));
      }
      
      public function decode(param1:ProtocolBuffer) : Object
      {
         var _loc2_:String = this.codec_key.decode(param1) as String;
         var _loc3_:int = this.codec_value.decode(param1) as int;
         return new IntPair(_loc2_,_loc3_);
      }
      
      public function encode(param1:ProtocolBuffer, param2:Object) : void
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:IntPair = IntPair(param2);
         this.codec_key.encode(param1,_loc3_.key);
         this.codec_value.encode(param1,_loc3_.value);
      }
   }
}

