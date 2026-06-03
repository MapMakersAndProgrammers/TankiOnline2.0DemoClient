package platform.client.core.general.spaces.models.quadro
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
   
   public class QuadroModelServer
   {
      
      private var protocol:IProtocol;
      
      private var protocolBuffer:ProtocolBuffer;
      
      private var _clickId:Long = Long.getLong(0,100004);
      
      private var _click_xCodec:ICodec;
      
      private var _click_yCodec:ICodec;
      
      private var model:IModel;
      
      public function QuadroModelServer(param1:IModel)
      {
         super();
         this.model = param1;
         var _loc2_:ByteArray = new ByteArray();
         this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
         this.protocolBuffer = new ProtocolBuffer(_loc2_,_loc2_,new OptionalMap());
         this._click_xCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
         this._click_yCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      }
      
      public function click(param1:int, param2:int) : void
      {
         ByteArray(this.protocolBuffer.writer).position = 0;
         ByteArray(this.protocolBuffer.writer).length = 0;
         this._click_xCodec.encode(this.protocolBuffer,param1);
         this._click_yCodec.encode(this.protocolBuffer,param2);
         ByteArray(this.protocolBuffer.writer).position = 0;
         if(Model.object == null)
         {
            throw new Error("ÐÑÐ·Ð¾Ð² ÑÐµÑÐ²ÐµÑÐ½Ð¾Ð³Ð¾ Ð¼ÐµÑÐ¾Ð´Ð° Ð±ÐµÐ· ÐºÐ¾Ð½ÑÐµÐºÑÑÐ°");
         }
         var _loc3_:SpaceCommand = new SpaceCommand(Model.object.id,this._clickId,this.protocolBuffer);
         var _loc4_:IGameObject = Model.object;
         var _loc5_:ISpace = _loc4_.space;
         _loc5_.commandSender.sendCommand(_loc3_);
         this.protocolBuffer.optionalMap.clear();
      }
   }
}

