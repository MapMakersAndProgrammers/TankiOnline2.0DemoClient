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
      
      private var conAlignShortcutH:KeyboardShortcut;
      
      private var conAlignShortcutV:KeyboardShortcut;
      
      public function ClientConfigurator()
      {
         super();
      }
      
      public function start(param1:DisplayObjectContainer, param2:Properties, param3:Vector.<LibraryInfo>, param4:ConnectionParameters, param5:Vector.<String>) : void
      {
         var _loc8_:LibraryInfo = null;
         this.osgi = OSGi.getInstance();
         this.initClientLog(param2,param5);
         this.initConsole(param1.stage,param2);
         this.osgi.registerService(ILauncherParams,new LauncherParams(param2,param3));
         this.osgi.registerService(IDisplay,new Display(param1));
         this.osgi.registerService(INetworkService,new NetworkService(param4.serverAddress,param4.serverPorts,param4.resourcesRootURL));
         var _loc6_:String = param2.getPropertyDef("lang","ru");
         this.osgi.registerService(ILocaleService,new LocaleService(_loc6_,"en"));
         var _loc7_:IDumpService = new DumpService(this.osgi);
         this.osgi.registerService(IDumpService,_loc7_);
         _loc7_.registerDumper(new BundleDumper(this.osgi));
         _loc7_.registerDumper(new ServiceDumper(this.osgi));
         for each(_loc8_ in param3)
         {
            this.osgi.installBundle(new BundleDescriptor(_loc8_.manifestProperties));
         }
      }
      
      private function initClientLog(param1:Properties, param2:Vector.<String>) : void
      {
         var _loc4_:String = null;
         var _loc3_:int = int(param1.getPropertyDef("log_channel_buffer_size","1000"));
         this.clientLog = new ClientLog(_loc3_);
         OSGi.clientLog = this.clientLog;
         this.osgi.registerService(IClientLog,this.clientLog);
         for each(_loc4_ in param2)
         {
            this.clientLog.log("startup",_loc4_);
         }
      }
      
      private function initConsole(param1:Stage, param2:Properties) : void
      {
         var _loc6_:String = null;
         this.console = new Console(param1,50,100,1,1);
         this.osgi.registerService(IConsole,this.console);
         var _loc3_:String = param2.getProperty("console");
         if(Boolean(_loc3_))
         {
            this.configureConsole(param1,this.console,_loc3_);
         }
         var _loc4_:ClientLogConnector = new ClientLogConnector(this.clientLog,this.console);
         this.console.setCommandHandler("log",_loc4_.onConsoleCommand);
         var _loc5_:String = param2.getProperty("showlog");
         if(Boolean(_loc5_))
         {
            if(_loc5_ == "all")
            {
               this.clientLog.addLogListener(_loc4_);
            }
            else
            {
               for each(_loc6_ in _loc5_.split(","))
               {
                  this.clientLog.addLogChannelListener(_loc6_,_loc4_);
               }
            }
         }
      }
      
      private function configureConsole(param1:Stage, param2:Console, param3:String) : void
      {
         var _loc6_:String = null;
         var _loc7_:Array = null;
         var _loc4_:Array = param3.split(",");
         var _loc5_:Object = {};
         for each(_loc6_ in _loc4_)
         {
            _loc7_ = _loc6_.split(":");
            _loc5_[_loc7_[0]] = _loc7_[1];
         }
         if(_loc5_["show"] != null)
         {
            param2.show();
         }
         if(_loc5_["ha"] != null)
         {
            param2.horizontalAlignment = int(_loc5_["ha"]);
         }
         if(_loc5_["va"] != null)
         {
            param2.vericalAlignment = int(_loc5_["va"]);
         }
         if(_loc5_["w"] != null)
         {
            param2.width = int(_loc5_["w"]);
         }
         if(_loc5_["h"] != null)
         {
            param2.height = int(_loc5_["h"]);
         }
         if(_loc5_["alpha"] != null)
         {
            param2.executeCommand("con_alpha " + _loc5_["alpha"]);
         }
         this.conAlignShortcutH = this.parseShortcut(_loc5_["hsw"],Keyboard.LEFT,false,true,true);
         this.conAlignShortcutV = this.parseShortcut(_loc5_["vsw"],Keyboard.UP,false,true,true);
         param1.addEventListener(KeyboardEvent.KEY_DOWN,this.onKey,true);
      }
      
      private function parseShortcut(param1:String, param2:int, param3:Boolean, param4:Boolean, param5:Boolean) : KeyboardShortcut
      {
         if(param1 == null)
         {
            return new KeyboardShortcut(param2,param3,param4,param5);
         }
         return new KeyboardShortcut(parseInt(param1),param1.indexOf("a") > -1,param1.indexOf("c") > -1,param1.indexOf("s") > -1);
      }
      
      private function onKey(param1:KeyboardEvent) : void
      {
         switch(param1.keyCode)
         {
            case this.conAlignShortcutH.keyCode:
               if(this.conAlignShortcutH.altKey == param1.altKey && this.conAlignShortcutH.shiftKey == param1.shiftKey && this.conAlignShortcutH.ctrlKey == param1.ctrlKey)
               {
                  if(this.console.horizontalAlignment == 1)
                  {
                     this.console.horizontalAlignment = 2;
                     break;
                  }
                  this.console.horizontalAlignment = 1;
               }
               break;
            case this.conAlignShortcutV.keyCode:
               if(this.conAlignShortcutV.altKey == param1.altKey && this.conAlignShortcutV.shiftKey == param1.shiftKey && this.conAlignShortcutV.ctrlKey == param1.ctrlKey)
               {
                  if(this.console.vericalAlignment == 1)
                  {
                     this.console.vericalAlignment = 2;
                     break;
                  }
                  this.console.vericalAlignment = 1;
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
   
   public function KeyboardShortcut(param1:int, param2:Boolean, param3:Boolean, param4:Boolean)
   {
      super();
      this.keyCode = param1;
      this.altKey = param2;
      this.ctrlKey = param3;
      this.shiftKey = param4;
   }
}
