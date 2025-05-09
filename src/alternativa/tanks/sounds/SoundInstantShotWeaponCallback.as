package alternativa.tanks.sounds
{
   import alternativa.tanks.game.weapons.IInstantShotWeaponCallback;
   import flash.media.Sound;
   
   public class SoundInstantShotWeaponCallback implements IInstantShotWeaponCallback
   {
      private var shotSound:Sound;
      
      public function SoundInstantShotWeaponCallback(param1:Sound)
      {
         super();
         this.shotSound = param1;
      }
      
      public function onInstantShot() : void
      {
         this.shotSound.play();
      }
   }
}

