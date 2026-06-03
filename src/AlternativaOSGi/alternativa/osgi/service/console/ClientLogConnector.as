package alternativa.osgi.service.console
{
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.osgi.service.clientlog.IClientLogChannelListener;
   
   public class ClientLogConnector implements IClientLogChannelListener
   {
      
      private static const ALL_CHANNELS:String = "all";
      
      private var clientLog:IClientLog;
      
      private var console:IConsole;
      
      public function ClientLogConnector(param1:IClientLog, param2:IConsole)
      {
         super();
         this.clientLog = param1;
         this.console = param2;
      }
      
      public function onLogEntryAdded(param1:String, param2:String) : void
      {
         this.console.addPrefixedText(param1 + " ",param2);
      }
      
      public function onConsoleCommand(param1:IConsole, param2:Array) : void
      {
         if(param2.length < 1)
         {
            param1.addText("Usage: log action [arguments]");
            return;
         }
         var _loc3_:String = param2.shift();
         switch(_loc3_)
         {
            case "c":
            case "connect":
               this.connectChannels(param2);
               break;
            case "d":
            case "disconnect":
               this.disconnectChannels(param2);
               break;
            case "show":
               if(param2.length == 0)
               {
                  param1.addText("Usage: log show channel_name [filter_string]");
                  break;
               }
               this.printFilteredLines(param1,param2[0],param2[1]);
               break;
            case "ls":
            case "list":
               param1.addText("Existing channels:");
               param1.addLines(this.clientLog.getChannelNames());
         }
      }
      
      private function printFilteredLines(param1:IConsole, param2:String, param3:String) : void
      {
         var filteredStrings:Vector.<String> = null;
         var console:IConsole = param1;
         var channelName:String = param2;
         var filterString:String = param3;
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
               filteredStrings = channelStrings.filter(function(param1:String, param2:int, param3:Vector.<String>):Boolean
               {
                  return param1.toLowerCase().indexOf(filterString) >= 0;
               });
            }
            else
            {
               filteredStrings = channelStrings;
            }
            console.addPrefixedLines(channelName + " ",filteredStrings);
         }
      }
      
      private function connectChannels(param1:Array) : void
      {
         var _loc2_:String = null;
         if(param1.length == 0)
         {
            this.console.addText("Usage: log connect channel_name1 [channel_name2 ...]");
            return;
         }
         if(param1[0] == ALL_CHANNELS)
         {
            this.clientLog.addLogListener(this);
            this.console.addText("All log channels have been connected");
         }
         else
         {
            for each(_loc2_ in param1)
            {
               if(_loc2_ != ALL_CHANNELS)
               {
                  this.clientLog.addLogChannelListener(_loc2_,this);
                  this.console.addText("Log channel " + _loc2_ + " has been connected");
               }
            }
         }
      }
      
      private function disconnectChannels(param1:Array) : void
      {
         var _loc2_:String = null;
         if(param1.length == 0)
         {
            this.console.addText("Usage: log disconnect channel_name1 [channel_name2 ...]");
            return;
         }
         if(param1[0] == ALL_CHANNELS)
         {
            this.clientLog.removeLogListener(this);
            this.console.addText("All log channels have been disconnected");
         }
         else
         {
            for each(_loc2_ in param1)
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

