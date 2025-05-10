package alternativa.tanks.config
{
   import alternativa.tanks.utils.TaskEvent;
   import alternativa.tanks.utils.TaskSequence;
   import flash.display.BitmapData;
   import flash.events.Event;
   
   public class TextureLibrary extends ResourceLoader
   {
      private var textures:Object = {};
      
      private var §_-gh§:BitmapData;
      
      private var §_-d5§:TaskSequence;
      
      public function TextureLibrary(param1:Config)
      {
         super("Texture library loader",param1);
      }
      
      public function getTexture(param1:String) : Object
      {
         return this.textures[param1] || this.getDummyTexture();
      }
      
      public function addTexture(param1:String, param2:Object) : void
      {
         this.textures[param1] = param2;
      }
      
      override public function run() : void
      {
         var _loc3_:XML = null;
         var _loc1_:XML = config.xml.textures[0];
         var _loc2_:String = StringUtils.makeCorrectBaseUrl(_loc1_.@baseUrl);
         this.§_-d5§ = new TaskSequence();
         for each(_loc3_ in _loc1_.texture)
         {
            this.§_-d5§.addTask(new TextureLoader(_loc3_.@id,_loc2_ + _loc3_.@url,this));
         }
         this.§_-d5§.addEventListener(TaskEvent.TASK_COMPLETE,this.onTaskComplete);
         this.§_-d5§.addEventListener(Event.COMPLETE,this.onSequenceComplete);
         this.§_-d5§.run();
      }
      
      private function onTaskComplete(param1:TaskEvent) : void
      {
         dispatchEvent(new TaskEvent(TaskEvent.TASK_PROGRESS,1,this.§_-d5§.length));
      }
      
      private function onSequenceComplete(param1:Event) : void
      {
         this.§_-d5§ = null;
         completeTask();
      }
      
      private function getDummyTexture() : BitmapData
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

import alternativa.tanks.utils.Task;
import flash.display.Bitmap;
import flash.display.Loader;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.utils.ByteArray;

class TextureLoader extends Task
{
   private var id:String;
   
   private var url:String;
   
   private var library:TextureLibrary;
   
   private var loader:Loader;
   
   private var urlLoader:URLLoader;
   
   public function TextureLoader(param1:String, param2:String, param3:TextureLibrary)
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
      this.library.addTexture(this.id,ByteArray(this.urlLoader.data));
      completeTask();
   }
   
   private function onLoadingComplete(param1:Event) : void
   {
      this.library.addTexture(this.id,Bitmap(this.loader.content).bitmapData);
      completeTask();
   }
}
