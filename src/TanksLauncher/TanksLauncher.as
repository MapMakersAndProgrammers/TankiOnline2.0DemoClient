package
{
   import alternativa.ILauncherListener;
   import alternativa.Launcher;
   import alternativa.osgi.OSGi;
   import alternativa.tanks.services.background.BackgroundService;
   import alternativa.tanks.services.background.IBackgroundService;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.display.StageAlign;
   import flash.display.StageQuality;
   import flash.display.StageScaleMode;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   [SWF(width="1024",height="768",backgroundColor="#000000",frameRate="40")]
   public class TanksLauncher extends Sprite implements ILauncherListener
   {
      
      private var launcher:Launcher;
      
      private var progressBar:ProgressBar;
      
      private var messageImage:Bitmap;
      
      private var messageImageLoader:Loader;
      
      private var bgService:IBackgroundService;
      
      public function TanksLauncher()
      {
         super();
         new IncludedLibrary();
         stage.align = StageAlign.TOP_LEFT;
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.quality = StageQuality.LOW;
         stage.stageFocusRect = false;
         mouseEnabled = false;
         tabEnabled = false;
         this.progressBar = new ProgressBar();
         stage.addChild(this.progressBar);
         this.progressBar.align();
         this.launcher = new Launcher(this,loaderInfo,this);
         this.bgService = new BackgroundService(stage);
         this.bgService.showBg();
         this.launcher.start();
      }
      
      public function onConfigLoadingStart() : void
      {
         this.progressBar.text = "Config: ";
      }
      
      public function onConfigLoadingComplete() : void
      {
         this.progressBar.text = null;
      }
      
      public function onConfigLoadingProgress(bytesLoaded:uint, bytesTotal:uint) : void
      {
         this.progressBar.setProgress(bytesLoaded,bytesTotal);
      }
      
      public function onConfigLoadingError(message:String) : void
      {
         this.progressBar.text = "Config Loading Error";
      }
      
      public function onLibrariesLoadingStart() : void
      {
         this.progressBar.text = "Base libs: ";
      }
      
      public function onLibrariesLoadingProgress(bytesLoaded:uint, bytesTotal:uint) : void
      {
         this.progressBar.setProgress(bytesLoaded,bytesTotal);
      }
      
      public function onLibraryLoadingError(message:String) : void
      {
         this.progressBar.text = "Library Loading Error";
      }
      
      public function onLibrariesLoadingComplete() : void
      {
         this.progressBar.text = null;
         this.progressBar.parent.removeChild(this.progressBar);
         this.progressBar = null;
      }
      
      public function onLibrariesInitialized() : void
      {
         OSGi.getInstance().registerService(IBackgroundService,this.bgService);
      }
      
      public function onServerUnavailable() : void
      {
         try
         {
            this.messageImageLoader = this.createLoader();
            this.messageImageLoader.load(new URLRequest("launcher/server_nedostupen.png"));
         }
         catch(e:Error)
         {
            showMessage(e.toString());
         }
      }
      
      public function onServerOverloaded() : void
      {
         this.messageImageLoader = this.createLoader();
         this.messageImageLoader.load(new URLRequest("launcher/server_peregrughen.png"));
      }
      
      private function createLoader() : Loader
      {
         var loader:Loader = new Loader();
         loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoadingComplete);
         loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadingError);
         loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadingError);
         return loader;
      }
      
      private function onLoadingComplete(e:Event) : void
      {
         this.showImage();
      }
      
      private function onLoadingError(e:ErrorEvent) : void
      {
         this.showMessage(e.toString());
      }
      
      private function showImage() : void
      {
         this.messageImage = Bitmap(this.messageImageLoader.content);
         addChild(this.messageImage);
         this.alignImage();
         stage.addEventListener(Event.RESIZE,this.alignImage);
      }
      
      private function alignImage(e:Event = null) : void
      {
         this.messageImage.x = stage.stageWidth - this.messageImage.width >> 1;
         this.messageImage.y = stage.stageHeight - this.messageImage.height >> 1;
      }
      
      private function showMessage(message:String) : void
      {
         var tf:TextField = new TextField();
         tf.wordWrap = true;
         tf.multiline = true;
         tf.width = 600;
         tf.autoSize = TextFieldAutoSize.LEFT;
         tf.defaultTextFormat = new TextFormat("Tahoma",16,16777215);
         tf.text = message;
         stage.addChild(tf);
         tf.x = stage.stageWidth - tf.width >> 1;
         tf.y = stage.stageHeight - tf.height >> 1;
      }
   }
}

