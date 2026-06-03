package platform.client.fp10.core.resource
{
   import alternativa.osgi.service.clientlog.IClientLog;
   import platform.client.fp10.core.service.messagebox.IMessageBoxService;
   import platform.client.fp10.core.service.messagebox.MessageBoxType;
   import platform.client.fp10.core.service.serverlog.IServerLog;
   
   public class BatchResourceLoader implements IResourceLoadingListener
   {
      
      [Inject]
      public static var logService:IServerLog;
      
      [Inject]
      public static var clientLog:IClientLog;
      
      [Inject]
      public static var messageBoxService:IMessageBoxService;
      
      [Inject]
      public static var resourceLoader:IResourceLoader;
      
      private var listener:IBatchResourceLoaderListener;
      
      private var numLoadedResources:int;
      
      private var resources:Vector.<Resource>;
      
      public function BatchResourceLoader(param1:IBatchResourceLoaderListener)
      {
         super();
         if(param1 == null)
         {
            throw new ArgumentError("Parameter listener is null");
         }
         this.listener = param1;
      }
      
      public function load(param1:Vector.<Resource>) : void
      {
         var _loc2_:Resource = null;
         if(this.resources != null)
         {
            throw new Error("Loading in progress");
         }
         if(param1 == null)
         {
            throw new ArgumentError("Parameter resources is null");
         }
         this.resources = param1;
         this.numLoadedResources = 0;
         for each(_loc2_ in param1)
         {
            resourceLoader.loadResource(_loc2_,this,ResourcePriority.NORMAL);
         }
      }
      
      public function onResourceLoadingStart(param1:Resource) : void
      {
         this.listener.onResourceLoadingStart(param1);
      }
      
      public function onResourceLoadingProgress(param1:Resource, param2:int) : void
      {
         this.listener.onResourceLoadingProgress(param1,param2);
      }
      
      public function onResourceLoadingComplete(param1:Resource) : void
      {
         ++this.numLoadedResources;
         this.listener.onResourceLoadingComplete(param1);
         if(this.numLoadedResources == this.resources.length)
         {
            this.completeBatchLoading();
         }
      }
      
      public function onResourceLoadingError(param1:Resource, param2:String) : void
      {
         this.onResourceLoadingComplete(param1);
      }
      
      public function onResourceLoadingFatalError(param1:Resource, param2:String) : void
      {
         var _loc3_:String = "Fatal error. " + param2;
         clientLog.log("resource",_loc3_);
         messageBoxService.showMessage(MessageBoxType.ERROR,"",_loc3_,0);
      }
      
      private function completeBatchLoading() : void
      {
         this.resources = null;
         this.listener.onBatchLoadingComplete();
      }
   }
}

