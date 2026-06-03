package platform.client.fp10.core.resource
{
   public interface IBatchResourceLoaderListener
   {
      
      function onBatchLoadingComplete() : void;
      
      function onResourceLoadingStart(param1:Resource) : void;
      
      function onResourceLoadingProgress(param1:Resource, param2:int) : void;
      
      function onResourceLoadingComplete(param1:Resource) : void;
   }
}

