package alternativa.protocol.impl
{
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.*;
   import alternativa.protocol.codec.OptionalCodecDecorator;
   import alternativa.protocol.codec.complex.ByteArrayCodec;
   import alternativa.protocol.codec.complex.StringCodec;
   import alternativa.protocol.codec.primitive.BooleanCodec;
   import alternativa.protocol.codec.primitive.ByteCodec;
   import alternativa.protocol.codec.primitive.DoubleCodec;
   import alternativa.protocol.codec.primitive.FloatCodec;
   import alternativa.protocol.codec.primitive.IntCodec;
   import alternativa.protocol.codec.primitive.LongCodec;
   import alternativa.protocol.codec.primitive.ShortCodec;
   import alternativa.protocol.codec.primitive.UIntCodec;
   import alternativa.protocol.codec.primitive.UShortCodec;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Byte;
   import alternativa.types.Float;
   import alternativa.types.Long;
   import alternativa.types.Short;
   import alternativa.types.UShort;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class Protocol implements IProtocol
   {
      [Inject]
      public static var clientLog:IClientLog;
      
      private static const LOG_CHANNEL:String = "protocol";
      
      public static var defaultInstance:IProtocol = new Protocol();
      
      private var §_-5c§:Object = new Object();
      
      private var §_-RY§:Dictionary = new Dictionary(false);
      
      public function Protocol()
      {
         super();
         this.registerCodec(new TypeCodecInfo(int,false),new IntCodec());
         this.registerCodec(new TypeCodecInfo(Short,false),new ShortCodec());
         this.registerCodec(new TypeCodecInfo(Byte,false),new ByteCodec());
         this.registerCodec(new TypeCodecInfo(UShort,false),new UShortCodec());
         this.registerCodec(new TypeCodecInfo(uint,false),new UIntCodec());
         this.registerCodec(new TypeCodecInfo(Number,false),new DoubleCodec());
         this.registerCodec(new TypeCodecInfo(Float,false),new FloatCodec());
         this.registerCodec(new TypeCodecInfo(Boolean,false),new BooleanCodec());
         this.registerCodec(new TypeCodecInfo(Long,false),new LongCodec());
         this.registerCodec(new TypeCodecInfo(String,false),new StringCodec());
         this.registerCodec(new TypeCodecInfo(ByteArray,false),new ByteArrayCodec());
         this.registerCodec(new TypeCodecInfo(int,true),new OptionalCodecDecorator(new IntCodec()));
         this.registerCodec(new TypeCodecInfo(Short,true),new OptionalCodecDecorator(new ShortCodec()));
         this.registerCodec(new TypeCodecInfo(Byte,true),new OptionalCodecDecorator(new ByteCodec()));
         this.registerCodec(new TypeCodecInfo(UShort,true),new OptionalCodecDecorator(new UShortCodec()));
         this.registerCodec(new TypeCodecInfo(uint,true),new OptionalCodecDecorator(new UIntCodec()));
         this.registerCodec(new TypeCodecInfo(Number,true),new OptionalCodecDecorator(new DoubleCodec()));
         this.registerCodec(new TypeCodecInfo(Float,true),new OptionalCodecDecorator(new FloatCodec()));
         this.registerCodec(new TypeCodecInfo(Boolean,true),new OptionalCodecDecorator(new BooleanCodec()));
         this.registerCodec(new TypeCodecInfo(Long,true),new OptionalCodecDecorator(new LongCodec()));
         this.registerCodec(new TypeCodecInfo(String,true),new OptionalCodecDecorator(new StringCodec()));
         this.registerCodec(new TypeCodecInfo(ByteArray,true),new OptionalCodecDecorator(new ByteArrayCodec()));
      }
      
      public function registerCodec(codecInfo:ICodecInfo, codec:ICodec) : void
      {
         this.§_-5c§[codecInfo] = codec;
      }
      
      public function registerCodecForType(type:Class, codec:ICodec) : void
      {
         this.§_-5c§[new TypeCodecInfo(type,false)] = codec;
         this.§_-5c§[new TypeCodecInfo(type,true)] = new OptionalCodecDecorator(codec);
      }
      
      public function getCodec(codecInfo:ICodecInfo) : ICodec
      {
         var result:ICodec = this.§_-5c§[codecInfo];
         if(result == null)
         {
            throw Error("Codec not found for  " + codecInfo);
         }
         if(this.§_-RY§[result] == null)
         {
            result.init(this);
            this.§_-RY§[result] = result;
         }
         return result;
      }
      
      public function makeCodecInfo(type:Class) : ICodecInfo
      {
         return new TypeCodecInfo(type,false);
      }
      
      public function wrapPacket(dest:IDataOutput, source:ProtocolBuffer, compressionType:CompressionType) : void
      {
         PacketHelper.wrapPacket(dest,source,compressionType);
      }
      
      public function unwrapPacket(source:IDataInput, dest:ProtocolBuffer) : Boolean
      {
         return PacketHelper.unwrapPacket(source,dest);
      }
   }
}

