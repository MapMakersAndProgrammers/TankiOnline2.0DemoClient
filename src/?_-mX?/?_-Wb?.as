package §_-mX§
{
   import §_-O5§.§_-Hk§;
   import §default§.§_-7d§;
   import flash.events.Event;
   import §return§.§_-Ui§;
   import §return§.§_-h5§;
   
   public class §_-Wb§ extends §_-h5§
   {
      public var data:§_-7d§;
      
      protected var §_-P9§:String;
      
      private var files:§_-Hk§;
      
      private var §_-e2§:§_-Ui§;
      
      private var baseUrl:String;
      
      private var partXML:XML;
      
      private var partsCollector:Vector.<§_-7d§>;
      
      public function §_-Wb§(param1:String, param2:XML, param3:Vector.<§_-7d§>)
      {
         super();
         this.partXML = param2;
         this.baseUrl = param1 + param2.@baseUrl + "/";
         this.partsCollector = param3;
      }
      
      override public function run() : void
      {
         var _loc2_:XML = null;
         this.files = new §_-Hk§();
         this.§_-e2§ = new §_-Ui§();
         var _loc1_:String = this.baseUrl + this.partXML.modelFile[0].toString();
         this.§_-P9§ = "main." + this.partXML.modelFile[0].@type;
         this.§_-e2§.addTask(new BlobLoadTask(this.§_-P9§,_loc1_,this.files));
         for each(_loc2_ in this.partXML.texture)
         {
            this.§_-e2§.addTask(new BlobLoadTask(_loc2_.@id,this.baseUrl + _loc2_.toString(),this.files));
         }
         this.§_-e2§.addEventListener(Event.COMPLETE,this.§_-Mk§);
         this.§_-e2§.run();
      }
      
      public function parseModelData(param1:§_-Hk§) : §_-7d§
      {
         throw new Error("Not implemented");
      }
      
      private function §_-Mk§(param1:Event) : void
      {
         this.§_-e2§ = null;
         this.data = this.parseModelData(this.files);
         this.data.id = this.partXML.id;
         this.partsCollector.push(this.data);
         §_-3Z§();
      }
   }
}

import §_-O5§.§_-Hk§;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import §return§.§_-h5§;

class BlobLoadTask extends §_-h5§
{
   public var blobId:String;
   
   private var collector:§_-Hk§;
   
   private var blobUrl:String;
   
   private var loader:URLLoader;
   
   public function BlobLoadTask(param1:String, param2:String, param3:§_-Hk§)
   {
      super();
      this.collector = param3;
      this.blobId = param1;
      this.blobUrl = param2;
   }
   
   override public function run() : void
   {
      this.loader = new URLLoader();
      this.loader.dataFormat = URLLoaderDataFormat.BINARY;
      this.loader.addEventListener(Event.COMPLETE,this.onLoadingComplete);
      this.loader.load(new URLRequest(this.blobUrl));
   }
   
   private function onLoadingComplete(param1:Event) : void
   {
      this.collector.§_-9v§(this.blobId,this.loader.data);
      this.loader = null;
      §_-3Z§();
   }
}
