package platform.client.fp10.core.dispatcher
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Long;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.registry.GameTypeRegistry;
   import platform.client.fp10.core.registry.ModelRegistry;
   import platform.client.fp10.core.registry.ResourceRegistry;
   import platform.client.fp10.core.resource.BatchResourceLoader;
   import platform.client.fp10.core.resource.IBatchResourceLoaderListener;
   import platform.client.fp10.core.resource.Resource;
   import platform.client.fp10.core.resource.ResourceInfo;
   import platform.client.fp10.core.service.messagebox.IMessageBoxService;
   import platform.client.fp10.core.service.messagebox.MessageBoxButton;
   import platform.client.fp10.core.service.messagebox.MessageBoxType;
   import platform.client.fp10.core.service.serverlog.IServerLog;
   import platform.client.fp10.core.type.impl.GameClass;
   
   public class Dispatcher implements IBatchResourceLoaderListener
   {
      
      [Inject]
      public static var messageBoxService:IMessageBoxService;
      
      [Inject]
      public static var resourceRegistry:ResourceRegistry;
      
      [Inject]
      public static var gameTypeRegistry:GameTypeRegistry;
      
      [Inject]
      public static var modelRegistry:ModelRegistry;
      
      [Inject]
      public static var clientLog:IClientLog;
      
      [Inject]
      public static var serverLog:IServerLog;
      
      private static const LOG_CHANNEL:String = "dispatcher";
      
      private var listener:IDispatcherListener;
      
      private var batchResourceLoader:BatchResourceLoader;
      
      private var items:Vector.<DispatcherItem>;
      
      private var levels:Vector.<ResourceLevel>;
      
      private var currentLevelIndex:int;
      
      private var packetBytesTotal:int;
      
      private var packetBytesLoaded:int;
      
      private var loadingResourcesProgress:Dictionary;
      
      private var protocol:IProtocol;
      
      private var longCodec:ICodec;
      
      private var intCodec:ICodec;
      
      public function Dispatcher(param1:IDispatcherListener, param2:IProtocol)
      {
         super();
         if(param1 == null)
         {
            throw new ArgumentError("Parameter listener is null");
         }
         if(param2 == null)
         {
            throw new ArgumentError("Parameter codecFactory is null");
         }
         this.listener = param1;
         this.protocol = param2;
         this.longCodec = param2.getCodec(new TypeCodecInfo(Long,false));
         this.intCodec = param2.getCodec(new TypeCodecInfo(int,false));
         this.batchResourceLoader = new BatchResourceLoader(this);
         this.loadingResourcesProgress = new Dictionary();
      }
      
      public function loadPacket(param1:Vector.<DispatcherItem>) : void
      {
         if(this.isLoading())
         {
            throw new Error("Loading is in progress");
         }
         if(param1 == null)
         {
            throw new ArgumentError("Parameter items is null");
         }
         this.items = param1;
         this.prepareLevels();
         if(this.packetBytesTotal > 0)
         {
            resourceRegistry.onPacketLoadingStart();
         }
         this.currentLevelIndex = 0;
         this.loadCurrentLevel();
      }
      
      public function onBatchLoadingComplete() : void
      {
         this.completeLevelLoading();
      }
      
      public function onResourceLoadingStart(param1:Resource) : void
      {
         this.loadingResourcesProgress[param1] = 0;
         param1.status = "Loading in progress";
      }
      
      public function onResourceLoadingProgress(param1:Resource, param2:int) : void
      {
         this.loadingResourcesProgress[param1] = param2;
         resourceRegistry.onPacketLoadingProgress(this.packetBytesLoaded + this.getLoadingResourcesProgress(),this.packetBytesTotal);
      }
      
      public function onResourceLoadingComplete(param1:Resource) : void
      {
         this.packetBytesLoaded += int(this.loadingResourcesProgress[param1]);
         delete this.loadingResourcesProgress[param1];
      }
      
      private function getLoadingResourcesProgress() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         for each(_loc2_ in this.loadingResourcesProgress)
         {
            _loc1_ += _loc2_;
         }
         return _loc1_;
      }
      
      private function isLoading() : Boolean
      {
         return this.items != null;
      }
      
      private function prepareLevels() : void
      {
         var _loc1_:Vector.<Resource> = null;
         var _loc2_:Vector.<ClassDispatcherItem> = null;
         var _loc3_:DispatcherItem = null;
         var _loc4_:Resource = null;
         this.packetBytesTotal = 0;
         this.packetBytesLoaded = 0;
         this.levels = new Vector.<ResourceLevel>();
         for each(_loc3_ in this.items)
         {
            switch(_loc3_.type)
            {
               case DispatcherItem.CLASS:
                  if(_loc2_ == null)
                  {
                     _loc2_ = new Vector.<ClassDispatcherItem>();
                  }
                  _loc2_.push(_loc3_);
                  break;
               case DispatcherItem.RESOURCE:
                  _loc4_ = this.createResource(_loc3_);
                  if(!_loc4_.isLazy)
                  {
                     this.packetBytesTotal += _loc4_.downloadSize;
                     if(_loc1_ == null)
                     {
                        _loc1_ = new Vector.<Resource>();
                     }
                     _loc1_.push(_loc4_);
                  }
                  resourceRegistry.registerResource(_loc4_);
                  break;
               case DispatcherItem.LEVEL_SEPARATOR:
                  this.levels.push(new ResourceLevel(_loc2_,_loc1_));
                  _loc2_ = null;
                  _loc1_ = null;
            }
         }
         this.levels.push(new ResourceLevel(_loc2_,_loc1_));
      }
      
      private function loadCurrentLevel() : void
      {
         var _loc2_:ClassDispatcherItem = null;
         var _loc1_:ResourceLevel = this.levels[this.currentLevelIndex];
         if(_loc1_.classes != null)
         {
            for each(_loc2_ in _loc1_.classes)
            {
               this.registerClass(_loc2_);
            }
         }
         if(_loc1_.resources != null)
         {
            this.batchResourceLoader.load(_loc1_.resources);
         }
         else
         {
            this.completeLevelLoading();
         }
      }
      
      private function completeLevelLoading() : void
      {
         if(++this.currentLevelIndex == this.levels.length)
         {
            this.completePacketLoading();
         }
         else
         {
            this.loadCurrentLevel();
         }
      }
      
      private function completePacketLoading() : void
      {
         this.items = null;
         this.levels = null;
         resourceRegistry.onPacketLoadingStop();
         this.listener.onPacketLoadingComplete();
      }
      
      private function registerClass(param1:ClassDispatcherItem) : void
      {
         var clientClass:GameClass = null;
         var nullMapPosition:int = 0;
         var numModelsData:int = 0;
         var i:int = 0;
         var modelId:Long = null;
         var paramsCodec:ICodec = null;
         var modelParams:Object = null;
         var message:String = null;
         var classItem:ClassDispatcherItem = param1;
         try
         {
            clientClass = gameTypeRegistry.createClass(classItem.classId,classItem.parentId,classItem.modelIds);
            if(classItem.buffer == null)
            {
               return;
            }
            nullMapPosition = int(classItem.buffer.optionalMap.getReadPosition());
            classItem.buffer.optionalMap.setReadPosition(classItem.optionalMapPosition);
            if(classItem.buffer.reader != null)
            {
               numModelsData = int(this.intCodec.decode(classItem.buffer));
               i = 0;
               while(i < numModelsData)
               {
                  modelId = Long(this.longCodec.decode(classItem.buffer));
                  paramsCodec = modelRegistry.getModelConstructorCodec(modelId);
                  if(paramsCodec == null)
                  {
                     throw new Error("Constructor codec for model " + modelId + " not found");
                  }
                  modelParams = null;
                  if(!classItem.buffer.optionalMap.get())
                  {
                     modelParams = paramsCodec.decode(classItem.buffer);
                  }
                  clientClass.setModelParams(modelId,modelParams);
                  i++;
               }
               classItem.buffer.optionalMap.setReadPosition(nullMapPosition);
            }
         }
         catch(e:Error)
         {
            message = "Class registration error: " + e.getStackTrace();
            clientLog.log(LOG_CHANNEL,message);
            messageBoxService.showMessage(MessageBoxType.ERROR,"",message,MessageBoxButton.OK);
         }
      }
      
      private function createResource(param1:DispatcherItem) : Resource
      {
         var _loc2_:ResourceRegistry = ResourceRegistry(OSGi.getInstance().getService(ResourceRegistry));
         var _loc3_:ResourceDispatcherItem = ResourceDispatcherItem(param1);
         var _loc4_:ResourceInfo = _loc3_.resourceInfo;
         var _loc5_:Class = _loc2_.getResourceClass(_loc4_.type);
         if(_loc3_.resourceParams == null)
         {
            return Resource(new _loc5_(_loc4_));
         }
         return Resource(new _loc5_(_loc4_,_loc3_.resourceParams));
      }
      
      private function log(param1:String) : void
      {
         clientLog.log(LOG_CHANNEL,param1);
      }
   }
}

import platform.client.fp10.core.resource.Resource;
import platform.client.fp10.core.dispatcher.ClassDispatcherItem;

class ResourceLevel
{
   
   public var classes:Vector.<ClassDispatcherItem>;
   
   public var resources:Vector.<Resource>;
   
   public function ResourceLevel(param1:Vector.<ClassDispatcherItem>, param2:Vector.<Resource>)
   {
      super();
      this.classes = param1;
      this.resources = param2;
   }
}
