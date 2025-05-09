package alternativa.tanks.game.weapons.debug
{
   import alternativa.tanks.game.weapons.IWeaponDistanceWeakening;
   
   public class DebugWeaponDistanceWeakening implements IWeaponDistanceWeakening
   {
      private var maximumDamageRadius:Number;
      
      private var minimumDamageRadius:Number;
      
      private var minimumDamageCoefficient:Number;
      
      public function DebugWeaponDistanceWeakening(maximumDamageRadius:Number, minimumDamageRadius:Number, minimumDamageCoefficient:Number)
      {
         super();
         this.maximumDamageRadius = maximumDamageRadius;
         this.minimumDamageRadius = minimumDamageRadius;
         this.minimumDamageCoefficient = minimumDamageCoefficient;
      }
      
      public function getWeakeningCoefficient(distance:Number) : Number
      {
         if(distance <= this.maximumDamageRadius)
         {
            return 1;
         }
         if(distance > this.minimumDamageRadius)
         {
            return this.minimumDamageCoefficient;
         }
         return this.minimumDamageCoefficient + (1 - this.minimumDamageCoefficient) * (this.minimumDamageRadius - distance) / (this.minimumDamageRadius - this.maximumDamageRadius);
      }
      
      public function getMaximumDamageRadius() : Number
      {
         return this.maximumDamageRadius;
      }
      
      public function getMinimumDamageRadius() : Number
      {
         return this.minimumDamageRadius;
      }
   }
}

