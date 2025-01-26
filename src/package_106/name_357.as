package package_106
{
   import package_102.name_636;
   import package_5.name_3;
   
   public class name_357 implements name_636
   {
      private var osgi:name_3;
      
      public function name_357(osgi:name_3)
      {
         super();
         this.osgi = osgi;
      }
      
      public function dump(params:Array) : String
      {
         var result:String = "Registered services\n";
         var services:Vector.<Object> = this.osgi.method_119;
         for(var i:int = 0; i < services.length; i++)
         {
            result += " " + (i + 1).toString() + ": " + services[i] + "\n";
         }
         return result;
      }
      
      public function get dumperName() : String
      {
         return "service";
      }
   }
}

