package package_81
{
   import flash.geom.Vector3D;
   import alternativa.osgi.service.console.variables.ConsoleVarFloat;
   import alternativa.tanks.game.subsystems.rendersystem.RenderSystem;
   import alternativa.tanks.game.subsystems.rendersystem.IGraphicEffect;
   import alternativa.tanks.game.subsystems.rendersystem.GameCamera;
   import package_25.name_250;
   import alternativa.tanks.game.utils.objectpool.PooledObject;
   import alternativa.tanks.game.utils.objectpool.ObjectPool;
   import package_46.Matrix3;
   import package_46.name_194;
   import package_75.class_15;
   import package_75.name_236;
   import package_76.name_256;
   import package_86.name_257;
   import package_90.name_273;
   
   public class name_544 extends PooledObject implements IGraphicEffect
   {
      private static const ANIMATION_FPS:Number = 30;
      
      private static const START_SCALE:Number = 0.5;
      
      private static const END_SCALE:Number = 4;
      
      private static const BARREL_INDEX:Number = 0;
      
      private static var particleBaseSize:ConsoleVarFloat = new ConsoleVarFloat("flame_base_size",100,1,1000);
      
      private static var matrix:Matrix3 = new Matrix3();
      
      private static var particlePosition:name_194 = new name_194();
      
      private static var barrelOrigin:name_194 = new name_194();
      
      private static var particleDirection:name_194 = new name_194();
      
      private static var xAxis:name_194 = new name_194();
      
      private static var sourcePosition:name_194 = new name_194();
      
      private static var rayHit:name_273 = new name_273();
      
      private var range:Number;
      
      private var var_641:Number;
      
      private var var_639:Number;
      
      private var maxParticles:int;
      
      private var particleSpeed:Number;
      
      private var sfxData:name_262;
      
      private var var_637:Vector.<Particle> = new Vector.<Particle>();
      
      private var var_638:int;
      
      private var numFrames:int;
      
      private var collisionDetector:name_256;
      
      private var dead:Boolean;
      
      private var var_640:int;
      
      private var var_642:int;
      
      private var collisionGroup:int = name_257.WEAPON | name_257.STATIC;
      
      private var origin:name_194 = new name_194();
      
      private var direction:name_194 = new name_194();
      
      private var sideAxis:name_194 = new name_194();
      
      private var var_636:Number;
      
      private var renderSystem:RenderSystem;
      
      private var turret:class_15;
      
      private var chassis:name_236;
      
      private var flame:name_717;
      
      private var position:Vector3D = new Vector3D();
      
      private var dir:Vector3D = new Vector3D();
      
      public function name_544(objectPool:ObjectPool)
      {
         super(objectPool);
      }
      
      public function addedToRenderSystem(system:RenderSystem) : void
      {
         this.renderSystem = system;
         this.turret.getGunData(BARREL_INDEX,this.origin,this.direction,this.sideAxis);
         this.var_636 = this.turret.getBarrelLength(BARREL_INDEX);
         this.position.x = this.origin.x + this.direction.x * this.var_636;
         this.position.y = this.origin.y + this.direction.y * this.var_636;
         this.position.z = this.origin.z + this.direction.z * this.var_636;
         this.flame.position = this.position;
         this.dir.x = this.direction.x;
         this.dir.y = this.direction.y;
         this.dir.z = this.direction.z;
         this.flame.direction = this.dir;
         this.renderSystem.method_48(this.flame);
      }
      
      public function init(turret:class_15, flamethrowerSmokeAtlas:name_250, flamethrowerFlashAtlas:name_250, flamethrowerFireAtlas:name_250) : void
      {
         this.turret = turret;
         this.flame = new name_717(flamethrowerSmokeAtlas,flamethrowerFireAtlas,flamethrowerFlashAtlas,15);
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
         this.var_636 = this.turret.getBarrelLength(BARREL_INDEX);
         this.position.x = this.origin.x + this.direction.x * this.var_636;
         this.position.y = this.origin.y + this.direction.y * this.var_636;
         this.position.z = this.origin.z + this.direction.z * this.var_636;
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
      
      public function method_255() : void
      {
         this.flame.stop();
         this.flame = null;
      }
      
      private function method_756() : void
      {
         var offset:Number = Math.random() * 50;
         if(!this.collisionDetector.name_324(this.origin,this.direction,name_257.STATIC,this.var_636 + offset,null,rayHit))
         {
            sourcePosition.x = this.origin.x + this.direction.x * this.var_636;
            sourcePosition.y = this.origin.y + this.direction.y * this.var_636;
            sourcePosition.z = this.origin.z + this.direction.z * this.var_636;
            particleDirection.copy(this.direction);
            xAxis.copy(this.sideAxis);
            this.method_755(sourcePosition,particleDirection,xAxis,offset);
         }
      }
      
      private function method_755(sourcePosition:name_194, direction:name_194, sideAxis:name_194, offset:Number) : void
      {
         var particle:Particle = Particle.getParticle();
         particle.currFrame = Math.random() * this.numFrames;
         var angle:Number = 2 * Math.PI * Math.random();
         matrix.method_344(direction,angle);
         sideAxis.transform3(matrix);
         var d:Number = this.range * this.var_639 * Math.random();
         direction.x = direction.x * this.range + sideAxis.x * d;
         direction.y = direction.y * this.range + sideAxis.y * d;
         direction.z = direction.z * this.range + sideAxis.z * d;
         direction.normalize();
         var bodyVelocity:name_194 = this.chassis.getBody().state.velocity;
         particle.velocity.x = this.particleSpeed * direction.x + bodyVelocity.x;
         particle.velocity.y = this.particleSpeed * direction.y + bodyVelocity.y;
         particle.velocity.z = this.particleSpeed * direction.z + bodyVelocity.z;
         particle.distance = offset;
         particle.x = sourcePosition.x + offset * direction.x;
         particle.y = sourcePosition.y + offset * direction.y;
         particle.z = sourcePosition.z + offset * direction.z;
         var _loc9_:* = this.var_638++;
         this.var_637[_loc9_] = particle;
      }
      
      private function method_757(index:int) : void
      {
         var particle:Particle = this.var_637[index];
         this.var_637[index] = this.var_637[--this.var_638];
         this.var_637[this.var_638] = null;
         particle.dispose();
      }
   }
}

import flash.geom.ColorTransform;
import package_19.name_494;
import package_21.name_78;
import package_46.name_194;
import package_72.name_242;

class Particle extends name_494
{
   private static var INITIAL_POOL_SIZE:int = 20;
   
   private static var pool:Vector.<Particle> = new Vector.<Particle>(INITIAL_POOL_SIZE);
   
   private static var poolIndex:int = -1;
   
   public var velocity:name_194 = new name_194();
   
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
   
   public function updateColorTransofrm(maxDistance:Number, points:Vector.<name_242>) : void
   {
      var point1:name_242 = null;
      var point2:name_242 = null;
      var i:int = 0;
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
         i = 1;
         point1 = points[0];
         for(point2 = points[1]; point2.t < t; )
         {
            i++;
            point1 = point2;
            point2 = points[i];
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
