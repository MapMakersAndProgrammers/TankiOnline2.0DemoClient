package platform.client.fp10.core.resource
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.osgi.service.console.IConsole;
   import alternativa.osgi.service.launcherparams.ILauncherParams;
   import alternativa.types.Long;
   import flash.events.NetStatusEvent;
   import flash.net.SharedObject;
   import flash.net.SharedObjectFlushStatus;
   import flash.system.Capabilities;
   import flash.utils.ByteArray;
   import platform.client.fp10.core.service.localstorage.IResourceLocalStorage;
   import platform.client.fp10.core.service.messagebox.IMessageBoxService;
   import platform.client.fp10.core.service.messagebox.MessageBoxButton;
   import platform.client.fp10.core.service.messagebox.MessageBoxType;
   
   public class ResourceLocalStorage implements IResourceLocalStorage, IResourceLocalStorageInternal
   {
      
      private static const LOG_CHANNEL:String = "resource";
      
      private var clientLog:IClientLog;
      
      private var _enabled:Boolean;
      
      private var soStorage:SharedObject;
      
      private var resourceIndex:ResourceIndex;
      
      private var temporaryStorageState:Boolean;
      
      private var consoleCommands:Object;
      
      public function ResourceLocalStorage(param1:OSGi)
      {
         super();
         this.soStorage = SharedObject.getLocal("localstorage","/");
         this.resourceIndex = new ResourceIndex(this.soStorage);
         this.clientLog = IClientLog(param1.getService(IClientLog));
         var _loc2_:ILauncherParams = ILauncherParams(param1.getService(ILauncherParams));
         var _loc3_:String = _loc2_.getParameter("uselocalstorage");
         if(_loc3_ == "1")
         {
            this.enableStorage(true);
         }
         else if(_loc3_ == "0")
         {
            this._enabled = false;
         }
         else
         {
            this._enabled = this.soStorage.data.enabled;
         }
         this.initConsoleCommands(param1);
      }
      
      public function get enabled() : Boolean
      {
         return this._enabled;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         if(param1)
         {
            this.enableStorage(false);
         }
         else
         {
            this.temporaryStorageState = false;
            this.setEnabledInternal(false);
         }
      }
      
      public function getResourceData(param1:Long, param2:int, param3:String) : ByteArray
      {
         var _loc4_:ResourceObject = new ResourceObject(param1.toString(),param3);
         if(_loc4_.resourceVersion == param2)
         {
            return _loc4_.data;
         }
         this.resourceIndex.removeResourceData(_loc4_.resourceId,param3);
         _loc4_.clear();
         return null;
      }
      
      public function setResourceData(param1:Long, param2:int, param3:ByteArray, param4:String, param5:String) : void
      {
         param5 ||= Resource.DEFAULT_CLASSIFIER;
         var _loc6_:ResourceObject = new ResourceObject(param1.toString(),param5);
         _loc6_.resourceVersion = param2;
         _loc6_.data = param3;
         _loc6_.flush();
         this.resourceIndex.addResourceData(_loc6_.resourceId,param5,param4);
      }
      
      public function clearResourceData(param1:Long) : void
      {
         this.clearResourceDataStr(param1.toString());
      }
      
      public function clear() : void
      {
         var _loc2_:String = null;
         var _loc1_:Vector.<String> = this.resourceIndex.getResourceIds();
         for each(_loc2_ in _loc1_)
         {
            this.clearResourceDataStr(_loc2_);
         }
      }
      
      public function flushIndex() : void
      {
         this.soStorage.flush();
      }
      
      public function clearResourceDataStr(param1:String) : void
      {
         var _loc3_:String = null;
         var _loc4_:ResourceObject = null;
         var _loc2_:LocalStorageResourceInfo = this.resourceIndex.getResourceInfo(param1);
         if(_loc2_.empty)
         {
            return;
         }
         for each(_loc3_ in _loc2_.classifiers)
         {
            _loc4_ = new ResourceObject(param1,_loc3_);
            _loc4_.clear();
         }
         this.resourceIndex.removeResourceInfo(param1);
      }
      
      public function getResourceIndex() : ResourceIndex
      {
         return this.resourceIndex;
      }
      
      private function enableStorage(param1:Boolean) : void
      {
         var flushStatus:String = null;
         var message:String = null;
         var messageBoxService:IMessageBoxService = null;
         var temporary:Boolean = param1;
         this.temporaryStorageState = temporary;
         try
         {
            flushStatus = this.soStorage.flush(100 * (1 << 20));
         }
         catch(e:Error)
         {
            message = "Local SharedObject is not accessible for writing";
            clientLog.log(LOG_CHANNEL,message);
            messageBoxService = IMessageBoxService(OSGi.getInstance().getService(IMessageBoxService));
            messageBoxService.showMessage(MessageBoxType.ERROR,"",message,MessageBoxButton.CLOSE);
         }
         switch(flushStatus)
         {
            case SharedObjectFlushStatus.FLUSHED:
               this.setEnabledInternal(true);
               break;
            case SharedObjectFlushStatus.PENDING:
               this.soStorage.addEventListener(NetStatusEvent.NET_STATUS,this.onNetStatus);
         }
      }
      
      private function onNetStatus(param1:NetStatusEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         this.soStorage.removeEventListener(NetStatusEvent.NET_STATUS,this.onNetStatus);
         if(param1.info.code == "SharedObject.Flush.Failed")
         {
            _loc2_ = Capabilities.os.indexOf("Windows");
            _loc3_ = Capabilities.os.indexOf("Linux");
            _loc4_ = Capabilities.os.indexOf("Mac");
            if(_loc2_ >= 0 || (_loc3_ >= 0 || _loc4_ >= 0) && this.soStorage.flush(100 * (1 << 20)) == SharedObjectFlushStatus.PENDING)
            {
               this.setEnabledInternal(false);
            }
            else
            {
               this.setEnabledInternal(true);
            }
         }
         else
         {
            this.setEnabledInternal(true);
         }
      }
      
      private function setEnabledInternal(param1:Boolean) : void
      {
         if(!this.temporaryStorageState)
         {
            this.soStorage.data.enabled = param1;
         }
         this._enabled = param1;
      }
      
      private function initConsoleCommands(param1:OSGi) : void
      {
         var _loc2_:IConsole = IConsole(param1.getService(IConsole));
         _loc2_.setCommandHandler("locstor",this.onConsoleCommand);
         this.consoleCommands = {};
         this.addConsoleCommand(new PrintIndexCommand("ls",this));
         this.addConsoleCommand(new DeleteResourceCommand("del",this));
         this.addConsoleCommand(new ClearStorageCommand("clear",this));
         this.addConsoleCommand(new StatusCommand("status",this));
         this.addConsoleCommand(new EnableStorageCommand("enable",this));
         this.addConsoleCommand(new DisableStorageCommand("disable",this));
         this.addConsoleCommand(new FlushStorageIndexCommand("flush",this));
      }
      
      private function addConsoleCommand(param1:ConsoleCommand) : void
      {
         this.consoleCommands[param1.name] = param1;
      }
      
      private function onConsoleCommand(param1:IConsole, param2:Array) : void
      {
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc3_:ConsoleCommand = this.consoleCommands[param2.shift()];
         if(_loc3_ == null)
         {
            param1.addText("Usage: locstor command [command arguments]");
            param1.addText("Available commands are:");
            _loc4_ = [];
            for(_loc5_ in this.consoleCommands)
            {
               _loc4_.push(_loc5_);
            }
            _loc4_.sort();
            for each(_loc5_ in _loc4_)
            {
               param1.addText(ConsoleCommand(this.consoleCommands[_loc5_]).description);
            }
            return;
         }
         _loc3_.execute(param1,param2);
      }
   }
}

