package package_39
{
   public class name_368 implements name_160
   {
      private var channels:Object = {};
      
      private var listeners:Vector.<name_450> = new Vector.<name_450>();
      
      private var channelBufferSize:int;
      
      public function name_368(channelBufferSize:int)
      {
         super();
         this.channelBufferSize = channelBufferSize;
      }
      
      public function log(channelName:String, text:String, ... vars) : void
      {
         this.method_620(channelName).log(this.method_621(text,vars));
      }
      
      public function logError(channelName:String, text:String, ... vars) : void
      {
         var message:String = this.method_621(text,vars);
         this.method_620(channelName).log(message);
         this.method_620("error").log(message);
      }
      
      public function getChannelStrings(channelName:String) : Vector.<String>
      {
         var channel:name_637 = this.channels[channelName];
         if(channel == null)
         {
            return null;
         }
         return channel.name_638();
      }
      
      public function addLogListener(listener:name_450) : void
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
      
      public function removeLogListener(listener:name_450) : void
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
      
      public function addLogChannelListener(channelName:String, listener:name_450) : void
      {
         this.method_620(channelName).addLogListener(listener);
      }
      
      public function removeLogChannelListener(channelName:String, listener:name_450) : void
      {
         this.method_620(channelName).removeLogListener(listener);
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
      
      private function method_620(channelName:String) : name_637
      {
         var listener:name_450 = null;
         var channel:name_637 = this.channels[channelName];
         if(channel == null)
         {
            channel = new name_637(channelName,this.channelBufferSize);
            this.channels[channelName] = channel;
            for each(listener in this.listeners)
            {
               channel.addLogListener(listener);
            }
         }
         return channel;
      }
      
      private function method_621(text:String, vars:Array) : String
      {
         for(var i:int = 0; i < vars.length; i++)
         {
            text = text.replace("%" + (i + 1),vars[i]);
         }
         return text;
      }
   }
}

