package platform.client.fp10.core.dumpers
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.dump.IDumper;
   import alternativa.types.Long;
   import flash.utils.getQualifiedClassName;
   import platform.client.fp10.core.registry.ModelRegistry;
   import platform.client.fp10.core.registry.SpaceRegistry;
   import platform.client.fp10.core.type.IGameClass;
   import platform.client.fp10.core.type.IGameObject;
   import platform.client.fp10.core.type.ISpace;
   
   public class ObjectDumper implements IDumper
   {
      
      private var osgi:OSGi;
      
      public function ObjectDumper(param1:OSGi)
      {
         super();
         this.osgi = param1;
      }
      
      public function dump(param1:Array) : String
      {
         var _loc6_:ISpace = null;
         var _loc7_:Vector.<IGameObject> = null;
         var _loc8_:IGameObject = null;
         var _loc9_:IGameClass = null;
         var _loc10_:Vector.<Long> = null;
         var _loc11_:int = 0;
         var _loc2_:String = "====== Objects ======\n";
         var _loc3_:ModelRegistry = ModelRegistry(this.osgi.getService(ModelRegistry));
         var _loc4_:Vector.<ISpace> = SpaceRegistry(this.osgi.getService(SpaceRegistry)).spaces;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc6_ = _loc4_[_loc5_];
            _loc2_ += "space id: " + _loc6_.id + "\n";
            _loc7_ = _loc6_.objects;
            for each(_loc8_ in _loc7_)
            {
               _loc2_ += "  object id: " + _loc8_.id + "\n";
               _loc9_ = _loc8_.gameClass;
               if(_loc9_ != null)
               {
                  _loc2_ += "    class id: " + _loc9_.id + "\n";
                  _loc10_ = _loc8_.gameClass.models;
                  if(_loc10_.length > 0)
                  {
                     _loc2_ += "    models:\n";
                     _loc11_ = 0;
                     while(_loc11_ < _loc10_.length)
                     {
                        _loc2_ += "      " + this.getClassName(_loc3_.getModel(_loc10_[_loc11_])) + " [" + _loc10_[_loc11_] + "]\n";
                        _loc11_++;
                     }
                  }
               }
               else
               {
                  _loc2_ += "    class id: null\n";
               }
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      public function get dumperName() : String
      {
         return "object";
      }
      
      private function getClassName(param1:Object) : String
      {
         var _loc2_:String = getQualifiedClassName(param1);
         var _loc3_:int = _loc2_.indexOf("::");
         if(_loc3_ > -1)
         {
            return _loc2_.substr(_loc3_ + 2);
         }
         return _loc2_;
      }
   }
}

