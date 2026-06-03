package _codec.platform.core.general.resource.types.l10n.protocol
{
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.CollectionCodecInfo;
   import alternativa.protocol.info.TypeCodecInfo;
   import platform.core.general.resource.types.l10n.protocol.BooleanPair;
   import platform.core.general.resource.types.l10n.protocol.DoublePair;
   import platform.core.general.resource.types.l10n.protocol.ImagePair;
   import platform.core.general.resource.types.l10n.protocol.IntPair;
   import platform.core.general.resource.types.l10n.protocol.LocaleStruct;
   import platform.core.general.resource.types.l10n.protocol.StringPair;
   
   public class CodecLocaleStruct implements ICodec
   {
      
      private var codec_booleans:ICodec;
      
      private var codec_doubles:ICodec;
      
      private var codec_images:ICodec;
      
      private var codec_ints:ICodec;
      
      private var codec_prefix:ICodec;
      
      private var codec_strings:ICodec;
      
      public function CodecLocaleStruct()
      {
         super();
      }
      
      public function init(param1:IProtocol) : void
      {
         this.codec_booleans = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(BooleanPair,false),false,1));
         this.codec_doubles = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(DoublePair,false),false,1));
         this.codec_images = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(ImagePair,false),false,1));
         this.codec_ints = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(IntPair,false),false,1));
         this.codec_prefix = param1.getCodec(new TypeCodecInfo(String,false));
         this.codec_strings = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(StringPair,false),false,1));
      }
      
      public function decode(param1:ProtocolBuffer) : Object
      {
         var _loc2_:Vector.<BooleanPair> = this.codec_booleans.decode(param1) as Vector.<BooleanPair>;
         var _loc3_:Vector.<DoublePair> = this.codec_doubles.decode(param1) as Vector.<DoublePair>;
         var _loc4_:Vector.<ImagePair> = this.codec_images.decode(param1) as Vector.<ImagePair>;
         var _loc5_:Vector.<IntPair> = this.codec_ints.decode(param1) as Vector.<IntPair>;
         var _loc6_:String = this.codec_prefix.decode(param1) as String;
         var _loc7_:Vector.<StringPair> = this.codec_strings.decode(param1) as Vector.<StringPair>;
         return new LocaleStruct(_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_);
      }
      
      public function encode(param1:ProtocolBuffer, param2:Object) : void
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:LocaleStruct = LocaleStruct(param2);
         this.codec_booleans.encode(param1,_loc3_.booleans);
         this.codec_doubles.encode(param1,_loc3_.doubles);
         this.codec_images.encode(param1,_loc3_.images);
         this.codec_ints.encode(param1,_loc3_.ints);
         this.codec_prefix.encode(param1,_loc3_.prefix);
         this.codec_strings.encode(param1,_loc3_.strings);
      }
   }
}

