package _codec.platform.core.general.resource.types.image
{
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import platform.core.general.resource.types.image.ResourceImageParams;
   
   public class CodecResourceImageParams implements ICodec
   {
      
      private var codec_alpha:ICodec;
      
      public function CodecResourceImageParams()
      {
         super();
      }
      
      public function init(param1:IProtocol) : void
      {
         this.codec_alpha = param1.getCodec(new TypeCodecInfo(Boolean,false));
      }
      
      public function decode(param1:ProtocolBuffer) : Object
      {
         var _loc2_:Boolean = this.codec_alpha.decode(param1) as Boolean;
         return new ResourceImageParams(_loc2_);
      }
      
      public function encode(param1:ProtocolBuffer, param2:Object) : void
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:ResourceImageParams = ResourceImageParams(param2);
         this.codec_alpha.encode(param1,_loc3_.alpha);
      }
   }
}

