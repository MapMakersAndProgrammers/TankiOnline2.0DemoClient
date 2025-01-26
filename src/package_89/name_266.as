package package_89
{
   import alternativa.engine3d.alternativa3d;
   import flash.display3D.Context3DBlendFactor;
   import package_18.name_44;
   import package_18.name_495;
   import package_18.name_85;
   import package_18.name_90;
   import package_19.name_380;
   import package_19.name_494;
   import package_21.name_78;
   import package_26.class_18;
   import package_26.name_402;
   import package_28.name_129;
   import package_4.name_313;
   import package_45.name_182;
   import package_46.Matrix3;
   import package_46.name_194;
   import package_75.class_15;
   
   use namespace alternativa3d;
   
   public class name_266 extends class_18 implements name_85
   {
      private static const BARREL_INDEX:int = 0;
      
      private static const EFFECT_DURATION:int = 50;
      
      private static const speed1:Number = 500;
      
      private static const speed2:Number = 1000;
      
      private static const speed3:Number = 1500;
      
      private static const trailSpeed1:Number = 1500;
      
      private static const trailSpeed2:Number = 2500;
      
      private static const trailSpeed3:Number = 1300;
      
      private static var muzzlePosition:name_194 = new name_194();
      
      private static var gunDirection:name_194 = new name_194();
      
      private static var axis:name_194 = new name_194();
      
      private static var eulerAngles:name_194 = new name_194();
      
      private static var trailMatrix:Matrix3 = new Matrix3();
      
      private static var trailMatrix2:Matrix3 = new Matrix3();
      
      private var turret:class_15;
      
      private var sprite1:name_494;
      
      private var sprite2:name_494;
      
      private var sprite3:name_494;
      
      private var var_427:name_495;
      
      private var var_428:name_313 = new name_313(16563726,0.1);
      
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
      
      public function name_266(objectPool:name_402)
      {
         super(objectPool);
         this.var_427 = new name_495();
         this.var_427.var_21 = true;
         this.var_427.blendModeSource = Context3DBlendFactor.ONE;
         this.var_427.blendModeDestination = Context3DBlendFactor.ONE;
         this.method_378();
      }
      
      public function init(turret:class_15, diffuse:name_129, opacity:name_129) : void
      {
         this.turret = turret;
      }
      
      public function addedToRenderSystem(system:name_44) : void
      {
         var container:name_78 = system.method_62();
         container.addChild(this.sprite1);
         container.addChild(this.sprite2);
         container.addChild(this.sprite3);
      }
      
      public function play(camera:name_90) : Boolean
      {
         if(this.timeToLive <= 0)
         {
            return false;
         }
         this.turret.getGunMuzzleData(BARREL_INDEX,muzzlePosition,gunDirection);
         var dt:Number = name_182.timeDeltaSeconds;
         this.timeToLive -= name_182.timeDelta;
         return true;
      }
      
      public function destroy() : void
      {
         this.sprite1.alternativa3d::removeFromParent();
         this.sprite2.alternativa3d::removeFromParent();
         this.sprite3.alternativa3d::removeFromParent();
         method_254();
      }
      
      private function method_378() : void
      {
         this.sprite1 = this.method_377(120);
         this.sprite2 = this.method_377(99.75);
         this.sprite3 = this.method_377(79.5);
      }
      
      private function method_377(size:Number) : name_494
      {
         var sprite:name_494 = new name_494(size,size);
         sprite.rotation = 2 * Math.PI * Math.random();
         sprite.material = this.var_427;
         return sprite;
      }
      
      private function method_380(sprite:name_494, basePoint:name_194, direction:name_194, distance:Number) : void
      {
         sprite.x = basePoint.x + direction.x * distance;
         sprite.y = basePoint.y + direction.y * distance;
         sprite.z = basePoint.z + direction.z * distance;
      }
      
      private function method_379(trail:name_380, angle:Number, basePoint:name_194, direction:name_194, distance:Number, dx:Number, dz:Number) : void
      {
         trailMatrix.method_344(name_194.Y_AXIS,angle);
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
         trailMatrix2.method_344(axis,angle);
         trailMatrix.append(trailMatrix2);
         trailMatrix.name_341(eulerAngles);
         trail.rotationX = eulerAngles.x;
         trail.rotationY = eulerAngles.y;
         trail.rotationZ = eulerAngles.z;
         trail.x = basePoint.x + direction.x * distance + dx * trailMatrix.a + dz * trailMatrix.c;
         trail.y = basePoint.y + direction.y * distance + dx * trailMatrix.e + dz * trailMatrix.g;
         trail.z = basePoint.z + direction.z * distance + dx * trailMatrix.i + dz * trailMatrix.k;
      }
   }
}

import package_19.name_380;
import package_21.name_126;
import package_21.name_78;
import package_28.name_119;
import package_4.class_4;

class Trail extends name_380
{
   private static var verts:Vector.<Number> = Vector.<Number>([0,0,0,0,0,0,0,0,0]);
   
   public function Trail(scale:Number, material:class_4)
   {
      super();
      var h:Number = 240 * scale;
      verts[0] = -4;
      verts[3] = 4;
      verts[7] = h;
      geometry = new name_119();
      var attributes:Array = [];
      attributes[0] = name_126.POSITION;
      attributes[1] = name_126.POSITION;
      attributes[2] = name_126.POSITION;
      geometry.addVertexStream(attributes);
      geometry.numVertices = 3;
      var values:Vector.<Number> = new Vector.<Number>(9);
      for(var i:int = 0; i < 9; i++)
      {
         values[i] = verts[i];
      }
      geometry.setAttributeValues(name_126.POSITION,values);
      geometry.indices = Vector.<uint>([0,1,2]);
      addSurface(material,0,1);
      calculateBoundBox();
   }
}
