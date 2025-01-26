package package_80
{
   import flash.events.Event;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.utils.Dictionary;
   import package_95.name_545;
   
   public class name_287 implements name_545
   {
      private var shotSound:Sound;
      
      private var channel:SoundChannel;
      
      public function name_287(param1:Sound)
      {
         super();
         this.shotSound = param1;
      }
      
      public function name_548() : void
      {
         this.loop();
      }
      
      private function loop() : void
      {
         this.channel = this.shotSound.play(0,0,new SoundTransform(0.25));
         this.channel.addEventListener(Event.SOUND_COMPLETE,this.method_460);
      }
      
      private function method_460(param1:Event) : void
      {
         this.channel.removeEventListener(Event.SOUND_COMPLETE,this.method_460);
         this.loop();
      }
      
      public function name_547() : void
      {
         if(this.channel != null)
         {
            this.channel.stop();
            this.channel.removeEventListener(Event.SOUND_COMPLETE,this.method_460);
         }
      }
      
      public function name_546(param1:Dictionary) : void
      {
      }
   }
}

