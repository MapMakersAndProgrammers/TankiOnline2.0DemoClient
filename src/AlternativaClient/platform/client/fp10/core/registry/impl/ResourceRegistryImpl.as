package platform.client.fp10.core.registry.impl
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.IProtocol;
   import alternativa.types.Long;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.registry.ResourceRegistry;
   import platform.client.fp10.core.resource.IResourceLoader;
   import platform.client.fp10.core.resource.IResourceLoadingListener;
   import platform.client.fp10.core.resource.Resource;
   import platform.client.fp10.core.resource.ResourcePriority;
   import platform.client.fp10.core.service.loadingprogress.ILoadingProgressListener;
   import platform.client.fp10.core.service.loadingprogress.ILoadingProgressService;
   
   public class ResourceRegistryImpl implements ResourceRegistry, ILoadingProgressService
   {
      
      [Inject]
      public static var clientLog:IClientLog;
      
      [Inject]
      public static var resourceLoader:IResourceLoader;
      
      private static const LOG_CHANNEL:String = "resource";
      
      private var protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      
      private var resourceGetterCodec:ResourceGetterCodec;
      
      private var classEntries:Dictionary = new Dictionary();
      
      private var resourceById:Dictionary = new Dictionary();
      
      private var _resources:Vector.<Resource> = new Vector.<Resource>();
      
      private var packetListeners:ProgressListeners = new ProgressListeners();
      
      private var debugProgressIndicator:DebugProgressIndicator;
      
      public function ResourceRegistryImpl()
      {
         super();
         this.resourceGetterCodec = new ResourceGetterCodec(this);
         this.resourceGetterCodec.init(this.protocol);
      }
      
      public function registerTypeClasses(param1:int, param2:Class, param3:Class = null) : void
      {
         this.classEntries[param1] = new TypeClassEntry(param2,param3);
         this.protocol.registerCodecForType(param2,this.resourceGetterCodec);
      }
      
      public function getResourceClass(param1:int) : Class
      {
         return this.getTypeClassEntry(param1).resourceClass;
      }
      
      public function getResourceParametersClass(param1:int) : Class
      {
         return this.getTypeClassEntry(param1).parametersClass;
      }
      
      public function registerResource(param1:Resource) : void
      {
         this.resourceById[param1.id] = param1;
         this._resources.push(param1);
      }
      
      public function unregisterResource(param1:Long) : void
      {
         var _loc2_:Resource = this.resourceById[param1];
         if(_loc2_ == null)
         {
            return;
         }
         delete this.resourceById[param1];
         this._resources.splice(this._resources.indexOf(_loc2_),1);
      }
      
      public function getResource(param1:Long) : Resource
      {
         return this.resourceById[param1];
      }
      
      public function get resources() : Vector.<Resource>
      {
         return this._resources;
      }
      
      public function loadLazyResource(param1:Resource, param2:IResourceLoadingListener) : void
      {
         if(!param1.isLoaded)
         {
            resourceLoader.loadResource(param1,param2,ResourcePriority.LAZY);
         }
      }
      
      public function removeLazyListener(param1:Resource, param2:IResourceLoadingListener) : void
      {
         resourceLoader.removeResourceListener(param1,param2);
      }
      
      public function onPacketLoadingStart() : void
      {
         this.packetListeners.onLoadingStart();
      }
      
      public function onPacketLoadingStop() : void
      {
         this.packetListeners.onLoadingStop();
      }
      
      public function onPacketLoadingProgress(param1:int, param2:int) : void
      {
         this.packetListeners.onLoadingProgress(param1,param2);
      }
      
      public function addPacketListener(param1:ILoadingProgressListener) : void
      {
         this.packetListeners.addListener(param1);
      }
      
      public function removePacketListener(param1:ILoadingProgressListener) : void
      {
         this.packetListeners.removeListener(param1);
      }
      
      private function getTypeClassEntry(param1:int) : TypeClassEntry
      {
         var _loc2_:TypeClassEntry = this.classEntries[param1];
         if(_loc2_ == null)
         {
            throw new Error("Class information not found for resource type " + param1);
         }
         return _loc2_;
      }
   }
}

import alternativa.protocol.ICodec;
import alternativa.protocol.IProtocol;
import alternativa.protocol.ProtocolBuffer;
import alternativa.protocol.info.TypeCodecInfo;
import alternativa.types.Long;
import platform.client.fp10.core.registry.ResourceRegistry;
import platform.client.fp10.core.resource.Resource;
import platform.client.fp10.core.service.loadingprogress.ILoadingProgressListener;

