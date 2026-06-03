package alternativa.osgi.service.network
{
   import flash.net.SharedObject;
   
   public class NetworkService implements INetworkService
   {
      
      private static const SHARED_OBJECT_NAME:String = "connection";
      
      private var _controlServerAddress:String;
      
      private var _controlServerPorts:Vector.<int>;
      
      private var _resourcesRootUrl:String;
      
      public function NetworkService(param1:String, param2:Vector.<int>, param3:String)
      {
         super();
         this._controlServerAddress = param1;
         this._controlServerPorts = param2;
         this._resourcesRootUrl = param3;
      }
      
      public function get controlServerAddress() : String
      {
         return this._controlServerAddress;
      }
      
      public function get controlServerPorts() : Vector.<int>
      {
         return this._controlServerPorts;
      }
      
      public function get resourcesRootUrl() : String
      {
         return this._resourcesRootUrl;
      }
      
      public function getLastPort(param1:String) : int
      {
         var _loc2_:SharedObject = SharedObject.getLocal(SHARED_OBJECT_NAME,"/");
         return _loc2_.data[param1];
      }
      
      public function saveLastPort(param1:String, param2:int) : void
      {
         var _loc3_:SharedObject = SharedObject.getLocal(SHARED_OBJECT_NAME,"/");
         _loc3_.data[param1] = param2;
         _loc3_.flush();
      }
   }
}

