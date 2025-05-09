package alternativa.tanks.game.weapons
{
   import alternativa.physics.Body;
   import alternativa.tanks.game.weapons.targeting.IGenericTargetEvaluator;
   
   public class SimpleTargetEvaluator implements IGenericTargetEvaluator
   {
      public static const INSTANCE:SimpleTargetEvaluator = new SimpleTargetEvaluator();
      
      public function SimpleTargetEvaluator()
      {
         super();
      }
      
      public function getTargetPriority(shooter:Body, target:Body, distance:Number, angle:Number) : Number
      {
         return 1;
      }
   }
}

