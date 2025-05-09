package §_-LL§
{
   import §_-1z§.§_-pi§;
   import §_-7A§.§_-3e§;
   import §_-8D§.§_-OX§;
   import §_-Ex§.§_-U2§;
   import §_-Ex§.§_-hW§;
   import §_-RQ§.§_-HE§;
   import §_-RQ§.§_-Va§;
   import §_-Vh§.§_-YD§;
   import §_-e6§.§_-1I§;
   import §_-e6§.§_-9l§;
   import §_-e6§.§_-RE§;
   import §_-e6§.§_-fX§;
   import §_-lS§.§_-h2§;
   import §_-nl§.Matrix3;
   import §_-nl§.§_-bj§;
   import alternativa.engine3d.alternativa3d;
   import flash.display3D.Context3DBlendFactor;
   
   use namespace alternativa3d;
   
   public class §_-nR§ extends §_-HE§ implements §_-fX§
   {
      private static const BARREL_INDEX:int = 0;
      
      private static const EFFECT_DURATION:int = 50;
      
      private static const speed1:Number = 500;
      
      private static const speed2:Number = 1000;
      
      private static const speed3:Number = 1500;
      
      private static const trailSpeed1:Number = 1500;
      
      private static const trailSpeed2:Number = 2500;
      
      private static const trailSpeed3:Number = 1300;
      
      private static var muzzlePosition:§_-bj§ = new §_-bj§();
      
      private static var gunDirection:§_-bj§ = new §_-bj§();
      
      private static var axis:§_-bj§ = new §_-bj§();
      
      private static var eulerAngles:§_-bj§ = new §_-bj§();
      
      private static var trailMatrix:Matrix3 = new Matrix3();
      
      private static var trailMatrix2:Matrix3 = new Matrix3();
      
      private var turret:§_-3e§;
      
      private var sprite1:§_-hW§;
      
      private var sprite2:§_-hW§;
      
      private var sprite3:§_-hW§;
      
      private var §_-kg§:§_-9l§;
      
      private var §_-ld§:§_-YD§ = new §_-YD§(16563726,0.1);
      
      private var trail1:Trail;
      
      private var trail2:Trail;
      
      private var trail3:Trail;
      
      private var distance1:Number = 40;
      
      private var distance2:Number = 75;
      
      private var distance3:Number = 80;
      
      private var trailDistance1:Number = 0;
      
      private var trailDistance2:Number = 0;
      
      private var trailDistance3:Number = 0;
      
      private var angle1:Number;
      
      private var angle2:Number;
      
      private var angle3:Number;
      
      private var timeToLive:int;
      
      public function §_-nR§(objectPool:§_-Va§)
      {
         super(objectPool);
         this.§_-kg§ = new §_-9l§();
         this.§_-kg§.§_-L4§ = true;
         this.§_-kg§.blendModeSource = Context3DBlendFactor.ONE;
         this.§_-kg§.blendModeDestination = Context3DBlendFactor.ONE;
         this.§_-5M§();
      }
      
      public function init(turret:§_-3e§, diffuse:§_-pi§, opacity:§_-pi§) : void
      {
         this.turret = turret;
      }
      
      public function addedToRenderSystem(system:§_-1I§) : void
      {
         var container:§_-OX§ = system.§_-Hn§();
         container.addChild(this.sprite1);
         container.addChild(this.sprite2);
         container.addChild(this.sprite3);
      }
      
      public function play(camera:§_-RE§) : Boolean
      {
         if(this.timeToLive <= 0)
         {
            return false;
         }
         this.turret.getGunMuzzleData(BARREL_INDEX,muzzlePosition,gunDirection);
         var dt:Number = Number(§_-h2§.timeDeltaSeconds);
         this.timeToLive -= §_-h2§.timeDelta;
         return true;
      }
      
      public function destroy() : void
      {
         this.sprite1.alternativa3d::removeFromParent();
         this.sprite2.alternativa3d::removeFromParent();
         this.sprite3.alternativa3d::removeFromParent();
         §_-DQ§();
      }
      
      private function §_-5M§() : void
      {
         this.sprite1 = this.§_-eJ§(120);
         this.sprite2 = this.§_-eJ§(99.75);
         this.sprite3 = this.§_-eJ§(79.5);
      }
      
      private function §_-eJ§(size:Number) : §_-hW§
      {
         var sprite:§_-hW§ = new §_-hW§(size,size);
         sprite.rotation = 2 * Math.PI * Math.random();
         sprite.material = this.§_-kg§;
         return sprite;
      }
      
      private function §_-ME§(sprite:§_-hW§, basePoint:§_-bj§, direction:§_-bj§, distance:Number) : void
      {
         sprite.x = basePoint.x + direction.x * distance;
         sprite.y = basePoint.y + direction.y * distance;
         sprite.z = basePoint.z + direction.z * distance;
      }
      
      private function §_-Qt§(trail:§_-U2§, angle:Number, basePoint:§_-bj§, direction:§_-bj§, distance:Number, dx:Number, dz:Number) : void
      {
         trailMatrix.§_-OB§(§_-bj§.Y_AXIS,angle);
         if(direction.y < -0.99999 || direction.y > 0.99999)
         {
            axis.x = 0;
            axis.y = 0;
            axis.z = 1;
            angle = direction.y < 0 ? Number(Math.PI) : 0;
         }
         else
         {
            axis.x = direction.z;
            axis.y = 0;
            axis.z = -direction.x;
            axis.normalize();
            angle = Number(Math.acos(direction.y));
         }
         trailMatrix2.§_-OB§(axis,angle);
         trailMatrix.append(trailMatrix2);
         trailMatrix.§_-fJ§(eulerAngles);
         trail.rotationX = eulerAngles.x;
         trail.rotationY = eulerAngles.y;
         trail.rotationZ = eulerAngles.z;
         trail.x = basePoint.x + direction.x * distance + dx * trailMatrix.a + dz * trailMatrix.c;
         trail.y = basePoint.y + direction.y * distance + dx * trailMatrix.e + dz * trailMatrix.g;
         trail.z = basePoint.z + direction.z * distance + dx * trailMatrix.i + dz * trailMatrix.k;
      }
   }
}

import §_-1z§.§_-gA§;
import §_-8D§.§_-OX§;
import §_-8D§.§_-d6§;
import §_-Ex§.§_-U2§;
import §_-Vh§.§_-b9§;

class Trail extends §_-U2§
{
   private static var verts:Vector.<Number> = Vector.<Number>([0,0,0,0,0,0,0,0,0]);
   
   public function Trail(scale:Number, material:§_-b9§)
   {
      super();
      var h:Number = 240 * scale;
      verts[0] = -4;
      verts[3] = 4;
      verts[7] = h;
      geometry = new §_-gA§();
      var attributes:Array = [];
      attributes[0] = §_-d6§.POSITION;
      attributes[1] = §_-d6§.POSITION;
      attributes[2] = §_-d6§.POSITION;
      geometry.addVertexStream(attributes);
      geometry.numVertices = 3;
      var values:Vector.<Number> = new Vector.<Number>(9);
      for(var i:int = 0; i < 9; i++)
      {
         values[i] = verts[i];
      }
      geometry.setAttributeValues(§_-d6§.POSITION,values);
      geometry.indices = Vector.<uint>([0,1,2]);
      addSurface(material,0,1);
      calculateBoundBox();
   }
}
