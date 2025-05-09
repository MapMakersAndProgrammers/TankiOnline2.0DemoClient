package §_-cv§
{
   import §_-O5§.§_-Hk§;
   import §_-aa§.§_-cS§;
   import §_-aa§.§_-i0§;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   import §return§.§_-Hr§;
   import §return§.§_-Ui§;
   import §return§.§_-h5§;
   import §return§.§_-pj§;
   
   [Event(name="complete",type="flash.events.Event")]
   public class §_-YU§ extends EventDispatcher
   {
      public var mapData:§_-Hk§;
      
      public var §_-WX§:§_-Tv§;
      
      public var tankParts:§_-Kz§;
      
      public var soundsLibrary:§_-i0§;
      
      public var §_-WG§:§_-o6§ = new §_-o6§();
      
      private var §_-Qb§:XML;
      
      private var §_-d5§:§_-Ui§;
      
      private var preloader:Preloader;
      
      private var §_-D9§:Object = {};
      
      public function §_-YU§()
      {
         super();
      }
      
      public function load(param1:String, param2:Preloader) : void
      {
         this.preloader = param2;
         this.§_-d5§ = new §_-Ui§();
         var _loc3_:ConfigXMLLoader = new ConfigXMLLoader(param1,this);
         this.§_-d5§.addTask(_loc3_);
         _loc3_.addEventListener(§_-pj§.TASK_COMPLETE,this.§_-Ax§);
         var _loc4_:§_-cS§ = new §_-cS§(this);
         this.§_-d5§.addTask(_loc4_);
         _loc4_.addEventListener(§_-pj§.TASK_PROGRESS,this.§_-Ax§);
         this.§_-WX§ = new §_-Tv§(this);
         this.§_-WX§.addEventListener(§_-pj§.TASK_PROGRESS,this.§_-Ax§);
         this.§_-d5§.addTask(this.§_-WX§);
         var _loc5_:§_-h5§ = this.§_-kp§();
         this.§_-d5§.addTask(_loc5_);
         _loc5_.addEventListener(§_-pj§.TASK_COMPLETE,this.§_-Ax§);
         this.tankParts = new §_-Kz§(this);
         this.tankParts.addEventListener(§_-pj§.TASK_PROGRESS,this.§_-Ax§);
         this.§_-d5§.addTask(this.tankParts);
         this.soundsLibrary = new §_-i0§(this);
         this.soundsLibrary.addEventListener(§_-pj§.TASK_PROGRESS,this.§_-Ax§);
         this.§_-d5§.addTask(this.soundsLibrary);
         this.§_-d5§.addEventListener(Event.COMPLETE,this.§_-Pw§);
         this.§_-d5§.run();
      }
      
      private function §_-Ax§(param1:§_-pj§) : void
      {
         this.preloader.§_-fE§(param1.progress / param1.total * 0.1);
      }
      
      public function §_-f§() : String
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
         this.static();
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
      
      private function §_-kp§() : §_-h5§
      {
         return new MapLoadTask(this,this.§_-SN§);
      }
      
      private function §_-Pw§(param1:Event) : void
      {
         this.§_-d5§ = null;
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function §_-SN§(param1:ByteArray) : void
      {
         var _loc2_:§_-Hr§ = new §_-Hr§(param1);
         this.mapData = new §_-Hk§(_loc2_.data);
      }
      
      private function static() : void
      {
         var _loc1_:XML = null;
         for each(_loc1_ in this.§_-Qb§.kernelOptions.option)
         {
            this.§_-D9§[_loc1_.@name] = _loc1_.toString();
         }
      }
   }
}

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.utils.ByteArray;
import §return§.§_-h5§;

class ConfigXMLLoader extends §_-h5§
{
   private var config:§_-YU§;
   
   private var loader:URLLoader;
   
   private var url:String;
   
   public function ConfigXMLLoader(param1:String, param2:§_-YU§)
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
      §_-3Z§();
   }
}

class MapLoadTask extends §_-h5§
{
   private var callback:Function;
   
   private var config:§_-YU§;
   
   private var loader:URLLoader;
   
   public function MapLoadTask(param1:§_-YU§, param2:Function)
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
      §_-3Z§();
   }
}
