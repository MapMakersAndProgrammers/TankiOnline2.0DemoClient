package package_87
{
   import alternativa.tanks.game.weapons.IWeaponDistanceWeakening;
   
   public class name_267 implements IWeaponDistanceWeakening
   {
      private var maximumDamageRadius:Number;
      
      private var minimumDamageRadius:Number;
      
      private var minimumDamageCoefficient:Number;
      
      public function name_267(maximumDamageRadius:Number, minimumDamageRadius:Number, minimumDamageCoefficient:Number)
      {
         super();
         this.maximumDamageRadius = maximumDamageRadius;
         this.minimumDamageRadius = minimumDamageRadius;
         this.minimumDamageCoefficient = minimumDamageCoefficient;
      }
      
      public function name_554(distance:Number) : Number
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
      
      public function method_467() : Number
      {
         return this.maximumDamageRadius;
      }
      
      public function method_468() : Number
      {
         return this.minimumDamageRadius;
      }
   }
}

