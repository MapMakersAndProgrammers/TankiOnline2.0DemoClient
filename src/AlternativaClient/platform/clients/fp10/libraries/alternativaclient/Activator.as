package platform.clients.fp10.libraries.alternativaclient
{
   import _codec.platform.client.fp10.core.dispatcher.VectorCodecDispatcherItemLevel1;
   import _codec.platform.client.fp10.core.dispatcher.VectorCodecDispatcherItemLevel2;
   import _codec.platform.client.fp10.core.dispatcher.VectorCodecDispatcherItemLevel3;
   import _codec.platform.client.fp10.core.resource.types.VectorCodecMultiframeImageResourceLevel1;
   import _codec.platform.client.fp10.core.resource.types.VectorCodecMultiframeImageResourceLevel2;
   import _codec.platform.client.fp10.core.resource.types.VectorCodecMultiframeImageResourceLevel3;
   import _codec.platform.client.fp10.core.type.VectorCodecIGameObjectLevel1;
   import _codec.platform.client.fp10.core.type.VectorCodecIGameObjectLevel2;
   import _codec.platform.client.fp10.core.type.VectorCodecIGameObjectLevel3;
   import alternativa.osgi.OSGi;
   import alternativa.osgi.bundle.IBundleActivator;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.osgi.service.console.IConsole;
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.osgi.service.launcherparams.ILauncherParams;
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.osgi.service.network.INetworkService;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.codec.OptionalCodecDecorator;
   import alternativa.protocol.impl.Protocol;
   import alternativa.protocol.info.CollectionCodecInfo;
   import alternativa.protocol.info.TypeCodecInfo;
   import platform.client.fp10.core.dispatcher.Dispatcher;
   import platform.client.fp10.core.dispatcher.DispatcherItem;
   import platform.client.fp10.core.dumpers.ResourceDumper;
   import platform.client.fp10.core.model.IObjectLoadListener;
   import platform.client.fp10.core.model.IObjectLoadListenerAdapt;
   import platform.client.fp10.core.model.IObjectLoadListenerEvents;
   import platform.client.fp10.core.network.Connection;
   import platform.client.fp10.core.network.command.control.server.LoadDependenciesCommandCodec;
   import platform.client.fp10.core.network.command.control.server.OpenSpaceCommand;
   import platform.client.fp10.core.network.command.control.server.UnloadDependenciesCommand;
   import platform.client.fp10.core.network.handler.ControlCommandHandler;
   import platform.client.fp10.core.network.handler.SpaceCommandHandler;
   import platform.client.fp10.core.protocol.codec.ControlRootCodec;
   import platform.client.fp10.core.protocol.codec.DispatcherItemCodec;
   import platform.client.fp10.core.protocol.codec.GameObjectCodec;
   import platform.client.fp10.core.protocol.codec.SpaceRootCodec;
   import platform.client.fp10.core.registry.GameTypeRegistry;
   import platform.client.fp10.core.registry.ModelRegistry;
   import platform.client.fp10.core.registry.ResourceRegistry;
   import platform.client.fp10.core.registry.SpaceRegistry;
   import platform.client.fp10.core.registry.impl.DebugProgressIndicator;
   import platform.client.fp10.core.registry.impl.ModelsRegistryImpl;
   import platform.client.fp10.core.registry.impl.ResourceRegistryImpl;
   import platform.client.fp10.core.resource.BatchResourceLoader;
   import platform.client.fp10.core.resource.IResourceLoader;
   import platform.client.fp10.core.resource.Resource;
   import platform.client.fp10.core.resource.ResourceLoader;
   import platform.client.fp10.core.resource.ResourceTimer;
   import platform.client.fp10.core.resource.types.ImageResource;
   import platform.client.fp10.core.resource.types.MultiframeImageResource;
   import platform.client.fp10.core.resource.types.Resource3DS;
   import platform.client.fp10.core.resource.types.SWFLibraryResource;
   import platform.client.fp10.core.service.IResourceTimer;
   import platform.client.fp10.core.service.localstorage.IResourceLocalStorage;
   import platform.client.fp10.core.service.messagebox.IMessageBoxService;
   import platform.client.fp10.core.service.serverlog.IServerLog;
   import platform.client.fp10.core.type.IGameObject;
   import platform.client.fp10.core.type.impl.GameObject;
   import platform.client.fp10.core.type.impl.Space;
   
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
         _loc2_ = new VectorCodecDispatcherItemLevel1(false);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(DispatcherItem,false),false,1),_loc2_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(DispatcherItem,false),true,1),new OptionalCodecDecorator(_loc2_));
         _loc2_ = new VectorCodecDispatcherItemLevel1(true);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(DispatcherItem,true),false,1),_loc2_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(DispatcherItem,true),true,1),new OptionalCodecDecorator(_loc2_));
         _loc2_ = new VectorCodecDispatcherItemLevel2(false);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(DispatcherItem,false),false,2),_loc2_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(DispatcherItem,false),true,2),new OptionalCodecDecorator(_loc2_));
         _loc2_ = new VectorCodecDispatcherItemLevel2(true);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(DispatcherItem,true),false,2),_loc2_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(DispatcherItem,true),true,2),new OptionalCodecDecorator(_loc2_));
         _loc2_ = new VectorCodecDispatcherItemLevel3(false);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(DispatcherItem,false),false,3),_loc2_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(DispatcherItem,false),true,3),new OptionalCodecDecorator(_loc2_));
         _loc2_ = new VectorCodecDispatcherItemLevel3(true);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(DispatcherItem,true),false,3),_loc2_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(DispatcherItem,true),true,3),new OptionalCodecDecorator(_loc2_));
         _loc2_ = new VectorCodecIGameObjectLevel1(false);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,false),false,1),_loc2_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,false),true,1),new OptionalCodecDecorator(_loc2_));
         _loc2_ = new VectorCodecIGameObjectLevel1(true);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,true),false,1),_loc2_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,true),true,1),new OptionalCodecDecorator(_loc2_));
         _loc2_ = new VectorCodecIGameObjectLevel2(false);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,false),false,2),_loc2_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,false),true,2),new OptionalCodecDecorator(_loc2_));
         _loc2_ = new VectorCodecIGameObjectLevel2(true);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,true),false,2),_loc2_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,true),true,2),new OptionalCodecDecorator(_loc2_));
         _loc2_ = new VectorCodecIGameObjectLevel3(false);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,false),false,3),_loc2_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,false),true,3),new OptionalCodecDecorator(_loc2_));
         _loc2_ = new VectorCodecIGameObjectLevel3(true);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,true),false,3),_loc2_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,true),true,3),new OptionalCodecDecorator(_loc2_));
         _loc2_ = new VectorCodecMultiframeImageResourceLevel1(false);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(MultiframeImageResource,false),false,1),_loc2_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(MultiframeImageResource,false),true,1),new OptionalCodecDecorator(_loc2_));
         _loc2_ = new VectorCodecMultiframeImageResourceLevel1(true);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(MultiframeImageResource,true),false,1),_loc2_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(MultiframeImageResource,true),true,1),new OptionalCodecDecorator(_loc2_));
         _loc2_ = new VectorCodecMultiframeImageResourceLevel2(false);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(MultiframeImageResource,false),false,2),_loc2_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(MultiframeImageResource,false),true,2),new OptionalCodecDecorator(_loc2_));
         _loc2_ = new VectorCodecMultiframeImageResourceLevel2(true);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(MultiframeImageResource,true),false,2),_loc2_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(MultiframeImageResource,true),true,2),new OptionalCodecDecorator(_loc2_));
         _loc2_ = new VectorCodecMultiframeImageResourceLevel3(false);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(MultiframeImageResource,false),false,3),_loc2_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(MultiframeImageResource,false),true,3),new OptionalCodecDecorator(_loc2_));
         _loc2_ = new VectorCodecMultiframeImageResourceLevel3(true);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(MultiframeImageResource,true),false,3),_loc2_);
         _loc3_.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(MultiframeImageResource,true),true,3),new OptionalCodecDecorator(_loc2_));
         osgi.injectService(IClientLog,Connection,"clientLog");
         osgi.injectService(IMessageBoxService,Connection,"messageBoxService");
         osgi.injectService(INetworkService,Connection,"networkService");
         osgi.injectService(ILauncherParams,Connection,"loaderParams");
         osgi.injectService(IServerLog,SpaceCommandHandler,"serverLog");
         osgi.injectService(IClientLog,SpaceCommandHandler,"clientLog");
         osgi.injectService(SpaceRegistry,SpaceCommandHandler,"spaceRegistry");
         osgi.injectService(ModelRegistry,SpaceCommandHandler,"modelRegistry");
         osgi.injectService(IProtocol,SpaceCommandHandler,"protocol");
         osgi.injectService(IClientLog,ControlCommandHandler,"clientLog");
         osgi.injectService(IMessageBoxService,ControlCommandHandler,"messageBoxService");
         osgi.injectService(SpaceRegistry,ControlCommandHandler,"spaceRegistry");
         osgi.injectService(IClientLog,LoadDependenciesCommandCodec,"clientLog");
         osgi.injectService(GameTypeRegistry,UnloadDependenciesCommand,"gameTypeRegistry");
         osgi.injectService(ResourceRegistry,UnloadDependenciesCommand,"resourceRegistry");
         osgi.injectService(SpaceRegistry,OpenSpaceCommand,"spaceRegistry");
         osgi.injectService(ModelRegistry,GameObject,"modelRegistry");
         osgi.injectService(IServerLog,GameObject,"serverLog");
         osgi.injectService(IClientLog,Space,"clientLog");
         osgi.injectService(IServerLog,Space,"serverLog");
         osgi.injectService(IMessageBoxService,Space,"messageBoxService");
         osgi.injectService(IClientLog,ModelsRegistryImpl,"clientLog");
         osgi.injectService(IServerLog,ModelsRegistryImpl,"logger");
         osgi.injectService(IProtocol,ModelsRegistryImpl,"protocol");
         osgi.injectService(IClientLog,ResourceRegistryImpl,"clientLog");
         osgi.injectService(IResourceLoader,ResourceRegistryImpl,"resourceLoader");
         osgi.injectService(IDisplay,DebugProgressIndicator,"display");
         osgi.injectService(IResourceLocalStorage,Resource3DS,"resourceLocalStorage");
         osgi.injectService(IClientLog,Resource3DS,"clientLog");
         osgi.injectService(IResourceLocalStorage,ImageResource,"resourceLocalStorage");
         osgi.injectService(IResourceLocalStorage,MultiframeImageResource,"resourceLocalStorage");
         osgi.injectService(ILocaleService,SWFLibraryResource,"localeService");
         osgi.injectService(ILauncherParams,SWFLibraryResource,"launcherParams");
         osgi.injectService(IResourceLocalStorage,SWFLibraryResource,"resourceLocalStorage");
         osgi.injectService(IServerLog,BatchResourceLoader,"logService");
         osgi.injectService(IClientLog,BatchResourceLoader,"clientLog");
         osgi.injectService(IMessageBoxService,BatchResourceLoader,"messageBoxService");
         osgi.injectService(IResourceLoader,BatchResourceLoader,"resourceLoader");
         osgi.injectService(IClientLog,ResourceLoader,"clientLog");
         osgi.injectService(IResourceLocalStorage,ResourceLoader,"localStorage");
         osgi.injectService(INetworkService,ResourceLoader,"networkSerice");
         osgi.injectService(ResourceRegistry,Resource,"resourceRegistry");
         osgi.injectService(IResourceTimer,Resource,"resourceTimer");
         osgi.injectService(IClientLog,Resource,"clientLog");
         osgi.injectService(IConsole,ResourceTimer,"console");
         osgi.injectService(IClientLog,ResourceTimer,"clientLog");
         osgi.injectService(IMessageBoxService,Dispatcher,"messageBoxService");
         osgi.injectService(ResourceRegistry,Dispatcher,"resourceRegistry");
         osgi.injectService(GameTypeRegistry,Dispatcher,"gameTypeRegistry");
         osgi.injectService(ModelRegistry,Dispatcher,"modelRegistry");
         osgi.injectService(IClientLog,Dispatcher,"clientLog");
         osgi.injectService(IServerLog,Dispatcher,"serverLog");
         osgi.injectService(ResourceRegistry,ResourceDumper,"resourceRegistry");
         osgi.injectService(SpaceRegistry,GameObjectCodec,"spaceRegistry");
         osgi.injectService(IClientLog,SpaceRootCodec,"clientLog");
         osgi.injectService(IClientLog,ControlRootCodec,"clientLog");
         osgi.injectService(IServerLog,ControlRootCodec,"logger");
         osgi.injectService(IServerLog,DispatcherItemCodec,"logger");
         osgi.injectService(IClientLog,DispatcherItemCodec,"clientLog");
         osgi.injectService(ModelRegistry,DispatcherItemCodec,"modelRegistry");
         var _loc4_:ModelRegistry = osgi.getService(ModelRegistry) as ModelRegistry;
         _loc4_.registerAdapt(IObjectLoadListener,IObjectLoadListenerAdapt);
         _loc4_.registerEvents(IObjectLoadListener,IObjectLoadListenerEvents);
      }
      
      public function stop(param1:OSGi) : void
      {
      }
   }
}

