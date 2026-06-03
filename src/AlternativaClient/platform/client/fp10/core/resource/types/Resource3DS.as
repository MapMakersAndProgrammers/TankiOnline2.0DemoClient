package platform.client.fp10.core.resource.types
{
   import alternativa.osgi.service.clientlog.IClientLog;
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
   
   public class Resource3DS extends Resource
   {
      
      [Inject]
      public static var resourceLocalStorage:IResourceLocalStorage;
      
      [Inject]
      public static var clientLog:IClientLog;
      
      private static const TARA_FILE:String = "3ds.tara";
      
      private static const IMAGES_FILE:String = "images.xml";
      
      private static const MODEL_FILE:String = "object.3ds";
      
      private static const CHAR_3:int = 51;
      
      private static const CHAR_D:int = 68;
      
      private static const CHAR_S:int = 83;
      
      private static const BINARY_VERSION:int = 1;
      
      private var loader:SafeURLLoader;
      
      private var _data:ByteArray;
      
      private var _textureData:Object;
      
      private var textureFileNames:Vector.<String>;
      
      private var batchTextureConstructor:BatchTextureConstructor;
      
      private var taraData:ByteArray;
      
      public function Resource3DS(param1:ResourceInfo)
      {
         super(param1);
      }
      
      public function get data() : ByteArray
      {
         return this._data;
      }
      
      public function getTextureFileNames() : Vector.<String>
      {
         var _loc2_:String = null;
         var _loc1_:Vector.<String> = new Vector.<String>();
         for(_loc2_ in this._textureData)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function getTexture(param1:String) : BitmapData
      {
         return this._textureData[param1];
      }
      
      override public function toString() : String
      {
         return "[Resource3DS id=" + id + "]";
      }
      
      override public function get description() : String
      {
         return "3DS";
      }
      
      override public function get downloadSize() : int
      {
         var _loc1_:ResourceFileInfo = resourceInfo.getFileInfo(TARA_FILE);
         if(_loc1_ == null)
         {
            throw new Error("Data file not found");
         }
         return _loc1_.fileSize;
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
         this.textureFileNames = null;
         this.batchTextureConstructor = null;
         if(hasAllFlags(ResourceFlags.LOCAL) || !resourceLocalStorage.enabled)
         {
            this.taraData = null;
         }
      }
      
      override public function loadBytes(param1:ByteArray, param2:IResourceLoadingListener) : Boolean
      {
         var data:ByteArray = null;
         var dataSize:int = 0;
         var bytes:ByteArray = param1;
         var listener:IResourceLoadingListener = param2;
         if(bytes.bytesAvailable < 4 || bytes.readByte() != CHAR_3 || bytes.readByte() != CHAR_D || bytes.readByte() != CHAR_S || bytes.readByte() != BINARY_VERSION)
         {
            return false;
         }
         if(listener == null)
         {
            throw new ArgumentError("Parameter listener is null");
         }
         this.listener = listener;
         try
         {
            data = new ByteArray();
            dataSize = bytes.readInt();
            bytes.readBytes(data,0,dataSize);
            this.buildResource(data);
         }
         catch(e:Error)
         {
            return false;
         }
         return true;
      }
      
      override public function serialize(param1:IResourceSerializationListener) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeByte(CHAR_3);
         _loc2_.writeByte(CHAR_D);
         _loc2_.writeByte(CHAR_S);
         _loc2_.writeByte(BINARY_VERSION);
         _loc2_.writeInt(this.taraData.length);
         _loc2_.writeBytes(this.taraData);
         this.taraData = null;
         param1.onSerializationComplete(this,_loc2_);
      }
      
      private function doLoad() : void
      {
         this.loader = new SafeURLLoader();
         this.loader.dataFormat = URLLoaderDataFormat.BINARY;
         this.loader.addEventListener(Event.OPEN,this.onTaraLoadingOpen);
         this.loader.addEventListener(ProgressEvent.PROGRESS,this.onProgress);
         this.loader.addEventListener(IOErrorEvent.IO_ERROR,this.onFatalError);
         this.loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onFatalError);
         this.loader.addEventListener(Event.COMPLETE,this.onTaraLoadingComplete);
         this.loader.load(new URLRequest(baseUrl + TARA_FILE));
         startTimeoutTracking();
         status = ResourceStatus.REQUESTED;
      }
      
      private function onTaraLoadingOpen(param1:Event) : void
      {
         updateLastActivityTime();
         listener.onResourceLoadingStart(this);
      }
      
      private function onProgress(param1:ProgressEvent) : void
      {
         updateLastActivityTime();
         listener.onResourceLoadingProgress(this,param1.bytesLoaded);
      }
      
      private function onFatalError(param1:ErrorEvent) : void
      {
         stopTimeoutTracking();
         this.loader = null;
         listener.onResourceLoadingFatalError(this,param1.text);
      }
      
      private function onTaraLoadingComplete(param1:Event) : void
      {
         stopTimeoutTracking();
         this.taraData = this.loader.data;
         this.loader = null;
         this.buildResource(this.taraData);
      }
      
      private function buildResource(param1:ByteArray) : void
      {
         this.parseData(param1);
         this.createBitmaps();
      }
      
      private function parseData(param1:ByteArray) : void
      {
         var _loc2_:TARAParser = new TARAParser(param1);
         this._data = _loc2_.getFileData(MODEL_FILE);
         this.processImages(_loc2_);
      }
      
      private function processImages(param1:TARAParser) : void
      {
         var _loc3_:XML = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Object = null;
         var _loc2_:XML = XML(param1.getFileData(IMAGES_FILE));
         this._textureData = {};
         if(_loc2_.image.length() > 0)
         {
            for each(_loc3_ in _loc2_.image)
            {
               _loc4_ = _loc3_.@name;
               _loc5_ = _loc3_.attribute("new-name");
               _loc6_ = _loc3_.@alpha;
               _loc7_ = {};
               _loc7_.diffuseMap = param1.getFileData(_loc5_);
               _loc7_.opacityMap = param1.getFileData(_loc6_);
               this._textureData[_loc4_] = _loc7_;
            }
         }
      }
      
      private function createBitmaps() : void
      {
         var _loc1_:Vector.<TextureByteData> = null;
         var _loc2_:String = null;
         var _loc3_:Object = null;
         this.textureFileNames = this.getTextureFileNames();
         if(this.textureFileNames.length > 0)
         {
            _loc1_ = new Vector.<TextureByteData>();
            for each(_loc2_ in this.textureFileNames)
            {
               _loc3_ = this._textureData[_loc2_];
               _loc1_.push(new TextureByteData(_loc3_.diffuseMap,_loc3_.opacityMap));
            }
            this.batchTextureConstructor = new BatchTextureConstructor();
            this.batchTextureConstructor.addEventListener(Event.COMPLETE,this.onTexturesReady);
            this.batchTextureConstructor.createTextures(_loc1_);
         }
         else
         {
            this.completeLoading();
         }
      }
      
      private function onTexturesReady(param1:Event) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.textureFileNames.length)
         {
            this._textureData[this.textureFileNames[_loc2_]] = this.batchTextureConstructor.textures[_loc2_];
            _loc2_++;
         }
         this.completeLoading();
      }
   }
}

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.ByteArray;
import platform.client.fp10.core.resource.ResourceUtils;

