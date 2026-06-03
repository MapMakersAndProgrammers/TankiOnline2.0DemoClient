package platform.client.fp10.core.dumpers
{
   import alternativa.osgi.service.dump.IDumper;
   import platform.client.fp10.core.registry.ResourceRegistry;
   import platform.client.fp10.core.resource.Resource;
   
   public class ResourceDumper implements IDumper
   {
      
      [Inject]
      public static var resourceRegistry:ResourceRegistry;
      
      public function ResourceDumper()
      {
         super();
      }
      
      public function get dumperName() : String
      {
         return "resource";
      }
      
      public function dump(param1:Array) : String
      {
         return this.getResourceList();
      }
      
      private function getResourceList() : String
      {
         var _loc4_:Resource = null;
         var _loc1_:String = "";
         var _loc2_:Vector.<Resource> = resourceRegistry.resources;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            _loc1_ += _loc4_.toString() + "\n";
            _loc3_++;
         }
         return _loc1_;
      }
   }
}

