package alternativa.osgi.service.console
{
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.osgi.service.clientlog.IClientLogChannelListener;
   
   public class ClientLogConnector implements IClientLogChannelListener
   {
      private static const ALL_CHANNELS:String = "all";
      
      private var clientLog:IClientLog;
      
      private var console:IConsole;
      
      public function ClientLogConnector(clientLog:IClientLog, console:IConsole)
      {
         super();
         this.clientLog = clientLog;
         this.console = console;
      }
      
      public function onLogEntryAdded(channelName:String, logText:String) : void
      {
         this.console.addPrefixedText(channelName + " ",logText);
      }
      
      public function onConsoleCommand(console:IConsole, args:Array) : void
      {
         if(args.length < 1)
         {
            console.addText("Usage: log action [arguments]");
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
                  console.addText("Usage: log show channel_name [filter_string]");
                  break;
               }
               this.printFilteredLines(console,args[0],args[1]);
               break;
            case "ls":
            case "list":
               console.addText("Existing channels:");
               console.addLines(this.clientLog.getChannelNames());
         }
      }
      
      private function printFilteredLines(console:IConsole, channelName:String, filterString:String) : void
      {
         var filteredStrings:Vector.<String> = null;
         var channelStrings:Vector.<String> = this.clientLog.getChannelStrings(channelName);
         if(channelStrings == null)
         {
            console.addText("Channel not found");
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
            console.addPrefixedLines(channelName + " ",filteredStrings);
         }
      }
      
      private function connectChannels(channels:Array) : void
      {
         var _loc2_:String = null;
         if(channels.length == 0)
         {
            this.console.addText("Usage: log connect channel_name1 [channel_name2 ...]");
            return;
         }
         if(channels[0] == ALL_CHANNELS)
         {
            this.clientLog.addLogListener(this);
            this.console.addText("All log channels have been connected");
         }
         else
         {
            for each(_loc2_ in channels)
            {
               if(_loc2_ != ALL_CHANNELS)
               {
                  this.clientLog.addLogChannelListener(_loc2_,this);
                  this.console.addText("Log channel " + _loc2_ + " has been connected");
               }
            }
         }
      }
      
      private function disconnectChannels(channels:Array) : void
      {
         var _loc2_:String = null;
         if(channels.length == 0)
         {
            this.console.addText("Usage: log disconnect channel_name1 [channel_name2 ...]");
            return;
         }
         if(channels[0] == ALL_CHANNELS)
         {
            this.clientLog.removeLogListener(this);
            this.console.addText("All log channels have been disconnected");
         }
         else
         {
            for each(_loc2_ in channels)
            {
               if(_loc2_ != ALL_CHANNELS)
               {
                  this.clientLog.removeLogChannelListener(_loc2_,this);
                  this.console.addText("Log channel " + _loc2_ + " has been disconnected");
               }
            }
         }
      }
   }
}

