package platform.client.core.general.spaces.models.dispatcher
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.CollectionCodecInfo;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   
   public class DispatcherModelBase extends Model
   {
      
      private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      
      protected var server:DispatcherModelServer = new DispatcherModelServer(IModel(this));
      
      private var client:IDispatcherModelBase = IDispatcherModelBase(this);
      
      private var modelId:Long = Long.getLong(0,100003);
      
      private var _loadObjectsId:Long = Long.getLong(0,100000);
      
      private var _loadObjects_objectsCodec:ICodec;
      
      private var _unloadObjectsId:Long = Long.getLong(0,100001);
      
      private var _unloadObjects_objectsCodec:ICodec;
      
      public function DispatcherModelBase()
      {
         super();
         this._loadObjects_objectsCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(LoadObjectStruct,false),false,1));
         this._unloadObjects_objectsCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,false),false,1));
      }
      
      override public function invoke(param1:Long, param2:ProtocolBuffer) : void
      {
         switch(param1)
         {
            case this._loadObjectsId:
               this.client.loadObjects(Vector.<LoadObjectStruct>(this._loadObjects_objectsCodec.decode(param2)));
               break;
            case this._unloadObjectsId:
               this.client.unloadObjects(Vector.<Long>(this._unloadObjects_objectsCodec.decode(param2)));
         }
      }
      
      override public function get id() : Long
      {
         return this.modelId;
      }
   }
}

