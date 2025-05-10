package alternativa.tanks.game.weapons.ammunition.splashhit.debug
{
   import alternativa.engine3d.materials.Material;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.physics.ITanksCollisionDetector;
   import alternativa.tanks.game.weapons.IGenericAmmunition;
   import alternativa.tanks.game.weapons.IGenericRound;
   import alternativa.tanks.game.weapons.ammunition.IAOEAmmunitionCallback;
   import alternativa.tanks.game.weapons.ammunition.splashhit.SplashDamageRound;
   import alternativa.tanks.game.weapons.debug.DebugWeaponDistanceWeakening;
   
   public class DebugSplashDamageAmmo implements IGenericAmmunition
   {
      private var name_ea:SplashDamageRound;
      
      public function DebugSplashDamageAmmo(gameKernel:GameKernel, radius:Number, impactForce:Number, maximumDamageRadius:Number, minimumDamageRadius:Number, minimumDamageCoefficient:Number, callback:IAOEAmmunitionCallback, frames:Vector.<Material>)
      {
         super();
         var splashDamage:DebugSplashDamage = new DebugSplashDamage(radius);
         var weaponDistanceWeakening:DebugWeaponDistanceWeakening = new DebugWeaponDistanceWeakening(maximumDamageRadius,minimumDamageRadius,minimumDamageCoefficient);
         var splashDamageEffects:DebugSplashDamageEffects = new DebugSplashDamageEffects(gameKernel,frames);
         var collisionDetector:ITanksCollisionDetector = ITanksCollisionDetector(gameKernel.getPhysicsSystem().getPhysicsScene().collisionDetector);
         var debugSplashTargetFilter:DebugSplashTargetFilter = new DebugSplashTargetFilter();
         this.name_ea = new SplashDamageRound(impactForce,weaponDistanceWeakening,splashDamage,splashDamageEffects,collisionDetector,debugSplashTargetFilter);
         this.name_ea.setCallback(callback);
      }
      
      public function getRound() : IGenericRound
      {
         return this.name_ea;
      }
   }
}

