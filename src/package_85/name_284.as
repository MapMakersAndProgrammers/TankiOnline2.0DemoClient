package package_85
{
   import package_10.class_17;
   import package_10.name_17;
   import package_4.class_4;
   import package_46.name_194;
   import package_71.name_252;
   import package_72.name_239;
   import package_72.name_260;
   import package_72.name_264;
   import package_75.name_236;
   import package_76.name_256;
   import package_86.name_257;
   import package_90.name_273;
   
   public class name_284 extends class_17
   {
      private static const MAX_SHOCK_WAVE_DISTANCE:Number = 1500;
      
      private static const FULL_SHOCK_WAVE_SIZE_DISTANCE:Number = 300;
      
      private static const SHOCK_WAVE_FPS:int = 30;
      
      private static const EXPLOSION_FPS:int = 25;
      
      private static const SMOKE_FPS:int = 25;
      
      private var shockWaveStartSize:Number;
      
      private var shockWaveGrowSpeed:Number;
      
      private var shockWaveFrames:Vector.<class_4>;
      
      private var explosionFrames:Vector.<class_4>;
      
      private var smokeFrames:Vector.<class_4>;
      
      private var gameKernel:name_17;
      
      public function name_284(shockWaveStartSize:Number, shockWaveGrowSpeed:Number, shockWaveFrames:Vector.<class_4>, explosionFrames:Vector.<class_4>, smokeFrames:Vector.<class_4>)
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
         entity.addEventHandler(name_252.SET_DEAD_STATE,this.method_446);
      }
      
      override public function addToGame(gameKernel:name_17) : void
      {
         this.gameKernel = gameKernel;
      }
      
      override public function removeFromGame(gameKernel:name_17) : void
      {
         this.gameKernel = null;
      }
      
      private function method_446(eventType:String, eventData:*) : void
      {
         var chassisPhysicsComponent:name_236 = name_236(entity.getComponentStrict(name_236));
         this.method_162(chassisPhysicsComponent);
         this.method_168(chassisPhysicsComponent);
         this.method_445(chassisPhysicsComponent);
      }
      
      private function method_162(chassisPhysicsComponent:name_236) : void
      {
         var actualSize:Number = NaN;
         var position:name_194 = null;
         var rotation:name_194 = null;
         var effect:name_264 = null;
         var collisionDetector:name_256 = this.gameKernel.method_112().name_246().collisionDetector;
         var origin:name_194 = chassisPhysicsComponent.getBody().state.position;
         var result:name_273 = new name_273();
         if(collisionDetector.name_324(origin,name_194.DOWN,name_257.STATIC,MAX_SHOCK_WAVE_DISTANCE,null,result))
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
            rotation = new name_194();
            rotation.x = -Math.acos(result.normal.z);
            if(result.normal.z < 0.999)
            {
               rotation.z = Math.atan2(-result.normal.x,result.normal.y);
            }
            effect = name_264(this.gameKernel.method_108().name_110(name_264));
            effect.init(actualSize,position,rotation,this.shockWaveFrames,SHOCK_WAVE_FPS,this.shockWaveGrowSpeed);
            this.gameKernel.name_5().method_37(effect);
         }
      }
      
      private function method_168(chassisPhysicsComponent:name_236) : void
      {
         var animatedSpriteEffect:name_239 = name_239(this.gameKernel.method_108().name_110(name_239));
         var position:name_194 = chassisPhysicsComponent.getBody().state.position.clone();
         position.z += 100;
         var rotation:Number = Math.random() * Math.PI;
         animatedSpriteEffect.init(600,600,this.explosionFrames,position,rotation,400,EXPLOSION_FPS,false);
         this.gameKernel.name_5().method_37(animatedSpriteEffect);
      }
      
      private function method_445(chassisPhysicsComponent:name_236) : void
      {
         var angle:Number = NaN;
         var speed:Number = NaN;
         var movingAnimatedSprite:name_260 = null;
         var rotation:Number = NaN;
         var minAngle:Number = 10 * Math.PI / 180;
         var maxAngle:Number = 60 * Math.PI / 180;
         var position:name_194 = chassisPhysicsComponent.getBody().state.position.clone();
         position.z += 100;
         var velocity:name_194 = new name_194();
         var rotationAngle:Number = Math.random() * Math.PI;
         var direction:name_194 = new name_194();
         for(var i:int = 0; i < 3; i++)
         {
            direction.x = Math.cos(rotationAngle);
            direction.y = Math.sin(rotationAngle);
            angle = Math.random() * (maxAngle - minAngle) + minAngle;
            speed = 900 + Math.random() * (1000 - 900);
            velocity.copy(direction).scale(Math.sin(angle)).add(name_194.UP).normalize().scale(speed);
            movingAnimatedSprite = name_260(this.gameKernel.method_108().name_110(name_260));
            rotation = Math.random() * Math.PI;
            movingAnimatedSprite.init(400,400,this.smokeFrames,position,velocity,-1000,rotation,SMOKE_FPS,false);
            this.gameKernel.name_5().method_37(movingAnimatedSprite);
            rotationAngle += 2 / 3 * Math.PI;
         }
      }
   }
}

