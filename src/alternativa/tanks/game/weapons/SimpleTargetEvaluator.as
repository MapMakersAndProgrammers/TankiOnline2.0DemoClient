package alternativa.tanks.game.weapons
{
   import package_79.name_326;
   import package_92.name_271;
   
   public class SimpleTargetEvaluator implements name_326
   {
      public static const INSTANCE:SimpleTargetEvaluator = new SimpleTargetEvaluator();
      
      public function SimpleTargetEvaluator()
      {
         super();
      }
      
      public function name_541(shooter:name_271, target:name_271, distance:Number, angle:Number) : Number
      {
         return 1;
      }
   }
}

