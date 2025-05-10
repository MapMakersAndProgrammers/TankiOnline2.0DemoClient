package alternativa.osgi.service.network
{
   import flash.net.SharedObject;
   
   public class NetworkService implements INetworkService
   {
      private static const SHARED_OBJECT_NAME:String = "connection";
      
      private var name_oQ:String;
      
      private var name_O7:Vector.<int>;
      
      private var name_5u:String;
      
      public function NetworkService(controlServerAddress:String, controlServerPorts:Vector.<int>, resourcesRootUrl:String)
      {
         super();
         this.name_oQ = controlServerAddress;
         this.name_O7 = controlServerPorts;
         this.name_5u = resourcesRootUrl;
      }
      
      public function get controlServerAddress() : String
      {
         return this.name_oQ;
      }
      
      public function get controlServerPorts() : Vector.<int>
      {
         return this.name_O7;
      }
      
      public function get resourcesRootUrl() : String
      {
         return this.name_5u;
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