import alternativa.osgi.service.console.IConsole;
import flash.net.SharedObject;
import flash.utils.ByteArray;
import platform.client.fp10.core.resource.ResourceLocalStorage;

class ResourceObject
{
   
   private var sharedObject:SharedObject;
   
   private var _resourceId:String;
   
   public function ResourceObject(param1:String, param2:String)
   {
      super();
      var _loc3_:String = param1 + "-" + param2;
      this.sharedObject = SharedObject.getLocal(_loc3_,"/");
      this._resourceId = param1;
   }
   
   public function get resourceId() : String
   {
      return this._resourceId;
   }
   
   public function get resourceVersion() : int
   {
      return this.sharedObject.data.version;
   }
   
   public function set resourceVersion(param1:int) : void
   {
      this.sharedObject.data.version = param1;
   }
   
   public function get data() : ByteArray
   {
      return this.sharedObject.data.data;
   }
   
   public function set data(param1:ByteArray) : void
   {
      this.sharedObject.data.data = param1;
   }
   
   public function flush() : void
   {
      this.sharedObject.flush();
   }
   
   public function clear() : void
   {
      this.sharedObject.clear();
   }
}

class ResourceIndex
{
   
   private var sharedObject:SharedObject;
   
   private var index:Object;
   
   public function ResourceIndex(param1:SharedObject)
   {
      super();
      this.sharedObject = param1;
      this.index = param1.data.index;
      if(this.index == null)
      {
         this.index = {};
         param1.data.index = this.index;
      }
   }
   
