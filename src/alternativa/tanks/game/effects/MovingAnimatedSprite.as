package alternativa.tanks.game.effects
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.materials.Material;
   import alternativa.engine3d.objects.Sprite3D;
   import alternativa.math.Vector3;
   import alternativa.tanks.game.subsystems.rendersystem.GameCamera;
   import alternativa.tanks.game.subsystems.rendersystem.IGraphicEffect;
   import alternativa.tanks.game.subsystems.rendersystem.RenderSystem;
   import alternativa.tanks.game.subsystems.timesystem.TimeSystem;
   import alternativa.tanks.game.utils.objectpool.ObjectPool;
   import alternativa.tanks.game.utils.objectpool.PooledObject;
   
   public class MovingAnimatedSprite extends PooledObject implements IGraphicEffect
   {
      private var sprite:Sprite3D;
      
      private var §_-iD§:Number;
      
      private var currFrame:Number;
      
      private var frames:Vector.<Material>;
      
      private var numFrames:int;
      
      private var position:Vector3 = new Vector3();
      
      private var loop:Boolean;
      
      private var velocity:Vector3 = new Vector3();
      
      private var acceleration:Number;
      
      public function MovingAnimatedSprite(objectPool:ObjectPool)
      {
         super(objectPool);
      }
      
      public function init(width:Number, height:Number, frames:Vector.<Material>, position:Vector3, velocity:Vector3, acceleration:Number, rotation:Number, fps:Number, loop:Boolean, originX:Number = 0.5, originY:Number = 0.5) : void
      {
         this.initSprite(width,height,rotation,originX,originY);
         this.frames = frames;
         this.§_-iD§ = 0.001 * fps;
         this.position.copy(position);
         this.velocity.copy(velocity);
         this.acceleration = acceleration;
         this.loop = loop;
         this.numFrames = frames.length;
         this.currFrame = 0;
      }
      
      public function setPosition(position:Vector3) : void
      {
         this.position.copy(position);
      }
      
      public function addedToRenderSystem(system:RenderSystem) : void
      {
         system.getEffectsContainer().addChild(this.sprite);
      }
      
      public function play(camera:GameCamera) : Boolean
      {
         if(!this.loop && this.currFrame >= this.numFrames)
         {
            return false;
         }
         var dt:Number = TimeSystem.timeDeltaSeconds;
         this.sprite.x = this.position.x;
         this.sprite.y = this.position.y;
         this.sprite.z = this.position.z;
         this.position.addScaled(dt,this.velocity);
         var speed:Number = this.velocity.length();
         speed += this.acceleration * dt;
         if(speed <= 0)
         {
            this.velocity.x = 0;
            this.velocity.y = 0;
            this.velocity.z = 0;
         }
         else
         {
            this.velocity.normalize();
            this.velocity.x *= speed;
            this.velocity.y *= speed;
            this.velocity.z *= speed;
         }
         this.sprite.material = this.frames[int(this.currFrame)];
         this.currFrame += this.§_-iD§ * TimeSystem.timeDelta;
         if(this.loop)
         {
            while(this.currFrame >= this.numFrames)
            {
               this.currFrame -= this.numFrames;
            }
         }
         return true;
      }
      
      public function destroy() : void
      {
         this.sprite.alternativa3d::removeFromParent();
         this.sprite.material = null;
         this.frames = null;
         storeInPool();
      }
      
      public function kill() : void
      {
         this.loop = false;
         this.currFrame = this.numFrames;
      }
      
      private function initSprite(width:Number, height:Number, rotation:Number, originX:Number, originY:Number) : void
      {
         if(this.sprite == null)
         {
            this.sprite = new Sprite3D(width,height);
         }
         else
         {
            this.sprite.width = width;
            this.sprite.height = height;
         }
         this.sprite.rotation = rotation;
         this.sprite.originX = originX;
         this.sprite.originY = originY;
      }
   }
}

