package alternativa.tanks.game.weapons.targeting
{
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   
   public interface IEnergyTargetingSystem
   {
      function getShotDirection(param1:Body, param2:Vector3, param3:Vector3, param4:Vector3, param5:Number, param6:Vector3) : void;
   }
}

