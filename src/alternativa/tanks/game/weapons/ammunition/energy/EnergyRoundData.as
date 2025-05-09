package alternativa.tanks.game.weapons.ammunition.energy
{
   import alternativa.tanks.game.weapons.IWeaponDistanceWeakening;
   
   public class EnergyRoundData
   {
      public var radius:Number;
      
      public var speed:Number;
      
      public var maxRicochets:uint;
      
      public var impactForce:Number;
      
      public var weakening:IWeaponDistanceWeakening;
      
      public function EnergyRoundData(radius:Number, speed:Number, maxRicochets:uint, impactForce:Number, weakening:IWeaponDistanceWeakening)
      {
         super();
         this.radius = radius;
         this.speed = speed;
         this.maxRicochets = maxRicochets;
         this.impactForce = impactForce;
         this.weakening = weakening;
      }
   }
}

