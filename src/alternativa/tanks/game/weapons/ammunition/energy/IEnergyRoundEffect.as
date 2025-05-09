package alternativa.tanks.game.weapons.ammunition.energy
{
   import alternativa.math.Vector3;
   import alternativa.tanks.game.subsystems.rendersystem.IGraphicEffect;
   
   public interface IEnergyRoundEffect extends IGraphicEffect
   {
      function kill() : void;
      
      function setPosition(param1:Vector3) : void;
   }
}

