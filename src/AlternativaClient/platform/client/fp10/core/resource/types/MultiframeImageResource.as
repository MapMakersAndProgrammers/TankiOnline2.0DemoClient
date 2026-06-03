package platform.client.fp10.core.resource.types
{
   import flash.display.BitmapData;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import platform.client.fp10.core.resource.IResourceLoadingListener;
   import platform.client.fp10.core.resource.IResourceSerializationListener;
   import platform.client.fp10.core.resource.Resource;
   import platform.client.fp10.core.resource.ResourceFileInfo;
   import platform.client.fp10.core.resource.ResourceFlags;
   import platform.client.fp10.core.resource.ResourceInfo;
   import platform.client.fp10.core.resource.ResourceStatus;
   import platform.client.fp10.core.resource.SafeURLLoader;
   import platform.client.fp10.core.resource.tara.TARAParser;
   import platform.client.fp10.core.service.localstorage.IResourceLocalStorage;
   import platform.core.general.resource.types.imageframe.ResourceImageFrameParams;
   
   public class MultiframeImageResource extends Resource
   {
      
      [Inject]
      public static var resourceLocalStorage:IResourceLocalStorage;
      
      private static const TARA_FILE:String = "imageframe.tara";
      
      private static const DIFFUSE_FILE:String = "image.jpg";
      
      private static const ALPHA_FILE:String = "alpha.jpg";
      
      private static const CHAR_F:int = 70;
      
      private static const CHAR_R:int = 82;
      
      private static const CHAR_M:int = 77;
      
      private static const BINARY_VERSION:int = 1;
      
      private var multiframeResourceInfo:ResourceImageFrameParams;
      
      private var framesConstructor:FramesConstructor;
      
      private var loader:SafeURLLoader;
      
      private var taraData:ByteArray;
      
      private var _data:Vector.<BitmapData>;
      
      public function MultiframeImageResource(param1:ResourceInfo, param2:ResourceImageFrameParams)
      {
         super(param1);
         if(param2 == null)
         {
            throw new Error("Parameter multiframeResourceInfo is null");
         }
         this.multiframeResourceInfo = param2;
      }
      
      public function get frameWidth() : int
      {
         return this.multiframeResourceInfo.w;
      }
      
      public function get frameHeight() : int
      {
         return this.multiframeResourceInfo.h;
      }
      
      public function get data() : Vector.<BitmapData>
      {
         return this._data;
      }
      
      override public function toString() : String
      {
         return "[MultiframeImageResource id=" + id + "]";
      }
      
      override public function get description() : String
      {
         return "Multiframe image";
      }
      
      override public function loadBytes(param1:ByteArray, param2:IResourceLoadingListener) : Boolean
      {
         if(param1.bytesAvailable < 4 || param1.readByte() != CHAR_F || param1.readByte() != CHAR_R || param1.readByte() != CHAR_M || param1.readByte() != BINARY_VERSION)
         {
            return false;
         }
         this.listener = param2;
         var _loc3_:int = param1.readInt();
         var _loc4_:ByteArray = new ByteArray();
         param1.readBytes(_loc4_,0,_loc3_);
         this.buildFrames(_loc4_);
         return true;
      }
      
      override public function serialize(param1:IResourceSerializationListener) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeByte(CHAR_F);
         _loc2_.writeByte(CHAR_R);
         _loc2_.writeByte(CHAR_M);
         _loc2_.writeByte(BINARY_VERSION);
         _loc2_.writeInt(this.taraData.length);
         _loc2_.writeBytes(this.taraData);
         this.taraData = null;
         param1.onSerializationComplete(this,_loc2_);
      }
      
      override public function get downloadSize() : int
      {
         var _loc1_:int = 0;
         var _loc2_:ResourceFileInfo = null;
         for each(_loc2_ in resourceInfo.fileInfos)
         {
            _loc1_ += _loc2_.fileSize;
         }
         return _loc1_;
      }
      
      override public function load(param1:String, param2:IResourceLoadingListener) : void
      {
         super.load(param1,param2);
         this.doLoad();
      }
      
      override protected function doReload() : void
      {
         this.loader.close();
         this.doLoad();
      }
      
      override protected function completeLoading() : void
      {
         super.completeLoading();
         if(hasAllFlags(ResourceFlags.LOCAL) || !resourceLocalStorage.enabled)
         {
            this.taraData = null;
         }
      }
      
      private function doLoad() : void
      {
         this.loader = new SafeURLLoader();
         this.loader.dataFormat = URLLoaderDataFormat.BINARY;
         this.loader.addEventListener(Event.OPEN,this.onLoadingOpen);
         this.loader.addEventListener(Event.COMPLETE,this.onLoadingComplete);
         this.loader.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadingError);
         this.loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadingError);
         this.loader.addEventListener(ProgressEvent.PROGRESS,this.onLoadingProgress);
         this.loader.load(new URLRequest(baseUrl + TARA_FILE));
         startTimeoutTracking();
         status = ResourceStatus.REQUESTED;
      }
      
      private function onLoadingOpen(param1:Event) : void
      {
         updateLastActivityTime();
         listener.onResourceLoadingStart(this);
      }
      
      private function onLoadingError(param1:ErrorEvent) : void
      {
         this.loader = null;
         this._data = new Vector.<BitmapData>();
         this._data[0] = new StubBitmapData(16711935,this.frameWidth,this.frameHeight);
         listener.onResourceLoadingError(this,param1.text);
      }
      
      private function onLoadingProgress(param1:ProgressEvent) : void
      {
         updateLastActivityTime();
         listener.onResourceLoadingProgress(this,param1.bytesLoaded);
      }
      
      private function onLoadingComplete(param1:Event) : void
      {
         stopTimeoutTracking();
         this.taraData = this.loader.data;
         this.loader = null;
         this.buildFrames(this.taraData);
      }
      
      private function buildFrames(param1:ByteArray) : void
      {
         var _loc2_:TARAParser = new TARAParser(param1);
         this.framesConstructor = new FramesConstructor();
         this.framesConstructor.addEventListener(Event.COMPLETE,this.onFramesComplete);
         this.framesConstructor.buildFrames(this.frameWidth,this.frameHeight,_loc2_.getFileData(DIFFUSE_FILE),_loc2_.getFileData(ALPHA_FILE));
      }
      
      private function onFramesComplete(param1:Event) : void
      {
         this._data = this.framesConstructor.data;
         this.framesConstructor = null;
         this.completeLoading();
      }
   }
}

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.ByteArray;
import platform.client.fp10.core.resource.ResourceUtils;

