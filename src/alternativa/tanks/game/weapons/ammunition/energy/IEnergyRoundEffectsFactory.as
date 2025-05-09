package alternativa.tanks.game.weapons.ammunition.energy
{
   import alternativa.math.Vector3;
   
   public interface IEnergyRoundEffectsFactory
   {
      function createEnergyRoundEffect() : IEnergyRoundEffect;
      
      function createExplosionEffects(param1:Vector3) : void;
      
      function createRicochetEffects(param1:Vector3, param2:Vector3, param3:Vector3) : void;
   }
}

