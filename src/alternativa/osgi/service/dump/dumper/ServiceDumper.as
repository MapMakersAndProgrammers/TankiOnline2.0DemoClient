package alternativa.osgi.service.dump.dumper
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.dump.IDumper;
   
   public class ServiceDumper implements IDumper
   {
      private var osgi:OSGi;
      
      public function ServiceDumper(osgi:OSGi)
      {
         super();
         this.osgi = osgi;
      }
      
      public function dump(params:Array) : String
      {
         var result:String = "Registered services\n";
         var services:Vector.<Object> = this.osgi.serviceList;
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

