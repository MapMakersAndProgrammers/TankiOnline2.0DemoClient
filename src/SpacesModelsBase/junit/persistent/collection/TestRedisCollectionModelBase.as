package junit.persistent.collection
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   
   public class TestRedisCollectionModelBase extends Model
   {
      
      private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      
      protected var server:TestRedisCollectionModelServer = new TestRedisCollectionModelServer(IModel(this));
      
      private var client:ITestRedisCollectionModelBase = ITestRedisCollectionModelBase(this);
      
      private var modelId:Long = Long.getLong(0,100001);
      
      public function TestRedisCollectionModelBase()
      {
         super();
      }
      
      override public function invoke(param1:Long, param2:ProtocolBuffer) : void
      {
         var _loc3_:Long = param1;
         switch(0)
         {
         }
      }
      
      override public function get id() : Long
      {
         return this.modelId;
      }
   }
}

