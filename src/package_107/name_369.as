package package_107
{
   import flash.net.SharedObject;
   
   public class name_369 implements name_362
   {
      private static const SHARED_OBJECT_NAME:String = "connection";
      
      private var var_555:String;
      
      private var var_554:Vector.<int>;
      
      private var var_556:String;
      
      public function name_369(controlServerAddress:String, controlServerPorts:Vector.<int>, resourcesRootUrl:String)
      {
         super();
         this.var_555 = controlServerAddress;
         this.var_554 = controlServerPorts;
         this.var_556 = resourcesRootUrl;
      }
      
      public function get controlServerAddress() : String
      {
         return this.var_555;
      }
      
      public function get controlServerPorts() : Vector.<int>
      {
         return this.var_554;
      }
      
      public function get resourcesRootUrl() : String
      {
         return this.var_556;
      }
      
      public function method_605(host:String) : int
      {
         var so:SharedObject = SharedObject.getLocal(SHARED_OBJECT_NAME,"/");
         return so.data[host];
      }
      
      public function method_606(host:String, port:int) : void
      {
         var so:SharedObject = SharedObject.getLocal(SHARED_OBJECT_NAME,"/");
         so.data[host] = port;
         so.flush();
      }
   }
}

