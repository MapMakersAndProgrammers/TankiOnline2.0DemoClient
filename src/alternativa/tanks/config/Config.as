package alternativa.tanks.config
{
   import alternativa.tanks.config.loaders.BlobsLoaderTask;
   import alternativa.tanks.config.loaders.SoundsLibrary;
   import alternativa.tanks.utils.TARAParser;
   import alternativa.tanks.utils.Task;
   import alternativa.tanks.utils.TaskEvent;
   import alternativa.tanks.utils.TaskSequence;
   import alternativa.utils.ByteArrayMap;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   
   [Event(name="complete",type="flash.events.Event")]
   public class Config extends EventDispatcher
   {
      public var mapData:ByteArrayMap;
      
      public var §_-WX§:TextureLibrary;
      
      public var tankParts:TankPartsLibrary;
      
      public var soundsLibrary:SoundsLibrary;
      
      public var §_-WG§:BlobLibrary = new BlobLibrary();
      
      private var §_-Qb§:XML;
      
      private var §_-d5§:TaskSequence;
      
      private var preloader:Preloader;
      
      private var §_-D9§:Object = {};
      
      public function Config()
      {
         super();
      }
      
      public function load(param1:String, param2:Preloader) : void
      {
         this.preloader = param2;
         this.§_-d5§ = new TaskSequence();
         var _loc3_:ConfigXMLLoader = new ConfigXMLLoader(param1,this);
         this.§_-d5§.addTask(_loc3_);
         _loc3_.addEventListener(TaskEvent.TASK_COMPLETE,this.onTaskProgress);
         var _loc4_:BlobsLoaderTask = new BlobsLoaderTask(this);
         this.§_-d5§.addTask(_loc4_);
         _loc4_.addEventListener(TaskEvent.TASK_PROGRESS,this.onTaskProgress);
         this.§_-WX§ = new TextureLibrary(this);
         this.§_-WX§.addEventListener(TaskEvent.TASK_PROGRESS,this.onTaskProgress);
         this.§_-d5§.addTask(this.§_-WX§);
         var _loc5_:Task = this.createMapLoadTask();
         this.§_-d5§.addTask(_loc5_);
         _loc5_.addEventListener(TaskEvent.TASK_COMPLETE,this.onTaskProgress);
         this.tankParts = new TankPartsLibrary(this);
         this.tankParts.addEventListener(TaskEvent.TASK_PROGRESS,this.onTaskProgress);
         this.§_-d5§.addTask(this.tankParts);
         this.soundsLibrary = new SoundsLibrary(this);
         this.soundsLibrary.addEventListener(TaskEvent.TASK_PROGRESS,this.onTaskProgress);
         this.§_-d5§.addTask(this.soundsLibrary);
         this.§_-d5§.addEventListener(Event.COMPLETE,this.onSequenceComplete);
         this.§_-d5§.run();
      }
      
      private function onTaskProgress(param1:TaskEvent) : void
      {
         this.preloader.addProgress(param1.progress / param1.total * 0.1);
      }
      
      public function getSkyboxId() : String
      {
         return this.xml.map.@skybox;
      }
      
      public function get xml() : XML
      {
         return this.§_-Qb§;
      }
      
      public function set xml(param1:XML) : void
      {
         this.§_-Qb§ = param1;
         this.parseOptions();
      }
      
      public function get options() : Object
      {
         return this.§_-D9§;
      }
      
      public function clear() : void
      {
         var _loc1_:* = undefined;
         for(_loc1_ in this.mapData.data)
         {
            delete this.mapData.data[_loc1_];
         }
         this.§_-Qb§ = null;
         this.mapData = null;
      }
      
      private function createMapLoadTask() : Task
      {
         return new MapLoadTask(this,this.setMapData);
      }
      
      private function onSequenceComplete(param1:Event) : void
      {
         this.§_-d5§ = null;
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function setMapData(param1:ByteArray) : void
      {
         var _loc2_:TARAParser = new TARAParser(param1);
         this.mapData = new ByteArrayMap(_loc2_.data);
      }
      
      private function parseOptions() : void
      {
         var _loc1_:XML = null;
         for each(_loc1_ in this.§_-Qb§.kernelOptions.option)
         {
            this.§_-D9§[_loc1_.@name] = _loc1_.toString();
         }
      }
   }
}

import alternativa.tanks.utils.Task;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.utils.ByteArray;

class ConfigXMLLoader extends Task
{
   private var config:Config;
   
   private var loader:URLLoader;
   
   private var url:String;
   
   public function ConfigXMLLoader(param1:String, param2:Config)
   {
      super();
      this.url = param1;
      this.config = param2;
   }
   
   override public function run() : void
   {
      this.loader = new URLLoader();
      this.loader.addEventListener(Event.COMPLETE,this.onLoadingComplete);
      this.loader.load(new URLRequest(this.url));
   }
   
   private function onLoadingComplete(param1:Event) : void
   {
      this.config.xml = XML(this.loader.data);
      this.loader = null;
      completeTask();
   }
}

class MapLoadTask extends Task
{
   private var callback:Function;
   
   private var config:Config;
   
   private var loader:URLLoader;
   
   public function MapLoadTask(param1:Config, param2:Function)
   {
      super();
      this.config = param1;
      this.callback = param2;
   }
   
   override public function run() : void
   {
      this.loader = new URLLoader();
      this.loader.dataFormat = URLLoaderDataFormat.BINARY;
      this.loader.addEventListener(Event.COMPLETE,this.onLoadingComplete);
      this.loader.load(new URLRequest(this.config.xml.map.@url));
   }
   
   private function onLoadingComplete(param1:Event) : void
   {
      this.callback.call(null,ByteArray(this.loader.data));
      this.loader = null;
      completeTask();
   }
}