class FramesConstructor extends EventDispatcher
{
   
   private var _data:Vector.<BitmapData>;
   
   private var alphaData:ByteArray;
   
   private var loader:Loader;
   
   private var frameWidth:int;
   
   private var frameHeight:int;
   
   private var image:BitmapData;
   
   public function FramesConstructor()
   {
      super();
   }
   
   public function get data() : Vector.<BitmapData>
   {
      return this._data;
   }
   
   public function buildFrames(param1:int, param2:int, param3:ByteArray, param4:ByteArray) : void
   {
      this.frameWidth = param1;
      this.frameHeight = param2;
      this.alphaData = param4;
      this.load(param3,this.onDiffuseImageComplete);
   }
   
   private function load(param1:ByteArray, param2:Function) : void
   {
      this.loader = new Loader();
      this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,param2);
      this.loader.loadBytes(param1);
   }
   
   private function onDiffuseImageComplete(param1:Event) : void
   {
      this.image = Bitmap(this.loader.content).bitmapData;
      if(this.alphaData != null)
      {
         this.load(this.alphaData,this.onAlphaImageComplete);
      }
      else
      {
         this.createFrames();
      }
   }
   
   private function onAlphaImageComplete(param1:Event) : void
   {
      var _loc2_:BitmapData = Bitmap(this.loader.content).bitmapData;
      this.image = ResourceUtils.mergeBitmapAlpha(this.image,_loc2_,true);
      this.createFrames();
   }
   
   private function createFrames() : void
   {
      var _loc5_:BitmapData = null;
      if(this.frameHeight > this.image.height)
      {
         this.frameHeight = this.image.height;
      }
      var _loc1_:Point = new Point();
      var _loc2_:Rectangle = new Rectangle(0,0,this.frameWidth,this.frameHeight);
      var _loc3_:int = this.image.width / this.frameWidth;
      this._data = new Vector.<BitmapData>(_loc3_);
      var _loc4_:int = 0;
      while(_loc4_ < _loc3_)
      {
         _loc5_ = new BitmapData(this.frameWidth,this.frameHeight,true,0);
         _loc5_.copyPixels(this.image,_loc2_,_loc1_);
         this._data[_loc4_] = _loc5_;
         _loc2_.x += this.frameWidth;
         _loc4_++;
      }
      this.image.dispose();
      this.loader = null;
      this.alphaData = null;
      this.image = null;
      dispatchEvent(new Event(Event.COMPLETE));
   }
}
