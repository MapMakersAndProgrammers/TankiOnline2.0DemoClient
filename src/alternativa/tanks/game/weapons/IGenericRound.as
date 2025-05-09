package alternativa.tanks.game.weapons
{
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.tanks.game.GameKernel;
   
   public interface IGenericRound
   {
      function shoot(param1:GameKernel, param2:int, param3:Body, param4:Vector3, param5:Number, param6:Vector3, param7:Vector3) : void;
   }
}

