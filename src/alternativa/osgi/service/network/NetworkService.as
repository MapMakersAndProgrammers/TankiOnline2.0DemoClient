package alternativa.osgi.service.network
{
   import flash.net.SharedObject;
   
   public class NetworkService implements INetworkService
   {
      private static const SHARED_OBJECT_NAME:String = "connection";
      
      private var var_556:String;
      
      private var var_555:Vector.<int>;
      
      private var var_554:String;
      
      public function NetworkService(controlServerAddress:String, controlServerPorts:Vector.<int>, resourcesRootUrl:String)
      {
         super();
         this.var_556 = controlServerAddress;
         this.var_555 = controlServerPorts;
         this.var_554 = resourcesRootUrl;
      }
      
      public function get controlServerAddress() : String
      {
         return this.var_556;
      }
      
      public function get controlServerPorts() : Vector.<int>
      {
         return this.var_555;
      }
      
      public function get resourcesRootUrl() : String
      {
         return this.var_554;
      }
      
      public function getLastPort(host:String) : int
      {
         var so:SharedObject = SharedObject.getLocal(SHARED_OBJECT_NAME,"/");
         return so.data[host];
      }
      
      public function saveLastPort(host:String, port:int) : void
      {
         var so:SharedObject = SharedObject.getLocal(SHARED_OBJECT_NAME,"/");
         so.data[host] = port;
         so.flush();
      }
   }
}

