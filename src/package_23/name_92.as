package package_23
{
   import flash.events.Event;
   import flash.media.Sound;
   import package_16.class_15;
   import package_16.name_18;
   import package_16.name_347;
   import package_22.name_87;
   import package_22.name_90;
   
   public class name_92 extends class_15
   {
      private var sounds:Object = {};
      
      private var var_34:name_90;
      
      public function name_92(param1:name_18)
      {
         super("Sounds library loader",param1);
      }
      
      public function name_214(param1:String) : Sound
      {
         return this.sounds[param1];
      }
      
      public function method_131(param1:String, param2:Sound) : void
      {
         this.sounds[param1] = param2;
      }
      
      override public function run() : void
      {
         var _loc3_:XML = null;
         if(config.xml.sounds == null)
         {
            name_88();
            return;
         }
         var _loc1_:XML = config.xml.sounds[0];
         var _loc2_:String = name_347.name_348(_loc1_.@baseUrl);
         this.var_34 = new name_90();
         for each(_loc3_ in _loc1_.sound)
         {
            this.var_34.addTask(new SoundLoader(_loc3_.@id,_loc2_ + _loc3_.@file,this));
         }
         this.var_34.addEventListener(name_87.TASK_COMPLETE,this.method_130);
         this.var_34.addEventListener(Event.COMPLETE,this.method_32);
         this.var_34.run();
      }
      
      private function method_130(param1:name_87) : void
      {
         dispatchEvent(new name_87(name_87.TASK_PROGRESS,1,this.var_34.length));
      }
      
      private function method_32(param1:Event) : void
      {
         this.var_34 = null;
         name_88();
      }
   }
}

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.media.Sound;
import flash.net.URLRequest;
import package_22.class_3;

class SoundLoader extends class_3
{
   private var id:String;
   
   private var url:String;
   
   private var library:name_92;
   
   private var loader:Sound;
   
   public function SoundLoader(param1:String, param2:String, param3:name_92)
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
      this.library.method_131(this.id,this.loader);
      name_88();
   }
}
