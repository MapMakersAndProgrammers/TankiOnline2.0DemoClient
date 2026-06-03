package alternativa
{
   import alternativa.osgi.OSGi;
   import alternativa.startup.ConnectionParameters;
   import alternativa.startup.IClientConfigurator;
   import alternativa.startup.LibraryInfo;
   import alternativa.utils.LoaderUtils;
   import alternativa.utils.Properties;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.SecurityDomain;
   import flash.utils.ByteArray;
   
   public class Launcher
   {
      
      private static const PARAM_DEBUG:String = "debug";
      
      private static const PARAM_RESOURCES_ROOT_URL:String = "resources";
      
      private static const PARAM_CONFIG_URL:String = "config";
      
      private static const SERVER_STATUS_NORMAL:String = "normal";
      
      private static const SERVER_STATUS_OVERLOADED:String = "overloaded";
      
      private static const SERVER_STATUS_UNAVAILABLE:String = "unavailable";
      
      private static const RESOURCES_ROOT:String = "resources";
      
      private static const OSGI_MANIFEST_CLASS_KEY:String = "Main-Class";
      
      private var container:DisplayObjectContainer;
      
      private var loaderInfo:LoaderInfo;
      
      private var listener:ILauncherListener;
      
      private var osgi:OSGi;
      
      private var debugMode:Boolean;
      
      private var logOutput:LogOutput;
      
      private var resourcesRootURL:String;
      
      private var serverAddress:String;
      
      private var serverPorts:Vector.<int>;
      
      private var libraryInfos:Vector.<LibraryInfo>;
      
      private var libraryIndex:int;
      
      private var logStrings:Vector.<String> = new Vector.<String>();
      
      private var configLoader:URLLoader;
      
      private var libBytesTotal:uint;
      
      private var libBytesLoaded:uint;
      
      public function Launcher(container:DisplayObjectContainer, loaderInfo:LoaderInfo, listener:ILauncherListener = null)
      {
         super();
         if(container == null)
         {
            throw new ArgumentError("Parameter container is null");
         }
         if(loaderInfo == null)
         {
            throw new ArgumentError("Parameter loaderInfo is null");
         }
         this.osgi = new OSGi();
         this.debugMode = loaderInfo.parameters[PARAM_DEBUG];
         if(this.debugMode)
         {
            this.logOutput = new LogOutput();
            container.addChild(this.logOutput);
         }
         this.log("Debug mode: " + this.debugMode);
         this.container = container;
         this.loaderInfo = loaderInfo;
         this.listener = listener || new DummyListener(this.logOutput);
      }
      
      public function start() : void
      {
         this.resourcesRootURL = this.makeResourcesRootURL();
         this.log("Resources root URL is set to " + this.resourcesRootURL);
         this.loadServerConfiguration();
      }
      
      private function makeResourcesRootURL() : String
      {
         var rootPath:String = null;
         var url:URL = new URL(this.loaderInfo.loaderURL);
         var result:String = this.loaderInfo.parameters[PARAM_RESOURCES_ROOT_URL];
         if(result == null)
         {
            rootPath = url.path.substring(0,url.path.lastIndexOf("/") + 1);
            result = rootPath + RESOURCES_ROOT;
         }
         else if(result.length > 0 && result.charAt(0) != "/")
         {
            result = url.path.substring(0,url.path.lastIndexOf("/") + 1) + result;
         }
         return url.getRoot() + result;
      }
      
      private function loadServerConfiguration() : void
      {
         var configURL:String = "http://" + this.loaderInfo.parameters[PARAM_CONFIG_URL] + "?rnd=" + Math.random();
         this.log("Loading server configuration from " + configURL);
         this.configLoader = new URLLoader(new URLRequest(configURL));
         this.configLoader.addEventListener(Event.COMPLETE,this.onServerConfigLoadingComplete);
         this.configLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onServerConfigLoadingError);
         this.configLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onServerConfigLoadingError);
         this.configLoader.addEventListener(ProgressEvent.PROGRESS,this.onServerConfigLoadingProgress);
         this.listener.onConfigLoadingStart();
      }
      
      private function onServerConfigLoadingProgress(event:ProgressEvent) : void
      {
         this.listener.onConfigLoadingProgress(event.bytesLoaded,event.bytesTotal);
      }
      
      private function onServerConfigLoadingComplete(e:Event) : void
      {
         var portXML:XML = null;
         var pluginXML:XML = null;
         var libraryInfo:LibraryInfo = null;
         this.listener.onConfigLoadingComplete();
         var configXML:XML = XML(this.configLoader.data);
         this.configLoader = null;
         var ns:Namespace = configXML.namespace();
         var serverStatus:String = configXML.ns::status.toString();
         switch(serverStatus)
         {
            case SERVER_STATUS_OVERLOADED:
               this.listener.onServerOverloaded();
               return;
            case SERVER_STATUS_UNAVAILABLE:
               this.listener.onServerUnavailable();
               return;
            default:
               this.serverAddress = configXML.ns::server.@address;
               this.log("Server address: " + this.serverAddress);
               this.serverPorts = new Vector.<int>();
               for each(portXML in configXML.ns::server.ns::ports.ns::port)
               {
                  this.serverPorts.push(int(portXML));
               }
               this.log("Ports: " + this.serverPorts.join(", "));
               this.libraryInfos = new Vector.<LibraryInfo>();
               this.log("Startup libraries:");
               for each(pluginXML in configXML.ns::plugins.ns::plugin)
               {
                  libraryInfo = this.parseLibraryInfo(pluginXML);
                  this.libraryInfos.push(libraryInfo);
                  this.log(libraryInfo.toString());
                  this.log("bytesTotal: " + this.libBytesTotal);
               }
               this.listener.onLibrariesLoadingStart();
               this.loadLibrary();
               return;
         }
      }
      
      private function parseLibraryInfo(pluginXML:XML) : LibraryInfo
      {
         var ns:Namespace = null;
         var name:String = null;
         var id:String = null;
         var version:String = null;
         var manifestProperties:Properties = null;
         var manifestPropertyXML:XML = null;
         var size:int = 0;
         ns = pluginXML.namespace();
         name = pluginXML.@name;
         id = pluginXML.@id;
         version = pluginXML.@version;
         manifestProperties = new Properties();
         for each(manifestPropertyXML in pluginXML.ns::manifest.ns::property)
         {
            manifestProperties.setProperty(manifestPropertyXML.@name,manifestPropertyXML.toString());
         }
         size = int(pluginXML.ns::files.ns::file.(@name == getLibraryFileName()).ns::size);
         this.libBytesTotal += size;
         return new LibraryInfo(name,id,version,manifestProperties,size);
      }
      
      private function getLibraryFileName() : String
      {
         return this.debugMode ? "debug_en.swf" : "library_en.swf";
      }
      
      private function loadLibrary() : void
      {
         var libraryInfo:LibraryInfo = this.libraryInfos[this.libraryIndex];
         var libraryURL:String = this.resourcesRootURL + LoaderUtils.getResourcePath(this.hexStringToByteArray(libraryInfo.resourceId),uint("0x" + libraryInfo.resourceVersion));
         libraryURL += this.getLibraryFileName();
         this.log("Loading library " + libraryInfo.name + " from " + libraryURL);
         var loader:Loader = new Loader();
         libraryInfo.loader = loader;
         var loaderInfo:LoaderInfo = loader.contentLoaderInfo;
         loaderInfo.addEventListener(Event.COMPLETE,this.onLibraryLoadingComplete);
         loaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onLibraryLoadingError);
         loaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLibraryLoadingError);
         loaderInfo.addEventListener(ProgressEvent.PROGRESS,this.onLibraryLoadingProgress);
         loader.load(new URLRequest(libraryURL),new LoaderContext(true,ApplicationDomain.currentDomain,SecurityDomain.currentDomain));
      }
      
      private function onLibraryLoadingProgress(event:ProgressEvent) : void
      {
         this.listener.onLibrariesLoadingProgress(this.libBytesLoaded + event.bytesLoaded,this.libBytesTotal);
      }
      
      private function onLibraryLoadingComplete(e:Event) : void
      {
         var loaderInfo:LoaderInfo = LoaderInfo(e.target);
         loaderInfo.removeEventListener(Event.COMPLETE,this.onLibraryLoadingComplete);
         loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onLibraryLoadingError);
         loaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLibraryLoadingError);
         this.libBytesLoaded += this.libraryInfos[this.libraryIndex].size;
         if(++this.libraryIndex == this.libraryInfos.length)
         {
            this.listener.onLibrariesLoadingComplete();
            this.initLibraries();
            this.listener.onLibrariesInitialized();
         }
         else
         {
            this.loadLibrary();
         }
      }
      
      private function hexStringToByteArray(hexString:String) : ByteArray
      {
         var result:ByteArray = new ByteArray();
         var len:int = hexString.length;
         if(len <= 8)
         {
            result.writeInt(0);
            result.writeInt(int("0x" + hexString));
         }
         else
         {
            result.writeInt(int("0x" + hexString.substr(0,len - 8)));
            result.writeInt(int("0x" + hexString.substr(len - 8)));
         }
         result.position = 0;
         return result;
      }
      
      private function initLibraries() : void
      {
         var urlParams:Properties;
         var connectionParams:ConnectionParameters;
         var configuratorClass:Class = null;
         var osgiLibraryInfo:LibraryInfo = this.libraryInfos.shift();
         var configuratorClassName:String = osgiLibraryInfo.manifestProperties.getProperty(OSGI_MANIFEST_CLASS_KEY);
         if(!configuratorClassName)
         {
            this.log("Configurator class name not found");
            return;
         }
         try
         {
            configuratorClass = Class(ApplicationDomain.currentDomain.getDefinition(configuratorClassName));
         }
         catch(e:Error)
         {
            log(e.getStackTrace());
            return;
         }
         this.log("Initializing libraries");
         if(this.debugMode)
         {
            this.logOutput.parent.removeChild(this.logOutput);
         }
         urlParams = new Properties(this.loaderInfo.parameters);
         connectionParams = new ConnectionParameters(this.serverAddress,this.serverPorts,this.resourcesRootURL);
         IClientConfigurator(new configuratorClass()).start(this.container,urlParams,this.libraryInfos,connectionParams,this.logStrings);
      }
      
      private function onServerConfigLoadingError(e:ErrorEvent) : void
      {
         this.log(e.text);
         this.listener.onConfigLoadingError(e.text);
      }
      
      private function onLibraryLoadingError(e:IOErrorEvent) : void
      {
         this.log(e.text);
         this.listener.onLibraryLoadingError(e.text);
      }
      
      private function log(text:String) : void
      {
         this.logStrings.push(text);
         if(this.debugMode)
         {
            this.logOutput.addLine(text);
         }
      }
   }
}

