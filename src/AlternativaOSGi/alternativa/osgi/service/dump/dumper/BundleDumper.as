package alternativa.osgi.service.dump.dumper
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.bundle.IBundleDescriptor;
   import alternativa.osgi.service.dump.IDumper;
   
   public class BundleDumper implements IDumper
   {
      
      private var osgi:OSGi;
      
      public function BundleDumper(param1:OSGi)
      {
         super();
         this.osgi = param1;
      }
      
      public function dump(param1:Array) : String
      {
         var _loc2_:String = "======= Registered bundles ======\n";
         var _loc3_:Vector.<IBundleDescriptor> = this.osgi.bundleList;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(_loc4_ < 9)
            {
               _loc2_ += " ";
            }
            _loc2_ += int(_loc4_ + 1).toString() + ". " + _loc3_[_loc4_].name + "\n";
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function get dumperName() : String
      {
         return "bundle";
      }
   }
}

