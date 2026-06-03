package platform.client.core.general.spaces.models.tests.selfunload
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.registry.ModelRegistry;
   
   public class SelfUnloadModelBase extends Model
   {
      
      private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      
      protected var server:SelfUnloadModelServer = new SelfUnloadModelServer(IModel(this));
      
      private var client:ISelfUnloadModelBase = ISelfUnloadModelBase(this);
      
      private var modelId:Long = Long.getLong(0,100006);
      
      public function SelfUnloadModelBase()
      {
         super();
         var _loc1_:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
         _loc1_.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(SelfUnloadModelCC,false)));
      }
      
      protected function getInitParam() : SelfUnloadModelCC
      {
         return SelfUnloadModelCC(initParams[Model.object]);
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

