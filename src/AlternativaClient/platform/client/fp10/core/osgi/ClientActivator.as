package platform.client.fp10.core.osgi
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.bundle.IBundleActivator;
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.osgi.service.dump.IDumpService;
   import alternativa.osgi.service.launcherparams.ILauncherParams;
   import alternativa.osgi.service.network.INetworkService;
   import alternativa.protocol.IProtocol;
   import alternativa.startup.LibraryInfo;
   import flash.events.Event;
   import flash.utils.setTimeout;
   import platform.client.fp10.core.dispatcher.DispatcherItem;
   import platform.client.fp10.core.dumpers.ClassDumper;
   import platform.client.fp10.core.dumpers.ModelDumper;
   import platform.client.fp10.core.dumpers.ObjectDumper;
   import platform.client.fp10.core.dumpers.ResourceDumper;
   import platform.client.fp10.core.dumpers.SpaceDumper;
   import platform.client.fp10.core.network.Connection;
   import platform.client.fp10.core.network.command.ControlCommand;
   import platform.client.fp10.core.network.command.SpaceCommand;
   import platform.client.fp10.core.network.handler.ControlCommandHandler;
   import platform.client.fp10.core.protocol.codec.ControlRootCodec;
   import platform.client.fp10.core.protocol.codec.DispatcherItemCodec;
   import platform.client.fp10.core.protocol.codec.GameObjectCodec;
   import platform.client.fp10.core.protocol.codec.SpaceRootCodec;
   import platform.client.fp10.core.registry.GameTypeRegistry;
   import platform.client.fp10.core.registry.ModelRegistry;
   import platform.client.fp10.core.registry.ResourceRegistry;
   import platform.client.fp10.core.registry.SpaceRegistry;
   import platform.client.fp10.core.registry.impl.GameTypeRegistryImpl;
   import platform.client.fp10.core.registry.impl.ModelsRegistryImpl;
   import platform.client.fp10.core.registry.impl.ResourceRegistryImpl;
   import platform.client.fp10.core.registry.impl.SpaceRegistryImpl;
   import platform.client.fp10.core.resource.IResourceLoader;
   import platform.client.fp10.core.resource.IResourceLocalStorageInternal;
   import platform.client.fp10.core.resource.LibraryResourceWrapper;
   import platform.client.fp10.core.resource.ResourceLoader;
   import platform.client.fp10.core.resource.ResourceLocalStorage;
   import platform.client.fp10.core.resource.ResourceTimer;
   import platform.client.fp10.core.resource.ResourceType;
   import platform.client.fp10.core.resource.types.ImageResource;
   import platform.client.fp10.core.resource.types.MultiframeImageResource;
   import platform.client.fp10.core.resource.types.Resource3DS;
   import platform.client.fp10.core.resource.types.SWFLibraryResource;
   import platform.client.fp10.core.resource.types.SoundResource;
   import platform.client.fp10.core.service.IResourceTimer;
   import platform.client.fp10.core.service.address.AddressService;
   import platform.client.fp10.core.service.address.impl.AddressServiceImpl;
   import platform.client.fp10.core.service.loadingprogress.ILoadingProgressService;
   import platform.client.fp10.core.service.localstorage.IResourceLocalStorage;
   import platform.client.fp10.core.service.messagebox.IMessageBoxService;
   import platform.client.fp10.core.service.messagebox.impl.MessageBoxService;
   import platform.client.fp10.core.service.serverlog.IServerLog;
   import platform.client.fp10.core.service.serverlog.impl.DebugServerLogService;
   import platform.client.fp10.core.service.serverlog.impl.ReleaseServerLogService;
   import platform.client.fp10.core.type.IGameObject;
   import platform.core.general.resource.types.image.ResourceImageParams;
   import platform.core.general.resource.types.imageframe.ResourceImageFrameParams;
   import platform.core.general.resource.types.swf.ResourceSWFParams;
   import swfaddress.SWFAddressEvent;
   
   public class ClientActivator implements IBundleActivator
   {
      
      private var osgi:OSGi;
      
      private var connection:Connection;
      
      private var protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      
      public function ClientActivator()
      {
         super();
      }
      
      public function start(param1:OSGi) : void
      {
         this.osgi = param1;
         this.registerCodecs();
         this.registerServices();
         this.registerDumpers();
         this.registerResources();
         this.createConnection();
         this.registerServerLog();
         setTimeout(this.completeInitialization,100);
      }
      
      public function stop(param1:OSGi) : void
      {
      }
      
      private function registerCodecs() : void
      {
         this.protocol.registerCodecForType(ControlCommand,new ControlRootCodec());
         this.protocol.registerCodecForType(SpaceCommand,new SpaceRootCodec());
         this.protocol.registerCodecForType(IGameObject,new GameObjectCodec());
         this.protocol.registerCodecForType(DispatcherItem,new DispatcherItemCodec());
      }
      
      private function registerServices() : void
      {
         this.osgi.registerService(GameTypeRegistry,new GameTypeRegistryImpl());
         this.osgi.registerService(SpaceRegistry,new SpaceRegistryImpl());
         this.osgi.registerService(ModelRegistry,new ModelsRegistryImpl());
         this.osgi.registerServiceMulty([IResourceLocalStorage,IResourceLocalStorageInternal],new ResourceLocalStorage(this.osgi));
         this.osgi.registerService(IResourceLoader,new ResourceLoader());
         var _loc1_:ResourceRegistryImpl = new ResourceRegistryImpl();
         this.osgi.registerService(ResourceRegistry,_loc1_);
         this.osgi.registerService(ILoadingProgressService,_loc1_);
         this.osgi.registerService(IMessageBoxService,new MessageBoxService(this.osgi));
         this.registerAddressService();
         this.osgi.registerService(IResourceTimer,new ResourceTimer());
      }
      
      private function registerAddressService() : void
      {
         var addressService:AddressService = new AddressServiceImpl();
         if(Boolean(addressService.getBaseURL()) && addressService.getBaseURL() != "undefined")
         {
            this.osgi.registerService(AddressService,addressService);
            addressService.addEventListener(SWFAddressEvent.CHANGE,function(param1:Event):void
            {
            });
         }
      }
      
      private function registerDumpers() : void
      {
         var _loc1_:IDumpService = IDumpService(this.osgi.getService(IDumpService));
         _loc1_.registerDumper(new SpaceDumper(this.osgi));
         _loc1_.registerDumper(new ObjectDumper(this.osgi));
         _loc1_.registerDumper(new ClassDumper(this.osgi));
         _loc1_.registerDumper(new ResourceDumper());
         _loc1_.registerDumper(new ModelDumper(this.osgi));
      }
      
      private function registerResources() : void
      {
         var _loc1_:ResourceRegistry = ResourceRegistry(this.osgi.getService(ResourceRegistry));
         _loc1_.registerTypeClasses(ResourceType.SWF_LIBRARY,SWFLibraryResource,ResourceSWFParams);
         _loc1_.registerTypeClasses(ResourceType.IMAGE,ImageResource,ResourceImageParams);
         _loc1_.registerTypeClasses(ResourceType.MULTIFRAME_IMAGE,MultiframeImageResource,ResourceImageFrameParams);
         _loc1_.registerTypeClasses(ResourceType.SOUND,SoundResource);
         _loc1_.registerTypeClasses(ResourceType.MODEL_3DS,Resource3DS);
      }
      
      private function createConnection() : void
      {
         this.connection = new Connection(this.protocol,new ControlRootCodec(),new ControlCommandHandler(this.osgi));
      }
      
      private function registerServerLog() : void
      {
         var _loc2_:IDisplay = null;
         var _loc1_:ILauncherParams = ILauncherParams(this.osgi.getService(ILauncherParams));
         if(_loc1_.isDebug)
         {
            _loc2_ = IDisplay(this.osgi.getService(IDisplay));
            this.osgi.registerService(IServerLog,new DebugServerLogService(this.connection,_loc2_.stage));
         }
         else
         {
            this.osgi.registerService(IServerLog,new ReleaseServerLogService());
         }
      }
      
      private function completeInitialization() : void
      {
         this.registerStartupLibraries();
         this.connectToServer();
      }
      
      private function registerStartupLibraries() : void
      {
         var _loc3_:LibraryInfo = null;
         var _loc1_:ILauncherParams = ILauncherParams(this.osgi.getService(ILauncherParams));
         var _loc2_:ResourceRegistry = ResourceRegistry(this.osgi.getService(ResourceRegistry));
         for each(_loc3_ in _loc1_.startupLibraryInfos)
         {
            _loc2_.registerResource(new LibraryResourceWrapper(_loc3_));
         }
      }
      
      private function connectToServer() : void
      {
         var _loc1_:INetworkService = INetworkService(this.osgi.getService(INetworkService));
         this.connection.connect(_loc1_.controlServerAddress,_loc1_.controlServerPorts);
      }
   }
}

