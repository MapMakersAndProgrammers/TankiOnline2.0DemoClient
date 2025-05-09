package alternativa.tanks.sounds
{
   import alternativa.tanks.game.weapons.conicareadamage.IConicAreaWeaponCallback;
   import flash.events.Event;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.utils.Dictionary;
   
   public class FlamethrowerSoundWeaponCallback implements IConicAreaWeaponCallback
   {
      private var shotSound:Sound;
      
      private var channel:SoundChannel;
      
      public function FlamethrowerSoundWeaponCallback(param1:Sound)
      {
         super();
         this.shotSound = param1;
      }
      
      public function onConicAreaWeaponStart() : void
      {
         this.loop();
      }
      
      private function loop() : void
      {
         this.channel = this.shotSound.play(0,0,new SoundTransform(0.25));
         this.channel.addEventListener(Event.SOUND_COMPLETE,this.onLoop);
      }
      
      private function onLoop(param1:Event) : void
      {
         this.channel.removeEventListener(Event.SOUND_COMPLETE,this.onLoop);
         this.loop();
      }
      
      public function onConicAreaWeaponStop() : void
      {
         if(this.channel != null)
         {
            this.channel.stop();
            this.channel.removeEventListener(Event.SOUND_COMPLETE,this.onLoop);
         }
      }
      
      public function onConicAreaWeaponTargetSetChange(param1:Dictionary) : void
      {
      }
   }
}

