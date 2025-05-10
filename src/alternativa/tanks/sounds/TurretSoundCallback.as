package alternativa.tanks.sounds
{
   import alternativa.tanks.config.loaders.SoundsLibrary;
   import alternativa.tanks.game.entities.tank.ITurretManualControlCallback;
   import flash.events.Event;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   
   public class TurretSoundCallback implements ITurretManualControlCallback
   {
      private var soundLibrary:SoundsLibrary;
      
      private var name_At:Sound;
      
      private var name_ha:SoundChannel = null;
      
      public function TurretSoundCallback(param1:SoundsLibrary)
      {
         super();
         this.soundLibrary = param1;
         this.name_At = param1.getSound("turret");
      }
      
      public function onTurretControlChanged(param1:int, param2:Boolean) : void
      {
         if(this.name_ha != null)
         {
            this.name_ha.stop();
         }
         if(param1 != 0)
         {
            this.playMusic();
         }
      }
      
      private function playMusic() : void
      {
         if(this.name_At != null)
         {
            this.name_ha = this.name_At.play(0,0,new SoundTransform(0.2));
            this.name_ha.addEventListener(Event.SOUND_COMPLETE,this.loopMusic);
         }
      }
      
      private function loopMusic(param1:Event) : void
      {
         if(this.name_ha != null)
         {
            this.name_ha.removeEventListener(Event.SOUND_COMPLETE,this.loopMusic);
            this.playMusic();
         }
      }
   }
}

