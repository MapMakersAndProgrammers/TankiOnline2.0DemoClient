package package_118
{
   import package_10.name_17;
   import package_119.name_552;
   import package_27.name_501;
   import package_46.name_194;
   import package_72.class_12;
   import package_74.name_233;
   import package_74.name_327;
   import package_74.name_553;
   import package_86.name_257;
   import package_86.name_468;
   import package_86.name_540;
   import package_86.name_654;
   import package_90.name_273;
   import package_92.name_271;
   
   public class name_550 implements name_233
   {
      private static const HIT_POINT_CORRECTION:Number = 1;
      
      private static var direction:name_194 = new name_194();
      
      private static var force:name_194 = new name_194();
      
      private static var splashHits:Vector.<name_553> = new Vector.<name_553>();
      
      private static var rayHit:name_273 = new name_273();
      
      private static var filter:name_540 = new name_540();
      
      private static var hitInfo:name_553 = new name_553();
      
      private var directImpactForce:Number;
      
      private var weakening:name_327;
      
      private var splashDamage:class_37;
      
      private var effects:class_12;
      
      private var collisionDetector:name_468;
      
      private var splashTargetFilter:class_38;
      
      private var callback:name_552;
      
      public function name_550(directImpactForce:Number, weakening:name_327, splashDamage:class_37, effects:class_12, collisionDetector:name_468, splashTargetFilter:class_38)
      {
         super();
         this.directImpactForce = directImpactForce;
         this.weakening = weakening;
         this.splashDamage = splashDamage;
         this.effects = effects;
         this.collisionDetector = collisionDetector;
         this.splashTargetFilter = splashTargetFilter;
      }
      
      public function method_383(callback:name_552) : void
      {
         this.callback = callback;
      }
      
      public function method_372(gameKernel:name_17, shotId:int, shooter:name_271, barrelOrigin:name_194, barrelLength:Number, shotDirection:name_194, muzzlePosition:name_194) : void
      {
         var distance:Number = NaN;
         var weakeningCoefficient:Number = NaN;
         var impactForce:Number = NaN;
         var primaryTarget:name_271 = null;
         filter.body = shooter;
         if(this.collisionDetector.raycast(barrelOrigin,shotDirection,name_257.WEAPON | name_257.STATIC,name_501.BIG_VALUE,filter,rayHit))
         {
            distance = rayHit.t - barrelLength;
            if(distance < 0)
            {
               distance = 0;
            }
            weakeningCoefficient = Number(this.weakening.name_554(distance));
            impactForce = this.directImpactForce * weakeningCoefficient;
            primaryTarget = rayHit.primitive.body;
            if(primaryTarget != null)
            {
               primaryTarget.name_556(rayHit.position,shotDirection,impactForce);
            }
            rayHit.position.method_362(HIT_POINT_CORRECTION,rayHit.normal);
            splashHits.length = 0;
            this.method_760(rayHit.position,primaryTarget,impactForce,splashHits);
            this.effects.createEffects(rayHit.position,weakeningCoefficient,this.splashDamage.radius);
            hitInfo.body = primaryTarget;
            hitInfo.direction.copy(shotDirection);
            hitInfo.distance = distance;
            hitInfo.normal.copy(rayHit.normal);
            hitInfo.position.copy(rayHit.position);
            if(this.callback != null)
            {
               this.callback.name_555(shotId,hitInfo,splashHits);
            }
            splashHits.length = 0;
         }
         filter.body = null;
      }
      
      public function method_465(hitPosition:name_194, primaryTarget:name_271, muzzlePosition:name_194) : void
      {
         direction.method_366(hitPosition,muzzlePosition);
         var weakeningCoefficient:Number = Number(this.weakening.name_554(direction.length()));
         var imactForce:Number = this.directImpactForce * weakeningCoefficient;
         if(primaryTarget != null)
         {
            direction.normalize();
            primaryTarget.name_556(hitPosition,direction,imactForce);
         }
         this.method_760(hitPosition,primaryTarget,imactForce,null);
         this.effects.createEffects(hitPosition,weakeningCoefficient,this.splashDamage.radius);
      }
      
      private function method_760(hitPosition:name_194, primaryTarget:name_271, impactForce:Number, splashHits:Vector.<name_553>) : void
      {
         var bodyDistance:name_654 = null;
         var targetBody:name_271 = null;
         var splashImpactForce:Number = NaN;
         var weaponHit:name_553 = null;
         this.splashTargetFilter.method_759(primaryTarget);
         var objectsInRadius:Vector.<name_654> = this.collisionDetector.method_651(hitPosition,this.splashDamage.radius,this.splashTargetFilter);
         this.splashTargetFilter.method_759(null);
         if(objectsInRadius != null)
         {
            for each(bodyDistance in objectsInRadius)
            {
               targetBody = bodyDistance.body;
               splashImpactForce = Number(this.splashDamage.method_758(impactForce,bodyDistance.distance));
               force.method_366(targetBody.state.position,hitPosition).normalize().scale(splashImpactForce);
               targetBody.name_585(force);
               if(splashHits != null)
               {
                  weaponHit = new name_553();
                  weaponHit.distance = bodyDistance.distance;
                  weaponHit.body = targetBody;
                  splashHits.push(weaponHit);
               }
            }
         }
      }
   }
}

