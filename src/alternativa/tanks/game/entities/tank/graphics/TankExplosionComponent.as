package alternativa.tanks.game.entities.tank.graphics
{
   import alternativa.engine3d.materials.Material;
   import alternativa.math.Vector3;
   import alternativa.physics.collision.ICollisionDetector;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.effects.AnimatedPlaneEffect;
   import alternativa.tanks.game.effects.AnimatedSpriteEffect;
   import alternativa.tanks.game.effects.MovingAnimatedSprite;
   import alternativa.tanks.game.entities.tank.TankEvents;
   import alternativa.tanks.game.entities.tank.physics.IChassisPhysicsComponent;
   import alternativa.tanks.game.physics.CollisionGroup;
   
   public class TankExplosionComponent extends EntityComponent
   {
      private static const MAX_SHOCK_WAVE_DISTANCE:Number = 1500;
      
      private static const FULL_SHOCK_WAVE_SIZE_DISTANCE:Number = 300;
      
      private static const SHOCK_WAVE_FPS:int = 30;
      
      private static const EXPLOSION_FPS:int = 25;
      
      private static const SMOKE_FPS:int = 25;
      
      private var shockWaveStartSize:Number;
      
      private var shockWaveGrowSpeed:Number;
      
      private var shockWaveFrames:Vector.<Material>;
      
      private var explosionFrames:Vector.<Material>;
      
      private var smokeFrames:Vector.<Material>;
      
      private var gameKernel:GameKernel;
      
      public function TankExplosionComponent(shockWaveStartSize:Number, shockWaveGrowSpeed:Number, shockWaveFrames:Vector.<Material>, explosionFrames:Vector.<Material>, smokeFrames:Vector.<Material>)
      {
         super();
         this.shockWaveStartSize = shockWaveStartSize;
         this.shockWaveGrowSpeed = shockWaveGrowSpeed;
         this.shockWaveFrames = shockWaveFrames;
         this.explosionFrames = explosionFrames;
         this.smokeFrames = smokeFrames;
      }
      
      override public function initComponent() : void
      {
         entity.addEventHandler(TankEvents.SET_DEAD_STATE,this.onSetDeadState);
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         this.gameKernel = gameKernel;
      }
      
      override public function removeFromGame(gameKernel:GameKernel) : void
      {
         this.gameKernel = null;
      }
      
      private function onSetDeadState(eventType:String, eventData:*) : void
      {
         var chassisPhysicsComponent:IChassisPhysicsComponent = IChassisPhysicsComponent(entity.getComponentStrict(IChassisPhysicsComponent));
         this.createShockWave(chassisPhysicsComponent);
         this.createExplosion(chassisPhysicsComponent);
         this.createSmoke(chassisPhysicsComponent);
      }
      
      private function createShockWave(chassisPhysicsComponent:IChassisPhysicsComponent) : void
      {
         var actualSize:Number = NaN;
         var position:Vector3 = null;
         var rotation:Vector3 = null;
         var effect:AnimatedPlaneEffect = null;
         var collisionDetector:ICollisionDetector = this.gameKernel.getPhysicsSystem().getPhysicsScene().collisionDetector;
         var origin:Vector3 = chassisPhysicsComponent.getBody().state.position;
         var result:RayHit = new RayHit();
         if(collisionDetector.raycastStatic(origin,Vector3.DOWN,CollisionGroup.STATIC,MAX_SHOCK_WAVE_DISTANCE,null,result))
         {
            if(result.t < FULL_SHOCK_WAVE_SIZE_DISTANCE)
            {
               actualSize = this.shockWaveStartSize;
            }
            else
            {
               actualSize = this.shockWaveStartSize * (MAX_SHOCK_WAVE_DISTANCE - result.t) / (MAX_SHOCK_WAVE_DISTANCE - FULL_SHOCK_WAVE_SIZE_DISTANCE);
            }
            position = result.position.clone();
            position.z += 1;
            rotation = new Vector3();
            rotation.x = -Math.acos(result.normal.z);
            if(result.normal.z < 0.999)
            {
               rotation.z = Math.atan2(-result.normal.x,result.normal.y);
            }
            effect = AnimatedPlaneEffect(this.gameKernel.getObjectPoolManager().getObject(AnimatedPlaneEffect));
            effect.init(actualSize,position,rotation,this.shockWaveFrames,SHOCK_WAVE_FPS,this.shockWaveGrowSpeed);
            this.gameKernel.getRenderSystem().addEffect(effect);
         }
      }
      
      private function createExplosion(chassisPhysicsComponent:IChassisPhysicsComponent) : void
      {
         var animatedSpriteEffect:AnimatedSpriteEffect = AnimatedSpriteEffect(this.gameKernel.getObjectPoolManager().getObject(AnimatedSpriteEffect));
         var position:Vector3 = chassisPhysicsComponent.getBody().state.position.clone();
         position.z += 100;
         var rotation:Number = Math.random() * Math.PI;
         animatedSpriteEffect.init(600,600,this.explosionFrames,position,rotation,400,EXPLOSION_FPS,false);
         this.gameKernel.getRenderSystem().addEffect(animatedSpriteEffect);
      }
      
      private function createSmoke(chassisPhysicsComponent:IChassisPhysicsComponent) : void
      {
         var angle:Number = NaN;
         var speed:Number = NaN;
         var movingAnimatedSprite:MovingAnimatedSprite = null;
         var rotation:Number = NaN;
         var minAngle:Number = 10 * Math.PI / 180;
         var maxAngle:Number = 60 * Math.PI / 180;
         var position:Vector3 = chassisPhysicsComponent.getBody().state.position.clone();
         position.z += 100;
         var velocity:Vector3 = new Vector3();
         var rotationAngle:Number = Math.random() * Math.PI;
         var direction:Vector3 = new Vector3();
         for(var i:int = 0; i < 3; i++)
         {
            direction.x = Math.cos(rotationAngle);
            direction.y = Math.sin(rotationAngle);
            angle = Math.random() * (maxAngle - minAngle) + minAngle;
            speed = 900 + Math.random() * (1000 - 900);
            velocity.copy(direction).scale(Math.sin(angle)).add(Vector3.UP).normalize().scale(speed);
            movingAnimatedSprite = MovingAnimatedSprite(this.gameKernel.getObjectPoolManager().getObject(MovingAnimatedSprite));
            rotation = Math.random() * Math.PI;
            movingAnimatedSprite.init(400,400,this.smokeFrames,position,velocity,-1000,rotation,SMOKE_FPS,false);
            this.gameKernel.getRenderSystem().addEffect(movingAnimatedSprite);
            rotationAngle += 2 / 3 * Math.PI;
         }
      }
   }
}

