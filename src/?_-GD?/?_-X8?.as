package §_-GD§
{
   import §_-MU§.§_-5-§;
   import §_-MU§.§_-XQ§;
   
   public class §_-X8§ implements §_-XQ§
   {
      private static const ALL_CHANNELS:String = "all";
      
      private var clientLog:§_-5-§;
      
      private var console:§_-6A§;
      
      public function §_-X8§(clientLog:§_-5-§, console:§_-6A§)
      {
         super();
         this.clientLog = clientLog;
         this.console = console;
      }
      
      public function §_-qU§(channelName:String, logText:String) : void
      {
         this.console.§_-H-§(channelName + " ",logText);
      }
      
      public function §_-9Q§(console:§_-6A§, args:Array) : void
      {
         if(args.length < 1)
         {
            console.§_-MR§("Usage: log action [arguments]");
            return;
         }
         var action:String = args.shift();
         switch(action)
         {
            case "c":
            case "connect":
               this.§_-1g§(args);
               break;
            case "d":
            case "disconnect":
               this.§_-W4§(args);
               break;
            case "show":
               if(args.length == 0)
               {
                  console.§_-MR§("Usage: log show channel_name [filter_string]");
                  break;
               }
               this.§_-95§(console,args[0],args[1]);
               break;
            case "ls":
            case "list":
               console.§_-MR§("Existing channels:");
               console.§_-3c§(this.clientLog.getChannelNames());
         }
      }
      
      private function §_-95§(console:§_-6A§, channelName:String, filterString:String) : void
      {
         var filteredStrings:Vector.<String> = null;
         var channelStrings:Vector.<String> = this.clientLog.getChannelStrings(channelName);
         if(channelStrings == null)
         {
            console.§_-MR§("Channel not found");
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
            console.§_-dU§(channelName + " ",filteredStrings);
         }
      }
      
      private function §_-1g§(channels:Array) : void
      {
         var channelName:String = null;
         if(channels.length == 0)
         {
            this.console.§_-MR§("Usage: log connect channel_name1 [channel_name2 ...]");
            return;
         }
         if(channels[0] == ALL_CHANNELS)
         {
            this.clientLog.addLogListener(this);
            this.console.§_-MR§("All log channels have been connected");
         }
         else
         {
            for each(channelName in channels)
            {
               if(channelName != ALL_CHANNELS)
               {
                  this.clientLog.addLogChannelListener(channelName,this);
                  this.console.§_-MR§("Log channel " + channelName + " has been connected");
               }
            }
         }
      }
      
      private function §_-W4§(channels:Array) : void
      {
         var channelName:String = null;
         if(channels.length == 0)
         {
            this.console.§_-MR§("Usage: log disconnect channel_name1 [channel_name2 ...]");
            return;
         }
         if(channels[0] == ALL_CHANNELS)
         {
            this.clientLog.removeLogListener(this);
            this.console.§_-MR§("All log channels have been disconnected");
         }
         else
         {
            for each(channelName in channels)
            {
               if(channelName != ALL_CHANNELS)
               {
                  this.clientLog.removeLogChannelListener(channelName,this);
                  this.console.§_-MR§("Log channel " + channelName + " has been disconnected");
               }
            }
         }
      }
   }
}

