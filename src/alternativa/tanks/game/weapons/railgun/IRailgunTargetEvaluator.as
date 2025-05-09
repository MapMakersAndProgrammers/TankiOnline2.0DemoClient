package alternativa.tanks.game.weapons.railgun
{
   import alternativa.physics.Body;
   
   public interface IRailgunTargetEvaluator
   {
      function getTargetPriority(param1:Body, param2:Number) : Number;
   }
}

