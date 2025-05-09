package alternativa.tanks.game.weapons.ammunition.splashhit.debug
{
   import alternativa.tanks.game.weapons.ammunition.splashhit.ISplashDamage;
   
   public class DebugSplashDamage implements ISplashDamage
   {
      private var var_643:Number;
      
      public function DebugSplashDamage(radius:Number)
      {
         super();
         this.var_643 = radius;
      }
      
      public function get radius() : Number
      {
         return this.var_643;
      }
      
      public function getPower(basePower:Number, radius:Number) : Number
      {
         return basePower;
      }
   }
}

