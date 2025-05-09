package alternativa.tanks.game.weapons.ammunition.pointhit
{
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.physics.collision.ICollisionDetector;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.effects.IAreaOfEffectSFX;
   import alternativa.tanks.game.physics.CollisionGroup;
   import alternativa.tanks.game.physics.SimpleRaycastFilter;
   import alternativa.tanks.game.utils.GameMathUtils;
   import alternativa.tanks.game.weapons.IGenericRound;
   import alternativa.tanks.game.weapons.IWeaponDistanceWeakening;
   import alternativa.tanks.game.weapons.WeaponHit;
   import alternativa.tanks.game.weapons.ammunition.IAOEAmmunitionCallback;
   
   public class PointHitRound implements IGenericRound
   {
      private static const COLLISION_MASK:int = CollisionGroup.STATIC | CollisionGroup.WEAPON;
      
      private static var hitPosition:Vector3 = new Vector3();
      
      private static var filter:SimpleRaycastFilter = new SimpleRaycastFilter();
      
      private static var rayHit:RayHit = new RayHit();
      
      private static var hitInfo:WeaponHit = new WeaponHit();
      
      private var impactForce:Number;
      
      private var weakening:IWeaponDistanceWeakening;
      
      private var effects:IAreaOfEffectSFX;
      
      private var callback:IAOEAmmunitionCallback;
      
      public function PointHitRound(impactForce:Number, weakening:IWeaponDistanceWeakening, effects:IAreaOfEffectSFX)
      {
         super();
         this.impactForce = impactForce;
         this.weakening = weakening;
         this.effects = effects;
      }
      
      public function setCallback(callback:IAOEAmmunitionCallback) : void
      {
         this.callback = callback;
      }
      
      public function shoot(gameKernel:GameKernel, shotId:int, shooter:Body, barrelOrigin:Vector3, barrelLength:Number, shotDirection:Vector3, muzzlePosition:Vector3) : void
      {
         var distance:Number = NaN;
         var weakeningCoefficient:Number = NaN;
         var collisionDetector:ICollisionDetector = gameKernel.getPhysicsSystem().getPhysicsScene().collisionDetector;
         filter.body = shooter;
         if(collisionDetector.raycast(barrelOrigin,shotDirection,COLLISION_MASK,GameMathUtils.BIG_VALUE,filter,rayHit))
         {
            distance = rayHit.t - barrelLength;
            if(distance < 0)
            {
               distance = 0;
            }
            weakeningCoefficient = Number(this.weakening.getWeakeningCoefficient(distance));
            hitInfo.body = rayHit.primitive.body;
            hitInfo.direction.copy(shotDirection);
            hitInfo.normal.copy(rayHit.normal);
            hitInfo.position.copy(rayHit.position);
            hitInfo.distance = distance;
            this.doShowHitEffects(hitInfo.body,hitInfo.position,hitInfo.direction,weakeningCoefficient);
            if(this.callback != null)
            {
               this.callback.onHit(shotId,hitInfo,null);
            }
         }
         filter.body = null;
      }
      
      public function showHitEffects(target:Body, targetHitPosition:Vector3, hitDirection:Vector3, distance:Number) : void
      {
         hitPosition.copy(targetHitPosition);
         this.doShowHitEffects(target,hitPosition,hitDirection,this.weakening.getWeakeningCoefficient(distance));
      }
      
      private function doShowHitEffects(target:Body, hitPosition:Vector3, hitDirection:Vector3, weakening:Number) : void
      {
         if(target != null)
         {
            target.addWorldForceScaled(hitPosition,hitDirection,this.impactForce * weakening);
         }
         this.effects.createEffects(hitPosition,weakening,0);
      }
   }
}

