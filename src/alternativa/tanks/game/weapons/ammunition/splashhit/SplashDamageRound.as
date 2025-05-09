package alternativa.tanks.game.weapons.ammunition.splashhit
{
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.effects.IAreaOfEffectSFX;
   import alternativa.tanks.game.physics.BodyDistance;
   import alternativa.tanks.game.physics.CollisionGroup;
   import alternativa.tanks.game.physics.ITanksCollisionDetector;
   import alternativa.tanks.game.physics.SimpleRaycastFilter;
   import alternativa.tanks.game.utils.GameMathUtils;
   import alternativa.tanks.game.weapons.IGenericRound;
   import alternativa.tanks.game.weapons.IWeaponDistanceWeakening;
   import alternativa.tanks.game.weapons.WeaponHit;
   import alternativa.tanks.game.weapons.ammunition.IAOEAmmunitionCallback;
   
   public class SplashDamageRound implements IGenericRound
   {
      private static const HIT_POINT_CORRECTION:Number = 1;
      
      private static var direction:Vector3 = new Vector3();
      
      private static var force:Vector3 = new Vector3();
      
      private static var splashHits:Vector.<WeaponHit> = new Vector.<WeaponHit>();
      
      private static var rayHit:RayHit = new RayHit();
      
      private static var filter:SimpleRaycastFilter = new SimpleRaycastFilter();
      
      private static var hitInfo:WeaponHit = new WeaponHit();
      
      private var directImpactForce:Number;
      
      private var weakening:IWeaponDistanceWeakening;
      
      private var splashDamage:ISplashDamage;
      
      private var effects:IAreaOfEffectSFX;
      
      private var collisionDetector:ITanksCollisionDetector;
      
      private var splashTargetFilter:ISplashTargetFilter;
      
      private var callback:IAOEAmmunitionCallback;
      
      public function SplashDamageRound(directImpactForce:Number, weakening:IWeaponDistanceWeakening, splashDamage:ISplashDamage, effects:IAreaOfEffectSFX, collisionDetector:ITanksCollisionDetector, splashTargetFilter:ISplashTargetFilter)
      {
         super();
         this.directImpactForce = directImpactForce;
         this.weakening = weakening;
         this.splashDamage = splashDamage;
         this.effects = effects;
         this.collisionDetector = collisionDetector;
         this.splashTargetFilter = splashTargetFilter;
      }
      
      public function setCallback(callback:IAOEAmmunitionCallback) : void
      {
         this.callback = callback;
      }
      
      public function shoot(gameKernel:GameKernel, shotId:int, shooter:Body, barrelOrigin:Vector3, barrelLength:Number, shotDirection:Vector3, muzzlePosition:Vector3) : void
      {
         var distance:Number = NaN;
         var weakeningCoefficient:Number = NaN;
         var impactForce:Number = NaN;
         var primaryTarget:Body = null;
         filter.body = shooter;
         if(this.collisionDetector.raycast(barrelOrigin,shotDirection,CollisionGroup.WEAPON | CollisionGroup.STATIC,GameMathUtils.BIG_VALUE,filter,rayHit))
         {
            distance = rayHit.t - barrelLength;
            if(distance < 0)
            {
               distance = 0;
            }
            weakeningCoefficient = Number(this.weakening.getWeakeningCoefficient(distance));
            impactForce = this.directImpactForce * weakeningCoefficient;
            primaryTarget = rayHit.primitive.body;
            if(primaryTarget != null)
            {
               primaryTarget.addWorldForceScaled(rayHit.position,shotDirection,impactForce);
            }
            rayHit.position.addScaled(HIT_POINT_CORRECTION,rayHit.normal);
            splashHits.length = 0;
            this.processSplashTargets(rayHit.position,primaryTarget,impactForce,splashHits);
            this.effects.createEffects(rayHit.position,weakeningCoefficient,this.splashDamage.radius);
            hitInfo.body = primaryTarget;
            hitInfo.direction.copy(shotDirection);
            hitInfo.distance = distance;
            hitInfo.normal.copy(rayHit.normal);
            hitInfo.position.copy(rayHit.position);
            if(this.callback != null)
            {
               this.callback.onHit(shotId,hitInfo,splashHits);
            }
            splashHits.length = 0;
         }
         filter.body = null;
      }
      
      public function showHitEffects(hitPosition:Vector3, primaryTarget:Body, muzzlePosition:Vector3) : void
      {
         direction.diff(hitPosition,muzzlePosition);
         var weakeningCoefficient:Number = Number(this.weakening.getWeakeningCoefficient(direction.length()));
         var imactForce:Number = this.directImpactForce * weakeningCoefficient;
         if(primaryTarget != null)
         {
            direction.normalize();
            primaryTarget.addWorldForceScaled(hitPosition,direction,imactForce);
         }
         this.processSplashTargets(hitPosition,primaryTarget,imactForce,null);
         this.effects.createEffects(hitPosition,weakeningCoefficient,this.splashDamage.radius);
      }
      
      private function processSplashTargets(hitPosition:Vector3, primaryTarget:Body, impactForce:Number, splashHits:Vector.<WeaponHit>) : void
      {
         var bodyDistance:BodyDistance = null;
         var targetBody:Body = null;
         var splashImpactForce:Number = NaN;
         var weaponHit:WeaponHit = null;
         this.splashTargetFilter.setPrimaryTarget(primaryTarget);
         var objectsInRadius:Vector.<BodyDistance> = this.collisionDetector.getObjectsInRadius(hitPosition,this.splashDamage.radius,this.splashTargetFilter);
         this.splashTargetFilter.setPrimaryTarget(null);
         if(objectsInRadius != null)
         {
            for each(bodyDistance in objectsInRadius)
            {
               targetBody = bodyDistance.body;
               splashImpactForce = Number(this.splashDamage.getPower(impactForce,bodyDistance.distance));
               force.diff(targetBody.state.position,hitPosition).normalize().scale(splashImpactForce);
               targetBody.addForce(force);
               if(splashHits != null)
               {
                  weaponHit = new WeaponHit();
                  weaponHit.distance = bodyDistance.distance;
                  weaponHit.body = targetBody;
                  splashHits.push(weaponHit);
               }
            }
         }
      }
   }
}