import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.text.TextField;
import flash.text.TextFormat;
import alternativa.ILauncherListener;

class URL
{
   
   public var scheme:String;
   
   public var host:String;
   
   public var port:String;
   
   public var path:String;
   
   public var query:String;
   
   public var fragment:String;
   
   public function URL(url:String)
   {
      super();
      var index:int = url.indexOf(":");
      this.scheme = url.substring(0,index);
      url = url.substring(index + 3);
      index = url.indexOf("/");
      var s:String = url.substring(0,index);
      var i:int = s.indexOf(":");
      if(i < 0)
      {
         this.host = s;
      }
      else
      {
         this.host = s.substring(0,i);
         this.port = s.substring(i + 1);
      }
      url = url.substring(index);
      var queryIndex:int = url.indexOf("?");
      var hashIndex:int = url.indexOf("#");
      if(queryIndex > -1)
      {
         this.path = url.substring(0,queryIndex);
         if(hashIndex > -1)
         {
            this.query = url.substring(queryIndex + 1,hashIndex);
            this.fragment = url.substring(hashIndex + 1);
         }
         else
         {
            this.query = url.substring(queryIndex + 1);
         }
      }
      else if(hashIndex > -1)
      {
         this.path = url.substring(0,hashIndex);
         this.fragment = url.substring(hashIndex + 1);
      }
      else
      {
         this.path = url;
      }
   }
   
