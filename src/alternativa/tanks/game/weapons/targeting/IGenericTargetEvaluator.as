package alternativa.tanks.game.weapons.targeting
{
   import alternativa.physics.Body;
   
   public interface IGenericTargetEvaluator
   {
      function getTargetPriority(param1:Body, param2:Body, param3:Number, param4:Number) : Number;
   }
}

