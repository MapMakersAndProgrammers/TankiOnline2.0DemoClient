package alternativa.tanks.game.weapons.thunder.effects
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.materials.FillMaterial;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.engine3d.objects.Sprite3D;
   import alternativa.engine3d.resources.TextureResource;
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.tanks.game.entities.tank.physics.ITurretPhysicsComponent;
   import alternativa.tanks.game.subsystems.rendersystem.BlendedMaterial;
   import alternativa.tanks.game.subsystems.rendersystem.GameCamera;
   import alternativa.tanks.game.subsystems.rendersystem.IGraphicEffect;
   import alternativa.tanks.game.subsystems.rendersystem.RenderSystem;
   import alternativa.tanks.game.subsystems.timesystem.TimeSystem;
   import alternativa.tanks.game.utils.objectpool.ObjectPool;
   import alternativa.tanks.game.utils.objectpool.PooledObject;
   import flash.display3D.Context3DBlendFactor;
   
   use namespace alternativa3d;
   
   public class ThunderShotEffect extends PooledObject implements IGraphicEffect
   {
      private static const BARREL_INDEX:int = 0;
      
      private static const EFFECT_DURATION:int = 50;
      
      private static const speed1:Number = 500;
      
      private static const speed2:Number = 1000;
      
      private static const speed3:Number = 1500;
      
      private static const trailSpeed1:Number = 1500;
      
      private static const trailSpeed2:Number = 2500;
      
      private static const trailSpeed3:Number = 1300;
      
      private static var muzzlePosition:Vector3 = new Vector3();
      
      private static var gunDirection:Vector3 = new Vector3();
      
      private static var axis:Vector3 = new Vector3();
      
      private static var eulerAngles:Vector3 = new Vector3();
      
      private static var trailMatrix:Matrix3 = new Matrix3();
      
      private static var trailMatrix2:Matrix3 = new Matrix3();
      
      private var turret:ITurretPhysicsComponent;
      
      private var sprite1:Sprite3D;
      
      private var sprite2:Sprite3D;
      
      private var sprite3:Sprite3D;
      
      private var name_kg:BlendedMaterial;
      
      private var name_ld:FillMaterial = new FillMaterial(16563726,0.1);
      
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
      
      public function ThunderShotEffect(objectPool:ObjectPool)
      {
         super(objectPool);
         this.name_kg = new BlendedMaterial();
         this.name_kg.transparentPass = true;
         this.name_kg.blendModeSource = Context3DBlendFactor.ONE;
         this.name_kg.blendModeDestination = Context3DBlendFactor.ONE;
         this.createParticles();
      }
      
      public function init(turret:ITurretPhysicsComponent, diffuse:TextureResource, opacity:TextureResource) : void
      {
         this.turret = turret;
      }
      
      public function addedToRenderSystem(system:RenderSystem) : void
      {
         var container:Object3D = system.getRootContainer();
         container.addChild(this.sprite1);
         container.addChild(this.sprite2);
         container.addChild(this.sprite3);
      }
      
      public function play(camera:GameCamera) : Boolean
      {
         if(this.timeToLive <= 0)
         {
            return false;
         }
         this.turret.getGunMuzzleData(BARREL_INDEX,muzzlePosition,gunDirection);
         var dt:Number = TimeSystem.timeDeltaSeconds;
         this.timeToLive -= TimeSystem.timeDelta;
         return true;
      }
      
      public function destroy() : void
      {
         this.sprite1.alternativa3d::removeFromParent();
         this.sprite2.alternativa3d::removeFromParent();
         this.sprite3.alternativa3d::removeFromParent();
         storeInPool();
      }
      
      private function createParticles() : void
      {
         this.sprite1 = this.createSprite(120);
         this.sprite2 = this.createSprite(99.75);
         this.sprite3 = this.createSprite(79.5);
      }
      
      private function createSprite(size:Number) : Sprite3D
      {
         var sprite:Sprite3D = new Sprite3D(size,size);
         sprite.rotation = 2 * Math.PI * Math.random();
         sprite.material = this.name_kg;
         return sprite;
      }
      
      private function setSpritePosition(sprite:Sprite3D, basePoint:Vector3, direction:Vector3, distance:Number) : void
      {
         sprite.x = basePoint.x + direction.x * distance;
         sprite.y = basePoint.y + direction.y * distance;
         sprite.z = basePoint.z + direction.z * distance;
      }
      
      private function setTrailMatrix(trail:Mesh, angle:Number, basePoint:Vector3, direction:Vector3, distance:Number, dx:Number, dz:Number) : void
      {
         trailMatrix.fromAxisAngle(Vector3.Y_AXIS,angle);
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
         trailMatrix2.fromAxisAngle(axis,angle);
         trailMatrix.append(trailMatrix2);
         trailMatrix.getEulerAngles(eulerAngles);
         trail.rotationX = eulerAngles.x;
         trail.rotationY = eulerAngles.y;
         trail.rotationZ = eulerAngles.z;
         trail.x = basePoint.x + direction.x * distance + dx * trailMatrix.a + dz * trailMatrix.c;
         trail.y = basePoint.y + direction.y * distance + dx * trailMatrix.e + dz * trailMatrix.g;
         trail.z = basePoint.z + direction.z * distance + dx * trailMatrix.i + dz * trailMatrix.k;
      }
   }
}

import alternativa.engine3d.core.Object3D;
import alternativa.engine3d.core.VertexAttributes;
import alternativa.engine3d.materials.Material;
import alternativa.engine3d.objects.Mesh;
import alternativa.engine3d.resources.Geometry;

class Trail extends Mesh
{
   private static var verts:Vector.<Number> = Vector.<Number>([0,0,0,0,0,0,0,0,0]);
   
   public function Trail(scale:Number, material:Material)
   {
      super();
      var h:Number = 240 * scale;
      verts[0] = -4;
      verts[3] = 4;
      verts[7] = h;
      geometry = new Geometry();
      var attributes:Array = [];
      attributes[0] = VertexAttributes.POSITION;
      attributes[1] = VertexAttributes.POSITION;
      attributes[2] = VertexAttributes.POSITION;
      geometry.addVertexStream(attributes);
      geometry.numVertices = 3;
      var values:Vector.<Number> = new Vector.<Number>(9);
      for(var i:int = 0; i < 9; i++)
      {
         values[i] = verts[i];
      }
      geometry.setAttributeValues(VertexAttributes.POSITION,values);
      geometry.indices = Vector.<uint>([0,1,2]);
      addSurface(material,0,1);
      calculateBoundBox();
   }
}
