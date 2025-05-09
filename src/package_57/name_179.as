package package_57
{
   import alternativa.engine3d.alternativa3d;
   import flash.display3D.Context3DBlendFactor;
   import package_18.class_17;
   import package_18.name_373;
   import package_18.name_375;
   import package_18.name_51;
   import package_19.class_16;
   import package_19.name_372;
   import package_21.name_86;
   import package_25.name_353;
   import package_25.name_355;
   import package_3.name_234;
   import package_30.name_103;
   import package_33.name_130;
   import package_38.Matrix3;
   import package_38.name_145;
   import package_41.class_12;
   
   use namespace alternativa3d;
   
   public class name_179 extends name_353 implements class_17
   {
      private static const BARREL_INDEX:int = 0;
      
      private static const EFFECT_DURATION:int = 50;
      
      private static const speed1:Number = 500;
      
      private static const speed2:Number = 1000;
      
      private static const speed3:Number = 1500;
      
      private static const trailSpeed1:Number = 1500;
      
      private static const trailSpeed2:Number = 2500;
      
      private static const trailSpeed3:Number = 1300;
      
      private static var muzzlePosition:name_145 = new name_145();
      
      private static var gunDirection:name_145 = new name_145();
      
      private static var axis:name_145 = new name_145();
      
      private static var eulerAngles:name_145 = new name_145();
      
      private static var trailMatrix:Matrix3 = new Matrix3();
      
      private static var trailMatrix2:Matrix3 = new Matrix3();
      
      private var turret:class_12;
      
      private var sprite1:name_372;
      
      private var sprite2:name_372;
      
      private var sprite3:name_372;
      
      private var var_427:name_373;
      
      private var var_428:name_234 = new name_234(16563726,0.1);
      
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
      
      public function name_179(objectPool:name_355)
      {
         super(objectPool);
         this.var_427 = new name_373();
         this.var_427.var_21 = true;
         this.var_427.blendModeSource = Context3DBlendFactor.ONE;
         this.var_427.blendModeDestination = Context3DBlendFactor.ONE;
         this.method_157();
      }
      
      public function init(turret:class_12, diffuse:name_86, opacity:name_86) : void
      {
         this.turret = turret;
      }
      
      public function addedToRenderSystem(system:name_51) : void
      {
         var container:name_130 = system.name_237();
         container.addChild(this.sprite1);
         container.addChild(this.sprite2);
         container.addChild(this.sprite3);
      }
      
      public function play(camera:name_375) : Boolean
      {
         if(this.timeToLive <= 0)
         {
            return false;
         }
         this.turret.getGunMuzzleData(BARREL_INDEX,muzzlePosition,gunDirection);
         var dt:Number = Number(name_103.timeDeltaSeconds);
         this.timeToLive -= name_103.timeDelta;
         return true;
      }
      
      public function destroy() : void
      {
         this.sprite1.alternativa3d::removeFromParent();
         this.sprite2.alternativa3d::removeFromParent();
         this.sprite3.alternativa3d::removeFromParent();
         name_363();
      }
      
      private function method_157() : void
      {
         this.sprite1 = this.method_156(120);
         this.sprite2 = this.method_156(99.75);
         this.sprite3 = this.method_156(79.5);
      }
      
      private function method_156(size:Number) : name_372
      {
         var sprite:name_372 = new name_372(size,size);
         sprite.rotation = 2 * Math.PI * Math.random();
         sprite.material = this.var_427;
         return sprite;
      }
      
      private function method_159(sprite:name_372, basePoint:name_145, direction:name_145, distance:Number) : void
      {
         sprite.x = basePoint.x + direction.x * distance;
         sprite.y = basePoint.y + direction.y * distance;
         sprite.z = basePoint.z + direction.z * distance;
      }
      
      private function method_158(trail:class_16, angle:Number, basePoint:name_145, direction:name_145, distance:Number, dx:Number, dz:Number) : void
      {
         trailMatrix.name_374(name_145.Y_AXIS,angle);
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
         trailMatrix2.name_374(axis,angle);
         trailMatrix.append(trailMatrix2);
         trailMatrix.name_267(eulerAngles);
         trail.rotationX = eulerAngles.x;
         trail.rotationY = eulerAngles.y;
         trail.rotationZ = eulerAngles.z;
         trail.x = basePoint.x + direction.x * distance + dx * trailMatrix.a + dz * trailMatrix.c;
         trail.y = basePoint.y + direction.y * distance + dx * trailMatrix.e + dz * trailMatrix.g;
         trail.z = basePoint.z + direction.z * distance + dx * trailMatrix.i + dz * trailMatrix.k;
      }
   }
}

import package_19.class_16;
import package_21.name_136;
import package_3.name_139;
import package_33.name_117;
import package_33.name_130;

class Trail extends class_16
{
   private static var verts:Vector.<Number> = Vector.<Number>([0,0,0,0,0,0,0,0,0]);
   
   public function Trail(scale:Number, material:name_139)
   {
      super();
      var h:Number = 240 * scale;
      verts[0] = -4;
      verts[3] = 4;
      verts[7] = h;
      geometry = new name_136();
      var attributes:Array = [];
      attributes[0] = name_117.POSITION;
      attributes[1] = name_117.POSITION;
      attributes[2] = name_117.POSITION;
      geometry.addVertexStream(attributes);
      geometry.numVertices = 3;
      var values:Vector.<Number> = new Vector.<Number>(9);
      for(var i:int = 0; i < 9; i++)
      {
         values[i] = verts[i];
      }
      geometry.setAttributeValues(name_117.POSITION,values);
      geometry.indices = Vector.<uint>([0,1,2]);
      addSurface(material,0,1);
      calculateBoundBox();
   }
}
