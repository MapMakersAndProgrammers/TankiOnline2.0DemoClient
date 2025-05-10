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
      
      private var §_-At§:Sound;
      
      private var §_-ha§:SoundChannel = null;
      
      public function TurretSoundCallback(param1:SoundsLibrary)
      {
         super();
         this.soundLibrary = param1;
         this.§_-At§ = param1.getSound("turret");
      }
      
      public function onTurretControlChanged(param1:int, param2:Boolean) : void
      {
         if(this.§_-ha§ != null)
         {
            this.§_-ha§.stop();
         }
         if(param1 != 0)
         {
            this.playMusic();
         }
      }
      
      private function playMusic() : void
      {
         if(this.§_-At§ != null)
         {
            this.§_-ha§ = this.§_-At§.play(0,0,new SoundTransform(0.2));
            this.§_-ha§.addEventListener(Event.SOUND_COMPLETE,this.loopMusic);
         }
      }
      
      private function loopMusic(param1:Event) : void
      {
         if(this.§_-ha§ != null)
         {
            this.§_-ha§.removeEventListener(Event.SOUND_COMPLETE,this.loopMusic);
            this.playMusic();
         }
      }
   }
}

