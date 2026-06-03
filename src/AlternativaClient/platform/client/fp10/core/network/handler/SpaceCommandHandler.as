package platform.client.fp10.core.network.handler
{
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Long;
   import flash.utils.ByteArray;
   import platform.client.fp10.core.network.ConnectionCloseStatus;
   import platform.client.fp10.core.network.ICommandSender;
   import platform.client.fp10.core.network.command.SpaceOpenedCommand;
   import platform.client.fp10.core.registry.ModelRegistry;
   import platform.client.fp10.core.registry.SpaceRegistry;
   import platform.client.fp10.core.service.serverlog.IServerLog;
   import platform.client.fp10.core.type.IGameObject;
   import platform.client.fp10.core.type.impl.Space;
   
   public class SpaceCommandHandler implements ISpaceCommandHandler
   {
      
      [Inject]
      public static var serverLog:IServerLog;
      
      [Inject]
      public static var clientLog:IClientLog;
      
      [Inject]
      public static var spaceRegistry:SpaceRegistry;
      
      [Inject]
      public static var modelRegistry:ModelRegistry;
      
      [Inject]
      public static var protocol:IProtocol;
      
      private static const LOG_CHANNEL:String = "space";
      
      private var space:Space;
      
      private var commandSender:ICommandSender;
      
      private var hashCode:ByteArray;
      
      private var longCodec:ICodec;
      
      public function SpaceCommandHandler(param1:ByteArray)
      {
         super();
         this.hashCode = param1;
         this.longCodec = protocol.getCodec(new TypeCodecInfo(Long,false));
      }
      
      public function setSpace(param1:Space) : void
      {
         this.space = param1;
      }
      
      public function onConnectionOpen(param1:ICommandSender) : void
      {
         this.commandSender = param1;
         param1.sendCommand(new SpaceOpenedCommand(this.space.id,this.hashCode));
      }
      
      public function onConnectionClose(param1:ConnectionCloseStatus, param2:String = null) : void
      {
         var _loc3_:Vector.<IGameObject> = null;
         var _loc4_:int = 0;
         if(this.space.objects.length > 0)
         {
            _loc3_ = this.space.objects.slice();
            _loc4_ = _loc3_.length - 1;
            while(_loc4_ >= 0)
            {
               this.space.destroyObject(_loc3_[_loc4_].id);
               _loc4_--;
            }
         }
         spaceRegistry.removeSpace(this.space);
         this.commandSender = null;
      }
      
      public function executeCommand(param1:Object) : void
      {
         var methodId:Long = null;
         var object:IGameObject = null;
         var message:String = null;
         var command:Object = param1;
         var buffer:ProtocolBuffer = ProtocolBuffer(command);
         var objectId:Long = Long(this.longCodec.decode(buffer));
         methodId = Long(this.longCodec.decode(buffer));
         object = this.space.getObject(objectId);
         if(object != null)
         {
            try
            {
               spaceRegistry.currentSpace = this.space;
               modelRegistry.invoke(object,methodId,buffer);
            }
            catch(e:Error)
            {
               throw new Error("Command execution error. Object id=" + object.id + ", method id=" + methodId + ", Error=" + e.getStackTrace());
            }
            return;
         }
         message = "Вызов метода модели поведения для незагруженного объекта (objectId: " + objectId + ", methodId: " + methodId + ")";
         throw new Error(message);
      }
   }
}

