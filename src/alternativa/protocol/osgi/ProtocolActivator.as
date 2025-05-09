package alternativa.protocol.osgi
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.bundle.IBundleActivator;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.codec.primitive.ByteCodec;
   import alternativa.protocol.codec.primitive.DoubleCodec;
   import alternativa.protocol.codec.primitive.FloatCodec;
   import alternativa.protocol.codec.primitive.IntCodec;
   import alternativa.protocol.codec.primitive.LongCodec;
   import alternativa.protocol.codec.primitive.ShortCodec;
   import alternativa.protocol.codec.primitive.UByteCodec;
   import alternativa.protocol.codec.primitive.UIntCodec;
   import alternativa.protocol.codec.primitive.UShortCodec;
   import alternativa.protocol.impl.Protocol;
   import alternativa.types.Byte;
   import alternativa.types.Float;
   import alternativa.types.Long;
   import alternativa.types.Short;
   import alternativa.types.UByte;
   import alternativa.types.UShort;
   
   public class ProtocolActivator implements IBundleActivator
   {
      public function ProtocolActivator()
      {
         super();
      }
      
      public function start(osgi:OSGi) : void
      {
         var protocol:IProtocol = Protocol.defaultInstance;
         osgi.registerService(IProtocol,protocol);
         protocol.registerCodecForType(Byte,new ByteCodec());
         protocol.registerCodecForType(Float,new FloatCodec());
         protocol.registerCodecForType(Long,new LongCodec());
         protocol.registerCodecForType(Short,new ShortCodec());
         protocol.registerCodecForType(UByte,new UByteCodec());
         protocol.registerCodecForType(UShort,new UShortCodec());
         protocol.registerCodecForType(uint,new UIntCodec());
         protocol.registerCodecForType(int,new IntCodec());
         protocol.registerCodecForType(Number,new DoubleCodec());
      }
      
      public function stop(osgi:OSGi) : void
      {
      }
   }
}

