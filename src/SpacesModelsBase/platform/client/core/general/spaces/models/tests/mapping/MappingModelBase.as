package platform.client.core.general.spaces.models.tests.mapping
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.type.IGameObject;
   
   public class MappingModelBase extends Model
   {
      
      private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      
      protected var server:MappingModelServer = new MappingModelServer(IModel(this));
      
      private var client:IMappingModelBase = IMappingModelBase(this);
      
      private var modelId:Long = Long.getLong(0,100013);
      
      private var _sendObjectId:Long = Long.getLong(0,100013);
      
      private var _sendObject_gameObjectCodec:ICodec;
      
      public function MappingModelBase()
      {
         super();
         this._sendObject_gameObjectCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      }
      
      override public function invoke(param1:Long, param2:ProtocolBuffer) : void
      {
         switch(param1)
         {
            case this._sendObjectId:
               this.client.sendObject(IGameObject(this._sendObject_gameObjectCodec.decode(param2)));
         }
      }
      
      override public function get id() : Long
      {
         return this.modelId;
      }
   }
}

