package alternativa.tanks.game.weapons.ammunition
{
   import alternativa.tanks.game.weapons.WeaponHit;
   
   public interface IAOEAmmunitionCallback
   {
      function onHit(param1:int, param2:WeaponHit, param3:Vector.<WeaponHit>) : void;
   }
}

