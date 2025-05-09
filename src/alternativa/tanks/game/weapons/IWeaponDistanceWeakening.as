package alternativa.tanks.game.weapons
{
   public interface IWeaponDistanceWeakening
   {
      function getWeakeningCoefficient(param1:Number) : Number;
      
      function getMaximumDamageRadius() : Number;
      
      function getMinimumDamageRadius() : Number;
   }
}