   public function getResourceInfo(param1:String) : LocalStorageResourceInfo
   {
      return new LocalStorageResourceInfo(this.index[param1]);
   }
   
   public function setResourceInfo(param1:String, param2:LocalStorageResourceInfo) : void
   {
      if(param2 == null)
      {
         this.removeResourceInfo(param1);
      }
      else
      {
         this.index[param1] = param2.rawData;
      }
   }
   
   public function removeResourceInfo(param1:String) : void
   {
      delete this.index[param1];
   }
   
   public function addResourceData(param1:String, param2:String, param3:String) : void
   {
      var _loc4_:LocalStorageResourceInfo = this.getResourceInfo(param1);
      _loc4_.description = param3;
      var _loc5_:Array = _loc4_.classifiers;
      if(_loc5_.indexOf(param2) < 0)
      {
         _loc5_.push(param2);
      }
      this.setResourceInfo(param1,_loc4_);
   }
   
   public function removeResourceData(param1:String, param2:String) : void
   {
      var _loc3_:LocalStorageResourceInfo = this.getResourceInfo(param1);
      if(_loc3_.empty)
      {
         return;
      }
      var _loc4_:Array = _loc3_.classifiers;
      var _loc5_:int = _loc4_.indexOf(param2);
      if(_loc5_ >= 0)
      {
         if(_loc4_.length == 1)
         {
            this.removeResourceInfo(param1);
         }
         else
         {
            _loc4_.splice(_loc5_,1);
            this.setResourceInfo(param1,_loc3_);
         }
      }
   }
   
   public function getResourceIds() : Vector.<String>
   {
      var _loc2_:String = null;
      var _loc1_:Vector.<String> = new Vector.<String>();
      for(_loc2_ in this.index)
      {
         _loc1_.push(_loc2_);
      }
      return _loc1_;
   }
}

class ConsoleCommand
{
   
   public var name:String;
   
   public var description:String;
   
   protected var storage:ResourceLocalStorage;
   
   public function ConsoleCommand(param1:String, param2:ResourceLocalStorage)
   {
      super();
      this.name = param1;
      this.storage = param2;
   }
   
   public function execute(param1:IConsole, param2:Array) : void
   {
   }
}

class PrintIndexCommand extends ConsoleCommand
{
   
   public function PrintIndexCommand(param1:String, param2:ResourceLocalStorage)
   {
      super(param1,param2);
      description = param1 + " -- lists all locally stored resources";
   }
   
