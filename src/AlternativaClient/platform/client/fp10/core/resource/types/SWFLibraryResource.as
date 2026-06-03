package platform.client.fp10.core.resource.types
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.bundle.BundleDescriptor;
   import alternativa.osgi.service.launcherparams.ILauncherParams;
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.utils.Properties;
   import flash.display.Loader;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import platform.client.fp10.core.resource.IResourceLoadingListener;
   import platform.client.fp10.core.resource.IResourceSerializationListener;
   import platform.client.fp10.core.resource.Resource;
   import platform.client.fp10.core.resource.ResourceFileInfo;
   import platform.client.fp10.core.resource.ResourceFlags;
   import platform.client.fp10.core.resource.ResourceInfo;
   import platform.client.fp10.core.resource.ResourceStatus;
   import platform.client.fp10.core.resource.SafeURLLoader;
   import platform.client.fp10.core.service.localstorage.IResourceLocalStorage;
   import platform.core.general.resource.types.swf.ResourceSWFParams;
   
   public class SWFLibraryResource extends Resource
   {
      
      [Inject]
      public static var localeService:ILocaleService;
      
      [Inject]
      public static var launcherParams:ILauncherParams;
      
      [Inject]
      public static var resourceLocalStorage:IResourceLocalStorage;
      
      private static const BASE_FILE_NAME:String = "library";
      
      private static const BASE_FILE_NAME_DEBUG:String = "debug";
      
      private var libraryResourceInfo:ResourceSWFParams;
      
      private var urlLoader:SafeURLLoader;
      
      private var bytesLoader:Loader;
      
      private var data:ByteArray;
      
      public function SWFLibraryResource(param1:ResourceInfo, param2:ResourceSWFParams)
      {
         super(param1);
         if(param2 == null)
         {
            throw new ArgumentError("Parameter libraryResourceInfo is null");
         }
         this.libraryResourceInfo = param2;
      }
      
      override public function get description() : String
      {
         return "Library";
      }
      
      override public function get classifier() : String
      {
         var _loc1_:String = localeService.language;
         var _loc2_:int = resourceInfo.locales.indexOf(_loc1_);
         if(_loc2_ < 0)
         {
            _loc1_ = localeService.defaultLanguage;
         }
         if(launcherParams.isDebug)
         {
            return _loc1_ + "-d";
         }
         return _loc1_ + "-r";
      }
      
      override public function load(param1:String, param2:IResourceLoadingListener) : void
      {
         super.load(param1,param2);
         this.doLoad();
      }
      
      private function doLoad() : void
      {
         var _loc1_:String = baseUrl + this.getFileName();
         this.urlLoader = new SafeURLLoader();
         this.urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
         this.urlLoader.addEventListener(Event.OPEN,this.onLoadingOpen);
         this.urlLoader.addEventListener(ProgressEvent.PROGRESS,this.onLoadingProgress);
         this.urlLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadingError);
         this.urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadingError);
         this.urlLoader.addEventListener(Event.COMPLETE,this.onLoadingComplete);
         this.urlLoader.load(new URLRequest(_loc1_));
         status = ResourceStatus.REQUESTED;
         startTimeoutTracking();
      }
      
      override public function get downloadSize() : int
      {
         var _loc1_:ResourceFileInfo = resourceInfo.getFileInfo(this.getFileName());
         return _loc1_ == null ? 0 : _loc1_.fileSize;
      }
      
      override public function toString() : String
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.libraryResourceInfo.keys.length)
         {
            if(this.libraryResourceInfo.keys[_loc2_] == "Bundle-Name")
            {
               _loc1_ = this.libraryResourceInfo.values[_loc2_];
               break;
            }
            _loc2_++;
         }
         return "[" + super.toString() + ", name = " + _loc1_ + "]";
      }
      
      override public function loadBytes(param1:ByteArray, param2:IResourceLoadingListener) : Boolean
      {
         this.listener = param2;
         this.loadLibraryBytes(param1);
         return true;
      }
      
      override public function serialize(param1:IResourceSerializationListener) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeBytes(this.data);
         param1.onSerializationComplete(this,_loc2_);
         this.data = null;
      }
      
      override protected function doReload() : void
      {
         this.urlLoader.close();
         this.doLoad();
      }
      
      override protected function completeLoading() : void
      {
         super.completeLoading();
         if(hasAllFlags(ResourceFlags.LOCAL) || !resourceLocalStorage.enabled)
         {
            this.data = null;
         }
      }
      
      private function getFileName() : String
      {
         var _loc1_:String = localeService.language;
         var _loc2_:int = resourceInfo.locales.indexOf(_loc1_);
         if(_loc2_ < 0)
         {
            _loc1_ = localeService.defaultLanguage;
         }
         var _loc3_:String = "_" + _loc1_ + ".swf";
         if(launcherParams.isDebug)
         {
            return BASE_FILE_NAME_DEBUG + _loc3_;
         }
         return BASE_FILE_NAME + _loc3_;
      }
      
      private function onLoadingOpen(param1:Event) : void
      {
         updateLastActivityTime();
         listener.onResourceLoadingStart(this);
      }
      
      private function onLoadingComplete(param1:Event) : void
      {
         stopTimeoutTracking();
         this.data = this.urlLoader.data;
         this.urlLoader = null;
         this.loadLibraryBytes(this.data);
      }
      
      private function loadLibraryBytes(param1:ByteArray) : void
      {
         this.bytesLoader = new Loader();
         this.bytesLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onBytesLoaded);
         this.bytesLoader.loadBytes(param1,new LoaderContext(false,ApplicationDomain.currentDomain));
      }
      
      private function onBytesLoaded(param1:Event) : void
      {
         var event:Event = param1;
         try
         {
            this.installLibrary();
            this.completeLoading();
         }
         catch(e:Error)
         {
            listener.onResourceLoadingFatalError(this,e.getStackTrace());
         }
      }
      
      private function installLibrary() : void
      {
         var _loc1_:Properties = new Properties();
         var _loc2_:Vector.<String> = this.libraryResourceInfo.keys;
         var _loc3_:Vector.<String> = this.libraryResourceInfo.values;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc1_.setProperty(_loc2_[_loc4_],_loc3_[_loc4_]);
            _loc4_++;
         }
         OSGi.getInstance().installBundle(new BundleDescriptor(_loc1_));
      }
      
      private function onLoadingProgress(param1:ProgressEvent) : void
      {
         updateLastActivityTime();
         listener.onResourceLoadingProgress(this,param1.bytesLoaded);
      }
      
      private function onLoadingError(param1:ErrorEvent) : void
      {
         stopTimeoutTracking();
         listener.onResourceLoadingFatalError(this,param1.toString());
      }
   }
}

