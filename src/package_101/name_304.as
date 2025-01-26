package package_101
{
   import package_10.name_17;
   import package_119.name_552;
   import package_27.name_501;
   import package_46.name_194;
   import package_72.class_12;
   import package_74.name_233;
   import package_74.name_327;
   import package_74.name_553;
   import package_76.name_256;
   import package_86.name_257;
   import package_86.name_540;
   import package_90.name_273;
   import package_92.name_271;
   
   public class name_304 implements name_233
   {
      private static const COLLISION_MASK:int = name_257.STATIC | name_257.WEAPON;
      
      private static var hitPosition:name_194 = new name_194();
      
      private static var filter:name_540 = new name_540();
      
      private static var rayHit:name_273 = new name_273();
      
      private static var hitInfo:name_553 = new name_553();
      
      private var impactForce:Number;
      
      private var weakening:name_327;
      
      private var effects:class_12;
      
      private var callback:name_552;
      
      public function name_304(impactForce:Number, weakening:name_327, effects:class_12)
      {
         super();
         this.impactForce = impactForce;
         this.weakening = weakening;
         this.effects = effects;
      }
      
      public function method_383(callback:name_552) : void
      {
         this.callback = callback;
      }
      
      public function method_372(gameKernel:name_17, shotId:int, shooter:name_271, barrelOrigin:name_194, barrelLength:Number, shotDirection:name_194, muzzlePosition:name_194) : void
      {
         var distance:Number = NaN;
         var weakeningCoefficient:Number = NaN;
         var collisionDetector:name_256 = gameKernel.method_112().name_246().collisionDetector;
         filter.body = shooter;
         if(collisionDetector.raycast(barrelOrigin,shotDirection,COLLISION_MASK,name_501.BIG_VALUE,filter,rayHit))
         {
            distance = rayHit.t - barrelLength;
            if(distance < 0)
            {
               distance = 0;
            }
            weakeningCoefficient = Number(this.weakening.name_554(distance));
            hitInfo.body = rayHit.primitive.body;
            hitInfo.direction.copy(shotDirection);
            hitInfo.normal.copy(rayHit.normal);
            hitInfo.position.copy(rayHit.position);
            hitInfo.distance = distance;
            this.method_464(hitInfo.body,hitInfo.position,hitInfo.direction,weakeningCoefficient);
            if(this.callback != null)
            {
               this.callback.name_555(shotId,hitInfo,null);
            }
         }
         filter.body = null;
      }
      
      public function method_465(target:name_271, targetHitPosition:name_194, hitDirection:name_194, distance:Number) : void
      {
         hitPosition.copy(targetHitPosition);
         this.method_464(target,hitPosition,hitDirection,this.weakening.name_554(distance));
      }
      
      private function method_464(target:name_271, hitPosition:name_194, hitDirection:name_194, weakening:Number) : void
      {
         if(target != null)
         {
            target.name_556(hitPosition,hitDirection,this.impactForce * weakening);
         }
         this.effects.createEffects(hitPosition,weakening,0);
      }
   }
}

