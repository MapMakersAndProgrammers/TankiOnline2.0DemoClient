package alternativa.osgi.service.clientlog
{
   import alternativa.utils.CircularStringBuffer;
   
   public class ClientLogChannel
   {
      
      private var _name:String;
      
      private var buffer:CircularStringBuffer;
      
      private var listeners:Vector.<IClientLogChannelListener> = new Vector.<IClientLogChannelListener>();
      
      public function ClientLogChannel(param1:String, param2:int)
      {
         super();
         this._name = param1;
         this.buffer = new CircularStringBuffer(param2);
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function log(param1:String) : void
      {
         var _loc2_:IClientLogChannelListener = null;
         this.buffer.add(param1);
         for each(_loc2_ in this.listeners)
         {
            _loc2_.onLogEntryAdded(this._name,param1);
         }
      }
      
      public function getStrings() : Vector.<String>
      {
         return this.buffer.getStrings();
      }
      
      public function addLogListener(param1:IClientLogChannelListener) : void
      {
         var _loc2_:int = this.listeners.indexOf(param1);
         if(_loc2_ < 0)
         {
            this.listeners.push(param1);
         }
      }
      
      public function removeLogListener(param1:IClientLogChannelListener) : void
      {
         var _loc2_:int = this.listeners.indexOf(param1);
         if(_loc2_ > -1)
         {
            this.listeners.splice(_loc2_,1);
         }
      }
   }
}

