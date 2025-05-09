package §_-9Z§
{
   import §_-1e§.§_-fx§;
   import §_-7A§.§_-3e§;
   import §_-7A§.§_-Is§;
   import §_-KA§.§_-jr§;
   import §_-KT§.§_-Ju§;
   import §_-RQ§.§_-HE§;
   import §_-RQ§.§_-Va§;
   import §_-aF§.§_-S8§;
   import §_-e6§.§_-1I§;
   import §_-e6§.§_-RE§;
   import §_-e6§.§_-fX§;
   import §_-fT§.§_-HM§;
   import §_-nl§.Matrix3;
   import §_-nl§.§_-bj§;
   import flash.geom.Vector3D;
   
   public class §_-q4§ extends §_-HE§ implements §_-fX§
   {
      private static const ANIMATION_FPS:Number = 30;
      
      private static const START_SCALE:Number = 0.5;
      
      private static const END_SCALE:Number = 4;
      
      private static const BARREL_INDEX:Number = 0;
      
      private static var particleBaseSize:§_-Ju§ = new §_-Ju§("flame_base_size",100,1,1000);
      
      private static var matrix:Matrix3 = new Matrix3();
      
      private static var particlePosition:§_-bj§ = new §_-bj§();
      
      private static var barrelOrigin:§_-bj§ = new §_-bj§();
      
      private static var particleDirection:§_-bj§ = new §_-bj§();
      
      private static var xAxis:§_-bj§ = new §_-bj§();
      
      private static var sourcePosition:§_-bj§ = new §_-bj§();
      
      private static var rayHit:§_-jr§ = new §_-jr§();
      
      private var range:Number;
      
      private var §_-n7§:Number;
      
      private var §_-er§:Number;
      
      private var maxParticles:int;
      
      private var particleSpeed:Number;
      
      private var sfxData:§_-Fj§;
      
      private var §_-lV§:Vector.<Particle> = new Vector.<Particle>();
      
      private var §_-Jx§:int;
      
      private var numFrames:int;
      
      private var collisionDetector:§_-fx§;
      
      private var dead:Boolean;
      
      private var §_-ny§:int;
      
      private var §_-jJ§:int;
      
      private var collisionGroup:int = §_-HM§.WEAPON | §_-HM§.STATIC;
      
      private var origin:§_-bj§ = new §_-bj§();
      
      private var direction:§_-bj§ = new §_-bj§();
      
      private var sideAxis:§_-bj§ = new §_-bj§();
      
      private var §_-6z§:Number;
      
      private var renderSystem:§_-1I§;
      
      private var turret:§_-3e§;
      
      private var chassis:§_-Is§;
      
      private var flame:§_-7Z§;
      
      private var position:Vector3D = new Vector3D();
      
      private var dir:Vector3D = new Vector3D();
      
      public function §_-q4§(objectPool:§_-Va§)
      {
         super(objectPool);
      }
      
      public function addedToRenderSystem(system:§_-1I§) : void
      {
         this.renderSystem = system;
         this.turret.getGunData(BARREL_INDEX,this.origin,this.direction,this.sideAxis);
         this.§_-6z§ = this.turret.getBarrelLength(BARREL_INDEX);
         this.position.x = this.origin.x + this.direction.x * this.§_-6z§;
         this.position.y = this.origin.y + this.direction.y * this.§_-6z§;
         this.position.z = this.origin.z + this.direction.z * this.§_-6z§;
         this.flame.position = this.position;
         this.dir.x = this.direction.x;
         this.dir.y = this.direction.y;
         this.dir.z = this.direction.z;
         this.flame.direction = this.dir;
         this.renderSystem.§_-9p§(this.flame);
      }
      
      public function init(turret:§_-3e§, flamethrowerSmokeAtlas:§_-S8§, flamethrowerFlashAtlas:§_-S8§, flamethrowerFireAtlas:§_-S8§) : void
      {
         this.turret = turret;
         this.flame = new §_-7Z§(flamethrowerSmokeAtlas,flamethrowerFireAtlas,flamethrowerFlashAtlas,15);
         this.flame.scale = 5 * 1.4;
         this.flame.name = "firebird";
      }
      
      public function play(camera:§_-RE§) : Boolean
      {
         if(this.flame == null)
         {
            return false;
         }
         this.turret.getGunData(BARREL_INDEX,this.origin,this.direction,this.sideAxis);
         this.§_-6z§ = this.turret.getBarrelLength(BARREL_INDEX);
         this.position.x = this.origin.x + this.direction.x * this.§_-6z§;
         this.position.y = this.origin.y + this.direction.y * this.§_-6z§;
         this.position.z = this.origin.z + this.direction.z * this.§_-6z§;
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
      
      public function §_-Bz§() : void
      {
         this.flame.stop();
         this.flame = null;
      }
      
      private function §_-XT§() : void
      {
         var offset:Number = Math.random() * 50;
         if(!this.collisionDetector.§_-cX§(this.origin,this.direction,§_-HM§.STATIC,this.§_-6z§ + offset,null,rayHit))
         {
            sourcePosition.x = this.origin.x + this.direction.x * this.§_-6z§;
            sourcePosition.y = this.origin.y + this.direction.y * this.§_-6z§;
            sourcePosition.z = this.origin.z + this.direction.z * this.§_-6z§;
            particleDirection.copy(this.direction);
            xAxis.copy(this.sideAxis);
            this.§_-0X§(sourcePosition,particleDirection,xAxis,offset);
         }
      }
      
      private function §_-0X§(sourcePosition:§_-bj§, direction:§_-bj§, sideAxis:§_-bj§, offset:Number) : void
      {
         var particle:Particle = Particle.getParticle();
         particle.currFrame = Math.random() * this.numFrames;
         var angle:Number = 2 * Math.PI * Math.random();
         matrix.§_-OB§(direction,angle);
         sideAxis.transform3(matrix);
         var d:Number = this.range * this.§_-er§ * Math.random();
         direction.x = direction.x * this.range + sideAxis.x * d;
         direction.y = direction.y * this.range + sideAxis.y * d;
         direction.z = direction.z * this.range + sideAxis.z * d;
         direction.normalize();
         var bodyVelocity:§_-bj§ = this.chassis.getBody().state.velocity;
         particle.velocity.x = this.particleSpeed * direction.x + bodyVelocity.x;
         particle.velocity.y = this.particleSpeed * direction.y + bodyVelocity.y;
         particle.velocity.z = this.particleSpeed * direction.z + bodyVelocity.z;
         particle.distance = offset;
         particle.x = sourcePosition.x + offset * direction.x;
         particle.y = sourcePosition.y + offset * direction.y;
         particle.z = sourcePosition.z + offset * direction.z;
         var _loc9_:* = this.§_-Jx§++;
         this.§_-lV§[_loc9_] = particle;
      }
      
      private function §_-90§(index:int) : void
      {
         var particle:Particle = this.§_-lV§[index];
         this.§_-lV§[index] = this.§_-lV§[--this.§_-Jx§];
         this.§_-lV§[this.§_-Jx§] = null;
         particle.dispose();
      }
   }
}

import §_-8D§.§_-OX§;
import §_-Ex§.§_-hW§;
import §_-nl§.§_-bj§;
import flash.geom.ColorTransform;
import §function§.§_-ok§;

class Particle extends §_-hW§
{
   private static var INITIAL_POOL_SIZE:int = 20;
   
   private static var pool:Vector.<Particle> = new Vector.<Particle>(INITIAL_POOL_SIZE);
   
   private static var poolIndex:int = -1;
   
   public var velocity:§_-bj§ = new §_-bj§();
   
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
   
   public function updateColorTransofrm(maxDistance:Number, points:Vector.<§_-ok§>) : void
   {
      var point1:§_-ok§ = null;
      var point2:§_-ok§ = null;
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
