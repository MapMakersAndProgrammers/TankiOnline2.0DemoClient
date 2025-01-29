package package_83
{
   import alternativa.tanks.game.GameKernel;
   import package_118.name_550;
   import package_119.name_552;
   import package_4.class_4;
   import alternativa.tanks.game.weapons.IGenericAmmunition;
   import alternativa.tanks.game.weapons.IGenericRound;
   import package_86.name_468;
   import package_87.name_267;
   
   public class name_269 implements IGenericAmmunition
   {
      private var var_468:name_550;
      
      public function name_269(gameKernel:GameKernel, radius:Number, impactForce:Number, maximumDamageRadius:Number, minimumDamageRadius:Number, minimumDamageCoefficient:Number, callback:name_552, frames:Vector.<class_4>)
      {
         super();
         var splashDamage:name_551 = new name_551(radius);
         var weaponDistanceWeakening:name_267 = new name_267(maximumDamageRadius,minimumDamageRadius,minimumDamageCoefficient);
         var splashDamageEffects:name_270 = new name_270(gameKernel,frames);
         var collisionDetector:name_468 = name_468(gameKernel.method_112().name_246().collisionDetector);
         var debugSplashTargetFilter:name_549 = new name_549();
         this.var_468 = new name_550(impactForce,weaponDistanceWeakening,splashDamage,splashDamageEffects,collisionDetector,debugSplashTargetFilter);
         this.var_468.method_383(callback);
      }
      
      public function getRound() : IGenericRound
      {
         return this.var_468;
      }
   }
}

