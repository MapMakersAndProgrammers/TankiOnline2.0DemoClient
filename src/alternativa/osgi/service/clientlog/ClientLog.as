package alternativa.osgi.service.clientlog
{
   public class ClientLog implements IClientLog
   {
      private var channels:Object = {};
      
      private var listeners:Vector.<IClientLogChannelListener> = new Vector.<IClientLogChannelListener>();
      
      private var channelBufferSize:int;
      
      public function ClientLog(channelBufferSize:int)
      {
         super();
         this.channelBufferSize = channelBufferSize;
      }
      
      public function log(channelName:String, text:String, ... vars) : void
      {
         this.getChannel(channelName).log(this.insertVars(text,vars));
      }
      
      public function logError(channelName:String, text:String, ... vars) : void
      {
         var message:String = this.insertVars(text,vars);
         this.getChannel(channelName).log(message);
         this.getChannel("error").log(message);
      }
      
      public function getChannelStrings(channelName:String) : Vector.<String>
      {
         var channel:ClientLogChannel = this.channels[channelName];
         if(channel == null)
         {
            return null;
         }
         return channel.getStrings();
      }
      
      public function addLogListener(listener:IClientLogChannelListener) : void
      {
         var channelName:String = null;
         var i:int = int(this.listeners.indexOf(listener));
         if(i < 0)
         {
            this.listeners.push(listener);
            for each(channelName in this.getChannelNames())
            {
               this.addLogChannelListener(channelName,listener);
            }
         }
      }
      
      public function removeLogListener(listener:IClientLogChannelListener) : void
      {
         var channelName:String = null;
         var i:int = int(this.listeners.indexOf(listener));
         if(i > -1)
         {
            for each(channelName in this.getChannelNames())
            {
               this.removeLogChannelListener(channelName,listener);
            }
            this.listeners.splice(i,1);
         }
      }
      
      public function addLogChannelListener(channelName:String, listener:IClientLogChannelListener) : void
      {
         this.getChannel(channelName).addLogListener(listener);
      }
      
      public function removeLogChannelListener(channelName:String, listener:IClientLogChannelListener) : void
      {
         this.getChannel(channelName).removeLogListener(listener);
      }
      
      public function getChannelNames() : Vector.<String>
      {
         var channelName:String = null;
         var result:Vector.<String> = new Vector.<String>();
         for(channelName in this.channels)
         {
            result.push(channelName);
         }
         return result;
      }
      
      private function getChannel(channelName:String) : ClientLogChannel
      {
         var listener:IClientLogChannelListener = null;
         var channel:ClientLogChannel = this.channels[channelName];
         if(channel == null)
         {
            channel = new ClientLogChannel(channelName,this.channelBufferSize);
            this.channels[channelName] = channel;
            for each(listener in this.listeners)
            {
               channel.addLogListener(listener);
            }
         }
         return channel;
      }
      
      private function insertVars(text:String, vars:Array) : String
      {
         for(var i:int = 0; i < vars.length; i++)
         {
            text = text.replace("%" + (i + 1),vars[i]);
         }
         return text;
      }
   }
}

