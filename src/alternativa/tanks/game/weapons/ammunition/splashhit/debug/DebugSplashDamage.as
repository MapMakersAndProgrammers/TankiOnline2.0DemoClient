package alternativa.tanks.game.weapons.ammunition.splashhit.debug
{
   import alternativa.tanks.game.weapons.ammunition.splashhit.ISplashDamage;
   
   public class DebugSplashDamage implements ISplashDamage
   {
      private var name_YZ:Number;
      
      public function DebugSplashDamage(radius:Number)
      {
         super();
         this.name_YZ = radius;
      }
      
      public function get radius() : Number
      {
         return this.name_YZ;
      }
      
      public function getPower(basePower:Number, radius:Number) : Number
      {
         return basePower;
      }
   }
}

