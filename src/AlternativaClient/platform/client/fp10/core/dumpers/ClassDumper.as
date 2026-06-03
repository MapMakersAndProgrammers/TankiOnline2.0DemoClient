package platform.client.fp10.core.dumpers
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.dump.IDumper;
   import platform.client.fp10.core.registry.GameTypeRegistry;
   import platform.client.fp10.core.type.IGameClass;
   
   public class ClassDumper implements IDumper
   {
      
      private var osgi:OSGi;
      
      public function ClassDumper(param1:OSGi)
      {
         super();
         this.osgi = param1;
      }
      
      public function dump(param1:Array) : String
      {
         var _loc5_:String = null;
         var _loc2_:String = "====== Classes ======\n";
         var _loc3_:Vector.<IGameClass> = GameTypeRegistry(this.osgi.getService(GameTypeRegistry)).classList;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ = String(_loc4_ + 1);
            _loc2_ += _loc5_ + ". " + _loc3_[_loc4_] + "\n";
            _loc4_++;
         }
         return _loc2_ + "\n";
      }
      
      public function get dumperName() : String
      {
         return "class";
      }
   }
}

