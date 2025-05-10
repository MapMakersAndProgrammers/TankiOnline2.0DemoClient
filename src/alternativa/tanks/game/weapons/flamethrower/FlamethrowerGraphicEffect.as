package alternativa.tanks.game.weapons.flamethrower
{
   import alternativa.engine3d.effects.TextureAtlas;
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.osgi.service.console.variables.ConsoleVarFloat;
   import alternativa.physics.collision.ICollisionDetector;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.game.entities.tank.physics.IChassisPhysicsComponent;
   import alternativa.tanks.game.entities.tank.physics.ITurretPhysicsComponent;
   import alternativa.tanks.game.physics.CollisionGroup;
   import alternativa.tanks.game.subsystems.rendersystem.GameCamera;
   import alternativa.tanks.game.subsystems.rendersystem.IGraphicEffect;
   import alternativa.tanks.game.subsystems.rendersystem.RenderSystem;
   import alternativa.tanks.game.utils.objectpool.ObjectPool;
   import alternativa.tanks.game.utils.objectpool.PooledObject;
   import flash.geom.Vector3D;
   
   public class FlamethrowerGraphicEffect extends PooledObject implements IGraphicEffect
   {
      private static const ANIMATION_FPS:Number = 30;
      
      private static const START_SCALE:Number = 0.5;
      
      private static const END_SCALE:Number = 4;
      
      private static const BARREL_INDEX:Number = 0;
      
      private static var particleBaseSize:ConsoleVarFloat = new ConsoleVarFloat("flame_base_size",100,1,1000);
      
      private static var matrix:Matrix3 = new Matrix3();
      
      private static var particlePosition:Vector3 = new Vector3();
      
      private static var barrelOrigin:Vector3 = new Vector3();
      
      private static var particleDirection:Vector3 = new Vector3();
      
      private static var xAxis:Vector3 = new Vector3();
      
      private static var sourcePosition:Vector3 = new Vector3();
      
      private static var rayHit:RayHit = new RayHit();
      
      private var range:Number;
      
      private var name_n7:Number;
      
      private var name_er:Number;
      
      private var maxParticles:int;
      
      private var particleSpeed:Number;
      
      private var sfxData:FlamethrowerSFXData;
      
      private var name_lV:Vector.<Particle> = new Vector.<Particle>();
      
      private var name_Jx:int;
      
      private var numFrames:int;
      
      private var collisionDetector:ICollisionDetector;
      
      private var dead:Boolean;
      
      private var name_ny:int;
      
      private var name_jJ:int;
      
      private var collisionGroup:int = CollisionGroup.WEAPON | CollisionGroup.STATIC;
      
      private var origin:Vector3 = new Vector3();
      
      private var direction:Vector3 = new Vector3();
      
      private var sideAxis:Vector3 = new Vector3();
      
      private var name_6z:Number;
      
      private var renderSystem:RenderSystem;
      
      private var turret:ITurretPhysicsComponent;
      
      private var chassis:IChassisPhysicsComponent;
      
      private var flame:FlameThrower;
      
      private var position:Vector3D = new Vector3D();
      
      private var dir:Vector3D = new Vector3D();
      
      public function FlamethrowerGraphicEffect(objectPool:ObjectPool)
      {
         super(objectPool);
      }
      
      public function addedToRenderSystem(system:RenderSystem) : void
      {
         this.renderSystem = system;
         this.turret.getGunData(BARREL_INDEX,this.origin,this.direction,this.sideAxis);
         this.name_6z = this.turret.getBarrelLength(BARREL_INDEX);
         this.position.x = this.origin.x + this.direction.x * this.name_6z;
         this.position.y = this.origin.y + this.direction.y * this.name_6z;
         this.position.z = this.origin.z + this.direction.z * this.name_6z;
         this.flame.position = this.position;
         this.dir.x = this.direction.x;
         this.dir.y = this.direction.y;
         this.dir.z = this.direction.z;
         this.flame.direction = this.dir;
         this.renderSystem.addA3DEffect(this.flame);
      }
      
      public function init(turret:ITurretPhysicsComponent, flamethrowerSmokeAtlas:TextureAtlas, flamethrowerFlashAtlas:TextureAtlas, flamethrowerFireAtlas:TextureAtlas) : void
      {
         this.turret = turret;
         this.flame = new FlameThrower(flamethrowerSmokeAtlas,flamethrowerFireAtlas,flamethrowerFlashAtlas,15);
         this.flame.scale = 5 * 1.4;
         this.flame.name = "firebird";
      }
      
      public function play(camera:GameCamera) : Boolean
      {
         if(this.flame == null)
         {
            return false;
         }
         this.turret.getGunData(BARREL_INDEX,this.origin,this.direction,this.sideAxis);
         this.name_6z = this.turret.getBarrelLength(BARREL_INDEX);
         this.position.x = this.origin.x + this.direction.x * this.name_6z;
         this.position.y = this.origin.y + this.direction.y * this.name_6z;
         this.position.z = this.origin.z + this.direction.z * this.name_6z;
         this.flame.position = this.position;
         this.dir.x = this.direction.x;
         this.dir.y = this.direction.y;
         this.dir.z = this.direction.z;
         this.flame.direction = this.dir;
         return true;
      }
      
      public function destroy() : void
      {
      }
      
      public function kill() : void
      {
         this.flame.stop();
         this.flame = null;
      }
      
      private function tryToAddParticle() : void
      {
         var offset:Number = Math.random() * 50;
         if(!this.collisionDetector.raycastStatic(this.origin,this.direction,CollisionGroup.STATIC,this.name_6z + offset,null,rayHit))
         {
            sourcePosition.x = this.origin.x + this.direction.x * this.name_6z;
            sourcePosition.y = this.origin.y + this.direction.y * this.name_6z;
            sourcePosition.z = this.origin.z + this.direction.z * this.name_6z;
            particleDirection.copy(this.direction);
            xAxis.copy(this.sideAxis);
            this.addParticle(sourcePosition,particleDirection,xAxis,offset);
         }
      }
      
      private function addParticle(sourcePosition:Vector3, direction:Vector3, sideAxis:Vector3, offset:Number) : void
      {
         var particle:Particle = Particle.getParticle();
         particle.currFrame = Math.random() * this.numFrames;
         var angle:Number = 2 * Math.PI * Math.random();
         matrix.fromAxisAngle(direction,angle);
         sideAxis.transform3(matrix);
         var d:Number = this.range * this.name_er * Math.random();
         direction.x = direction.x * this.range + sideAxis.x * d;
         direction.y = direction.y * this.range + sideAxis.y * d;
         direction.z = direction.z * this.range + sideAxis.z * d;
         direction.normalize();
         var bodyVelocity:Vector3 = this.chassis.getBody().state.velocity;
         particle.velocity.x = this.particleSpeed * direction.x + bodyVelocity.x;
         particle.velocity.y = this.particleSpeed * direction.y + bodyVelocity.y;
         particle.velocity.z = this.particleSpeed * direction.z + bodyVelocity.z;
         particle.distance = offset;
         particle.x = sourcePosition.x + offset * direction.x;
         particle.y = sourcePosition.y + offset * direction.y;
         particle.z = sourcePosition.z + offset * direction.z;
         var _loc9_:* = this.name_Jx++;
         this.name_lV[_loc9_] = particle;
      }
      
      private function removeParticle(index:int) : void
      {
         var particle:Particle = this.name_lV[index];
         this.name_lV[index] = this.name_lV[--this.name_Jx];
         this.name_lV[this.name_Jx] = null;
         particle.dispose();
      }
   }
}