class TypeClassEntry
{
   
   public var resourceClass:Class;
   
   public var parametersClass:Class;
   
   public function TypeClassEntry(param1:Class, param2:Class)
   {
      super();
      this.resourceClass = param1;
      this.parametersClass = param2;
   }
}

class ResourceGetterCodec implements ICodec
{
   
   private var resourceRegistry:ResourceRegistry;
   
   private var longCodec:ICodec;
   
   public function ResourceGetterCodec(param1:ResourceRegistry)
   {
      super();
      this.resourceRegistry = param1;
   }
   
   public function init(param1:IProtocol) : void
   {
      this.longCodec = param1.getCodec(new TypeCodecInfo(Long,false));
   }
   
   public function encode(param1:ProtocolBuffer, param2:Object) : void
   {
   }
   
   public function decode(param1:ProtocolBuffer) : Object
   {
      var _loc2_:Long = Long(this.longCodec.decode(param1));
      var _loc3_:Resource = this.resourceRegistry.getResource(_loc2_);
      if(_loc3_ == null)
      {
         throw new Error("Resource " + _loc2_ + " not found");
      }
      return _loc3_;
   }
}

class ProgressListeners
{
   
   public var listeners:Vector.<ILoadingProgressListener> = new Vector.<ILoadingProgressListener>();
   
   private var added:Vector.<ILoadingProgressListener> = new Vector.<ILoadingProgressListener>();
   
   private var removed:Vector.<ILoadingProgressListener> = new Vector.<ILoadingProgressListener>();
   
   private var locked:Boolean;
   
   public function ProgressListeners()
   {
      super();
   }
   
   public function addListener(param1:ILoadingProgressListener) : void
   {
      var _loc2_:int = 0;
      if(this.locked)
      {
         _loc2_ = int(this.removed.indexOf(param1));
         if(_loc2_ > -1)
         {
            this.removeByIndex(_loc2_,this.removed);
         }
         else if(this.listeners.indexOf(param1) < 0 && this.added.indexOf(param1) < 0)
         {
            this.added.push(param1);
         }
      }
      else if(this.listeners.indexOf(param1) < 0)
      {
         this.listeners.push(param1);
      }
   }
   
   public function removeListener(param1:ILoadingProgressListener) : void
   {
      var _loc2_:int = 0;
      if(this.locked)
      {
         _loc2_ = int(this.added.indexOf(param1));
         if(_loc2_ > -1)
         {
            this.removeByIndex(_loc2_,this.added);
         }
         else if(this.listeners.indexOf(param1) > -1 && this.removed.indexOf(param1) < 0)
         {
            this.removed.push(param1);
         }
      }
      else
      {
         _loc2_ = int(this.listeners.indexOf(param1));
         if(_loc2_ > -1)
         {
            this.removeByIndex(_loc2_,this.listeners);
         }
      }
   }
   
   public function onLoadingStart() : void
   {
      var _loc1_:ILoadingProgressListener = null;
      this.lock();
      for each(_loc1_ in this.listeners)
      {
         _loc1_.onLoadingStart();
      }
      this.unlock();
   }
   
   public function onLoadingStop() : void
   {
      var _loc1_:ILoadingProgressListener = null;
      this.lock();
      for each(_loc1_ in this.listeners)
      {
         _loc1_.onLoadingStop();
      }
      this.unlock();
   }
   
   public function onLoadingProgress(param1:int, param2:int) : void
   {
      var _loc3_:ILoadingProgressListener = null;
      this.lock();
      for each(_loc3_ in this.listeners)
      {
         _loc3_.onLoadingProgress(param1,param2);
      }
      this.unlock();
   }
   
   private function lock() : void
   {
      this.locked = true;
   }
   
   private function unlock() : void
   {
      var _loc1_:ILoadingProgressListener = null;
      this.locked = false;
      if(this.removed.length > 0)
      {
         for each(_loc1_ in this.removed)
         {
            this.removeByIndex(this.listeners.indexOf(_loc1_),this.listeners);
         }
         this.removed.length = 0;
      }
      if(this.added.length > 0)
      {
         for each(_loc1_ in this.added)
         {
            this.listeners.push(_loc1_);
         }
         this.added.length = 0;
      }
   }
   
   private function removeByIndex(param1:int, param2:Vector.<ILoadingProgressListener>) : void
   {
      var _loc3_:uint = param2.length;
      param2[param1] = param2[--_loc3_];
      param2.length = _loc3_;
   }
}
