package package_11
{
   import package_32.class_23;
   import package_32.name_180;
   
   public class name_288 implements class_23
   {
      private static const ALL_CHANNELS:String = "all";
      
      private var clientLog:name_180;
      
      private var console:name_4;
      
      public function name_288(clientLog:name_180, console:name_4)
      {
         super();
         this.clientLog = clientLog;
         this.console = console;
      }
      
      public function method_225(channelName:String, logText:String) : void
      {
         this.console.name_469(channelName + " ",logText);
      }
      
      public function name_305(console:name_4, args:Array) : void
      {
         if(args.length < 1)
         {
            console.name_217("Usage: log action [arguments]");
            return;
         }
         var action:String = args.shift();
         switch(action)
         {
            case "c":
            case "connect":
               this.method_223(args);
               break;
            case "d":
            case "disconnect":
               this.method_224(args);
               break;
            case "show":
               if(args.length == 0)
               {
                  console.name_217("Usage: log show channel_name [filter_string]");
                  break;
               }
               this.method_222(console,args[0],args[1]);
               break;
            case "ls":
            case "list":
               console.name_217("Existing channels:");
               console.name_468(this.clientLog.getChannelNames());
         }
      }
      
      private function method_222(console:name_4, channelName:String, filterString:String) : void
      {
         var filteredStrings:Vector.<String> = null;
         var channelStrings:Vector.<String> = this.clientLog.getChannelStrings(channelName);
         if(channelStrings == null)
         {
            console.name_217("Channel not found");
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
            console.name_467(channelName + " ",filteredStrings);
         }
      }
      
      private function method_223(channels:Array) : void
      {
         var channelName:String = null;
         if(channels.length == 0)
         {
            this.console.name_217("Usage: log connect channel_name1 [channel_name2 ...]");
            return;
         }
         if(channels[0] == ALL_CHANNELS)
         {
            this.clientLog.addLogListener(this);
            this.console.name_217("All log channels have been connected");
         }
         else
         {
            for each(channelName in channels)
            {
               if(channelName != ALL_CHANNELS)
               {
                  this.clientLog.addLogChannelListener(channelName,this);
                  this.console.name_217("Log channel " + channelName + " has been connected");
               }
            }
         }
      }
      
      private function method_224(channels:Array) : void
      {
         var channelName:String = null;
         if(channels.length == 0)
         {
            this.console.name_217("Usage: log disconnect channel_name1 [channel_name2 ...]");
            return;
         }
         if(channels[0] == ALL_CHANNELS)
         {
            this.clientLog.removeLogListener(this);
            this.console.name_217("All log channels have been disconnected");
         }
         else
         {
            for each(channelName in channels)
            {
               if(channelName != ALL_CHANNELS)
               {
                  this.clientLog.removeLogChannelListener(channelName,this);
                  this.console.name_217("Log channel " + channelName + " has been disconnected");
               }
            }
         }
      }
   }
}

