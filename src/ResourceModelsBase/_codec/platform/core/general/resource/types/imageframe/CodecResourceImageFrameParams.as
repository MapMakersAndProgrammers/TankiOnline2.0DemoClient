package _codec.platform.core.general.resource.types.imageframe
{
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import platform.core.general.resource.types.imageframe.ResourceImageFrameParams;
   
   public class CodecResourceImageFrameParams implements ICodec
   {
      
      private var codec_alpha:ICodec;
      
      private var codec_h:ICodec;
      
      private var codec_w:ICodec;
      
      public function CodecResourceImageFrameParams()
      {
         super();
      }
      
      public function init(param1:IProtocol) : void
      {
         this.codec_alpha = param1.getCodec(new TypeCodecInfo(Boolean,false));
         this.codec_h = param1.getCodec(new TypeCodecInfo(int,false));
         this.codec_w = param1.getCodec(new TypeCodecInfo(int,false));
      }
      
      public function decode(param1:ProtocolBuffer) : Object
      {
         var _loc2_:Boolean = this.codec_alpha.decode(param1) as Boolean;
         var _loc3_:int = this.codec_h.decode(param1) as int;
         var _loc4_:int = this.codec_w.decode(param1) as int;
         return new ResourceImageFrameParams(_loc2_,_loc3_,_loc4_);
      }
      
      public function encode(param1:ProtocolBuffer, param2:Object) : void
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:ResourceImageFrameParams = ResourceImageFrameParams(param2);
         this.codec_alpha.encode(param1,_loc3_.alpha);
         this.codec_h.encode(param1,_loc3_.h);
         this.codec_w.encode(param1,_loc3_.w);
      }
   }
}

