package alternativa.tanks.config.loaders
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.net.URLRequest;
   
   [Event(name="complete",type="flash.events.Event")]
   public class ImageSequenceLoader extends EventDispatcher
   {
      public var images:Vector.<BitmapData>;
      
      private var baseUrl:String;
      
      private var imagesXml:XMLList;
      
      private var loader:Loader;
      
      private var name_lW:int;
      
      public function ImageSequenceLoader()
      {
         super();
      }
      
      public function load(param1:String, param2:XMLList) : void
      {
         this.baseUrl = param1;
         this.imagesXml = param2;
         this.loader = new Loader();
         this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onImageLoadingComplete);
         this.name_lW = -1;
         this.images = new Vector.<BitmapData>();
         this.loadNextImage();
      }
      
      private function loadNextImage() : void
      {
         ++this.name_lW;
         if(this.name_lW == this.imagesXml.length())
         {
            this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onImageLoadingComplete);
            this.loader.unload();
            this.loader = null;
            this.baseUrl = null;
            this.imagesXml = null;
            if(hasEventListener(Event.COMPLETE))
            {
               dispatchEvent(new Event(Event.COMPLETE));
            }
         }
         else
         {
            this.loader.load(new URLRequest(this.baseUrl + this.imagesXml[this.name_lW].@file));
         }
      }
      
      private function onImageLoadingComplete(param1:Event) : void
      {
         this.images.push(Bitmap(this.loader.content).bitmapData);
         this.loadNextImage();
      }
   }
}

