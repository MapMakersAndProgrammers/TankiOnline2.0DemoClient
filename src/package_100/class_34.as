package package_100
{
   import flash.events.Event;
   import package_12.name_54;
   import package_22.class_3;
   import package_22.name_90;
   import package_39.name_257;
   
   public class class_34 extends class_3
   {
      public var data:name_257;
      
      protected var var_673:String;
      
      private var files:name_54;
      
      private var var_672:name_90;
      
      private var baseUrl:String;
      
      private var partXML:XML;
      
      private var partsCollector:Vector.<name_257>;
      
      public function class_34(param1:String, param2:XML, param3:Vector.<name_257>)
      {
         super();
         this.partXML = param2;
         this.baseUrl = param1 + param2.@baseUrl + "/";
         this.partsCollector = param3;
      }
      
      override public function run() : void
      {
         var _loc2_:XML = null;
         this.files = new name_54();
         this.var_672 = new name_90();
         var _loc1_:String = this.baseUrl + this.partXML.modelFile[0].toString();
         this.var_673 = "main." + this.partXML.modelFile[0].@type;
         this.var_672.addTask(new BlobLoadTask(this.var_673,_loc1_,this.files));
         for each(_loc2_ in this.partXML.texture)
         {
            this.var_672.addTask(new BlobLoadTask(_loc2_.@id,this.baseUrl + _loc2_.toString(),this.files));
         }
         this.var_672.addEventListener(Event.COMPLETE,this.method_330);
         this.var_672.run();
      }
      
      public function parseModelData(param1:name_54) : name_257
      {
         throw new Error("Not implemented");
      }
      
      private function method_330(param1:Event) : void
      {
         this.var_672 = null;
         this.data = this.parseModelData(this.files);
         this.data.id = this.partXML.id;
         this.partsCollector.push(this.data);
         name_88();
      }
   }
}

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import package_12.name_54;
import package_22.class_3;

class BlobLoadTask extends class_3
{
   public var blobId:String;
   
   private var collector:name_54;
   
   private var blobUrl:String;
   
   private var loader:URLLoader;
   
   public function BlobLoadTask(param1:String, param2:String, param3:name_54)
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
      this.collector.name_58(this.blobId,this.loader.data);
      this.loader = null;
      name_88();
   }
}
