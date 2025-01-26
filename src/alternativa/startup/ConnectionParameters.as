package alternativa.startup
{
   public class ConnectionParameters
   {
      public var serverAddress:String;
      
      public var serverPorts:Vector.<int>;
      
      public var resourcesRootURL:String;
      
      public function ConnectionParameters(serverAddress:String, serverPorts:Vector.<int>, resourcesRootURL:String)
      {
         super();
         this.serverAddress = serverAddress;
         this.serverPorts = serverPorts;
         this.resourcesRootURL = resourcesRootURL;
      }
   }
}

