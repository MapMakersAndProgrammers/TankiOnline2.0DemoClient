package alternativa.osgi.service.clientlog
{
   public class ClientLog implements IClientLog
   {
      
      private var channels:Object = {};
      
      private var listeners:Vector.<IClientLogChannelListener> = new Vector.<IClientLogChannelListener>();
      
      private var channelBufferSize:int;
      
      public function ClientLog(param1:int)
      {
         super();
         this.channelBufferSize = param1;
      }
      
      public function log(param1:String, param2:String, ... rest) : void
      {
         this.getChannel(param1).log(this.insertVars(param2,rest));
      }
      
      public function logError(param1:String, param2:String, ... rest) : void
      {
         var _loc4_:String = this.insertVars(param2,rest);
         this.getChannel(param1).log(_loc4_);
         this.getChannel("error").log(_loc4_);
      }
      
      public function getChannelStrings(param1:String) : Vector.<String>
      {
         var _loc2_:ClientLogChannel = this.channels[param1];
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_.getStrings();
      }
      
      public function addLogListener(param1:IClientLogChannelListener) : void
      {
         var _loc3_:String = null;
         var _loc2_:int = this.listeners.indexOf(param1);
         if(_loc2_ < 0)
         {
            this.listeners.push(param1);
            for each(_loc3_ in this.getChannelNames())
            {
               this.addLogChannelListener(_loc3_,param1);
            }
         }
      }
      
      public function removeLogListener(param1:IClientLogChannelListener) : void
      {
         var _loc3_:String = null;
         var _loc2_:int = this.listeners.indexOf(param1);
         if(_loc2_ > -1)
         {
            for each(_loc3_ in this.getChannelNames())
            {
               this.removeLogChannelListener(_loc3_,param1);
            }
            this.listeners.splice(_loc2_,1);
         }
      }
      
      public function addLogChannelListener(param1:String, param2:IClientLogChannelListener) : void
      {
         this.getChannel(param1).addLogListener(param2);
      }
      
      public function removeLogChannelListener(param1:String, param2:IClientLogChannelListener) : void
      {
         this.getChannel(param1).removeLogListener(param2);
      }
      
      public function getChannelNames() : Vector.<String>
      {
         var _loc2_:String = null;
         var _loc1_:Vector.<String> = new Vector.<String>();
         for(_loc2_ in this.channels)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      private function getChannel(param1:String) : ClientLogChannel
      {
         var _loc3_:IClientLogChannelListener = null;
         var _loc2_:ClientLogChannel = this.channels[param1];
         if(_loc2_ == null)
         {
            _loc2_ = new ClientLogChannel(param1,this.channelBufferSize);
            this.channels[param1] = _loc2_;
            for each(_loc3_ in this.listeners)
            {
               _loc2_.addLogListener(_loc3_);
            }
         }
         return _loc2_;
      }
      
      private function insertVars(param1:String, param2:Array) : String
      {
         var _loc3_:int = 0;
         while(_loc3_ < param2.length)
         {
            param1 = param1.replace("%" + (_loc3_ + 1),param2[_loc3_]);
            _loc3_++;
         }
         return param1;
      }
   }
}

