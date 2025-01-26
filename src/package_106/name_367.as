package package_106
{
   import package_102.name_636;
   import package_31.name_202;
   import alternativa.osgi.OSGi;
   
   public class name_367 implements name_636
   {
      private var osgi:OSGi;
      
      public function name_367(osgi:OSGi)
      {
         super();
         this.osgi = osgi;
      }
      
      public function dump(params:Array) : String
      {
         var result:String = "======= Registered bundles ======\n";
         var bundles:Vector.<name_202> = this.osgi.method_122;
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

