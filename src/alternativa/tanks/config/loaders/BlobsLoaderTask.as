package alternativa.tanks.config.loaders
{
   import alternativa.tanks.config.BlobCategory;
   import alternativa.tanks.config.BlobGroup;
   import alternativa.tanks.config.Config;
   import alternativa.tanks.config.StringUtils;
   import alternativa.tanks.utils.Task;
   import alternativa.tanks.utils.TaskEvent;
   import alternativa.tanks.utils.TaskSequence;
   import flash.events.Event;
   import flash.utils.ByteArray;
   
   public class BlobsLoaderTask extends Task
   {
      private var config:Config;
      
      private var §_-d5§:TaskSequence;
      
      public function BlobsLoaderTask(param1:Config)
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
         this.§_-d5§ = new TaskSequence();
         for each(_loc1_ in this.config.xml.elements("blobs").elements("blobs-category"))
         {
            _loc2_ = _loc1_.@id;
            for each(_loc3_ in _loc1_.elements("blobs-group"))
            {
               _loc4_ = _loc3_.@id;
               _loc5_ = StringUtils.makeCorrectBaseUrl(_loc3_.@baseUrl);
               for each(_loc6_ in _loc3_.elements("blob"))
               {
                  _loc7_ = _loc6_.@id;
                  _loc8_ = _loc5_ + _loc6_.@file;
                  this.§_-d5§.addTask(new BlobLoader(_loc2_,_loc4_,_loc7_,_loc8_,this));
               }
            }
         }
         this.§_-d5§.addEventListener(TaskEvent.TASK_COMPLETE,this.onTaskComplete);
         this.§_-d5§.addEventListener(Event.COMPLETE,this.onLoadingComplete);
         this.§_-d5§.run();
      }
      
      private function onTaskComplete(param1:TaskEvent) : void
      {
         dispatchEvent(new TaskEvent(TaskEvent.TASK_PROGRESS,1,this.§_-d5§.length));
      }
      
      public function addBlob(param1:String, param2:String, param3:String, param4:ByteArray) : void
      {
         var _loc5_:BlobCategory = this.config.§_-WG§.getCategory(param1);
         if(_loc5_ == null)
         {
            _loc5_ = new BlobCategory();
            this.config.§_-WG§.setCategory(param1,_loc5_);
         }
         var _loc6_:BlobGroup = _loc5_.getGroup(param2);
         if(_loc6_ == null)
         {
            _loc6_ = new BlobGroup();
            _loc5_.setGroup(param2,_loc6_);
         }
         _loc6_.setBlob(param3,param4);
      }
      
      private function onLoadingComplete(param1:Event) : void
      {
         this.§_-d5§ = null;
         completeTask();
      }
   }
}

import alternativa.tanks.utils.Task;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;

class BlobLoader extends Task
{
   private var categoryId:String;
   
   private var groupId:String;
   
   private var blobId:String;
   
   private var blobUrl:String;
   
   private var blobsLoaderTask:BlobsLoaderTask;
   
   private var loader:URLLoader;
   
   public function BlobLoader(param1:String, param2:String, param3:String, param4:String, param5:BlobsLoaderTask)
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
      this.blobsLoaderTask.addBlob(this.categoryId,this.groupId,this.blobId,this.loader.data);
      this.loader = null;
      completeTask();
   }
}
