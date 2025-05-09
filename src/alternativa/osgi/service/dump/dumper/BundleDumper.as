package alternativa.osgi.service.dump.dumper
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.bundle.IBundleDescriptor;
   import alternativa.osgi.service.dump.IDumper;
   
   public class BundleDumper implements IDumper
   {
      private var osgi:OSGi;
      
      public function BundleDumper(osgi:OSGi)
      {
         super();
         this.osgi = osgi;
      }
      
      public function dump(params:Array) : String
      {
         var result:String = "======= Registered bundles ======\n";
         var bundles:Vector.<IBundleDescriptor> = this.osgi.bundleList;
         for(var i:int = 0; i < bundles.length; i++)
         {
            if(i < 9)
            {
               result += " ";
            }
            result += int(i + 1).toString() + ". " + bundles[i].name + "\n";
         }
         return result;
      }
      
      public function get dumperName() : String
      {
         return "bundle";
      }
   }
}

