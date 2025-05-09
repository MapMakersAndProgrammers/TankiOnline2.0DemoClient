package package_46
{
   import flash.geom.Vector3D;
   import package_18.class_17;
   import package_18.name_375;
   import package_18.name_51;
   import package_2.name_1;
   import package_25.name_353;
   import package_25.name_355;
   import package_38.Matrix3;
   import package_38.name_145;
   import package_41.class_12;
   import package_41.name_146;
   import package_48.name_162;
   import package_51.name_169;
   import package_54.name_170;
   import package_58.name_189;
   
   public class class_26 extends name_353 implements class_17
   {
      private static const ANIMATION_FPS:Number = 30;
      
      private static const START_SCALE:Number = 0.5;
      
      private static const END_SCALE:Number = 4;
      
      private static const BARREL_INDEX:Number = 0;
      
      private static var particleBaseSize:name_1 = new name_1("flame_base_size",100,1,1000);
      
      private static var matrix:Matrix3 = new Matrix3();
      
      private static var particlePosition:name_145 = new name_145();
      
      private static var barrelOrigin:name_145 = new name_145();
      
      private static var particleDirection:name_145 = new name_145();
      
      private static var xAxis:name_145 = new name_145();
      
      private static var sourcePosition:name_145 = new name_145();
      
      private static var rayHit:name_189 = new name_189();
      
      private var range:Number;
      
      private var var_641:Number;
      
      private var var_639:Number;
      
      private var maxParticles:int;
      
      private var particleSpeed:Number;
      
      private var sfxData:name_175;
      
      private var var_637:Vector.<Particle> = new Vector.<Particle>();
      
      private var var_638:int;
      
      private var numFrames:int;
      
      private var collisionDetector:name_169;
      
      private var dead:Boolean;
      
      private var var_640:int;
      
      private var var_642:int;
      
      private var collisionGroup:int = name_170.WEAPON | name_170.STATIC;
      
      private var origin:name_145 = new name_145();
      
      private var direction:name_145 = new name_145();
      
      private var sideAxis:name_145 = new name_145();
      
      private var var_636:Number;
      
      private var renderSystem:name_51;
      
      private var turret:class_12;
      
      private var chassis:name_146;
      
      private var flame:name_554;
      
      private var position:Vector3D = new Vector3D();
      
      private var dir:Vector3D = new Vector3D();
      
      public function class_26(objectPool:name_355)
      {
         super(objectPool);
      }
      
      public function addedToRenderSystem(system:name_51) : void
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
         this.renderSystem.name_281(this.flame);
      }
      
      public function init(turret:class_12, flamethrowerSmokeAtlas:name_162, flamethrowerFlashAtlas:name_162, flamethrowerFireAtlas:name_162) : void
      {
         this.turret = turret;
         this.flame = new name_554(flamethrowerSmokeAtlas,flamethrowerFireAtlas,flamethrowerFlashAtlas,15);
         this.flame.scale = 5 * 1.4;
         this.flame.name = "firebird";
      }
      
      public function play(camera:name_375) : Boolean
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
      
      public function method_301() : void
      {
         this.flame.stop();
         this.flame = null;
      }
      
      private function method_299() : void
      {
         var offset:Number = Math.random() * 50;
         if(!this.collisionDetector.name_246(this.origin,this.direction,name_170.STATIC,this.var_636 + offset,null,rayHit))
         {
            sourcePosition.x = this.origin.x + this.direction.x * this.var_636;
            sourcePosition.y = this.origin.y + this.direction.y * this.var_636;
            sourcePosition.z = this.origin.z + this.direction.z * this.var_636;
            particleDirection.copy(this.direction);
            xAxis.copy(this.sideAxis);
            this.method_298(sourcePosition,particleDirection,xAxis,offset);
         }
      }
      
      private function method_298(sourcePosition:name_145, direction:name_145, sideAxis:name_145, offset:Number) : void
      {
         var particle:Particle = Particle.getParticle();
         particle.currFrame = Math.random() * this.numFrames;
         var angle:Number = 2 * Math.PI * Math.random();
         matrix.name_374(direction,angle);
         sideAxis.transform3(matrix);
         var d:Number = this.range * this.var_639 * Math.random();
         direction.x = direction.x * this.range + sideAxis.x * d;
         direction.y = direction.y * this.range + sideAxis.y * d;
         direction.z = direction.z * this.range + sideAxis.z * d;
         direction.normalize();
         var bodyVelocity:name_145 = this.chassis.getBody().state.velocity;
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
      
      private function method_300(index:int) : void
      {
         var particle:Particle = this.var_637[index];
         this.var_637[index] = this.var_637[--this.var_638];
         this.var_637[this.var_638] = null;
         particle.dispose();
      }
   }
}

import flash.geom.ColorTransform;
import package_19.name_372;
import package_33.name_130;
import package_37.name_153;
import package_38.name_145;

class Particle extends name_372
{
   private static var INITIAL_POOL_SIZE:int = 20;
   
   private static var pool:Vector.<Particle> = new Vector.<Particle>(INITIAL_POOL_SIZE);
   
   private static var poolIndex:int = -1;
   
   public var velocity:name_145 = new name_145();
   
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
   
   public function updateColorTransofrm(maxDistance:Number, points:Vector.<name_153>) : void
   {
      var point1:name_153 = null;
      var point2:name_153 = null;
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
