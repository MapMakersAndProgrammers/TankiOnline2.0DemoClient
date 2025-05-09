package alternativa.tanks.game.weapons.ammunition.energy
{
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   
   public interface IEnergyRoundCallback
   {
      function onEnergyRoundHit(param1:int, param2:Vector3, param3:Number, param4:Body) : void;
   }
}

