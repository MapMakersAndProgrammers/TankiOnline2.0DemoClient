package alternativa.model.general.dispatcher
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.types.Long;
   import platform.client.core.general.spaces.models.dispatcher.DispatcherModelBase;
   import platform.client.core.general.spaces.models.dispatcher.IDispatcherModelBase;
   import platform.client.core.general.spaces.models.dispatcher.LoadObjectStruct;
   import platform.client.core.general.spaces.models.dispatcher.ModelData;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.IObjectLoadListener;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.registry.GameTypeRegistry;
   import platform.client.fp10.core.registry.ModelRegistry;
   import platform.client.fp10.core.registry.SpaceRegistry;
   import platform.client.fp10.core.service.messagebox.IMessageBoxService;
   import platform.client.fp10.core.service.messagebox.MessageBoxType;
   import platform.client.fp10.core.service.serverlog.IServerLog;
   import platform.client.fp10.core.type.IGameClass;
   import platform.client.fp10.core.type.IGameObject;
   import platform.client.fp10.core.type.ISpace;
   
   [ModelInfo]
   public class DispatcherModel extends DispatcherModelBase implements IDispatcherModelBase
   {
      
      [Inject]
      public static var serverLog:IServerLog;
      
      [Inject]
      public static var clientLog:IClientLog;
      
      [Inject]
      public static var classRegister:GameTypeRegistry;
      
      [Inject]
      public static var modelRegister:ModelRegistry;
      
      [Inject]
      public static var spaceService:SpaceRegistry;
      
      private static const LOG_CHANNEL:String = "dispatcher";
      
      public function DispatcherModel()
      {
         super();
      }
      
      public function loadObjects(param1:Vector.<LoadObjectStruct>) : void
      {
         var objectStruct:LoadObjectStruct = null;
         var stackTrace:String = null;
         var errorMessage:String = null;
         var object:IGameObject = null;
         var objectLoadListeners:IObjectLoadListener = null;
         var objects:Vector.<LoadObjectStruct> = param1;
         var currentSpace:ISpace = spaceService.currentSpace;
         for each(objectStruct in objects)
         {
            try
            {
               this.loadObject(objectStruct,currentSpace);
            }
            catch(e:Error)
            {
               stackTrace = e.getStackTrace();
               errorMessage = "Object loading error. Object id: " + objectStruct.id + ". Error: " + stackTrace;
               processError(errorMessage);
            }
         }
         for each(objectStruct in objects)
         {
            try
            {
               object = currentSpace.getObject(objectStruct.id);
               objectLoadListeners = IObjectLoadListener(object.event(IObjectLoadListener));
               objectLoadListeners.objectLoaded();
               objectLoadListeners.objectLoadedPost();
            }
            catch(e:Error)
            {
               stackTrace = e.getStackTrace();
               errorMessage = "Object loading event processing error. Object id: " + objectStruct.id + ". Error: " + stackTrace;
               processError(errorMessage);
            }
         }
      }
      
      public function unloadObjects(param1:Vector.<Long>) : void
      {
         var _loc2_:Long = null;
         for each(_loc2_ in param1)
         {
            spaceService.currentSpace.destroyObject(_loc2_);
         }
      }
      
      private function loadObject(param1:LoadObjectStruct, param2:ISpace) : void
      {
         var _loc9_:ModelData = null;
         var _loc10_:IModel = null;
         var _loc11_:Object = null;
         var _loc3_:Long = param1.id;
         var _loc4_:Long = param1.parent;
         var _loc5_:IGameClass = classRegister.getClass(_loc4_);
         if(_loc5_ == null)
         {
            throw new Error("Object class not found. Class id: " + _loc4_);
         }
         if(_loc3_ == param2.id)
         {
            param2.destroyObject(_loc3_);
         }
         var _loc6_:IGameObject = param2.createObject(_loc3_,_loc5_,"object " + _loc3_.toString());
         var _loc7_:Vector.<ModelData> = param1.data;
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_.length)
         {
            _loc9_ = _loc7_[_loc8_];
            _loc10_ = modelRegister.getModel(_loc9_.id);
            if(_loc10_ == null)
            {
               this.processError("Model [" + _loc9_.id + "] is missing. Object id: " + _loc3_);
            }
            else
            {
               _loc11_ = _loc9_.data || _loc5_.modelsParams[_loc9_.id];
               if(_loc11_ != null)
               {
                  Model.object = _loc6_;
                  _loc10_.putInitParams(_loc11_);
                  Model.popObject();
               }
            }
            _loc8_++;
         }
      }
      
      private function processError(param1:String) : void
      {
         clientLog.logError(LOG_CHANNEL,param1);
         this.showErrorMessage(param1);
      }
      
      private function showErrorMessage(param1:String) : void
      {
         IMessageBoxService(OSGi.getInstance().getService(IMessageBoxService)).showMessage(MessageBoxType.ERROR,"",param1,0);
      }
   }
}

