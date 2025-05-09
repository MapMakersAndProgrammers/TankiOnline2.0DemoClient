package §_-5U§
{
   import §_-5g§.§_-OD§;
   import §_-5g§.§_-iB§;
   import §_-Ep§.§_-7§;
   import §_-Ep§.§_-pA§;
   import §_-GD§.§_-6A§;
   import §_-GD§.§_-X8§;
   import §_-GD§.§_-dX§;
   import §_-HW§.§_-pf§;
   import §_-MU§.§_-5-§;
   import §_-MU§.§_-du§;
   import §_-O5§.§_-c-§;
   import §_-Tt§.§_-Hi§;
   import §_-Tt§.§_-Ho§;
   import §_-Uy§.§_-oP§;
   import §_-XV§.§_-31§;
   import §_-XV§.§_-Yx§;
   import §_-aA§.§_-1O§;
   import §_-aA§.§_-6t§;
   import §_-aA§.§_-a-§;
   import §_-io§.§_-39§;
   import §_-io§.§_-Cs§;
   import §_-o8§.§_-Bh§;
   import §_-o8§.§_-Ut§;
   import flash.display.DisplayObjectContainer;
   import flash.display.Stage;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   
   public class §_-Kr§ implements §_-6t§
   {
      private var osgi:§_-oP§;
      
      private var clientLog:§_-5-§;
      
      private var console:§_-dX§;
      
      private var §_-UU§:KeyboardShortcut;
      
      private var §_-jQ§:KeyboardShortcut;
      
      public function §_-Kr§()
      {
         super();
      }
      
      public function start(rootContainer:DisplayObjectContainer, urlParams:§_-c-§, libraryInfos:Vector.<§_-a-§>, connectionParameters:§_-1O§, startupLogStrings:Vector.<String>) : void
      {
         var libraryInfo:§_-a-§ = null;
         this.osgi = §_-oP§.§_-nQ§();
         this.§_-SF§(urlParams,startupLogStrings);
         this.§_-33§(rootContainer.stage,urlParams);
         this.osgi.§_-g2§(§_-iB§,new §_-OD§(urlParams,libraryInfos));
         this.osgi.§_-g2§(§_-31§,new §_-Yx§(rootContainer));
         this.osgi.§_-g2§(§_-Ho§,new §_-Hi§(connectionParameters.serverAddress,connectionParameters.serverPorts,connectionParameters.resourcesRootURL));
         var language:String = urlParams.§_-aR§("lang","ru");
         this.osgi.§_-g2§(§_-7§,new §_-pA§(language,"en"));
         var dumpService:§_-39§ = new §_-Cs§(this.osgi);
         this.osgi.§_-g2§(§_-39§,dumpService);
         dumpService.§_-Wc§(new §_-Bh§(this.osgi));
         dumpService.§_-Wc§(new §_-Ut§(this.osgi));
         for each(libraryInfo in libraryInfos)
         {
            this.osgi.§_-XK§(new §_-pf§(libraryInfo.manifestProperties));
         }
      }
      
      private function §_-SF§(urlParams:§_-c-§, startupLogStrings:Vector.<String>) : void
      {
         var s:String = null;
         var logChannelBufferSize:int = int(int(urlParams.§_-aR§("log_channel_buffer_size","1000")));
         this.clientLog = new §_-du§(logChannelBufferSize);
         §_-oP§.clientLog = this.clientLog;
         this.osgi.§_-g2§(§_-5-§,this.clientLog);
         for each(s in startupLogStrings)
         {
            this.clientLog.log("startup",s);
         }
      }
      
      private function §_-33§(stage:Stage, urlParams:§_-c-§) : void
      {
         var channelName:String = null;
         this.console = new §_-dX§(stage,50,100,1,1);
         this.osgi.§_-g2§(§_-6A§,this.console);
         var consoleParams:String = urlParams.§_-PU§("console");
         if(Boolean(consoleParams))
         {
            this.§_-bC§(stage,this.console,consoleParams);
         }
         var clientLogConnector:§_-X8§ = new §_-X8§(this.clientLog,this.console);
         this.console.§_-0j§("log",clientLogConnector.§_-9Q§);
         var logChannels:String = urlParams.§_-PU§("showlog");
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
      
      private function §_-bC§(stage:Stage, console:§_-dX§, consoleParams:String) : void
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
            console.§_-TC§ = int(params["ha"]);
         }
         if(params["va"] != null)
         {
            console.§_-p2§ = int(params["va"]);
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
            console.§_-I1§("con_alpha " + params["alpha"]);
         }
         this.§_-UU§ = this.§ for§(params["hsw"],Keyboard.LEFT,false,true,true);
         this.§_-jQ§ = this.§ for§(params["vsw"],Keyboard.UP,false,true,true);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.§_-bM§,true);
      }
      
      private function § for§(s:String, defKey:int, defAlt:Boolean, defCtrl:Boolean, defShift:Boolean) : KeyboardShortcut
      {
         if(s == null)
         {
            return new KeyboardShortcut(defKey,defAlt,defCtrl,defShift);
         }
         return new KeyboardShortcut(parseInt(s),s.indexOf("a") > -1,s.indexOf("c") > -1,s.indexOf("s") > -1);
      }
      
      private function §_-bM§(e:KeyboardEvent) : void
      {
         switch(e.keyCode)
         {
            case this.§_-UU§.keyCode:
               if(this.§_-UU§.altKey == e.altKey && this.§_-UU§.shiftKey == e.shiftKey && this.§_-UU§.ctrlKey == e.ctrlKey)
               {
                  if(this.console.§_-TC§ == 1)
                  {
                     this.console.§_-TC§ = 2;
                     break;
                  }
                  this.console.§_-TC§ = 1;
               }
               break;
            case this.§_-jQ§.keyCode:
               if(this.§_-jQ§.altKey == e.altKey && this.§_-jQ§.shiftKey == e.shiftKey && this.§_-jQ§.ctrlKey == e.ctrlKey)
               {
                  if(this.console.§_-p2§ == 1)
                  {
                     this.console.§_-p2§ = 2;
                     break;
                  }
                  this.console.§_-p2§ = 1;
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
