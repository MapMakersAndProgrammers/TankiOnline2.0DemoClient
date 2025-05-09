package package_16
{
   import flash.display.BitmapData;
   import flash.events.Event;
   import package_22.name_87;
   import package_22.name_90;
   
   public class name_91 extends class_15
   {
      private var textures:Object = {};
      
      private var var_193:BitmapData;
      
      private var var_34:name_90;
      
      public function name_91(param1:name_18)
      {
         super("Texture library loader",param1);
      }
      
      public function name_155(param1:String) : Object
      {
         return this.textures[param1] || this.method_129();
      }
      
      public function method_128(param1:String, param2:Object) : void
      {
         this.textures[param1] = param2;
      }
      
      override public function run() : void
      {
         var _loc3_:XML = null;
         var _loc1_:XML = config.xml.textures[0];
         var _loc2_:String = name_347.name_348(_loc1_.@baseUrl);
         this.var_34 = new name_90();
         for each(_loc3_ in _loc1_.texture)
         {
            this.var_34.addTask(new TextureLoader(_loc3_.@id,_loc2_ + _loc3_.@url,this));
         }
         this.var_34.addEventListener(name_87.TASK_COMPLETE,this.method_130);
         this.var_34.addEventListener(Event.COMPLETE,this.method_32);
         this.var_34.run();
      }
      
      private function method_130(param1:name_87) : void
      {
         dispatchEvent(new name_87(name_87.TASK_PROGRESS,1,this.var_34.length));
      }
      
      private function method_32(param1:Event) : void
      {
         this.var_34 = null;
         name_88();
      }
      
      private function method_129() : BitmapData
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this.var_193 == null)
         {
            _loc1_ = 128;
            _loc2_ = 16711935;
            this.var_193 = new BitmapData(_loc1_,_loc1_,false,0);
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               _loc4_ = 0;
               while(_loc4_ < _loc1_)
               {
                  this.var_193.setPixel(Boolean(_loc3_ % 2) ? _loc4_ : _loc4_ + 1,_loc3_,_loc2_);
                  _loc4_ += 2;
               }
               _loc3_++;
            }
         }
         return this.var_193;
      }
   }
}

import flash.display.Bitmap;
import flash.display.Loader;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.utils.ByteArray;
import package_22.class_3;

class TextureLoader extends class_3
{
   private var id:String;
   
   private var url:String;
   
   private var library:name_91;
   
   private var loader:Loader;
   
   private var urlLoader:URLLoader;
   
   public function TextureLoader(param1:String, param2:String, param3:name_91)
   {
      super();
      this.id = param1;
      this.url = param2;
      this.library = param3;
   }
   
   override public function run() : void
   {
      if(this.url.indexOf(".atf") > 0)
      {
         this.urlLoader = new URLLoader();
         this.urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
         this.urlLoader.addEventListener(Event.COMPLETE,this.onLoadingCompressedComplete);
         this.urlLoader.load(new URLRequest(this.url));
      }
      else
      {
         this.loader = new Loader();
         this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoadingComplete);
         this.loader.load(new URLRequest(this.url));
      }
   }
   
   private function onLoadingCompressedComplete(param1:Event) : void
   {
      this.library.method_128(this.id,ByteArray(this.urlLoader.data));
      name_88();
   }
   
   private function onLoadingComplete(param1:Event) : void
   {
      this.library.method_128(this.id,Bitmap(this.loader.content).bitmapData);
      name_88();
   }
}
