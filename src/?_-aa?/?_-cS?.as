package §_-aa§
{
   import §_-cv§.§_-NN§;
   import §_-cv§.§_-YU§;
   import §_-cv§.§_-cP§;
   import §_-cv§.§_-dD§;
   import flash.events.Event;
   import flash.utils.ByteArray;
   import §return§.§_-Ui§;
   import §return§.§_-h5§;
   import §return§.§_-pj§;
   
   public class §_-cS§ extends §_-h5§
   {
      private var config:§_-YU§;
      
      private var §_-d5§:§_-Ui§;
      
      public function §_-cS§(param1:§_-YU§)
      {
         super();
         this.config = param1;
      }
      
      override public function run() : void
      {
         var _loc1_:XML = null;
         var _loc2_:String = null;
         var _loc3_:XML = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:XML = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         this.§_-d5§ = new §_-Ui§();
         for each(_loc1_ in this.config.xml.elements("blobs").elements("blobs-category"))
         {
            _loc2_ = _loc1_.@id;
            for each(_loc3_ in _loc1_.elements("blobs-group"))
            {
               _loc4_ = _loc3_.@id;
               _loc5_ = §_-NN§.§_-KN§(_loc3_.@baseUrl);
               for each(_loc6_ in _loc3_.elements("blob"))
               {
                  _loc7_ = _loc6_.@id;
                  _loc8_ = _loc5_ + _loc6_.@file;
                  this.§_-d5§.addTask(new BlobLoader(_loc2_,_loc4_,_loc7_,_loc8_,this));
               }
            }
         }
         this.§_-d5§.addEventListener(§_-pj§.TASK_COMPLETE,this.§_-fm§);
         this.§_-d5§.addEventListener(Event.COMPLETE,this.onLoadingComplete);
         this.§_-d5§.run();
      }
      
      private function §_-fm§(param1:§_-pj§) : void
      {
         dispatchEvent(new §_-pj§(§_-pj§.TASK_PROGRESS,1,this.§_-d5§.length));
      }
      
      public function §_-To§(param1:String, param2:String, param3:String, param4:ByteArray) : void
      {
         var _loc5_:§_-cP§ = this.config.§_-WG§.§_-hJ§(param1);
         if(_loc5_ == null)
         {
            _loc5_ = new §_-cP§();
            this.config.§_-WG§.§_-hv§(param1,_loc5_);
         }
         var _loc6_:§_-dD§ = _loc5_.§_-EZ§(param2);
         if(_loc6_ == null)
         {
            _loc6_ = new §_-dD§();
            _loc5_.§_-b6§(param2,_loc6_);
         }
         _loc6_.§_-CC§(param3,param4);
      }
      
      private function onLoadingComplete(param1:Event) : void
      {
         this.§_-d5§ = null;
         §_-3Z§();
      }
   }
}

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import §return§.§_-h5§;

class BlobLoader extends §_-h5§
{
   private var categoryId:String;
   
   private var groupId:String;
   
   private var blobId:String;
   
   private var blobUrl:String;
   
   private var blobsLoaderTask:§_-cS§;
   
   private var loader:URLLoader;
   
   public function BlobLoader(param1:String, param2:String, param3:String, param4:String, param5:§_-cS§)
   {
      super();
      this.categoryId = param1;
      this.groupId = param2;
      this.blobId = param3;
      this.blobUrl = param4;
      this.blobsLoaderTask = param5;
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
      this.blobsLoaderTask.§_-To§(this.categoryId,this.groupId,this.blobId,this.loader.data);
      this.loader = null;
      §_-3Z§();
   }
}
