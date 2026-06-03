package _codec.platform.core.general.resource.types.swf
{
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.CollectionCodecInfo;
   import alternativa.protocol.info.TypeCodecInfo;
   import platform.core.general.resource.types.swf.ResourceSWFParams;
   
   public class CodecResourceSWFParams implements ICodec
   {
      
      private var codec_keys:ICodec;
      
      private var codec_values:ICodec;
      
      public function CodecResourceSWFParams()
      {
         super();
      }
      
      public function init(param1:IProtocol) : void
      {
         this.codec_keys = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(String,false),false,1));
         this.codec_values = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(String,false),false,1));
      }
      
      public function decode(param1:ProtocolBuffer) : Object
      {
         var _loc2_:Vector.<String> = this.codec_keys.decode(param1) as Vector.<String>;
         var _loc3_:Vector.<String> = this.codec_values.decode(param1) as Vector.<String>;
         return new ResourceSWFParams(_loc2_,_loc3_);
      }
      
      public function encode(param1:ProtocolBuffer, param2:Object) : void
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:ResourceSWFParams = ResourceSWFParams(param2);
         this.codec_keys.encode(param1,_loc3_.keys);
         this.codec_values.encode(param1,_loc3_.values);
      }
   }
}

