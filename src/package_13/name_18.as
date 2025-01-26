package package_13
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   import package_15.name_55;
   import package_40.class_7;
   import package_40.name_169;
   import package_40.name_170;
   import package_40.name_171;
   import package_41.name_173;
   import package_41.name_175;
   
   [Event(name="complete",type="flash.events.Event")]
   public class name_18 extends EventDispatcher
   {
      public var mapData:name_55;
      
      public var var_37:name_172;
      
      public var tankParts:name_176;
      
      public var soundsLibrary:name_173;
      
      public var name_68:name_174 = new name_174();
      
      private var var_35:XML;
      
      private var var_34:name_170;
      
      private var preloader:Preloader;
      
      private var var_36:Object = {};
      
      public function name_18()
      {
         super();
      }
      
      public function load(param1:String, param2:Preloader) : void
      {
         this.preloader = param2;
         this.var_34 = new name_170();
         var _loc3_:ConfigXMLLoader = new ConfigXMLLoader(param1,this);
         this.var_34.addTask(_loc3_);
         _loc3_.addEventListener(name_169.TASK_COMPLETE,this.method_103);
         var _loc4_:name_175 = new name_175(this);
         this.var_34.addTask(_loc4_);
         _loc4_.addEventListener(name_169.TASK_PROGRESS,this.method_103);
         this.var_37 = new name_172(this);
         this.var_37.addEventListener(name_169.TASK_PROGRESS,this.method_103);
         this.var_34.addTask(this.var_37);
         var _loc5_:class_7 = this.method_106();
         this.var_34.addTask(_loc5_);
         _loc5_.addEventListener(name_169.TASK_COMPLETE,this.method_103);
         this.tankParts = new name_176(this);
         this.tankParts.addEventListener(name_169.TASK_PROGRESS,this.method_103);
         this.var_34.addTask(this.tankParts);
         this.soundsLibrary = new name_173(this);
         this.soundsLibrary.addEventListener(name_169.TASK_PROGRESS,this.method_103);
         this.var_34.addTask(this.soundsLibrary);
         this.var_34.addEventListener(Event.COMPLETE,this.method_107);
         this.var_34.run();
      }
      
      private function method_103(param1:name_169) : void
      {
         this.preloader.method_82(param1.progress / param1.total * 0.1);
      }
      
      public function name_67() : String
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
         this.method_104();
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
      
      private function method_106() : class_7
      {
         return new MapLoadTask(this,this.method_105);
      }
      
      private function method_107(param1:Event) : void
      {
         this.var_34 = null;
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function method_105(param1:ByteArray) : void
      {
         var _loc2_:name_171 = new name_171(param1);
         this.mapData = new name_55(_loc2_.data);
      }
      
      private function method_104() : void
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
import package_40.class_7;

class ConfigXMLLoader extends class_7
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
      method_102();
   }
}

class MapLoadTask extends class_7
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
      method_102();
   }
}
