package alternativa.tanks.config.loaders.tankparts
{
   import alternativa.tanks.game.entities.tank.TankPart;
   import alternativa.tanks.utils.Task;
   import alternativa.tanks.utils.TaskSequence;
   import alternativa.utils.ByteArrayMap;
   import flash.events.Event;
   
   public class TankPartLoader extends Task
   {
      public var data:TankPart;
      
      protected var name_P9:String;
      
      private var files:ByteArrayMap;
      
      private var name_e2:TaskSequence;
      
      private var baseUrl:String;
      
      private var partXML:XML;
      
      private var partsCollector:Vector.<TankPart>;
      
      public function TankPartLoader(param1:String, param2:XML, param3:Vector.<TankPart>)
      {
         super();
         this.partXML = param2;
         this.baseUrl = param1 + param2.@baseUrl + "/";
         this.partsCollector = param3;
      }
      
      override public function run() : void
      {
         var _loc2_:XML = null;
         this.files = new ByteArrayMap();
         this.name_e2 = new TaskSequence();
         var _loc1_:String = this.baseUrl + this.partXML.modelFile[0].toString();
         this.name_P9 = "main." + this.partXML.modelFile[0].@type;
         this.name_e2.addTask(new BlobLoadTask(this.name_P9,_loc1_,this.files));
         for each(_loc2_ in this.partXML.texture)
         {
            this.name_e2.addTask(new BlobLoadTask(_loc2_.@id,this.baseUrl + _loc2_.toString(),this.files));
         }
         this.name_e2.addEventListener(Event.COMPLETE,this.onTexturesLoadingComplete);
         this.name_e2.run();
      }
      
      public function parseModelData(param1:ByteArrayMap) : TankPart
      {
         throw new Error("Not implemented");
      }
      
      private function onTexturesLoadingComplete(param1:Event) : void
      {
         this.name_e2 = null;
         this.data = this.parseModelData(this.files);
         this.data.id = this.partXML.id;
         this.partsCollector.push(this.data);
         completeTask();
      }
   }
}

import alternativa.tanks.utils.Task;
import alternativa.utils.ByteArrayMap;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;

class BlobLoadTask extends Task
{
   public var blobId:String;
   
   private var collector:ByteArrayMap;
   
   private var blobUrl:String;
   
   private var loader:URLLoader;
   
   public function BlobLoadTask(param1:String, param2:String, param3:ByteArrayMap)
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
      this.collector.putValue(this.blobId,this.loader.data);
      this.loader = null;
      completeTask();
   }
}
