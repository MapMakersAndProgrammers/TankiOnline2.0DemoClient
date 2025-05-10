package alternativa.osgi.service.network
{
   import flash.net.SharedObject;
   
   public class NetworkService implements INetworkService
   {
      private static const SHARED_OBJECT_NAME:String = "connection";
      
      private var §_-oQ§:String;
      
      private var §_-O7§:Vector.<int>;
      
      private var §_-5u§:String;
      
      public function NetworkService(controlServerAddress:String, controlServerPorts:Vector.<int>, resourcesRootUrl:String)
      {
         super();
         this.§_-oQ§ = controlServerAddress;
         this.§_-O7§ = controlServerPorts;
         this.§_-5u§ = resourcesRootUrl;
      }
      
      public function get controlServerAddress() : String
      {
         return this.§_-oQ§;
      }
      
      public function get controlServerPorts() : Vector.<int>
      {
         return this.§_-O7§;
      }
      
      public function get resourcesRootUrl() : String
      {
         return this.§_-5u§;
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

