package alternativa.tanks.game.weapons.ammunition.railgun.debug
{
   import alternativa.physics.Body;
   import alternativa.tanks.game.weapons.railgun.IRailgunTargetEvaluator;
   
   public class DebugRailgunTargetEvaluator implements IRailgunTargetEvaluator
   {
      public function DebugRailgunTargetEvaluator()
      {
         super();
      }
      
      public function getTargetPriority(body:Body, distance:Number) : Number
      {
         return 1;
      }
   }
}

