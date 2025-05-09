package §_-cv§
{
   import flash.display.BitmapData;
   import flash.events.Event;
   import §return§.§_-Ui§;
   import §return§.§_-pj§;
   
   public class §_-Tv§ extends §_-FR§
   {
      private var textures:Object = {};
      
      private var §_-gh§:BitmapData;
      
      private var §_-d5§:§_-Ui§;
      
      public function §_-Tv§(param1:§_-YU§)
      {
         super("Texture library loader",param1);
      }
      
      public function §_-o0§(param1:String) : Object
      {
         return this.textures[param1] || this.§_-8P§();
      }
      
      public function §_-Co§(param1:String, param2:Object) : void
      {
         this.textures[param1] = param2;
      }
      
      override public function run() : void
      {
         var _loc3_:XML = null;
         var _loc1_:XML = config.xml.textures[0];
         var _loc2_:String = §_-NN§.§_-KN§(_loc1_.@baseUrl);
         this.§_-d5§ = new §_-Ui§();
         for each(_loc3_ in _loc1_.texture)
         {
            this.§_-d5§.addTask(new TextureLoader(_loc3_.@id,_loc2_ + _loc3_.@url,this));
         }
         this.§_-d5§.addEventListener(§_-pj§.TASK_COMPLETE,this.§_-fm§);
         this.§_-d5§.addEventListener(Event.COMPLETE,this.§_-Pw§);
         this.§_-d5§.run();
      }
      
      private function §_-fm§(param1:§_-pj§) : void
      {
         dispatchEvent(new §_-pj§(§_-pj§.TASK_PROGRESS,1,this.§_-d5§.length));
      }
      
      private function §_-Pw§(param1:Event) : void
      {
         this.§_-d5§ = null;
         §_-3Z§();
      }
      
      private function §_-8P§() : BitmapData
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this.§_-gh§ == null)
         {
            _loc1_ = 128;
            _loc2_ = 16711935;
            this.§_-gh§ = new BitmapData(_loc1_,_loc1_,false,0);
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               _loc4_ = 0;
               while(_loc4_ < _loc1_)
               {
                  this.§_-gh§.setPixel(Boolean(_loc3_ % 2) ? _loc4_ : _loc4_ + 1,_loc3_,_loc2_);
                  _loc4_ += 2;
               }
               _loc3_++;
            }
         }
         return this.§_-gh§;
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
import §return§.§_-h5§;

class TextureLoader extends §_-h5§
{
   private var id:String;
   
   private var url:String;
   
   private var library:§_-Tv§;
   
   private var loader:Loader;
   
   private var urlLoader:URLLoader;
   
   public function TextureLoader(param1:String, param2:String, param3:§_-Tv§)
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
      this.library.§_-Co§(this.id,ByteArray(this.urlLoader.data));
      §_-3Z§();
   }
   
   private function onLoadingComplete(param1:Event) : void
   {
      this.library.§_-Co§(this.id,Bitmap(this.loader.content).bitmapData);
      §_-3Z§();
   }
}
