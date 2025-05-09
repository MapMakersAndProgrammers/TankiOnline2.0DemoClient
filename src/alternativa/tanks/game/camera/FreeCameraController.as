package alternativa.tanks.game.camera
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.math.Matrix3;
   import alternativa.math.Matrix4;
   import alternativa.math.Vector3;
   import alternativa.tanks.game.Entity;
   import alternativa.tanks.game.ObjectController;
   import alternativa.tanks.game.entities.tank.graphics.turret.TurretGraphicsComponent;
   import alternativa.tanks.game.subsystems.inputsystem.IInput;
   import alternativa.tanks.game.subsystems.rendersystem.GameCamera;
   import alternativa.tanks.game.subsystems.rendersystem.ICameraController;
   import alternativa.tanks.game.subsystems.timesystem.TimeSystem;
   import alternativa.utils.KeyboardUtils;
   import flash.geom.Vector3D;
   
   public class FreeCameraController implements ICameraController
   {
      public static var smoothing:Number = 20;
      
      public static var targeted:Boolean = false;
      
      private static const KEY_FORWARD:int = KeyboardUtils.W;
      
      private static const KEY_BACK:int = KeyboardUtils.S;
      
      private static const KEY_LEFT:int = KeyboardUtils.A;
      
      private static const KEY_RIGHT:int = KeyboardUtils.D;
      
      private static const KEY_UP:int = KeyboardUtils.E;
      
      private static const KEY_DOWN:int = KeyboardUtils.C;
      
      private static const KEY_SPEED:int = KeyboardUtils.SHIFT;
      
      private static var matrix:Matrix3 = new Matrix3();
      
      private static var vector:Vector3 = new Vector3();
      
      public var var_49:Number = 0.01;
      
      public var var_50:Number = 0.01;
      
      public var speed:Number = 500;
      
      public var var_48:Number = 3;
      
      private var var_47:Number = 0;
      
      private var var_46:Number = 0;
      
      private var currentPosition:Vector3D = new Vector3D();
      
      private var input:IInput;
      
      private var controller:ObjectController;
      
      private var target:Object3D;
      
      private var parentMatrix:Matrix4 = new Matrix4();
      
      private var var_45:Matrix4 = new Matrix4();
      
      public function FreeCameraController(camera:GameCamera, input:IInput)
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
      
      public function enable() : void
      {
         var object:Object3D = this.controller.object;
         this.var_46 = object.rotationX;
         this.var_47 = object.rotationZ;
         this.currentPosition.x = object.x;
         this.currentPosition.y = object.y;
         this.currentPosition.z = object.z;
      }
      
      public function setPositionXYZ(x:Number, y:Number, z:Number) : void
      {
         this.controller.setPosition(x,y,z);
         this.currentPosition.x = this.controller.object.x;
         this.currentPosition.y = this.controller.object.y;
         this.currentPosition.z = this.controller.object.z;
      }
      
      public function lookAtXYZ(x:Number, y:Number, z:Number) : void
      {
         this.controller.lookAtXYZ(x,y,z);
         this.var_46 = this.controller.object.rotationX;
         this.var_47 = this.controller.object.rotationZ;
      }
      
      public function setTarget(value:Entity) : void
      {
         if(value == null)
         {
            this.target = null;
         }
         else
         {
            this.target = TurretGraphicsComponent(value.getComponentStrict(TurretGraphicsComponent)).turretMesh;
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
         var timeDelta:Number = TimeSystem.timeDeltaSeconds;
         if(smoothing > 0)
         {
            k = 100 / smoothing * timeDelta;
            k = k > 1 ? 1 : k;
         }
         if(this.input.mouseButtonPressed())
         {
            yaw = -this.input.getMouseDeltaX() * this.var_49;
            pitch = -this.input.getMouseDeltaY() * this.var_50;
            this.var_47 += yaw;
            this.var_46 += pitch;
         }
         var object:Object3D = this.controller.object;
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
         vector.x = this.input.getKeyState(KEY_RIGHT) - this.input.getKeyState(KEY_LEFT);
         vector.y = this.input.getKeyState(KEY_DOWN) - this.input.getKeyState(KEY_UP);
         vector.z = this.input.getKeyState(KEY_FORWARD) - this.input.getKeyState(KEY_BACK);
         var moved:Boolean = vector.x != 0 || vector.y != 0 || vector.z != 0;
         if(moved)
         {
            vector.normalize();
            vector.scale(this.speed * timeDelta * (1 + this.input.getKeyState(KEY_SPEED) * (this.var_48 - 1)));
         }
         matrix.setRotationMatrix(object.rotationX,object.rotationY,object.rotationZ);
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
            this.updateTargetState();
            dx = this.var_45.d - object.x;
            dy = this.var_45.h - object.y;
            dz = this.var_45.l - object.z;
            object.rotationX = Math.atan2(dz,Math.sqrt(dx * dx + dy * dy)) - 0.5 * Math.PI;
            object.rotationY = 0;
            object.rotationZ = -Math.atan2(dx,dy);
         }
      }
      
      private function updateTargetState() : void
      {
         this.setMatrixFromObject(this.target.parent,this.parentMatrix);
         this.setMatrixFromObject(this.target,this.var_45);
         this.var_45.append(this.parentMatrix);
      }
      
      private function setMatrixFromObject(object:Object3D, matrix:Matrix4) : void
      {
         matrix.setRotationMatrix(object.rotationX,object.rotationY,object.rotationZ);
         matrix.setPositionXYZ(object.x,object.y,object.z);
      }
   }
}