   public function getRoot() : String
   {
      var s:String = this.scheme + "://" + this.host;
      if(this.port == null)
      {
         return s;
      }
      return s + ":" + this.port;
   }
   
   public function toString() : String
   {
      return "scheme: " + this.scheme + "\n" + "host: " + this.host + "\n" + "port: " + this.port + "\n" + "path: " + this.path + "\n" + "query: " + this.query + "\n" + "fragment: " + this.fragment;
   }
}

class LogOutput extends TextField
{
   
   public function LogOutput()
   {
      super();
      defaultTextFormat = new TextFormat("Tahoma",11,16777215);
      multiline = true;
      wordWrap = true;
      addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
   }
   
   public function addLine(text:String) : void
   {
      appendText(text + "\n");
   }
   
   private function onAddedToStage(e:Event) : void
   {
      stage.addEventListener(Event.RESIZE,this.onStageResize);
      this.onStageResize(null);
   }
   
   private function onRemovedFromStage(e:Event) : void
   {
      stage.removeEventListener(Event.RESIZE,this.onStageResize);
   }
   
   private function onStageResize(e:Event) : void
   {
      width = stage.stageWidth;
      height = stage.stageHeight;
   }
}

class DummyListener implements ILauncherListener
{
   
   private var logOutput:LogOutput;
   
   public function DummyListener(logOutput:LogOutput)
   {
      super();
      this.logOutput = logOutput;
   }
   
   public function onConfigLoadingStart() : void
   {
      this.log("Config loading start");
   }
   
   public function onConfigLoadingComplete() : void
   {
      this.log("Config loading complete");
   }
   
   public function onConfigLoadingProgress(bytesLoaded:uint, bytesTotal:uint) : void
   {
   }
   
   public function onLibrariesLoadingStart() : void
   {
      this.log("Libraries loading start");
   }
   
   public function onLibrariesLoadingComplete() : void
   {
      this.log("Libraries loading complete");
   }
   
   public function onLibraryLoadingError(message:String) : void
   {
      this.log("Library loading error: " + message);
   }
   
   public function onLibrariesLoadingProgress(bytesLoaded:uint, bytesTotal:uint) : void
   {
   }
   
   public function onServerUnavailable() : void
   {
      this.log("Server is unavailable");
   }
   
   public function onServerOverloaded() : void
   {
      this.log("Server is overloaded");
   }
   
   public function onConfigLoadingError(message:String) : void
   {
      this.log("Configuration loading error: " + message);
   }
   
   public function onLibrariesInitialized() : void
   {
      this.log("Libraries have been initialized");
   }
   
   private function log(text:String) : void
   {
      if(this.logOutput != null)
      {
         this.logOutput.addLine(text);
      }
   }
}
