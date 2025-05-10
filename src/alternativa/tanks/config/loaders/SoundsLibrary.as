package alternativa.tanks.config.loaders
{
   import alternativa.tanks.config.Config;
   import alternativa.tanks.config.ResourceLoader;
   import alternativa.tanks.config.StringUtils;
   import alternativa.tanks.utils.TaskEvent;
   import alternativa.tanks.utils.TaskSequence;
   import flash.events.Event;
   import flash.media.Sound;
   
   public class SoundsLibrary extends ResourceLoader
   {
      private var sounds:Object = {};
      
      private var §_-d5§:TaskSequence;
      
      public function SoundsLibrary(param1:Config)
      {
         super("Sounds library loader",param1);
      }
      
      public function getSound(param1:String) : Sound
      {
         return this.sounds[param1];
      }
      
      public function addSound(param1:String, param2:Sound) : void
      {
         this.sounds[param1] = param2;
      }
      
      override public function run() : void
      {
         var _loc3_:XML = null;
         if(config.xml.sounds == null)
         {
            completeTask();
            return;
         }
         var _loc1_:XML = config.xml.sounds[0];
         var _loc2_:String = StringUtils.makeCorrectBaseUrl(_loc1_.@baseUrl);
         this.§_-d5§ = new TaskSequence();
         for each(_loc3_ in _loc1_.sound)
         {
            this.§_-d5§.addTask(new SoundLoader(_loc3_.@id,_loc2_ + _loc3_.@file,this));
         }
         this.§_-d5§.addEventListener(TaskEvent.TASK_COMPLETE,this.onTaskComplete);
         this.§_-d5§.addEventListener(Event.COMPLETE,this.onSequenceComplete);
         this.§_-d5§.run();
      }
      
      private function onTaskComplete(param1:TaskEvent) : void
      {
         dispatchEvent(new TaskEvent(TaskEvent.TASK_PROGRESS,1,this.§_-d5§.length));
      }
      
      private function onSequenceComplete(param1:Event) : void
      {
         this.§_-d5§ = null;
         completeTask();
      }
   }
}

import alternativa.tanks.utils.Task;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.media.Sound;
import flash.net.URLRequest;

class SoundLoader extends Task
{
   private var id:String;
   
   private var url:String;
   
   private var library:SoundsLibrary;
   
   private var loader:Sound;
   
   public function SoundLoader(param1:String, param2:String, param3:SoundsLibrary)
   {
      super();
      this.id = param1;
      this.url = param2;
      this.library = param3;
   }
   
   override public function run() : void
   {
      this.loader = new Sound();
      this.loader.addEventListener(Event.COMPLETE,this.onLoadingComplete);
      this.loader.load(new URLRequest(this.url));
   }
   
   private function onLoadingComplete(param1:Event) : void
   {
      this.library.addSound(this.id,this.loader);
      completeTask();
   }
}