import alternativa.engine3d.core.Object3D;
import alternativa.engine3d.objects.Sprite3D;
import alternativa.math.Vector3;
import alternativa.tanks.game.effects.ColorTransformEntry;
import flash.geom.ColorTransform;

class Particle extends Sprite3D
{
   private static var INITIAL_POOL_SIZE:int = 20;
   
   private static var pool:Vector.<Particle> = new Vector.<Particle>(INITIAL_POOL_SIZE);
   
   private static var poolIndex:int = -1;
   
   public var velocity:Vector3 = new Vector3();
   
   public var distance:Number = 0;
   
   public var currFrame:Number;
   
   public function Particle()
   {
      super(300,300);
   }
   
   public static function getParticle() : Particle
   {
      if(poolIndex == -1)
      {
         return new Particle();
      }
      var particle:Particle = pool[poolIndex];
      var _loc2_:* = poolIndex--;
      pool[_loc2_] = null;
      return particle;
   }
   
   public function dispose() : void
   {
      material = null;
      var _loc1_:* = ++poolIndex;
      pool[_loc1_] = this;
   }
   
   public function updateColorTransofrm(maxDistance:Number, points:Vector.<ColorTransformEntry>) : void
   {
      var point1:ColorTransformEntry = null;
      var point2:ColorTransformEntry = null;
      var _loc6_:int = 0;
      if(points == null)
      {
         return;
      }
      var t:Number = this.distance / maxDistance;
      if(t <= 0)
      {
         point1 = points[0];
      }
      else if(t >= 1)
      {
         point1 = points[points.length - 1];
      }
      else
      {
         _loc6_ = 1;
         point1 = points[0];
         for(point2 = points[1]; point2.t < t; )
         {
            _loc6_++;
            point1 = point2;
            point2 = points[_loc6_];
         }
         t = (t - point1.t) / (point2.t - point1.t);
      }
   }
   
   private function interpolateColorTransform(ct1:ColorTransform, ct2:ColorTransform, t:Number, result:ColorTransform) : void
   {
      result.alphaMultiplier = ct1.alphaMultiplier + t * (ct2.alphaMultiplier - ct1.alphaMultiplier);
      result.alphaOffset = ct1.alphaOffset + t * (ct2.alphaOffset - ct1.alphaOffset);
      result.redMultiplier = ct1.redMultiplier + t * (ct2.redMultiplier - ct1.redMultiplier);
      result.redOffset = ct1.redOffset + t * (ct2.redOffset - ct1.redOffset);
      result.greenMultiplier = ct1.greenMultiplier + t * (ct2.greenMultiplier - ct1.greenMultiplier);
      result.greenOffset = ct1.greenOffset + t * (ct2.greenOffset - ct1.greenOffset);
      result.blueMultiplier = ct1.blueMultiplier + t * (ct2.blueMultiplier - ct1.blueMultiplier);
      result.blueOffset = ct1.blueOffset + t * (ct2.blueOffset - ct1.blueOffset);
   }
   
   private function copyStructToColorTransform(source:ColorTransform, result:ColorTransform) : void
   {
      result.alphaMultiplier = source.alphaMultiplier;
      result.alphaOffset = source.alphaOffset;
      result.redMultiplier = source.redMultiplier;
      result.redOffset = source.redOffset;
      result.greenMultiplier = source.greenMultiplier;
      result.greenOffset = source.greenOffset;
      result.blueMultiplier = source.blueMultiplier;
      result.blueOffset = source.blueOffset;
   }
}
