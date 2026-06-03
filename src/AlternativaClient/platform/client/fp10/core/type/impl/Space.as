package platform.client.fp10.core.type.impl
{
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.IProtocol;
   import alternativa.types.Long;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.model.IObjectLoadListener;
   import platform.client.fp10.core.network.Connection;
   import platform.client.fp10.core.network.ConnectionCloseStatus;
   import platform.client.fp10.core.network.ICommandSender;
   import platform.client.fp10.core.network.handler.ISpaceCommandHandler;
   import platform.client.fp10.core.protocol.codec.SpaceRootCodec;
   import platform.client.fp10.core.service.messagebox.IMessageBoxService;
   import platform.client.fp10.core.service.serverlog.IServerLog;
   import platform.client.fp10.core.type.*;
   
   public class Space implements ISpace
   {
      
      [Inject]
      public static var clientLog:IClientLog;
      
      [Inject]
      public static var serverLog:IServerLog;
      
      [Inject]
      public static var messageBoxService:IMessageBoxService;
      
      private static const LOG_CHANNEL:String = "space";
      
      private var _id:Long;
      
      private var objectById:Dictionary = new Dictionary();
      
      private var _objects:Vector.<IGameObject>;
      
      private var connection:Connection;
      
      public function Space(param1:Long, param2:ISpaceCommandHandler, param3:IProtocol)
      {
         super();
         this._id = param1;
         this._objects = new Vector.<IGameObject>();
         this.connection = new Connection(param3,new SpaceRootCodec(),param2);
         param2.setSpace(this);
         var _loc4_:GameClass = new GameClass(Long.getLong(0,0),null,new Vector.<Long>());
         this.createObject(param1,_loc4_,"Space object");
      }
      
      public function connect(param1:String, param2:Vector.<int>) : void
      {
         this.connection.connect(param1,param2);
      }
      
      public function close() : void
      {
         this.connection.close(ConnectionCloseStatus.SPACE_CLOSED);
      }
      
      public function createObject(param1:Long, param2:IGameClass, param3:String) : IGameObject
      {
         var _loc4_:GameObject = null;
         if(this.objectById[param1] == null)
         {
            _loc4_ = new GameObject(param1,GameClass(param2),param3,this);
            this.objectById[_loc4_.id] = _loc4_;
            this._objects.push(_loc4_);
         }
         return this.objectById[param1];
      }
      
      public function destroyObject(param1:Long) : void
      {
         var message:String = null;
         var objectLoadListener:IObjectLoadListener = null;
         var objectId:Long = param1;
         var clientObject:GameObject = this.objectById[objectId];
         if(clientObject !== null)
         {
            try
            {
               objectLoadListener = IObjectLoadListener(clientObject.event(IObjectLoadListener));
               objectLoadListener.objectUnloaded();
               objectLoadListener.objectUnloadedPost();
            }
            catch(e:Error)
            {
            }
            finally
            {
               this._objects.splice(this._objects.indexOf(this.objectById[objectId]),1);
               delete this.objectById[objectId];
            }
         }
      }
      
      public function getObject(param1:Long) : IGameObject
      {
         return this.objectById[param1];
      }
      
      public function get objects() : Vector.<IGameObject>
      {
         return this._objects;
      }
      
      public function get id() : Long
      {
         return this._id;
      }
      
      public function get commandSender() : ICommandSender
      {
         return this.connection;
      }
      
      public function get rootObject() : IGameObject
      {
         return this.getObject(this._id);
      }
      
      public function toString() : String
      {
         return "[Space id=" + this.id + "]";
      }
   }
}

