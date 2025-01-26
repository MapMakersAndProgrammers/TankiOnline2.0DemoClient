package package_41
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.net.URLRequest;
   
   [Event(name="complete",type="flash.events.Event")]
   public class name_462 extends EventDispatcher
   {
      public var images:Vector.<BitmapData>;
      
      private var baseUrl:String;
      
      private var imagesXml:XMLList;
      
      private var loader:Loader;
      
      private var var_589:int;
      
      public function name_462()
      {
         super();
      }
      
      public function load(param1:String, param2:XMLList) : void
      {
         this.baseUrl = param1;
         this.imagesXml = param2;
         this.loader = new Loader();
         this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.method_650);
         this.var_589 = -1;
         this.images = new Vector.<BitmapData>();
         this.method_649();
      }
      
      private function method_649() : void
      {
         ++this.var_589;
         if(this.var_589 == this.imagesXml.length())
         {
            this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.method_650);
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
            this.loader.load(new URLRequest(this.baseUrl + this.imagesXml[this.var_589].@file));
         }
      }
      
      private function method_650(param1:Event) : void
      {
         this.images.push(Bitmap(this.loader.content).bitmapData);
         this.method_649();
      }
   }
}

