package package_16
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   import package_12.name_54;
   import package_22.class_3;
   import package_22.name_87;
   import package_22.name_89;
   import package_22.name_90;
   import package_23.name_92;
   import package_23.name_94;
   
   [Event(name="complete",type="flash.events.Event")]
   public class name_18 extends EventDispatcher
   {
      public var mapData:name_54;
      
      public var var_37:name_91;
      
      public var tankParts:name_95;
      
      public var soundsLibrary:name_92;
      
      public var name_67:name_93 = new name_93();
      
      private var var_35:XML;
      
      private var var_34:name_90;
      
      private var preloader:Preloader;
      
      private var var_36:Object = {};
      
      public function name_18()
      {
         super();
      }
      
      public function load(param1:String, param2:Preloader) : void
      {
         this.preloader = param2;
         this.var_34 = new name_90();
         var _loc3_:ConfigXMLLoader = new ConfigXMLLoader(param1,this);
         this.var_34.addTask(_loc3_);
         _loc3_.addEventListener(name_87.TASK_COMPLETE,this.method_28);
         var _loc4_:name_94 = new name_94(this);
         this.var_34.addTask(_loc4_);
         _loc4_.addEventListener(name_87.TASK_PROGRESS,this.method_28);
         this.var_37 = new name_91(this);
         this.var_37.addEventListener(name_87.TASK_PROGRESS,this.method_28);
         this.var_34.addTask(this.var_37);
         var _loc5_:class_3 = this.method_31();
         this.var_34.addTask(_loc5_);
         _loc5_.addEventListener(name_87.TASK_COMPLETE,this.method_28);
         this.tankParts = new name_95(this);
         this.tankParts.addEventListener(name_87.TASK_PROGRESS,this.method_28);
         this.var_34.addTask(this.tankParts);
         this.soundsLibrary = new name_92(this);
         this.soundsLibrary.addEventListener(name_87.TASK_PROGRESS,this.method_28);
         this.var_34.addTask(this.soundsLibrary);
         this.var_34.addEventListener(Event.COMPLETE,this.method_32);
         this.var_34.run();
      }
      
      private function method_28(param1:name_87) : void
      {
         this.preloader.method_27(param1.progress / param1.total * 0.1);
      }
      
      public function name_66() : String
      {
         return this.xml.map.@skybox;
      }
      
      public function get xml() : XML
      {
         return this.var_35;
      }
      
      public function set xml(param1:XML) : void
      {
         this.var_35 = param1;
         this.method_29();
      }
      
      public function get options() : Object
      {
         return this.var_36;
      }
      
      public function clear() : void
      {
         var _loc1_:* = undefined;
         for(_loc1_ in this.mapData.data)
         {
            delete this.mapData.data[_loc1_];
         }
         this.var_35 = null;
         this.mapData = null;
      }
      
      private function method_31() : class_3
      {
         return new MapLoadTask(this,this.method_30);
      }
      
      private function method_32(param1:Event) : void
      {
         this.var_34 = null;
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function method_30(param1:ByteArray) : void
      {
         var _loc2_:name_89 = new name_89(param1);
         this.mapData = new name_54(_loc2_.data);
      }
      
      private function method_29() : void
      {
         var _loc1_:XML = null;
         for each(_loc1_ in this.var_35.kernelOptions.option)
         {
            this.var_36[_loc1_.@name] = _loc1_.toString();
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
import package_22.class_3;

class ConfigXMLLoader extends class_3
{
   private var config:name_18;
   
   private var loader:URLLoader;
   
   private var url:String;
   
   public function ConfigXMLLoader(param1:String, param2:name_18)
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
      name_88();
   }
}

class MapLoadTask extends class_3
{
   private var callback:Function;
   
   private var config:name_18;
   
   private var loader:URLLoader;
   
   public function MapLoadTask(param1:name_18, param2:Function)
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
      name_88();
   }
}
