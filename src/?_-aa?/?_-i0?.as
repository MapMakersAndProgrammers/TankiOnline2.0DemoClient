package §_-aa§
{
   import §_-cv§.§_-FR§;
   import §_-cv§.§_-NN§;
   import §_-cv§.§_-YU§;
   import flash.events.Event;
   import flash.media.Sound;
   import §return§.§_-Ui§;
   import §return§.§_-pj§;
   
   public class §_-i0§ extends §_-FR§
   {
      private var sounds:Object = {};
      
      private var §_-d5§:§_-Ui§;
      
      public function §_-i0§(param1:§_-YU§)
      {
         super("Sounds library loader",param1);
      }
      
      public function §_-lM§(param1:String) : Sound
      {
         return this.sounds[param1];
      }
      
      public function §_-Od§(param1:String, param2:Sound) : void
      {
         this.sounds[param1] = param2;
      }
      
      override public function run() : void
      {
         var _loc3_:XML = null;
         if(config.xml.sounds == null)
         {
            §_-3Z§();
            return;
         }
         var _loc1_:XML = config.xml.sounds[0];
         var _loc2_:String = §_-NN§.§_-KN§(_loc1_.@baseUrl);
         this.§_-d5§ = new §_-Ui§();
         for each(_loc3_ in _loc1_.sound)
         {
            this.§_-d5§.addTask(new SoundLoader(_loc3_.@id,_loc2_ + _loc3_.@file,this));
         }
         this.§_-d5§.addEventListener(§_-pj§.TASK_COMPLETE,this.§_-fm§);
         this.§_-d5§.addEventListener(Event.COMPLETE,this.§_-Pw§);
         this.§_-d5§.run();
      }
      
      private function §_-fm§(param1:§_-pj§) : void
      {
         dispatchEvent(new §_-pj§(§_-pj§.TASK_PROGRESS,1,this.§_-d5§.length));
      }
      
      private function §_-Pw§(param1:Event) : void
      {
         this.§_-d5§ = null;
         §_-3Z§();
      }
   }
}

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.media.Sound;
import flash.net.URLRequest;
import §return§.§_-h5§;

class SoundLoader extends §_-h5§
{
   private var id:String;
   
   private var url:String;
   
   private var library:§_-i0§;
   
   private var loader:Sound;
   
   public function SoundLoader(param1:String, param2:String, param3:§_-i0§)
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
      this.library.§_-Od§(this.id,this.loader);
      §_-3Z§();
   }
}
