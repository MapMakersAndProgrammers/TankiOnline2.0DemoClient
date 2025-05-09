package alternativa.tanks.game.weapons.flamethrower
{
   import alternativa.engine3d.core.BoundBox;
   import alternativa.engine3d.effects.ParticlePrototype;
   import alternativa.engine3d.effects.TextureAtlas;
   import alternativa.engine3d.effects.§_-SG§;
   import flash.display3D.Context3DBlendFactor;
   import flash.geom.Vector3D;
   
   public class FlameThrower extends §_-SG§
   {
      private static var smokePrototype1:ParticlePrototype;
      
      private static var smokePrototype2:ParticlePrototype;
      
      private static var flashPrototype1:ParticlePrototype;
      
      private static var flashPrototype2:ParticlePrototype;
      
      private static var flashPrototype3:ParticlePrototype;
      
      private static var firePrototype:ParticlePrototype;
      
      private static var pos:Vector3D = new Vector3D();
      
      private static var dir:Vector3D = new Vector3D();
      
      private static var liftSpeed:Number = 25;
      
      private static var windSpeed:Number = 10;
      
      public function FlameThrower(smoke:TextureAtlas, fire:TextureAtlas, flash:TextureAtlas, live:Number = 1)
      {
         var keyTime:Number = NaN;
         super();
         if(flashPrototype1 == null)
         {
            flashPrototype1 = new ParticlePrototype(50,50,flash,true,Context3DBlendFactor.SOURCE_ALPHA,Context3DBlendFactor.ONE);
            flashPrototype1.addKey(0 * 0.03333333333333333,0,0.13,0.13,1,1,1,0.8);
            flashPrototype1.addKey(2 * 0.03333333333333333,0,0.4,0.4,1,1,1,1);
            flashPrototype1.addKey(6 * 0.03333333333333333,0,1.1,1.1,1,1,1,0.8);
            flashPrototype1.addKey(11 * 0.03333333333333333,0,1.26,1.26,1,1,1,0.8);
            flashPrototype1.addKey(17 * 0.03333333333333333,0,1.47,1.47,1,1,0.3,0);
            flashPrototype2 = new ParticlePrototype(50,50,flash,true,Context3DBlendFactor.SOURCE_ALPHA,Context3DBlendFactor.ONE);
            flashPrototype2.addKey(1 * 0.03333333333333333,0,0.13,0.13,1,1,1,0.8);
            flashPrototype2.addKey(3 * 0.03333333333333333,0,0.3,0.3,1,1,1,1);
            flashPrototype2.addKey(8 * 0.03333333333333333,0,0.8,0.8,1,1,1,0.5);
            flashPrototype2.addKey(12 * 0.03333333333333333,0,1.26,1.26,1,1,1,0);
            flashPrototype3 = new ParticlePrototype(50,50,flash,true,Context3DBlendFactor.SOURCE_ALPHA,Context3DBlendFactor.ONE);
            flashPrototype3.addKey(2 * 0.03333333333333333,0,0.13,0.13,1,1,1,0.8);
            flashPrototype3.addKey(4 * 0.03333333333333333,0,0.3,0.3,1,1,1,1);
            flashPrototype3.addKey(8 * 0.03333333333333333,0,0.6,0.6,1,1,1,0);
         }
         if(firePrototype == null)
         {
            firePrototype = new ParticlePrototype(50,50,fire,true);
            firePrototype.addKey(6 * 0.03333333333333333,0,1.53,1.53,1,1,1,0);
            firePrototype.addKey(11 * 0.03333333333333333,0,1.53,1.53,1,1,1,0.6);
            firePrototype.addKey(17 * 0.03333333333333333,0,1.85,1.85,1,0.7,0,0.8);
            firePrototype.addKey(24 * 0.03333333333333333,0,1.98,1.98,1,0.3,0,0.2);
         }
         if(smokePrototype1 == null)
         {
            smokePrototype1 = new ParticlePrototype(50,50,smoke,true);
            smokePrototype1.addKey(6 * 0.03333333333333333,0,1.51,1.51,1,1,1,0);
            smokePrototype1.addKey(11 * 0.03333333333333333,0,1.92,1.92,1,1,1,0.9);
            smokePrototype1.addKey(17 * 0.03333333333333333,0,2.49,2.49,0.5,0.5,0.5,1);
            smokePrototype1.addKey(24 * 0.03333333333333333,0,2.66,2.66,0,0,0,0);
            smokePrototype2 = new ParticlePrototype(50,50,smoke,false);
            smokePrototype2.addKey(15 * 0.03333333333333333,0,1.51,1.51,1,1,1,0);
            smokePrototype2.addKey(20 * 0.03333333333333333,0,1.92,1.92,0.8,0.8,0.8,0.3);
            smokePrototype2.addKey(26 * 0.03333333333333333,0,2.49,2.49,0.5,0.5,0.5,0.6);
            smokePrototype2.addKey(55 * 0.03333333333333333,0,2.66,2.66,0,0,0,0);
         }
         boundBox = new BoundBox();
         boundBox.minX = -350;
         boundBox.minY = -350;
         boundBox.minZ = -350;
         boundBox.maxX = 350;
         boundBox.maxY = 350;
         boundBox.maxZ = 350;
         var i:int = 0;
         while(true)
         {
            keyTime = i * 2 * 0.03333333333333333;
            if(keyTime >= live)
            {
               break;
            }
            addKey(keyTime,this.keyFrame1);
            i++;
         }
         §_-DM§(§_-gV§[§_-kf§ - 1] + smokePrototype2.lifeTime);
      }
      
      private function keyFrame1(keyTime:Number, time:Number) : void
      {
         var ang:Number = 6 * 3.14 / 180;
         dir.x = §_-cF§.x;
         dir.y = §_-cF§.y;
         dir.z = §_-cF§.z + 0.2;
         dir.normalize();
         this.randomDirection(§_-cF§,ang,pos);
         pos.scaleBy(time * 300 + 10);
         flashPrototype1.createParticle(this,time,pos,random() * 6.28,1,1,1,random() * flashPrototype1.atlas.rangeLength);
         this.randomDirection(§_-cF§,ang,pos);
         pos.scaleBy((time - 0.03333333333333333) * 150 + 10);
         flashPrototype2.createParticle(this,time,pos,random() * 6.28,1,1,1,random() * flashPrototype1.atlas.rangeLength);
         this.randomDirection(§_-cF§,ang,pos);
         pos.scaleBy((time - 0.03333333333333333 - 0.03333333333333333) * 80 + 10);
         flashPrototype3.createParticle(this,time,pos,random() * 6.28,1,1,1,random() * flashPrototype1.atlas.rangeLength);
         this.randomDirection(§_-cF§,ang,pos);
         pos.scaleBy(time * 240 + 10);
         firePrototype.createParticle(this,time,pos,random() * 6.28,1,1,1,-6 * 0.03333333333333333 * firePrototype.atlas.fps);
         this.randomDirection(dir,ang,pos);
         pos.scaleBy(time * 300 + 10);
         firePrototype.createParticle(this,time,pos,random() * 6.28,1,1,1,-6 * 0.03333333333333333 * firePrototype.atlas.fps);
         this.randomDirection(§_-cF§,ang,pos);
         pos.scaleBy(time * 300 + 10);
         smokePrototype1.createParticle(this,time,pos,random() * 6.28,1,1,1,random() * smokePrototype1.atlas.rangeLength);
         this.randomDirection(dir,ang,pos);
         pos.scaleBy(time * 330 + 10);
         smokePrototype1.createParticle(this,time,pos,random() * 6.28,1,1,1,random() * smokePrototype1.atlas.rangeLength);
         this.randomDirection(dir,ang,pos);
         pos.scaleBy(time * 40 + 100 + random() * 120);
         pos.x += random() * 50 - 25;
         pos.y += random() * 50 - 25;
         pos.z += random() * 50 - 25;
         this.displacePosition(time - 15 * 0.03333333333333333,1,pos);
         smokePrototype2.createParticle(this,time,pos,random() * 6.28,1,1,1,random() * smokePrototype1.atlas.rangeLength);
      }
      
      private function randomDirection(direction:Vector3D, angle:Number, result:Vector3D) : void
      {
         var x:Number = random() * 2 - 1;
         var y:Number = random() * 2 - 1;
         var z:Number = random() * 2 - 1;
         result.x = direction.z * y - direction.y * z;
         result.y = direction.x * z - direction.z * x;
         result.z = direction.y * x - direction.x * y;
         result.normalize();
         result.scaleBy(Math.sin(angle / 2));
         result.x += direction.x;
         result.y += direction.y;
         result.z += direction.z;
         result.normalize();
      }
      
      private function displacePosition(time:Number, factor:Number, result:Vector3D) : void
      {
         result.x += time * windSpeed * §_-Ta§.wind.x;
         result.y += time * windSpeed * §_-Ta§.wind.y;
         result.z += time * windSpeed * §_-Ta§.wind.z + time * liftSpeed * factor;
      }
   }
}