   override public function execute(param1:IConsole, param2:Array) : void
   {
      var counter:int = 0;
      var sid:String = null;
      var resourceInfo:LocalStorageResourceInfo = null;
      var console:IConsole = param1;
      var params:Array = param2;
      var resourceIndex:ResourceIndex = storage.getResourceIndex();
      var resourceIds:Vector.<String> = resourceIndex.getResourceIds();
      resourceIds.sort(function(param1:String, param2:String):Number
      {
         if(param1 < param2)
         {
            return -1;
         }
         if(param1 > param2)
         {
            return 1;
         }
         return 0;
      });
      for each(sid in resourceIds)
      {
         resourceInfo = resourceIndex.getResourceInfo(sid);
         console.addText(++counter + ". " + sid + ": " + resourceInfo.description + ", " + resourceInfo.classifiers);
      }
   }
}

class DeleteResourceCommand extends ConsoleCommand
{
   
   public function DeleteResourceCommand(param1:String, param2:ResourceLocalStorage)
   {
      super(param1,param2);
      description = param1 + " resource_id -- removes locally stored resource with given id";
   }
   
   override public function execute(param1:IConsole, param2:Array) : void
   {
      var _loc3_:String = param2[0];
      if(!_loc3_)
      {
         param1.addText("Resource id should be specified");
         return;
      }
      storage.clearResourceDataStr(_loc3_);
      param1.addText("Resource " + _loc3_ + " has been removed from local storage");
   }
}

class ClearStorageCommand extends ConsoleCommand
{
   
   public function ClearStorageCommand(param1:String, param2:ResourceLocalStorage)
   {
      super(param1,param2);
      description = param1 + " -- wipes out all locally stored resources";
   }
   
   override public function execute(param1:IConsole, param2:Array) : void
   {
      storage.clear();
      param1.addText("Local storage has been cleared");
   }
}

class StatusCommand extends ConsoleCommand
{
   
   public function StatusCommand(param1:String, param2:ResourceLocalStorage)
   {
      super(param1,param2);
      description = param1 + " -- prints local storage status";
   }
   
   override public function execute(param1:IConsole, param2:Array) : void
   {
      param1.addText("Local storage is " + (storage.enabled ? "enabled" : "disabled"));
   }
}

class EnableStorageCommand extends ConsoleCommand
{
   
   public function EnableStorageCommand(param1:String, param2:ResourceLocalStorage)
   {
      super(param1,param2);
      description = param1 + " -- enables local storage";
   }
   
   override public function execute(param1:IConsole, param2:Array) : void
   {
      storage.enabled = true;
      param1.addText("Locale storage enabled");
   }
}

class DisableStorageCommand extends ConsoleCommand
{
   
   public function DisableStorageCommand(param1:String, param2:ResourceLocalStorage)
   {
      super(param1,param2);
      description = param1 + " -- disables local storage";
   }
   
   override public function execute(param1:IConsole, param2:Array) : void
   {
      storage.enabled = false;
      param1.addText("Locale storage disabled");
   }
}

class FlushStorageIndexCommand extends ConsoleCommand
{
   
   public function FlushStorageIndexCommand(param1:String, param2:ResourceLocalStorage)
   {
      super(param1,param2);
      description = param1 + " -- writes storage index to disk";
   }
   
   override public function execute(param1:IConsole, param2:Array) : void
   {
      storage.flushIndex();
   }
}

class LocalStorageResourceInfo
{
   
   public var empty:Boolean;
   
   public var rawData:Object;
   
   public function LocalStorageResourceInfo(param1:Object)
   {
      super();
      if(param1 == null)
      {
         this.empty = true;
         this.rawData = {};
      }
      else
      {
         this.rawData = param1;
      }
   }
   
   public function get description() : String
   {
      return this.rawData.description;
   }
   
   public function set description(param1:String) : void
   {
      this.rawData.description = param1;
   }
   
   public function get classifiers() : Array
   {
      var _loc1_:Array = this.rawData.classifiers;
      if(_loc1_ == null)
      {
         _loc1_ = [];
         this.rawData.classifiers = _loc1_;
      }
      return _loc1_;
   }
}
