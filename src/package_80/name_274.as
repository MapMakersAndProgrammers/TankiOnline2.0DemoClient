package package_80
{
   import flash.media.Sound;
   import alternativa.tanks.game.weapons.IInstantShotWeaponCallback;
   
   public class name_274 implements IInstantShotWeaponCallback
   {
      private var shotSound:Sound;
      
      public function name_274(param1:Sound)
      {
         super();
         this.shotSound = param1;
      }
      
      public function name_526() : void
      {
         this.shotSound.play();
      }
   }
}

