package alternativa.osgi.service.clientlog
{
   import alternativa.utils.CircularStringBuffer;
   
   public class ClientLogChannel
   {
      private var _name:String;
      
      private var buffer:CircularStringBuffer;
      
      private var listeners:Vector.<IClientLogChannelListener> = new Vector.<IClientLogChannelListener>();
      
      public function ClientLogChannel(name:String, bufferSize:int)
      {
         super();
         this._name = name;
         this.buffer = new CircularStringBuffer(bufferSize);
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function log(text:String) : void
      {
         var listener:IClientLogChannelListener = null;
         this.buffer.add(text);
         for each(listener in this.listeners)
         {
            listener.onLogEntryAdded(this._name,text);
         }
      }
      
      public function getStrings() : Vector.<String>
      {
         return this.buffer.getStrings();
      }
      
      public function addLogListener(listener:IClientLogChannelListener) : void
      {
         var i:int = int(this.listeners.indexOf(listener));
         if(i < 0)
         {
            this.listeners.push(listener);
         }
      }
      
      public function removeLogListener(listener:IClientLogChannelListener) : void
      {
         var i:int = int(this.listeners.indexOf(listener));
         if(i > -1)
         {
            this.listeners.splice(i,1);
         }
      }
   }
}

