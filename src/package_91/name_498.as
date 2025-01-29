package package_91
{
   import alternativa.tanks.game.weapons.IWeaponDistanceWeakening;
   
   public class name_498
   {
      public var radius:Number;
      
      public var speed:Number;
      
      public var maxRicochets:uint;
      
      public var impactForce:Number;
      
      public var weakening:IWeaponDistanceWeakening;
      
      public function name_498(radius:Number, speed:Number, maxRicochets:uint, impactForce:Number, weakening:IWeaponDistanceWeakening)
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

