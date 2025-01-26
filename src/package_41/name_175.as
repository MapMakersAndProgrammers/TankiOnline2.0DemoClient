package package_41
{
   import flash.events.Event;
   import flash.utils.ByteArray;
   import package_13.name_18;
   import package_13.name_459;
   import package_13.name_58;
   import package_13.name_70;
   import package_40.class_7;
   import package_40.name_169;
   import package_40.name_170;
   
   public class name_175 extends class_7
   {
      private var config:name_18;
      
      private var var_34:name_170;
      
      public function name_175(param1:name_18)
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
         this.var_34 = new name_170();
         for each(_loc1_ in this.config.xml.elements("blobs").elements("blobs-category"))
         {
            _loc2_ = _loc1_.@id;
            for each(_loc3_ in _loc1_.elements("blobs-group"))
            {
               _loc4_ = _loc3_.@id;
               _loc5_ = name_459.name_460(_loc3_.@baseUrl);
               for each(_loc6_ in _loc3_.elements("blob"))
               {
                  _loc7_ = _loc6_.@id;
                  _loc8_ = _loc5_ + _loc6_.@file;
                  this.var_34.addTask(new BlobLoader(_loc2_,_loc4_,_loc7_,_loc8_,this));
               }
            }
         }
         this.var_34.addEventListener(name_169.TASK_COMPLETE,this.method_312);
         this.var_34.addEventListener(Event.COMPLETE,this.onLoadingComplete);
         this.var_34.run();
      }
      
      private function method_312(param1:name_169) : void
      {
         dispatchEvent(new name_169(name_169.TASK_PROGRESS,1,this.var_34.length));
      }
      
      public function method_328(param1:String, param2:String, param3:String, param4:ByteArray) : void
      {
         var _loc5_:name_70 = this.config.name_68.name_72(param1);
         if(_loc5_ == null)
         {
            _loc5_ = new name_70();
            this.config.name_68.method_326(param1,_loc5_);
         }
         var _loc6_:name_58 = _loc5_.name_62(param2);
         if(_loc6_ == null)
         {
            _loc6_ = new name_58();
            _loc5_.method_214(param2,_loc6_);
         }
         _loc6_.method_218(param3,param4);
      }
      
      private function onLoadingComplete(param1:Event) : void
      {
         this.var_34 = null;
         method_102();
      }
   }
}

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import package_40.class_7;

class BlobLoader extends class_7
{
   private var categoryId:String;
   
   private var groupId:String;
   
   private var blobId:String;
   
   private var blobUrl:String;
   
   private var blobsLoaderTask:name_175;
   
   private var loader:URLLoader;
   
   public function BlobLoader(param1:String, param2:String, param3:String, param4:String, param5:name_175)
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
      this.blobsLoaderTask.method_328(this.categoryId,this.groupId,this.blobId,this.loader.data);
      this.loader = null;
      method_102();
   }
}
