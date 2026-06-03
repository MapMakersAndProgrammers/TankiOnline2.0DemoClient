package platform.client.core.general.spaces.models.tests.pingpong
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   
   public class PingPongModelBase extends Model
   {
      
      private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      
      protected var server:PingPongModelServer = new PingPongModelServer(IModel(this));
      
      private var client:IPingPongModelBase = IPingPongModelBase(this);
      
      private var modelId:Long = Long.getLong(0,100010);
      
      private var _pongId:Long = Long.getLong(0,100003);
      
      public function PingPongModelBase()
      {
         super();
      }
      
      override public function invoke(param1:Long, param2:ProtocolBuffer) : void
      {
         switch(param1)
         {
            case this._pongId:
               this.client.pong();
         }
      }
      
      override public function get id() : Long
      {
         return this.modelId;
      }
   }
}

