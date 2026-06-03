package platform.client.fp10.core.registry
{
   import alternativa.types.Long;
   import platform.client.fp10.core.resource.IResourceLoadingListener;
   import platform.client.fp10.core.resource.Resource;
   
   public interface ResourceRegistry
   {
      
      function registerTypeClasses(param1:int, param2:Class, param3:Class = null) : void;
      
      function getResourceClass(param1:int) : Class;
      
      function getResourceParametersClass(param1:int) : Class;
      
      function registerResource(param1:Resource) : void;
      
      function unregisterResource(param1:Long) : void;
      
      function getResource(param1:Long) : Resource;
      
      function get resources() : Vector.<Resource>;
      
      function loadLazyResource(param1:Resource, param2:IResourceLoadingListener) : void;
      
      function removeLazyListener(param1:Resource, param2:IResourceLoadingListener) : void;
      
      function onPacketLoadingStart() : void;
      
      function onPacketLoadingStop() : void;
      
      function onPacketLoadingProgress(param1:int, param2:int) : void;
   }
}

