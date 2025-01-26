package alternativa
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Stage;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import package_102.name_355;
   import package_102.name_359;
   import package_103.name_361;
   import package_103.name_365;
   import package_104.name_358;
   import package_104.name_370;
   import package_105.name_363;
   import package_105.name_364;
   import package_106.name_357;
   import package_106.name_367;
   import package_107.name_362;
   import package_107.name_369;
   import package_15.name_19;
   import package_31.name_366;
   import package_39.name_160;
   import package_39.name_368;
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.console.Console;
   import alternativa.osgi.service.console.ClientLogConnector;
   import alternativa.osgi.service.console.IConsole;
   import alternativa.startup.IClientConfigurator;
   import alternativa.startup.LibraryInfo;
   import alternativa.startup.ConnectionParameters;
   
   public class ClientConfigurator implements IClientConfigurator
   {
      private var osgi:OSGi;
      
      private var clientLog:name_160;
      
      private var console:Console;
      
      private var var_83:KeyboardShortcut;
      
      private var var_84:KeyboardShortcut;
      
      public function ClientConfigurator()
      {
         super();
      }
      
      public function start(rootContainer:DisplayObjectContainer, urlParams:name_19, libraryInfos:Vector.<LibraryInfo>, connectionParameters:ConnectionParameters, startupLogStrings:Vector.<String>) : void
      {
         var libraryInfo:LibraryInfo = null;
         this.osgi = OSGi.name_8();
         this.initClientLog(urlParams,startupLogStrings);
         this.initConsole(rootContainer.stage,urlParams);
         this.osgi.method_116(name_365,new name_361(urlParams,libraryInfos));
         this.osgi.method_116(name_363,new name_364(rootContainer));
         this.osgi.method_116(name_362,new name_369(connectionParameters.serverAddress,connectionParameters.serverPorts,connectionParameters.resourcesRootURL));
         var language:String = urlParams.method_25("lang","ru");
         this.osgi.method_116(name_358,new name_370(language,"en"));
         var dumpService:name_355 = new name_359(this.osgi);
         this.osgi.method_116(name_355,dumpService);
         dumpService.name_360(new name_367(this.osgi));
         dumpService.name_360(new name_357(this.osgi));
         for each(libraryInfo in libraryInfos)
         {
            this.osgi.method_121(new name_366(libraryInfo.manifestProperties));
         }
      }
      
      private function initClientLog(urlParams:name_19, startupLogStrings:Vector.<String>) : void
      {
         var s:String = null;
         var logChannelBufferSize:int = int(int(urlParams.method_25("log_channel_buffer_size","1000")));
         this.clientLog = new name_368(logChannelBufferSize);
         OSGi.clientLog = this.clientLog;
         this.osgi.method_116(name_160,this.clientLog);
         for each(s in startupLogStrings)
         {
            this.clientLog.log("startup",s);
         }
      }
      
      private function initConsole(stage:Stage, urlParams:name_19) : void
      {
         var channelName:String = null;
         this.console = new Console(stage,50,100,1,1);
         this.osgi.method_116(IConsole,this.console);
         var consoleParams:String = urlParams.method_24("console");
         if(Boolean(consoleParams))
         {
            this.configureConsole(stage,this.console,consoleParams);
         }
         var clientLogConnector:ClientLogConnector = new ClientLogConnector(this.clientLog,this.console);
         this.console.name_45("log",clientLogConnector.name_371);
         var logChannels:String = urlParams.method_24("showlog");
         if(Boolean(logChannels))
         {
            if(logChannels == "all")
            {
               this.clientLog.addLogListener(clientLogConnector);
            }
            else
            {
               for each(channelName in logChannels.split(","))
               {
                  this.clientLog.addLogChannelListener(channelName,clientLogConnector);
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
            console.method_138 = int(params["ha"]);
         }
         if(params["va"] != null)
         {
            console.method_137 = int(params["va"]);
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
            console.method_139("con_alpha " + params["alpha"]);
         }
         this.var_83 = this.parseShortcut(params["hsw"],Keyboard.LEFT,false,true,true);
         this.var_84 = this.parseShortcut(params["vsw"],Keyboard.UP,false,true,true);
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
            case this.var_83.keyCode:
               if(this.var_83.altKey == e.altKey && this.var_83.shiftKey == e.shiftKey && this.var_83.ctrlKey == e.ctrlKey)
               {
                  if(this.console.method_138 == 1)
                  {
                     this.console.method_138 = 2;
                     break;
                  }
                  this.console.method_138 = 1;
               }
               break;
            case this.var_84.keyCode:
               if(this.var_84.altKey == e.altKey && this.var_84.shiftKey == e.shiftKey && this.var_84.ctrlKey == e.ctrlKey)
               {
                  if(this.console.method_137 == 1)
                  {
                     this.console.method_137 = 2;
                     break;
                  }
                  this.console.method_137 = 1;
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
