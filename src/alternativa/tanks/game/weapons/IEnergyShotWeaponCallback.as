package alternativa.tanks.game.weapons
{
   import alternativa.math.Vector3;
   
   public interface IEnergyShotWeaponCallback
   {
      function onEnergyShotWeaponFire(param1:int, param2:EnergyShotType, param3:Vector3, param4:int) : void;
   }
}

