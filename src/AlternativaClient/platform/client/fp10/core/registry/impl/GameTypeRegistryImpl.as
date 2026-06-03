package platform.client.fp10.core.registry.impl
{
   import alternativa.types.Long;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.registry.GameTypeRegistry;
   import platform.client.fp10.core.type.IGameClass;
   import platform.client.fp10.core.type.impl.GameClass;
   
   public class GameTypeRegistryImpl implements GameTypeRegistry
   {
      
      private var _classes:Dictionary;
      
      private var _classList:Vector.<IGameClass>;
      
      public function GameTypeRegistryImpl()
      {
         super();
         this._classList = new Vector.<IGameClass>();
         this._classes = new Dictionary();
      }
      
      public function createClass(param1:Long, param2:Long, param3:Vector.<Long>) : GameClass
      {
         var _loc7_:Dictionary = null;
         var _loc8_:* = undefined;
         var _loc4_:IGameClass = this.getClass(param2);
         var _loc5_:GameClass = GameClass(_loc4_);
         var _loc6_:GameClass = new GameClass(param1,_loc5_,param3);
         if(_loc4_ != null)
         {
            _loc5_.addChild(_loc6_);
            _loc7_ = _loc5_.modelsParams;
            for(_loc8_ in _loc7_)
            {
               if(_loc7_[_loc8_] != null)
               {
                  _loc6_.setModelParams(_loc8_,_loc7_[_loc8_]);
               }
            }
         }
         this._classes[param1] = _loc6_;
         this._classList.push(_loc6_);
         return _loc6_;
      }
      
      public function destroyClass(param1:Long) : void
      {
         this._classList.splice(this._classList.indexOf(this._classes[param1]),1);
         this._classes[param1] = null;
      }
      
      public function getClass(param1:Long) : IGameClass
      {
         return this._classes[param1];
      }
      
      public function get classes() : Dictionary
      {
         return this._classes;
      }
      
      public function get classList() : Vector.<IGameClass>
      {
         return this._classList;
      }
   }
}

