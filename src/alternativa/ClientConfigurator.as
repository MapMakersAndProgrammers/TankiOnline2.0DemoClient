package alternativa
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.bundle.BundleDescriptor;
   import alternativa.osgi.service.clientlog.ClientLog;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.osgi.service.console.ClientLogConnector;
   import alternativa.osgi.service.console.Console;
   import alternativa.osgi.service.console.IConsole;
   import alternativa.osgi.service.display.Display;
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.osgi.service.dump.DumpService;
   import alternativa.osgi.service.dump.IDumpService;
   import alternativa.osgi.service.dump.dumper.BundleDumper;
   import alternativa.osgi.service.dump.dumper.ServiceDumper;
   import alternativa.osgi.service.launcherparams.ILauncherParams;
   import alternativa.osgi.service.launcherparams.LauncherParams;
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.osgi.service.locale.LocaleService;
   import alternativa.osgi.service.network.INetworkService;
   import alternativa.osgi.service.network.NetworkService;
   import alternativa.startup.ConnectionParameters;
   import alternativa.startup.IClientConfigurator;
   import alternativa.startup.LibraryInfo;
   import alternativa.utils.Properties;
   import flash.display.DisplayObjectContainer;
   import flash.display.Stage;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   
   public class ClientConfigurator implements IClientConfigurator
   {
      private var osgi:OSGi;
      
      private var clientLog:IClientLog;
      
      private var console:Console;
      
      private var name_UU:KeyboardShortcut;
      
      private var name_jQ:KeyboardShortcut;
      
      public function ClientConfigurator()
      {
         super();
      }
      
      public function start(rootContainer:DisplayObjectContainer, urlParams:Properties, libraryInfos:Vector.<LibraryInfo>, connectionParameters:ConnectionParameters, startupLogStrings:Vector.<String>) : void
      {
         var libraryInfo:LibraryInfo = null;
         this.osgi = OSGi.getInstance();
         this.initClientLog(urlParams,startupLogStrings);
         this.initConsole(rootContainer.stage,urlParams);
         this.osgi.registerService(ILauncherParams,new LauncherParams(urlParams,libraryInfos));
         this.osgi.registerService(IDisplay,new Display(rootContainer));
         this.osgi.registerService(INetworkService,new NetworkService(connectionParameters.serverAddress,connectionParameters.serverPorts,connectionParameters.resourcesRootURL));
         var language:String = urlParams.getPropertyDef("lang","ru");
         this.osgi.registerService(ILocaleService,new LocaleService(language,"en"));
         var dumpService:IDumpService = new DumpService(this.osgi);
         this.osgi.registerService(IDumpService,dumpService);
         dumpService.registerDumper(new BundleDumper(this.osgi));
         dumpService.registerDumper(new ServiceDumper(this.osgi));
         for each(libraryInfo in libraryInfos)
         {
            this.osgi.installBundle(new BundleDescriptor(libraryInfo.manifestProperties));
         }
      }
      
      private function initClientLog(urlParams:Properties, startupLogStrings:Vector.<String>) : void
      {
         var s:String = null;
         var logChannelBufferSize:int = int(int(urlParams.getPropertyDef("log_channel_buffer_size","1000")));
         this.clientLog = new ClientLog(logChannelBufferSize);
         OSGi.clientLog = this.clientLog;
         this.osgi.registerService(IClientLog,this.clientLog);
         for each(s in startupLogStrings)
         {
            this.clientLog.log("startup",s);
         }
      }
      
      private function initConsole(stage:Stage, urlParams:Properties) : void
      {
         var _loc6_:String = null;
         this.console = new Console(stage,50,100,1,1);
         this.osgi.registerService(IConsole,this.console);
         var consoleParams:String = urlParams.getProperty("console");
         if(Boolean(consoleParams))
         {
            this.configureConsole(stage,this.console,consoleParams);
         }
         var clientLogConnector:ClientLogConnector = new ClientLogConnector(this.clientLog,this.console);
         this.console.setCommandHandler("log",clientLogConnector.onConsoleCommand);
         var logChannels:String = urlParams.getProperty("showlog");
         if(Boolean(logChannels))
         {
            if(logChannels == "all")
            {
               this.clientLog.addLogListener(clientLogConnector);
            }
            else
            {
               for each(_loc6_ in logChannels.split(","))
               {
                  this.clientLog.addLogChannelListener(_loc6_,clientLogConnector);
               }
            }
         }
      }
      
      private function configureConsole(stage:Stage, console:Console, consoleParams:String) : void
      {
         var pair:String = null;
         var parts:Array = null;
         var pairs:Array = consoleParams.split(",");
         var params:Object = {};
         for each(pair in pairs)
         {
            parts = pair.split(":");
            params[parts[0]] = parts[1];
         }
         if(params["show"] != null)
         {
            console.show();
         }
         if(params["ha"] != null)
         {
            console.horizontalAlignment = int(params["ha"]);
         }
         if(params["va"] != null)
         {
            console.vericalAlignment = int(params["va"]);
         }
         if(params["w"] != null)
         {
            console.width = int(params["w"]);
         }
         if(params["h"] != null)
         {
            console.height = int(params["h"]);
         }
         if(params["alpha"] != null)
         {
            console.executeCommand("con_alpha " + params["alpha"]);
         }
         this.name_UU = this.parseShortcut(params["hsw"],Keyboard.LEFT,false,true,true);
         this.name_jQ = this.parseShortcut(params["vsw"],Keyboard.UP,false,true,true);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKey,true);
      }
      
      private function parseShortcut(s:String, defKey:int, defAlt:Boolean, defCtrl:Boolean, defShift:Boolean) : KeyboardShortcut
      {
         if(s == null)
         {
            return new KeyboardShortcut(defKey,defAlt,defCtrl,defShift);
         }
         return new KeyboardShortcut(parseInt(s),s.indexOf("a") > -1,s.indexOf("c") > -1,s.indexOf("s") > -1);
      }
      
      private function onKey(e:KeyboardEvent) : void
      {
         switch(e.keyCode)
         {
            case this.name_UU.keyCode:
               if(this.name_UU.altKey == e.altKey && this.name_UU.shiftKey == e.shiftKey && this.name_UU.ctrlKey == e.ctrlKey)
               {
                  if(this.console.horizontalAlignment == 1)
                  {
                     this.console.horizontalAlignment = 2;
                     break;
                  }
                  this.console.horizontalAlignment = 1;
               }
               break;
            case this.name_jQ.keyCode:
               if(this.name_jQ.altKey == e.altKey && this.name_jQ.shiftKey == e.shiftKey && this.name_jQ.ctrlKey == e.ctrlKey)
               {
                  if(this.console.vericalAlignment == 1)
                  {
                     this.console.vericalAlignment = 2;
                     break;
                  }
                  this.console.vericalAlignment = 1;
                  break;
               }
         }
      }
   }
}

class KeyboardShortcut
{
   public var keyCode:int;
   
   public var altKey:Boolean;
   
   public var ctrlKey:Boolean;
   
   public var shiftKey:Boolean;
   
   public function KeyboardShortcut(keyCode:int, altKey:Boolean, ctrlKey:Boolean, shiftKey:Boolean)
   {
      super();
      this.keyCode = keyCode;
      this.altKey = altKey;
      this.ctrlKey = ctrlKey;
      this.shiftKey = shiftKey;
   }
}
