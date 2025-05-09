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
      
      private var var_474:Sound;
      
      private var var_473:SoundChannel = null;
      
      public function TurretSoundCallback(param1:SoundsLibrary)
      {
         super();
         this.soundLibrary = param1;
         this.var_474 = param1.getSound("turret");
      }
      
      public function onTurretControlChanged(param1:int, param2:Boolean) : void
      {
         if(this.var_473 != null)
         {
            this.var_473.stop();
         }
         if(param1 != 0)
         {
            this.playMusic();
         }
      }
      
      private function playMusic() : void
      {
         if(this.var_474 != null)
         {
            this.var_473 = this.var_474.play(0,0,new SoundTransform(0.2));
            this.var_473.addEventListener(Event.SOUND_COMPLETE,this.loopMusic);
         }
      }
      
      private function loopMusic(param1:Event) : void
      {
         if(this.var_473 != null)
         {
            this.var_473.removeEventListener(Event.SOUND_COMPLETE,this.loopMusic);
            this.playMusic();
         }
      }
   }
}

