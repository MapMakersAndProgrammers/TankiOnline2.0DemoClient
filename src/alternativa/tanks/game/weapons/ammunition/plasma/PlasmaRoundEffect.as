package alternativa.tanks.game.weapons.ammunition.plasma
{
   import alternativa.tanks.game.effects.AnimatedSpriteEffect;
   import alternativa.tanks.game.utils.objectpool.ObjectPool;
   import alternativa.tanks.game.weapons.ammunition.energy.IEnergyRoundEffect;
   
   public class PlasmaRoundEffect extends AnimatedSpriteEffect implements IEnergyRoundEffect
   {
      public function PlasmaRoundEffect(objectPool:ObjectPool)
      {
         super(objectPool);
      }
   }
}

