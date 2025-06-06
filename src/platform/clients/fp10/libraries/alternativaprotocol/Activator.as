package platform.clients.fp10.libraries.alternativaprotocol
{
   import _codec.VectorCodecStringLevel1;
   import _codec.VectorCodecStringLevel2;
   import _codec.VectorCodecStringLevel3;
   import _codec.VectorCodecbyteLevel1;
   import _codec.VectorCodecbyteLevel2;
   import _codec.VectorCodecbyteLevel3;
   import _codec.VectorCodecfloatLevel1;
   import _codec.VectorCodecfloatLevel2;
   import _codec.VectorCodecfloatLevel3;
   import _codec.VectorCodecintLevel1;
   import _codec.VectorCodecintLevel2;
   import _codec.VectorCodecintLevel3;
   import _codec.VectorCodeclongLevel1;
   import _codec.VectorCodeclongLevel2;
   import _codec.VectorCodeclongLevel3;
   import _codec.VectorCodecshortLevel1;
   import _codec.VectorCodecshortLevel2;
   import _codec.VectorCodecshortLevel3;
   import _codec.unsigned.VectorCodecintLevel1;
   import _codec.unsigned.VectorCodecintLevel2;
   import _codec.unsigned.VectorCodecintLevel3;
   import _codec.unsigned.VectorCodeclongLevel1;
   import _codec.unsigned.VectorCodeclongLevel2;
   import _codec.unsigned.VectorCodeclongLevel3;
   import _codec.unsigned.VectorCodecshortLevel1;
   import _codec.unsigned.VectorCodecshortLevel2;
   import _codec.unsigned.VectorCodecshortLevel3;
   import alternativa.osgi.OSGi;
   import alternativa.osgi.bundle.IBundleActivator;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.codec.OptionalCodecDecorator;
   import alternativa.protocol.impl.PacketHelper;
   import alternativa.protocol.impl.Protocol;
   import alternativa.protocol.info.CollectionCodecInfo;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Byte;
   import alternativa.types.Float;
   import alternativa.types.Long;
   import alternativa.types.Short;
   import alternativa.types.UByte;
   import alternativa.types.UShort;
   
   public class Activator implements IBundleActivator
   {
      public static var osgi:OSGi;
      
      public function Activator()
      {
         super();
      }
      
      public function start(_osgi:OSGi) : void
      {
         var codec:ICodec = null;
         osgi = _osgi;
         var protocol:IProtocol = Protocol.defaultInstance;
         codec = new VectorCodecbyteLevel1(false);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Byte,false),false,1),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Byte,false),true,1),new OptionalCodecDecorator(codec));
         codec = new VectorCodecbyteLevel1(true);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Byte,true),false,1),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Byte,true),true,1),new OptionalCodecDecorator(codec));
         codec = new VectorCodecbyteLevel2(false);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Byte,false),false,2),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Byte,false),true,2),new OptionalCodecDecorator(codec));
         codec = new VectorCodecbyteLevel2(true);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Byte,true),false,2),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Byte,true),true,2),new OptionalCodecDecorator(codec));
         codec = new VectorCodecbyteLevel3(false);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Byte,false),false,3),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Byte,false),true,3),new OptionalCodecDecorator(codec));
         codec = new VectorCodecbyteLevel3(true);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Byte,true),false,3),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Byte,true),true,3),new OptionalCodecDecorator(codec));
         codec = new _codec.VectorCodecintLevel1(false);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(int,false),false,1),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(int,false),true,1),new OptionalCodecDecorator(codec));
         codec = new _codec.VectorCodecintLevel1(true);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(int,true),false,1),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(int,true),true,1),new OptionalCodecDecorator(codec));
         codec = new _codec.VectorCodecintLevel2(false);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(int,false),false,2),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(int,false),true,2),new OptionalCodecDecorator(codec));
         codec = new _codec.VectorCodecintLevel2(true);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(int,true),false,2),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(int,true),true,2),new OptionalCodecDecorator(codec));
         codec = new _codec.VectorCodecintLevel3(false);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(int,false),false,3),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(int,false),true,3),new OptionalCodecDecorator(codec));
         codec = new _codec.VectorCodecintLevel3(true);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(int,true),false,3),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(int,true),true,3),new OptionalCodecDecorator(codec));
         codec = new _codec.VectorCodecshortLevel1(false);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Short,false),false,1),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Short,false),true,1),new OptionalCodecDecorator(codec));
         codec = new _codec.VectorCodecshortLevel1(true);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Short,true),false,1),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Short,true),true,1),new OptionalCodecDecorator(codec));
         codec = new _codec.VectorCodecshortLevel2(false);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Short,false),false,2),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Short,false),true,2),new OptionalCodecDecorator(codec));
         codec = new _codec.VectorCodecshortLevel2(true);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Short,true),false,2),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Short,true),true,2),new OptionalCodecDecorator(codec));
         codec = new _codec.VectorCodecshortLevel3(false);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Short,false),false,3),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Short,false),true,3),new OptionalCodecDecorator(codec));
         codec = new _codec.VectorCodecshortLevel3(true);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Short,true),false,3),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Short,true),true,3),new OptionalCodecDecorator(codec));
         codec = new _codec.VectorCodeclongLevel1(false);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,false),false,1),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,false),true,1),new OptionalCodecDecorator(codec));
         codec = new _codec.VectorCodeclongLevel1(true);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,true),false,1),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,true),true,1),new OptionalCodecDecorator(codec));
         codec = new _codec.VectorCodeclongLevel2(false);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,false),false,2),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,false),true,2),new OptionalCodecDecorator(codec));
         codec = new _codec.VectorCodeclongLevel2(true);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,true),false,2),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,true),true,2),new OptionalCodecDecorator(codec));
         codec = new _codec.VectorCodeclongLevel3(false);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,false),false,3),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,false),true,3),new OptionalCodecDecorator(codec));
         codec = new _codec.VectorCodeclongLevel3(true);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,true),false,3),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,true),true,3),new OptionalCodecDecorator(codec));
         codec = new VectorCodecfloatLevel1(false);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Float,false),false,1),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Float,false),true,1),new OptionalCodecDecorator(codec));
         codec = new VectorCodecfloatLevel1(true);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Float,true),false,1),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Float,true),true,1),new OptionalCodecDecorator(codec));
         codec = new VectorCodecfloatLevel2(false);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Float,false),false,2),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Float,false),true,2),new OptionalCodecDecorator(codec));
         codec = new VectorCodecfloatLevel2(true);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Float,true),false,2),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Float,true),true,2),new OptionalCodecDecorator(codec));
         codec = new VectorCodecfloatLevel3(false);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Float,false),false,3),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Float,false),true,3),new OptionalCodecDecorator(codec));
         codec = new VectorCodecfloatLevel3(true);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Float,true),false,3),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Float,true),true,3),new OptionalCodecDecorator(codec));
         codec = new _codec.unsigned.VectorCodecintLevel1(false);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UShort,false),false,1),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UShort,false),true,1),new OptionalCodecDecorator(codec));
         codec = new _codec.unsigned.VectorCodecintLevel1(true);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UShort,true),false,1),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UShort,true),true,1),new OptionalCodecDecorator(codec));
         codec = new _codec.unsigned.VectorCodecintLevel2(false);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UShort,false),false,2),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UShort,false),true,2),new OptionalCodecDecorator(codec));
         codec = new _codec.unsigned.VectorCodecintLevel2(true);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UShort,true),false,2),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UShort,true),true,2),new OptionalCodecDecorator(codec));
         codec = new _codec.unsigned.VectorCodecintLevel3(false);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UShort,false),false,3),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UShort,false),true,3),new OptionalCodecDecorator(codec));
         codec = new _codec.unsigned.VectorCodecintLevel3(true);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UShort,true),false,3),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UShort,true),true,3),new OptionalCodecDecorator(codec));
         codec = new _codec.unsigned.VectorCodecshortLevel1(false);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UByte,false),false,1),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UByte,false),true,1),new OptionalCodecDecorator(codec));
         codec = new _codec.unsigned.VectorCodecshortLevel1(true);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UByte,true),false,1),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UByte,true),true,1),new OptionalCodecDecorator(codec));
         codec = new _codec.unsigned.VectorCodecshortLevel2(false);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UByte,false),false,2),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UByte,false),true,2),new OptionalCodecDecorator(codec));
         codec = new _codec.unsigned.VectorCodecshortLevel2(true);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UByte,true),false,2),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UByte,true),true,2),new OptionalCodecDecorator(codec));
         codec = new _codec.unsigned.VectorCodecshortLevel3(false);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UByte,false),false,3),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UByte,false),true,3),new OptionalCodecDecorator(codec));
         codec = new _codec.unsigned.VectorCodecshortLevel3(true);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UByte,true),false,3),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UByte,true),true,3),new OptionalCodecDecorator(codec));
         codec = new _codec.unsigned.VectorCodeclongLevel1(false);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(uint,false),false,1),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(uint,false),true,1),new OptionalCodecDecorator(codec));
         codec = new _codec.unsigned.VectorCodeclongLevel1(true);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(uint,true),false,1),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(uint,true),true,1),new OptionalCodecDecorator(codec));
         codec = new _codec.unsigned.VectorCodeclongLevel2(false);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(uint,false),false,2),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(uint,false),true,2),new OptionalCodecDecorator(codec));
         codec = new _codec.unsigned.VectorCodeclongLevel2(true);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(uint,true),false,2),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(uint,true),true,2),new OptionalCodecDecorator(codec));
         codec = new _codec.unsigned.VectorCodeclongLevel3(false);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(uint,false),false,3),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(uint,false),true,3),new OptionalCodecDecorator(codec));
         codec = new _codec.unsigned.VectorCodeclongLevel3(true);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(uint,true),false,3),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(uint,true),true,3),new OptionalCodecDecorator(codec));
         codec = new VectorCodecStringLevel1(false);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(String,false),false,1),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(String,false),true,1),new OptionalCodecDecorator(codec));
         codec = new VectorCodecStringLevel1(true);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(String,true),false,1),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(String,true),true,1),new OptionalCodecDecorator(codec));
         codec = new VectorCodecStringLevel2(false);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(String,false),false,2),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(String,false),true,2),new OptionalCodecDecorator(codec));
         codec = new VectorCodecStringLevel2(true);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(String,true),false,2),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(String,true),true,2),new OptionalCodecDecorator(codec));
         codec = new VectorCodecStringLevel3(false);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(String,false),false,3),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(String,false),true,3),new OptionalCodecDecorator(codec));
         codec = new VectorCodecStringLevel3(true);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(String,true),false,3),codec);
         protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(String,true),true,3),new OptionalCodecDecorator(codec));
         osgi.injectService(IClientLog,Protocol,"clientLog");
         osgi.injectService(IClientLog,PacketHelper,"clientLog");
      }
      
      public function stop(osgi:OSGi) : void
      {
      }
   }
}

