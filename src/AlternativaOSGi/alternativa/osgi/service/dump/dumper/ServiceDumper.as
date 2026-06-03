package alternativa.osgi.service.dump.dumper
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.dump.IDumper;
   
   public class ServiceDumper implements IDumper
   {
      
      private var osgi:OSGi;
      
      public function ServiceDumper(param1:OSGi)
      {
         super();
         this.osgi = param1;
      }
      
      public function dump(param1:Array) : String
      {
         var _loc2_:String = "Registered services\n";
         var _loc3_:Vector.<Object> = this.osgi.serviceList;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc2_ += " " + (_loc4_ + 1).toString() + ": " + _loc3_[_loc4_] + "\n";
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function get dumperName() : String
      {
         return "service";
      }
   }
}

