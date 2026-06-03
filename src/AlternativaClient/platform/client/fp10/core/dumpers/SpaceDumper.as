package platform.client.fp10.core.dumpers
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.dump.IDumper;
   import platform.client.fp10.core.registry.SpaceRegistry;
   import platform.client.fp10.core.type.ISpace;
   
   public class SpaceDumper implements IDumper
   {
      
      private var osgi:OSGi;
      
      public function SpaceDumper(param1:OSGi)
      {
         super();
         this.osgi = param1;
      }
      
      public function dump(param1:Array) : String
      {
         var _loc4_:ISpace = null;
         var _loc2_:String = "====== Spaces ======\n";
         var _loc3_:Vector.<ISpace> = SpaceRegistry(this.osgi.getService(SpaceRegistry)).spaces;
         for each(_loc4_ in _loc3_)
         {
            _loc2_ += "space id: " + (_loc4_.id == null ? "null" : _loc4_.id.toString()) + "\n";
         }
         return _loc2_ + "\n";
      }
      
      public function get dumperName() : String
      {
         return "space";
      }
   }
}

