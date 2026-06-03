package platform.client.fp10.core.type.impl
{
   import alternativa.types.Long;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.registry.ModelRegistry;
   import platform.client.fp10.core.service.serverlog.IServerLog;
   import platform.client.fp10.core.type.*;
   
   public class GameObject implements IGameObject
   {
      
      [Inject]
      public static var modelRegistry:ModelRegistry;
      
      [Inject]
      public static var serverLog:IServerLog;
      
      private var _name:String;
      
      private var _id:Long;
      
      private var _gameClass:GameClass;
      
      private var _space:ISpace;
      
      private var data:Dictionary = new Dictionary();
      
      private var _adapts:Dictionary = new Dictionary();
      
      private var _events:Dictionary = new Dictionary();
      
      private var _multyAdapts:Dictionary = new Dictionary();
      
      public function GameObject(param1:Long, param2:GameClass, param3:String, param4:ISpace)
      {
         super();
         this._id = param1;
         this._gameClass = param2;
         this._name = param3;
         this._space = param4;
      }
      
      public function putData(param1:Model, param2:Class, param3:Object) : void
      {
         var _loc4_:Dictionary = this.data[param1];
         if(_loc4_ == null)
         {
            _loc4_ = new Dictionary();
            this.data[param1] = _loc4_;
         }
         _loc4_[param2] = param3;
      }
      
      public function getData(param1:Model, param2:Class) : Object
      {
         var _loc3_:Dictionary = this.data[param1];
         return _loc3_ == null ? null : _loc3_[param2];
      }
      
      public function clearData(param1:Model, param2:Class) : Object
      {
         var _loc3_:Dictionary = this.data[param1];
         if(_loc3_ == null)
         {
            return null;
         }
         var _loc4_:Object = _loc3_[param2];
         delete _loc3_[param2];
         return _loc4_;
      }
      
      public function get id() : Long
      {
         return this._id;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get gameClass() : IGameClass
      {
         return this._gameClass;
      }
      
      public function get space() : ISpace
      {
         return this._space;
      }
      
      public function event(param1:Class) : Object
      {
         var _loc2_:Object = this._events[param1];
         if(_loc2_ == null)
         {
            _loc2_ = this._adapt(param1,true);
            this._events[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      public function hasModel(param1:Class) : Boolean
      {
         if(this._adapts[param1] == null)
         {
            return modelRegistry.getModelsForObject(this,param1).length > 0;
         }
         return true;
      }
      
      public function adapt(param1:Class) : Object
      {
         var _loc2_:Object = this._adapts[param1];
         if(_loc2_ == null)
         {
            _loc2_ = this._adapt(param1,false);
            if(_loc2_ == null)
            {
               throw new Error("GameObject::adapt() No models have been found. Object: " + this + ", interface: " + param1);
            }
            this._adapts[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      public function adaptMulti(param1:Class) : Vector.<Object>
      {
         var _loc3_:Class = null;
         var _loc4_:Vector.<IModel> = null;
         var _loc5_:int = 0;
         var _loc2_:Vector.<Object> = this._multyAdapts[param1];
         if(_loc2_ == null)
         {
            _loc3_ = modelRegistry.getAdaptClass(param1);
            _loc4_ = modelRegistry.getModelsForObject(this,param1);
            _loc2_ = new Vector.<Object>(_loc4_.length);
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               _loc2_[_loc5_] = new _loc3_(this,_loc4_[_loc5_]);
               _loc5_++;
            }
            this._multyAdapts[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      public function toString() : String
      {
         return "[GameObject id=" + this._id + "]";
      }
      
      private function _adapt(param1:Class, param2:Boolean) : Object
      {
         var _loc5_:uint = 0;
         var _loc3_:Vector.<IModel> = modelRegistry.getModelsForObject(this,param1);
         if(!param2)
         {
            _loc5_ = _loc3_.length;
            if(_loc5_ > 1)
            {
               throw new Error("GameObject::_adapt() Multiple models have been found. Object: " + this + ", interface: " + param1);
            }
            if(_loc5_ == 0)
            {
               return null;
            }
         }
         var _loc4_:Class = param2 ? modelRegistry.getEventsClass(param1) : modelRegistry.getAdaptClass(param1);
         if(_loc4_ == null)
         {
            throw new Error("Proxy class not found for specified interface");
         }
         return new _loc4_(this,param2 ? _loc3_ : _loc3_[0]);
      }
   }
}

