package package_9
{
   import flash.geom.Vector3D;
   import alternativa.tanks.game.ObjectController;
   import alternativa.tanks.game.Entity;
   import package_15.name_191;
   import package_18.name_102;
   import package_18.name_90;
   import package_21.name_78;
   import alternativa.tanks.game.subsystems.inputsystem.IInput;
   import package_45.name_182;
   import package_46.Matrix3;
   import package_46.Matrix4;
   import package_46.name_194;
   import package_47.name_193;
   
   public class name_20 implements name_102
   {
      public static var smoothing:Number = 20;
      
      public static var targeted:Boolean = false;
      
      private static const KEY_FORWARD:int = name_191.W;
      
      private static const KEY_BACK:int = name_191.S;
      
      private static const KEY_LEFT:int = name_191.A;
      
      private static const KEY_RIGHT:int = name_191.D;
      
      private static const KEY_UP:int = name_191.E;
      
      private static const KEY_DOWN:int = name_191.C;
      
      private static const KEY_SPEED:int = name_191.SHIFT;
      
      private static var matrix:Matrix3 = new Matrix3();
      
      private static var vector:name_194 = new name_194();
      
      public var var_50:Number = 0.01;
      
      public var var_48:Number = 0.01;
      
      public var speed:Number = 500;
      
      public var var_49:Number = 3;
      
      private var var_47:Number = 0;
      
      private var var_46:Number = 0;
      
      private var currentPosition:Vector3D = new Vector3D();
      
      private var input:IInput;
      
      private var controller:ObjectController;
      
      private var target:name_78;
      
      private var parentMatrix:Matrix4 = new Matrix4();
      
      private var var_45:Matrix4 = new Matrix4();
      
      public function name_20(camera:name_90, input:IInput)
      {
         super();
         this.input = input;
         this.controller = new ObjectController();
         this.controller.object = camera;
         this.var_46 = camera.rotationX;
         this.var_47 = camera.rotationZ;
         this.currentPosition.x = camera.x;
         this.currentPosition.y = camera.y;
         this.currentPosition.z = camera.z;
      }
      
      public function name_108() : void
      {
         var object:name_78 = this.controller.object;
         this.var_46 = object.rotationX;
         this.var_47 = object.rotationZ;
         this.currentPosition.x = object.x;
         this.currentPosition.y = object.y;
         this.currentPosition.z = object.z;
      }
      
      public function name_75(x:Number, y:Number, z:Number) : void
      {
         this.controller.name_201(x,y,z);
         this.currentPosition.x = this.controller.object.x;
         this.currentPosition.y = this.controller.object.y;
         this.currentPosition.z = this.controller.object.z;
      }
      
      public function name_76(x:Number, y:Number, z:Number) : void
      {
         this.controller.name_76(x,y,z);
         this.var_46 = this.controller.object.rotationX;
         this.var_47 = this.controller.object.rotationZ;
      }
      
      public function method_115(value:Entity) : void
      {
         if(value == null)
         {
            this.target = null;
         }
         else
         {
            this.target = name_193(value.getComponentStrict(name_193)).name_198;
         }
      }
      
      public function update() : void
      {
         var dx:Number = NaN;
         var dy:Number = NaN;
         var dz:Number = NaN;
         var k:Number = NaN;
         var yaw:Number = NaN;
         var pitch:Number = NaN;
         var timeDelta:Number = name_182.timeDeltaSeconds;
         if(smoothing > 0)
         {
            k = 100 / smoothing * timeDelta;
            k = k > 1 ? 1 : k;
         }
         if(this.input.name_199())
         {
            yaw = -this.input.name_197() * this.var_50;
            pitch = -this.input.name_200() * this.var_48;
            this.var_47 += yaw;
            this.var_46 += pitch;
         }
         var object:name_78 = this.controller.object;
         var drX:Number = this.var_46 - object.rotationX;
         var drZ:Number = this.var_47 - object.rotationZ;
         if(drX != 0 || drZ != 0)
         {
            if(smoothing > 0)
            {
               drX *= k;
               drZ *= k;
            }
            object.rotationX += drX;
            object.rotationZ += drZ;
         }
         vector.x = this.input.name_192(KEY_RIGHT) - this.input.name_192(KEY_LEFT);
         vector.y = this.input.name_192(KEY_DOWN) - this.input.name_192(KEY_UP);
         vector.z = this.input.name_192(KEY_FORWARD) - this.input.name_192(KEY_BACK);
         var moved:Boolean = vector.x != 0 || vector.y != 0 || vector.z != 0;
         if(moved)
         {
            vector.normalize();
            vector.scale(this.speed * timeDelta * (1 + this.input.name_192(KEY_SPEED) * (this.var_49 - 1)));
         }
         matrix.name_196(object.rotationX,object.rotationY,object.rotationZ);
         vector.reset(vector.x,vector.y,vector.z);
         vector.transform3(matrix);
         this.currentPosition.x += vector.x;
         this.currentPosition.y += vector.y;
         this.currentPosition.z += vector.z;
         vector.reset();
         dx = this.currentPosition.x - object.x;
         dy = this.currentPosition.y - object.y;
         dz = this.currentPosition.z - object.z;
         if(smoothing > 0)
         {
            object.x += dx * k;
            object.y += dy * k;
            object.z += dz * k;
         }
         else
         {
            object.x += dx;
            object.y += dy;
            object.z += dz;
         }
         if(targeted && this.target != null)
         {
            this.method_114();
            dx = this.var_45.d - object.x;
            dy = this.var_45.h - object.y;
            dz = this.var_45.l - object.z;
            object.rotationX = Math.atan2(dz,Math.sqrt(dx * dx + dy * dy)) - 0.5 * Math.PI;
            object.rotationY = 0;
            object.rotationZ = -Math.atan2(dx,dy);
         }
      }
      
      private function method_114() : void
      {
         this.method_113(this.target.parent,this.parentMatrix);
         this.method_113(this.target,this.var_45);
         this.var_45.append(this.parentMatrix);
      }
      
      private function method_113(object:name_78, matrix:Matrix4) : void
      {
         matrix.name_196(object.rotationX,object.rotationY,object.rotationZ);
         matrix.name_75(object.x,object.y,object.z);
      }
   }
}

