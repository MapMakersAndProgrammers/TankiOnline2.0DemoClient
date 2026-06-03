package platform.client.fp10.core.registry.impl
{
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.types.Long;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.registry.ModelRegistry;
   import platform.client.fp10.core.service.serverlog.IServerLog;
   import platform.client.fp10.core.type.IGameObject;
   
   public class ModelsRegistryImpl implements ModelRegistry
   {
      
      [Inject]
      public static var clientLog:IClientLog;
      
      [Inject]
      public static var logger:IServerLog;
      
      [Inject]
      public static var protocol:IProtocol;
      
      private static const LOG_CHANNEL:String = "modelsreg";
      
      private var modelById:Dictionary;
      
      private var modelsByInterface:Dictionary;
      
      private var modelInterfacesById:Dictionary;
      
      private var modelByMethod:Dictionary;
      
      private var model2constructorCodec:Dictionary;
      
      private var _models:Vector.<IModel>;
      
      private var class2Adapt:Dictionary = new Dictionary();
      
      private var class2Events:Dictionary = new Dictionary();
      
      public function ModelsRegistryImpl()
      {
         super();
         this.modelInterfacesById = new Dictionary();
         this.modelById = new Dictionary();
         this.modelByMethod = new Dictionary();
         this.modelsByInterface = new Dictionary();
         this.model2constructorCodec = new Dictionary();
         this._models = new Vector.<IModel>();
      }
      
      public function register(param1:Long, param2:Long) : void
      {
         this.modelByMethod[param2] = param1;
      }
      
      public function registerModelConstructorCodec(param1:Long, param2:ICodec) : void
      {
         this.model2constructorCodec[param1] = param2;
      }
      
      public function unregisterModelsParamsStruct(param1:Long) : void
      {
         delete this.model2constructorCodec[param1];
      }
      
      public function getModelConstructorCodec(param1:Long) : ICodec
      {
         return this.model2constructorCodec[param1];
      }
      
      public function add(param1:IModel, param2:Vector.<Class>) : void
      {
         var _loc5_:Class = null;
         var _loc6_:Vector.<IModel> = null;
         this._models.push(param1);
         var _loc3_:Long = param1.id;
         this.modelById[_loc3_] = param1;
         this.modelInterfacesById[_loc3_] = param2;
         var _loc4_:int = 0;
         while(_loc4_ < param2.length)
         {
            _loc5_ = param2[_loc4_];
            _loc6_ = this.modelsByInterface[_loc5_];
            if(_loc6_ == null)
            {
               this.modelsByInterface[_loc5_] = _loc6_ = new Vector.<IModel>();
            }
            _loc6_.push(param1);
            _loc4_++;
         }
      }
      
      public function remove(param1:Long) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:IModel = null;
         var _loc4_:Vector.<Class> = null;
         var _loc5_:int = 0;
         var _loc6_:Long = null;
         var _loc7_:Class = null;
         var _loc8_:Vector.<IModel> = null;
         var _loc9_:int = 0;
         this._models.splice(this._models.indexOf(this.modelById[param1]),1);
         for(_loc2_ in this.modelByMethod)
         {
            _loc6_ = this.modelByMethod[_loc2_];
            if(_loc6_ == param1)
            {
               delete this.modelByMethod[_loc2_];
            }
         }
         _loc3_ = IModel(this.modelById[param1]);
         _loc4_ = this.modelInterfacesById[param1] as Vector.<Class>;
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc7_ = _loc4_[_loc5_];
            _loc8_ = this.modelsByInterface[_loc7_] as Vector.<IModel>;
            _loc9_ = _loc8_.indexOf(_loc3_);
            _loc8_.splice(_loc9_,1);
            _loc5_++;
         }
         delete this.modelInterfacesById[param1];
         delete this.modelById[param1];
      }
      
      public function invoke(param1:IGameObject, param2:Long, param3:ProtocolBuffer) : void
      {
         var _loc4_:Long = Long(this.modelByMethod[param2]);
         var _loc5_:Model = Model(this.modelById[_loc4_]);
         if(_loc5_ != null)
         {
            Model.object = param1;
            _loc5_.invoke(param2,param3);
            Model.popObject();
         }
      }
      
      public function getModel(param1:Long) : IModel
      {
         return this.modelById[param1];
      }
      
      public function getModelsByInterface(param1:Class) : Vector.<IModel>
      {
         return this.modelsByInterface[param1];
      }
      
      public function getModelForObject(param1:IGameObject, param2:Class) : IModel
      {
         var _loc3_:IModel = null;
         var _loc6_:Long = null;
         var _loc7_:Vector.<Class> = null;
         var _loc8_:int = 0;
         var _loc4_:Vector.<Long> = param1.gameClass.models;
         var _loc5_:int = _loc4_.length - 1;
         while(_loc5_ >= 0)
         {
            _loc6_ = _loc4_[_loc5_];
            _loc7_ = this.modelInterfacesById[_loc6_] as Vector.<Class>;
            if(_loc7_ == null)
            {
               throw new Error("ModelsRegistryImpl::getModelForObject() No interfaces found. Object id=" + param1.id + ", model id=" + _loc6_);
            }
            _loc8_ = _loc7_.length - 1;
            while(_loc8_ >= 0)
            {
               if(_loc7_[_loc8_] == param2)
               {
                  if(_loc3_ == null)
                  {
                     _loc3_ = this.getModel(_loc6_);
                     break;
                  }
                  throw new Error("ModelsRegistryImpl::getModelForObject() Multiple models have been found. Object: " + param1 + ", interface: " + param2);
               }
               _loc8_--;
            }
            _loc5_--;
         }
         return _loc3_;
      }
      
      public function getModelsForObject(param1:IGameObject, param2:Class) : Vector.<IModel>
      {
         var _loc6_:Long = null;
         var _loc7_:Vector.<Class> = null;
         if(param1.gameClass == null)
         {
            throw new Error("ModelsRegistryImpl::getModelsForObject(): Object class not found. Object: " + param1 + ", interface: " + param2);
         }
         var _loc3_:Vector.<Long> = param1.gameClass.models;
         var _loc4_:Vector.<IModel> = new Vector.<IModel>();
         var _loc5_:int = _loc3_.length - 1;
         while(_loc5_ >= 0)
         {
            _loc6_ = _loc3_[_loc5_];
            _loc7_ = this.modelInterfacesById[_loc6_] as Vector.<Class>;
            if(_loc7_ != null && _loc7_.indexOf(param2) >= 0)
            {
               _loc4_.push(this.getModel(_loc6_));
            }
            _loc5_--;
         }
         return _loc4_;
      }
      
      public function getInterfacesForModel(param1:Long) : Vector.<Class>
      {
         return this.modelInterfacesById[param1];
      }
      
      public function get models() : Vector.<IModel>
      {
         return this._models;
      }
      
      public function registerAdapt(param1:Class, param2:Class) : void
      {
         this.class2Adapt[param1] = param2;
      }
      
      public function registerEvents(param1:Class, param2:Class) : void
      {
         this.class2Events[param1] = param2;
      }
      
      public function getAdaptClass(param1:Class) : Class
      {
         return this.class2Adapt[param1];
      }
      
      public function getEventsClass(param1:Class) : Class
      {
         return this.class2Events[param1];
      }
   }
}

