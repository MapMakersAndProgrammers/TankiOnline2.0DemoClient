package alternativa.tanks.game.weapons.ammunition.splashhit.debug
{
   import alternativa.engine3d.core.BoundBox;
   import alternativa.engine3d.effects.ParticleEffect;
   import alternativa.engine3d.effects.ParticlePrototype;
   import alternativa.engine3d.effects.TextureAtlas;
   import flash.display3D.Context3DBlendFactor;
   import flash.geom.Vector3D;
   
   public class SmokyShot extends ParticleEffect
   {
      private static var shotPrototype:ParticlePrototype;
      
      private static var pos:Vector3D = new Vector3D();
      
      public function SmokyShot(shot:TextureAtlas)
      {
         super();
         if(shotPrototype == null)
         {
            shotPrototype = new ParticlePrototype(50,50,shot,false,Context3DBlendFactor.SOURCE_ALPHA,Context3DBlendFactor.ONE);
            shotPrototype.addKey(0 * 0.03333333333333333,0,0.85,0.85,1,1,1,0.6);
            shotPrototype.addKey(1 * 0.03333333333333333,0,1,1,1,1,1,1);
            shotPrototype.addKey(2 * 0.03333333333333333,0,1,1,1,1,1,0.5);
            shotPrototype.addKey(3 * 0.03333333333333333,0,1,1,1,1,1,0.5);
         }
         boundBox = new BoundBox();
         boundBox.minX = -100;
         boundBox.minY = -100;
         boundBox.minZ = -100;
         boundBox.maxX = 100;
         boundBox.maxY = 100;
         boundBox.maxZ = 100;
         addKey(0 * 0.03333333333333333,this.keyFrame1);
         setLife(name_gV[name_kf - 1] + shotPrototype.lifeTime);
      }
      
      private function keyFrame1(keyTime:Number, time:Number) : void
      {
         pos.copyFrom(name_cF);
         pos.scaleBy(time * 100 + 25);
         shotPrototype.createParticle(this,time,pos,random() * 6.28,1,1,1,0);
         pos.copyFrom(name_cF);
         pos.scaleBy(time * 300 + 32);
         shotPrototype.createParticle(this,time,pos,random() * 6.28,0.88,0.88,1,0);
         pos.copyFrom(name_cF);
         pos.scaleBy(time * 400 + 39);
         shotPrototype.createParticle(this,time,pos,random() * 6.28,0.66,0.66,1,0);
      }
   }
}