class TextureByteData
{
   
   public var diffuseData:ByteArray;
   
   public var opacityData:ByteArray;
   
   public function TextureByteData(param1:ByteArray = null, param2:ByteArray = null)
   {
      super();
      this.diffuseData = param1;
      this.opacityData = param2;
   }
   
   public function toString() : String
   {
      return "[TextureByteData diffuseData=" + this.diffuseData + ", opacityData=" + this.opacityData + "]";
   }
}

class TextureConstructor extends EventDispatcher
{
   
   private var loader:Loader;
   
   private var textureData:TextureByteData;
   
   private var _texture:BitmapData;
   
   public function TextureConstructor()
   {
      super();
   }
   
   public function get texture() : BitmapData
   {
      return this._texture;
   }
   
   public function createTexture(param1:TextureByteData) : void
   {
      if(this.loader != null)
      {
         throw new Error("Construction in progress");
      }
      if(param1 == null)
      {
         throw new ArgumentError("Parameter textureData is null");
      }
      if(param1.diffuseData == null)
      {
         throw new ArgumentError("Diffuse data is null");
      }
      this.textureData = param1;
      param1.diffuseData.position = 0;
      this.loader = new Loader();
      this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onDiffuseTextureLoadingComplete);
      this.loader.loadBytes(param1.diffuseData);
   }
   
   private function onDiffuseTextureLoadingComplete(param1:Event) : void
   {
      this._texture = Bitmap(this.loader.content).bitmapData;
      this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onDiffuseTextureLoadingComplete);
      this.loader.unload();
      if(this.textureData.opacityData != null)
      {
         this.textureData.opacityData.position = 0;
         this.loader = new Loader();
         this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onAlphaTextureLoadingComplete);
         this.loader.loadBytes(this.textureData.opacityData);
      }
      else
      {
         this.complete();
      }
   }
   
   private function onAlphaTextureLoadingComplete(param1:Event) : void
   {
      var _loc2_:BitmapData = Bitmap(this.loader.content).bitmapData;
      this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onAlphaTextureLoadingComplete);
      this.loader.unload();
      this._texture = ResourceUtils.mergeBitmapAlpha(this._texture,_loc2_,true);
      this.complete();
   }
   
   private function complete() : void
   {
      this.loader = null;
      this.textureData = null;
      dispatchEvent(new Event(Event.COMPLETE));
   }
}

class BatchTextureConstructor extends EventDispatcher
{
   
   public var textures:Vector.<BitmapData>;
   
   private var textureDatas:Vector.<TextureByteData>;
   
   private var textureIndex:int;
   
   private var textureConstructor:TextureConstructor;
   
   public function BatchTextureConstructor()
   {
      super();
   }
   
   public function createTextures(param1:Vector.<TextureByteData>) : void
   {
      this.textureDatas = param1;
      this.textures = new Vector.<BitmapData>();
      this.textureIndex = -1;
      this.createNextTexture();
   }
   
   private function createNextTexture() : void
   {
      ++this.textureIndex;
      if(this.textureIndex == this.textureDatas.length)
      {
         dispatchEvent(new Event(Event.COMPLETE));
         return;
      }
      this.textureConstructor = new TextureConstructor();
      this.textureConstructor.addEventListener(Event.COMPLETE,this.onTextureComplete);
      this.textureConstructor.createTexture(this.textureDatas[this.textureIndex]);
   }
   
   private function onTextureComplete(param1:Event) : void
   {
      this.textures[this.textureIndex] = this.textureConstructor.texture;
      this.createNextTexture();
   }
}
