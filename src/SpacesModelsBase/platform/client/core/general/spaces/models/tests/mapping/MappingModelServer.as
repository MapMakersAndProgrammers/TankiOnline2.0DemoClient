package platform.client.core.general.spaces.models.tests.mapping
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.OptionalMap;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Long;
   import flash.utils.ByteArray;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.network.command.SpaceCommand;
   import platform.client.fp10.core.type.IGameObject;
   import platform.client.fp10.core.type.ISpace;
   
   public class MappingModelServer
   {
      
      private var protocol:IProtocol;
      
      private var protocolBuffer:ProtocolBuffer;
      
      private var _testGameObjectId:Long = Long.getLong(0,100012);
      
      private var _testGameObject_gameObjectCodec:ICodec;
      
      private var model:IModel;
      
      public function MappingModelServer(param1:IModel)
      {
         super();
         this.model = param1;
         var _loc2_:ByteArray = new ByteArray();
         this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
         this.protocolBuffer = new ProtocolBuffer(_loc2_,_loc2_,new OptionalMap());
         this._testGameObject_gameObjectCodec = this.protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      }
      
      public function testGameObject(param1:IGameObject) : void
      {
         ByteArray(this.protocolBuffer.writer).position = 0;
         ByteArray(this.protocolBuffer.writer).length = 0;
         this._testGameObject_gameObjectCodec.encode(this.protocolBuffer,param1);
         ByteArray(this.protocolBuffer.writer).position = 0;
         if(Model.object == null)
         {
            throw new Error("ÐÑÐ·Ð¾Ð² ÑÐµÑÐ²ÐµÑÐ½Ð¾Ð³Ð¾ Ð¼ÐµÑÐ¾Ð´Ð° Ð±ÐµÐ· ÐºÐ¾Ð½ÑÐµÐºÑÑÐ°");
         }
         var _loc2_:SpaceCommand = new SpaceCommand(Model.object.id,this._testGameObjectId,this.protocolBuffer);
         var _loc3_:IGameObject = Model.object;
         var _loc4_:ISpace = _loc3_.space;
         _loc4_.commandSender.sendCommand(_loc2_);
         this.protocolBuffer.optionalMap.clear();
      }
   }
}

