package package_41
{
   import flash.events.Event;
   import flash.media.Sound;
   import package_13.class_21;
   import package_13.name_18;
   import package_13.name_459;
   import package_40.name_169;
   import package_40.name_170;
   
   public class name_173 extends class_21
   {
      private var sounds:Object = {};
      
      private var var_34:name_170;
      
      public function name_173(param1:name_18)
      {
         super("Sounds library loader",param1);
      }
      
      public function name_297(param1:String) : Sound
      {
         return this.sounds[param1];
      }
      
      public function method_313(param1:String, param2:Sound) : void
      {
         this.sounds[param1] = param2;
      }
      
      override public function run() : void
      {
         var _loc3_:XML = null;
         if(config.xml.sounds == null)
         {
            method_102();
            return;
         }
         var _loc1_:XML = config.xml.sounds[0];
         var _loc2_:String = name_459.name_460(_loc1_.@baseUrl);
         this.var_34 = new name_170();
         for each(_loc3_ in _loc1_.sound)
         {
            this.var_34.addTask(new SoundLoader(_loc3_.@id,_loc2_ + _loc3_.@file,this));
         }
         this.var_34.addEventListener(name_169.TASK_COMPLETE,this.method_312);
         this.var_34.addEventListener(Event.COMPLETE,this.method_107);
         this.var_34.run();
      }
      
      private function method_312(param1:name_169) : void
      {
         dispatchEvent(new name_169(name_169.TASK_PROGRESS,1,this.var_34.length));
      }
      
      private function method_107(param1:Event) : void
      {
         this.var_34 = null;
         method_102();
      }
   }
}

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.media.Sound;
import flash.net.URLRequest;
import package_40.class_7;

class SoundLoader extends class_7
{
   private var id:String;
   
   private var url:String;
   
   private var library:name_173;
   
   private var loader:Sound;
   
   public function SoundLoader(param1:String, param2:String, param3:name_173)
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
      this.library.method_313(this.id,this.loader);
      method_102();
   }
}
