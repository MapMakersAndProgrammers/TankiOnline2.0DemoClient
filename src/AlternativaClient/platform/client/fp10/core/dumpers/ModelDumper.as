package platform.client.fp10.core.dumpers
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.dump.IDumper;
   import flash.utils.getQualifiedClassName;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.registry.ModelRegistry;
   
   public class ModelDumper implements IDumper
   {
      
      private var osgi:OSGi;
      
      public function ModelDumper(param1:OSGi)
      {
         super();
         this.osgi = param1;
      }
      
      public function dump(param1:Array) : String
      {
         var _loc2_:String = null;
         var _loc5_:IModel = null;
         var _loc6_:Vector.<Class> = null;
         var _loc7_:Vector.<String> = null;
         var _loc8_:Class = null;
         var _loc9_:String = null;
         var _loc10_:int = 0;
         if(param1.length > 0)
         {
            _loc2_ = param1[0].toLowerCase();
         }
         var _loc3_:String = "====== Models ======\n";
         var _loc4_:ModelRegistry = ModelRegistry(this.osgi.getService(ModelRegistry));
         for each(_loc5_ in _loc4_.models)
         {
            if(!(_loc2_ != null && getQualifiedClassName(_loc5_).indexOf(_loc2_) < 0))
            {
               _loc3_ += getQualifiedClassName(_loc5_) + "\n";
               _loc3_ += "  id: " + _loc5_.id + "\n";
               _loc6_ = _loc4_.getInterfacesForModel(_loc5_.id);
               if(_loc6_ != null)
               {
                  _loc7_ = new Vector.<String>();
                  for each(_loc8_ in _loc6_)
                  {
                     _loc9_ = getQualifiedClassName(_loc8_);
                     _loc10_ = _loc9_.indexOf("::");
                     if(_loc10_ > -1)
                     {
                        _loc9_ = _loc9_.substr(_loc10_ + 2);
                     }
                     _loc7_.push(_loc9_);
                  }
                  _loc3_ += "  interfaces: " + _loc7_.join(", ") + "\n";
               }
               else
               {
                  _loc3_ += "  no interfaces found\n";
               }
            }
         }
         return _loc3_;
      }
      
      public function get dumperName() : String
      {
         return "model";
      }
   }
}

