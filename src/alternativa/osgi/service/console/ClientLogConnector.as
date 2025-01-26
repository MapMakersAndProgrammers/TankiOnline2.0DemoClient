package alternativa.osgi.service.console
{
   import package_39.name_160;
   import package_39.name_450;
   
   public class ClientLogConnector implements name_450
   {
      private static const ALL_CHANNELS:String = "all";
      
      private var clientLog:name_160;
      
      private var console:IConsole;
      
      public function ClientLogConnector(clientLog:name_160, console:IConsole)
      {
         super();
         this.clientLog = clientLog;
         this.console = console;
      }
      
      public function method_622(channelName:String, logText:String) : void
      {
         this.console.method_143(channelName + " ",logText);
      }
      
      public function name_371(console:IConsole, args:Array) : void
      {
         if(args.length < 1)
         {
            console.name_145("Usage: log action [arguments]");
            return;
         }
         var action:String = args.shift();
         switch(action)
         {
            case "c":
            case "connect":
               this.connectChannels(args);
               break;
            case "d":
            case "disconnect":
               this.disconnectChannels(args);
               break;
            case "show":
               if(args.length == 0)
               {
                  console.name_145("Usage: log show channel_name [filter_string]");
                  break;
               }
               this.printFilteredLines(console,args[0],args[1]);
               break;
            case "ls":
            case "list":
               console.name_145("Existing channels:");
               console.method_145(this.clientLog.getChannelNames());
         }
      }
      
      private function printFilteredLines(console:IConsole, channelName:String, filterString:String) : void
      {
         var filteredStrings:Vector.<String> = null;
         var channelStrings:Vector.<String> = this.clientLog.getChannelStrings(channelName);
         if(channelStrings == null)
         {
            console.name_145("Channel not found");
         }
         else
         {
            if(Boolean(filterString))
            {
               filterString = filterString.toLowerCase();
               filteredStrings = channelStrings.filter(function(item:String, index:int, vector:Vector.<String>):Boolean
               {
                  return item.toLowerCase().indexOf(filterString) >= 0;
               });
            }
            else
            {
               filteredStrings = channelStrings;
            }
            console.method_142(channelName + " ",filteredStrings);
         }
      }
      
      private function connectChannels(channels:Array) : void
      {
         var channelName:String = null;
         if(channels.length == 0)
         {
            this.console.name_145("Usage: log connect channel_name1 [channel_name2 ...]");
            return;
         }
         if(channels[0] == ALL_CHANNELS)
         {
            this.clientLog.addLogListener(this);
            this.console.name_145("All log channels have been connected");
         }
         else
         {
            for each(channelName in channels)
            {
               if(channelName != ALL_CHANNELS)
               {
                  this.clientLog.addLogChannelListener(channelName,this);
                  this.console.name_145("Log channel " + channelName + " has been connected");
               }
            }
         }
      }
      
      private function disconnectChannels(channels:Array) : void
      {
         var channelName:String = null;
         if(channels.length == 0)
         {
            this.console.name_145("Usage: log disconnect channel_name1 [channel_name2 ...]");
            return;
         }
         if(channels[0] == ALL_CHANNELS)
         {
            this.clientLog.removeLogListener(this);
            this.console.name_145("All log channels have been disconnected");
         }
         else
         {
            for each(channelName in channels)
            {
               if(channelName != ALL_CHANNELS)
               {
                  this.clientLog.removeLogChannelListener(channelName,this);
                  this.console.name_145("Log channel " + channelName + " has been disconnected");
               }
            }
         }
      }
   }
}

