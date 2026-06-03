package platform.client.core.general.spaces.osgi
{
   import _codec.platform.client.core.general.spaces.models.dispatcher.CodecLoadObjectStruct;
   import _codec.platform.client.core.general.spaces.models.dispatcher.CodecModelData;
   import _codec.platform.client.core.general.spaces.models.dispatcher.VectorCodecLoadObjectStructLevel1;
   import _codec.platform.client.core.general.spaces.models.dispatcher.VectorCodecLoadObjectStructLevel2;
   import _codec.platform.client.core.general.spaces.models.dispatcher.VectorCodecLoadObjectStructLevel3;
   import _codec.platform.client.core.general.spaces.models.dispatcher.VectorCodecModelDataLevel1;
   import _codec.platform.client.core.general.spaces.models.dispatcher.VectorCodecModelDataLevel2;
   import _codec.platform.client.core.general.spaces.models.dispatcher.VectorCodecModelDataLevel3;
   import _codec.platform.client.core.general.spaces.models.quadro.CodecQuadroModelCC;
   import _codec.platform.client.core.general.spaces.models.quadro.CodecTest;
   import _codec.platform.client.core.general.spaces.models.quadro.VectorCodecQuadroModelCCLevel1;
   import _codec.platform.client.core.general.spaces.models.quadro.VectorCodecQuadroModelCCLevel2;
   import _codec.platform.client.core.general.spaces.models.quadro.VectorCodecQuadroModelCCLevel3;
   import _codec.platform.client.core.general.spaces.models.quadro.VectorCodecTestLevel1;
   import _codec.platform.client.core.general.spaces.models.quadro.VectorCodecTestLevel2;
   import _codec.platform.client.core.general.spaces.models.quadro.VectorCodecTestLevel3;
   import _codec.platform.client.core.general.spaces.models.quadrosimple.CodecQuadroSimpleModelCC;
   import _codec.platform.client.core.general.spaces.models.quadrosimple.VectorCodecQuadroSimpleModelCCLevel1;
   import _codec.platform.client.core.general.spaces.models.quadrosimple.VectorCodecQuadroSimpleModelCCLevel2;
   import _codec.platform.client.core.general.spaces.models.quadrosimple.VectorCodecQuadroSimpleModelCCLevel3;
   import _codec.platform.client.core.general.spaces.models.tests.selfunload.CodecSelfUnloadModelCC;
   import _codec.platform.client.core.general.spaces.models.tests.selfunload.VectorCodecSelfUnloadModelCCLevel1;
   import _codec.platform.client.core.general.spaces.models.tests.selfunload.VectorCodecSelfUnloadModelCCLevel2;
   import _codec.platform.client.core.general.spaces.models.tests.selfunload.VectorCodecSelfUnloadModelCCLevel3;
   import alternativa.osgi.OSGi;
   import alternativa.osgi.bundle.IBundleActivator;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.codec.OptionalCodecDecorator;
   import alternativa.protocol.info.CollectionCodecInfo;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Long;
   import platform.client.core.general.spaces.models.dispatcher.LoadObjectStruct;
   import platform.client.core.general.spaces.models.dispatcher.ModelData;
   import platform.client.core.general.spaces.models.quadro.QuadroModelCC;
   import platform.client.core.general.spaces.models.quadro.Test;
   import platform.client.core.general.spaces.models.quadrosimple.QuadroSimpleModelCC;
   import platform.client.core.general.spaces.models.tests.selfunload.SelfUnloadModelCC;
   import platform.client.fp10.core.registry.ModelRegistry;
   
   public class Activator implements IBundleActivator
   {
      
      public static var osgi:OSGi;
      
      public function Activator()
      {
         super();
      }
      
      public function start(param1:OSGi) : void
      {
         var _loc4_:ICodec = null;
         osgi = param1;
         var _loc2_:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
         _loc2_.register(Long.getLong(0,100013),Long.getLong(0,100013));
         _loc2_.register(Long.getLong(0,100010),Long.getLong(0,100003));
         _loc2_.register(Long.getLong(0,100012),Long.getLong(0,100009));
         _loc2_.register(Long.getLong(0,100012),Long.getLong(0,100010));
         _loc2_.register(Long.getLong(0,100012),Long.getLong(0,100011));
         _loc2_.register(Long.getLong(0,100003),Long.getLong(0,100000));
         _loc2_.register(Long.getLong(0,100003),Long.getLong(0,100001));
         _loc2_.register(Long.getLong(0,100011),Long.getLong(0,100005));
         _loc2_.register(Long.getLong(0,100011),Long.getLong(0,100006));
         _loc2_.register(Long.getLong(0,100011),Long.getLong(0,100007));
         var _loc3_:IProtocol = IProtocol(osgi.getService(IProtocol));
         _loc4_ = new CodecLoadObjectStruct();
         _loc3_.registerCodec(new TypeCodecInfo(LoadObjectStruct,false),_loc4_);
         _loc3_.registerCodec(new TypeCodecInfo(LoadObjectStruct,true),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new CodecModelData();
         _loc3_.registerCodec(new TypeCodecInfo(ModelData,false),_loc4_);
         _loc3_.registerCodec(new TypeCodecInfo(ModelData,true),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new CodecQuadroSimpleModelCC();
         _loc3_.registerCodec(new TypeCodecInfo(QuadroSimpleModelCC,false),_loc4_);
         _loc3_.registerCodec(new TypeCodecInfo(QuadroSimpleModelCC,true),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new CodecTest();
         _loc3_.registerCodec(new TypeCodecInfo(Test,false),_loc4_);
         _loc3_.registerCodec(new TypeCodecInfo(Test,true),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new CodecSelfUnloadModelCC();
         _loc3_.registerCodec(new TypeCodecInfo(SelfUnloadModelCC,false),_loc4_);
         _loc3_.registerCodec(new TypeCodecInfo(SelfUnloadModelCC,true),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new CodecQuadroModelCC();
         _loc3_.registerCodec(new TypeCodecInfo(QuadroModelCC,false),_loc4_);
         _loc3_.registerCodec(new TypeCodecInfo(QuadroModelCC,true),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecQuadroSimpleModelCCLevel3(false);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(QuadroSimpleModelCC,false),false,3),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(QuadroSimpleModelCC,false),true,3),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecQuadroSimpleModelCCLevel3(true);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(QuadroSimpleModelCC,true),false,3),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(QuadroSimpleModelCC,true),true,3),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecLoadObjectStructLevel2(false);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LoadObjectStruct,false),false,2),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LoadObjectStruct,false),true,2),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecLoadObjectStructLevel2(true);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LoadObjectStruct,true),false,2),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LoadObjectStruct,true),true,2),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecQuadroSimpleModelCCLevel1(false);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(QuadroSimpleModelCC,false),false,1),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(QuadroSimpleModelCC,false),true,1),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecQuadroSimpleModelCCLevel1(true);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(QuadroSimpleModelCC,true),false,1),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(QuadroSimpleModelCC,true),true,1),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecQuadroModelCCLevel2(false);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(QuadroModelCC,false),false,2),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(QuadroModelCC,false),true,2),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecQuadroModelCCLevel2(true);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(QuadroModelCC,true),false,2),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(QuadroModelCC,true),true,2),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecModelDataLevel2(false);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ModelData,false),false,2),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ModelData,false),true,2),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecModelDataLevel2(true);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ModelData,true),false,2),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ModelData,true),true,2),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecTestLevel3(false);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Test,false),false,3),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Test,false),true,3),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecTestLevel3(true);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Test,true),false,3),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Test,true),true,3),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecQuadroModelCCLevel1(false);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(QuadroModelCC,false),false,1),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(QuadroModelCC,false),true,1),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecQuadroModelCCLevel1(true);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(QuadroModelCC,true),false,1),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(QuadroModelCC,true),true,1),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecModelDataLevel1(false);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ModelData,false),false,1),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ModelData,false),true,1),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecModelDataLevel1(true);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ModelData,true),false,1),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ModelData,true),true,1),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecTestLevel2(false);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Test,false),false,2),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Test,false),true,2),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecTestLevel2(true);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Test,true),false,2),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Test,true),true,2),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecSelfUnloadModelCCLevel1(false);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(SelfUnloadModelCC,false),false,1),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(SelfUnloadModelCC,false),true,1),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecSelfUnloadModelCCLevel1(true);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(SelfUnloadModelCC,true),false,1),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(SelfUnloadModelCC,true),true,1),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecSelfUnloadModelCCLevel3(false);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(SelfUnloadModelCC,false),false,3),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(SelfUnloadModelCC,false),true,3),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecSelfUnloadModelCCLevel3(true);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(SelfUnloadModelCC,true),false,3),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(SelfUnloadModelCC,true),true,3),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecLoadObjectStructLevel1(false);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LoadObjectStruct,false),false,1),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LoadObjectStruct,false),true,1),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecLoadObjectStructLevel1(true);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LoadObjectStruct,true),false,1),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LoadObjectStruct,true),true,1),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecQuadroModelCCLevel3(false);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(QuadroModelCC,false),false,3),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(QuadroModelCC,false),true,3),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecQuadroModelCCLevel3(true);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(QuadroModelCC,true),false,3),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(QuadroModelCC,true),true,3),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecQuadroSimpleModelCCLevel2(false);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(QuadroSimpleModelCC,false),false,2),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(QuadroSimpleModelCC,false),true,2),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecQuadroSimpleModelCCLevel2(true);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(QuadroSimpleModelCC,true),false,2),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(QuadroSimpleModelCC,true),true,2),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecModelDataLevel3(false);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ModelData,false),false,3),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ModelData,false),true,3),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecModelDataLevel3(true);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ModelData,true),false,3),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ModelData,true),true,3),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecLoadObjectStructLevel3(false);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LoadObjectStruct,false),false,3),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LoadObjectStruct,false),true,3),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecLoadObjectStructLevel3(true);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LoadObjectStruct,true),false,3),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LoadObjectStruct,true),true,3),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecSelfUnloadModelCCLevel2(false);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(SelfUnloadModelCC,false),false,2),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(SelfUnloadModelCC,false),true,2),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecSelfUnloadModelCCLevel2(true);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(SelfUnloadModelCC,true),false,2),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(SelfUnloadModelCC,true),true,2),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecTestLevel1(false);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Test,false),false,1),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Test,false),true,1),new OptionalCodecDecorator(_loc4_));
         _loc4_ = new VectorCodecTestLevel1(true);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Test,true),false,1),_loc4_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Test,true),true,1),new OptionalCodecDecorator(_loc4_));
      }
      
      public function stop(param1:OSGi) : void
      {
      }
   }
}

