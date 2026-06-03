package platform.client.fp10.core.type.impl
{
   import alternativa.osgi.OSGi;
   import alternativa.types.Long;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import platform.client.fp10.core.registry.ModelRegistry;
   import platform.client.fp10.core.type.*;
   
   public class GameClass implements IGameClass
   {
      
      private var _id:Long;
      
      private var _parent:GameClass;
      
      private var _children:Vector.<IGameClass>;
      
      private var _models:Vector.<Long>;
      
      private var _modelsParams:Dictionary;
      
      public function GameClass(param1:Long, param2:GameClass, param3:Vector.<Long> = null)
      {
         super();
         this._id = param1;
         this._parent = param2;
         this._children = new Vector.<IGameClass>();
         this._modelsParams = new Dictionary();
         if(param3 != null)
         {
            this._models = param3;
         }
         else
         {
            this._models = new Vector.<Long>();
         }
      }
      
      public function addChild(param1:IGameClass) : void
      {
         this._children.push(param1);
      }
      
      public function removeChild(param1:IGameClass) : void
      {
         this._children.splice(this._children.indexOf(param1),1);
      }
      
      public function get id() : Long
      {
         return this._id;
      }
      
      public function get parent() : IGameClass
      {
         return this._parent;
      }
      
      public function get children() : Vector.<IGameClass>
      {
         return this._children;
      }
      
      public function get models() : Vector.<Long>
      {
         return this._models;
      }
      
      public function get modelsParams() : Dictionary
      {
         return this._modelsParams;
      }
      
      public function setModelParams(param1:Long, param2:Object) : void
      {
         this._modelsParams[param1] = param2;
      }
      
      public function toString() : String
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:* = undefined;
         var _loc1_:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
         var _loc2_:String = "ClientClass\n";
         _loc2_ += "  id: " + this._id + "\n";
         if(this._parent != null)
         {
            _loc2_ += "  parent id: " + this._parent.id + "\n";
         }
         if(this._children.length > 0)
         {
            _loc2_ += "  children id:";
            _loc3_ = 0;
            while(_loc3_ < this._children.length)
            {
               _loc2_ += " " + this._children[_loc3_].id;
               _loc3_++;
            }
            _loc2_ += "\n";
         }
         if(this._models.length > 0)
         {
            _loc2_ += "  models:\n";
            _loc4_ = 0;
            while(_loc4_ < this._models.length)
            {
               _loc2_ += "    id: " + this._models[_loc4_] + ", class: " + getQualifiedClassName(_loc1_.getModel(this._models[_loc4_])) + "\n";
               _loc4_++;
            }
            _loc2_ += "  modelParams: \n";
            for(_loc5_ in this._modelsParams)
            {
               _loc2_ += "    " + _loc5_.toString() + ": " + this._modelsParams[_loc5_] + "\n";
            }
         }
         return _loc2_;
      }
   }
}

