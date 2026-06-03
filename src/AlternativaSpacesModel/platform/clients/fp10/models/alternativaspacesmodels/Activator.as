package platform.clients.fp10.models.alternativaspacesmodels
{
   import _codec.platform.client.core.general.spaces.models.dispatcher.VectorCodecLoadObjectStructLevel1;
   import _codec.platform.client.core.general.spaces.models.dispatcher.VectorCodecLoadObjectStructLevel2;
   import _codec.platform.client.core.general.spaces.models.dispatcher.VectorCodecLoadObjectStructLevel3;
   import alternativa.model.general.dispatcher.*;
   import alternativa.model.general.quadro.*;
   import alternativa.osgi.OSGi;
   import alternativa.osgi.bundle.IBundleActivator;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.codec.ModelDataCodecHook;
   import alternativa.protocol.codec.OptionalCodecDecorator;
   import alternativa.protocol.impl.Protocol;
   import alternativa.protocol.info.CollectionCodecInfo;
   import alternativa.protocol.info.TypeCodecInfo;
   import platform.client.core.general.spaces.models.dispatcher.IDispatcherModelBase;
   import platform.client.core.general.spaces.models.dispatcher.LoadObjectStruct;
   import platform.client.core.general.spaces.models.quadro.IQuadroModelBase;
   import platform.client.fp10.core.model.IObjectLoadListener;
   import platform.client.fp10.core.registry.GameTypeRegistry;
   import platform.client.fp10.core.registry.ModelRegistry;
   import platform.client.fp10.core.registry.SpaceRegistry;
   import platform.client.fp10.core.service.serverlog.IServerLog;
   
   public class Activator implements IBundleActivator
   {
      
      public static var osgi:OSGi;
      
      public function Activator()
      {
         super();
      }
      
      public function start(param1:OSGi) : void
      {
         var _loc2_:ICodec = null;
         osgi = param1;
         var _loc3_:IProtocol = Protocol.defaultInstance;
         _loc2_ = new VectorCodecLoadObjectStructLevel1(false);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LoadObjectStruct,false),false,1),_loc2_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LoadObjectStruct,false),true,1),new OptionalCodecDecorator(_loc2_));
         _loc2_ = new VectorCodecLoadObjectStructLevel1(true);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LoadObjectStruct,true),false,1),_loc2_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LoadObjectStruct,true),true,1),new OptionalCodecDecorator(_loc2_));
         _loc2_ = new VectorCodecLoadObjectStructLevel2(false);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LoadObjectStruct,false),false,2),_loc2_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LoadObjectStruct,false),true,2),new OptionalCodecDecorator(_loc2_));
         _loc2_ = new VectorCodecLoadObjectStructLevel2(true);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LoadObjectStruct,true),false,2),_loc2_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LoadObjectStruct,true),true,2),new OptionalCodecDecorator(_loc2_));
         _loc2_ = new VectorCodecLoadObjectStructLevel3(false);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LoadObjectStruct,false),false,3),_loc2_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LoadObjectStruct,false),true,3),new OptionalCodecDecorator(_loc2_));
         _loc2_ = new VectorCodecLoadObjectStructLevel3(true);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LoadObjectStruct,true),false,3),_loc2_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LoadObjectStruct,true),true,3),new OptionalCodecDecorator(_loc2_));
         osgi.injectService(IServerLog,DispatcherModel,"serverLog");
         osgi.injectService(IClientLog,DispatcherModel,"clientLog");
         osgi.injectService(GameTypeRegistry,DispatcherModel,"classRegister");
         osgi.injectService(ModelRegistry,DispatcherModel,"modelRegister");
         osgi.injectService(SpaceRegistry,DispatcherModel,"spaceService");
         osgi.injectService(IDisplay,QuadroModel,"display");
         osgi.injectService(ILocaleService,QuadroModel,"localeService");
         osgi.injectService(IClientLog,QuadroModel,"clientLog");
         osgi.injectService(IClientLog,ModelDataCodecHook,"clientLog");
         osgi.injectService(ModelRegistry,ModelDataCodecHook,"modelRegister");
         var _loc4_:ModelRegistry = osgi.getService(ModelRegistry) as ModelRegistry;
         _loc4_.add(new DispatcherModel(),Vector.<Class>([IDispatcherModelBase]));
         var _loc5_:ModelRegistry = osgi.getService(ModelRegistry) as ModelRegistry;
         _loc5_.registerAdapt(IQuadro,IQuadroAdapt);
         _loc5_.registerEvents(IQuadro,IQuadroEvents);
         _loc4_.add(new QuadroModel(),Vector.<Class>([IQuadroModelBase,IObjectLoadListener,IQuadro]));
      }
      
      public function stop(param1:OSGi) : void
      {
      }
   }
}

