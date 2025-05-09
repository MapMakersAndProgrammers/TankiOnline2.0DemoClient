package alternativa.tanks.game.weapons.conicareadamage
{
   import flash.utils.Dictionary;
   
   public interface IConicAreaWeaponCallback
   {
      function onConicAreaWeaponStart() : void;
      
      function onConicAreaWeaponStop() : void;
      
      function onConicAreaWeaponTargetSetChange(param1:Dictionary) : void;
   }
}

