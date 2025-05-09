package package_9
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Stage;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import package_11.name_284;
   import package_11.name_288;
   import package_11.name_4;
   import package_12.name_27;
   import package_14.name_3;
   import package_31.name_300;
   import package_32.name_180;
   import package_32.name_302;
   import package_7.class_13;
   import package_7.name_32;
   import package_7.name_33;
   import package_72.name_287;
   import package_72.name_291;
   import package_73.name_293;
   import package_73.name_298;
   import package_74.name_290;
   import package_74.name_304;
   import package_75.name_295;
   import package_75.name_296;
   import package_76.name_289;
   import package_76.name_301;
   import package_77.name_294;
   import package_77.name_303;
   
   public class name_15 implements class_13
   {
      private var osgi:name_3;
      
      private var clientLog:name_180;
      
      private var console:name_284;
      
      private var var_83:KeyboardShortcut;
      
      private var var_84:KeyboardShortcut;
      
      public function name_15()
      {
         super();
      }
      
      public function start(rootContainer:DisplayObjectContainer, urlParams:name_27, libraryInfos:Vector.<name_33>, connectionParameters:name_32, startupLogStrings:Vector.<String>) : void
      {
         var libraryInfo:name_33 = null;
         this.osgi = name_3.name_8();
         this.method_98(urlParams,startupLogStrings);
         this.method_7(rootContainer.stage,urlParams);
         this.osgi.method_38(name_298,new name_293(urlParams,libraryInfos));
         this.osgi.method_38(name_295,new name_296(rootContainer));
         this.osgi.method_38(name_294,new name_303(connectionParameters.serverAddress,connectionParameters.serverPorts,connectionParameters.resourcesRootURL));
         var language:String = urlParams.name_297("lang","ru");
         this.osgi.method_38(name_290,new name_304(language,"en"));
         var dumpService:name_287 = new name_291(this.osgi);
         this.osgi.method_38(name_287,dumpService);
         dumpService.name_292(new name_301(this.osgi));
         dumpService.name_292(new name_289(this.osgi));
         for each(libraryInfo in libraryInfos)
         {
            this.osgi.method_44(new name_300(libraryInfo.manifestProperties));
         }
      }
      
      private function method_98(urlParams:name_27, startupLogStrings:Vector.<String>) : void
      {
         var s:String = null;
         var logChannelBufferSize:int = int(int(urlParams.name_297("log_channel_buffer_size","1000")));
         this.clientLog = new name_302(logChannelBufferSize);
         name_3.clientLog = this.clientLog;
         this.osgi.method_38(name_180,this.clientLog);
         for each(s in startupLogStrings)
         {
            this.clientLog.log("startup",s);
         }
      }
      
      private function method_7(stage:Stage, urlParams:name_27) : void
      {
         var channelName:String = null;
         this.console = new name_284(stage,50,100,1,1);
         this.osgi.method_38(name_4,this.console);
         var consoleParams:String = urlParams.name_299("console");
         if(Boolean(consoleParams))
         {
            this.method_99(stage,this.console,consoleParams);
         }
         var clientLogConnector:name_288 = new name_288(this.clientLog,this.console);
         this.console.name_34("log",clientLogConnector.name_305);
         var logChannels:String = urlParams.name_299("showlog");
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
      
      private function method_99(stage:Stage, console:name_284, consoleParams:String) : void
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
            console.name_285 = int(params["ha"]);
         }
         if(params["va"] != null)
         {
            console.name_286 = int(params["va"]);
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
            console.name_248("con_alpha " + params["alpha"]);
         }
         this.var_83 = this.method_97(params["hsw"],Keyboard.LEFT,false,true,true);
         this.var_84 = this.method_97(params["vsw"],Keyboard.UP,false,true,true);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.method_100,true);
      }
      
      private function method_97(s:String, defKey:int, defAlt:Boolean, defCtrl:Boolean, defShift:Boolean) : KeyboardShortcut
      {
         if(s == null)
         {
            return new KeyboardShortcut(defKey,defAlt,defCtrl,defShift);
         }
         return new KeyboardShortcut(parseInt(s),s.indexOf("a") > -1,s.indexOf("c") > -1,s.indexOf("s") > -1);
      }
      
      private function method_100(e:KeyboardEvent) : void
      {
         switch(e.keyCode)
         {
            case this.var_83.keyCode:
               if(this.var_83.altKey == e.altKey && this.var_83.shiftKey == e.shiftKey && this.var_83.ctrlKey == e.ctrlKey)
               {
                  if(this.console.name_285 == 1)
                  {
                     this.console.name_285 = 2;
                     break;
                  }
                  this.console.name_285 = 1;
               }
               break;
            case this.var_84.keyCode:
               if(this.var_84.altKey == e.altKey && this.var_84.shiftKey == e.shiftKey && this.var_84.ctrlKey == e.ctrlKey)
               {
                  if(this.console.name_286 == 1)
                  {
                     this.console.name_286 = 2;
                     break;
                  }
                  this.console.name_286 = 1;
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
