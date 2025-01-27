package alternativa.tanks.game.camera
{
   import flash.ui.Keyboard;
   import flash.utils.getTimer;
   import alternativa.osgi.service.console.variables.ConsoleVarFloat;
   import alternativa.osgi.service.console.variables.ConsoleVarInt;
   import alternativa.tanks.game.Entity;
   import package_18.name_102;
   import package_18.name_90;
   import package_19.name_380;
   import package_21.name_78;
   import alternativa.tanks.game.subsystems.inputsystem.IInput;
   import package_27.name_501;
   import package_45.name_182;
   import package_46.Matrix3;
   import package_46.Matrix4;
   import package_46.name_194;
   import package_47.name_193;
   import package_76.name_256;
   import package_90.name_273;
   
   public class OrbitCameraController extends CameraControllerBase implements name_102
   {
      private static var parentMatrix:Matrix4 = new Matrix4();
      
      private static var matrix:Matrix4 = new Matrix4();
      
      private static var maxPositionError:Number = 10;
      
      private static var maxAngleError:Number = Math.PI / 180;
      
      private static var camSpeedThreshold:Number = 10;
      
      private static var fixedPitch:ConsoleVarFloat = new ConsoleVarFloat("cam_fixedpitch",10 * Math.PI / 180,-1,1);
      
      private static var noPitchCorrection:ConsoleVarInt = new ConsoleVarInt("cam_nopitchcorrection",1,0,1);
      
      private static var pitchCorrectionCoeff:ConsoleVarFloat = new ConsoleVarFloat("cam_pitchcorrectioncoeff",1,0,10);
      
      private static var reboundDelay:ConsoleVarInt = new ConsoleVarInt("cam_rebound",1000,0,2000);
      
      private static var elevationAngles:Vector.<Number> = new Vector.<Number>(1,true);
      
      private static var rotationMatrix:Matrix3 = new Matrix3();
      
      private static var axis:name_194 = new name_194();
      
      private static var rayDirection:name_194 = new name_194();
      
      private static const MIN_CAMERA_ANGLE:Number = 5 * Math.PI / 180;
      
      private static const KEY_CAMERA_UP:uint = Keyboard.PAGE_UP;
      
      private static const KEY_CAMERA_DOWN:uint = Keyboard.PAGE_DOWN;
      
      private static const HEIGHT_CHANGE_STEP:Number = 50;
      
      private static const MIN_HEIGHT:Number = 150;
      
      private static const MAX_HEIGHT:Number = 3100;
      
      private static const MIN_DISTANCE:Number = 300;
      
      private static const COLLISION_OFFSET:Number = 100;
      
      private static const targetOffset:name_194 = new name_194(0,0,50);
      
      private static var currentPosition:name_194 = new name_194();
      
      private static var currentRotation:name_194 = new name_194();
      
      private static var rayOrigin:name_194 = new name_194();
      
      private static var flatDirection:name_194 = new name_194();
      
      private static var positionDelta:name_194 = new name_194();
      
      private static var rayHit:name_273 = new name_273();
      
      private var collisionDetector:name_256;
      
      private var collisionMask:int;
      
      private var var_510:Number = 0;
      
      private var var_511:Number = 0;
      
      private var locked:Boolean;
      
      private var position:name_194 = new name_194();
      
      private var rotation:name_194 = new name_194();
      
      private var targetPosition:name_194 = new name_194();
      
      private var targetDirection:name_194 = new name_194();
      
      private var var_526:Number = 0;
      
      private var var_525:Number = 0;
      
      private var var_527:Number = 0;
      
      private var var_518:Number = 10000000;
      
      private var var_522:int;
      
      private var cameraPositionData:CameraPositionData = new CameraPositionData();
      
      private var var_521:Number;
      
      private var input:IInput;
      
      private var var_515:name_380;
      
      private var var_514:Number = 0;
      
      private var var_513:Number = 0;
      
      private var var_516:Number = 1000;
      
      private var var_519:Number = 0;
      
      private var var_520:Number = 0;
      
      private var var_517:Number = 1000;
      
      public var smoothing:Number = 40;
      
      private var angles:name_194 = new name_194();
      
      private var var_512:name_194 = new name_194();
      
      private var rotationMatrix:Matrix4 = new Matrix4();
      
      private var var_524:Matrix4 = new Matrix4();
      
      private var var_523:name_194 = new name_194();
      
      public function OrbitCameraController(camera:name_90, collisionDetector:name_256, collisionMask:int, input:IInput)
      {
         super();
         this.camera = camera;
         if(collisionDetector == null)
         {
            throw new ArgumentError("Parameter collisionDetector cannot be null");
         }
         this.collisionDetector = collisionDetector;
         this.collisionMask = collisionMask;
         this.input = input;
         this.cameraHeight = 600;
      }
      
      public function name_108() : void
      {
      }
      
      public function method_115(target:Entity) : void
      {
         if(target == null)
         {
            this.var_515 = null;
         }
         else
         {
            this.var_515 = name_193(target.getComponentStrict(name_193)).name_198;
         }
      }
      
      public function update() : void
      {
         if(this.var_515 == null)
         {
            throw new Error("Target is not set");
         }
         if(camera == null)
         {
            throw new Error("Camera is not set");
         }
         var dt:Number = name_182.timeDeltaSeconds;
         if(dt > 0.1)
         {
            dt = 0.1;
         }
         this.updateTargetState();
         matrix.method_353(targetOffset,this.var_512);
         var distanceChangeDir:int = this.input.name_192(KEY_CAMERA_UP) - this.input.name_192(KEY_CAMERA_DOWN) - this.input.method_261();
         if(distanceChangeDir != 0)
         {
            this.var_517 *= Math.pow(10,distanceChangeDir * 0.02);
         }
         if(this.input.name_199())
         {
            this.var_519 -= this.input.name_200() * 0.01;
            this.var_520 -= this.input.name_197() * 0.01;
         }
         var k:Number = 1;
         if(this.smoothing > 0)
         {
            k = 100 / this.smoothing * dt;
            k = k > 1 ? 1 : k;
            this.var_514 += (this.var_519 - this.var_514) * k;
            this.var_513 += (this.var_520 - this.var_513) * k;
         }
         else
         {
            this.var_514 = this.var_519;
            this.var_513 = this.var_520;
         }
         this.rotationMatrix.name_196(this.var_514,0,this.var_513);
         this.rotationMatrix.name_75(matrix.d,matrix.h,matrix.l);
         matrix.getAxis(3,rayOrigin);
         this.rotationMatrix.method_345(name_194.Y_AXIS,rayDirection);
         rayDirection.reverse();
         var distance:Number = this.var_517;
         if(this.collisionDetector.raycast(rayOrigin,rayDirection,this.collisionMask,distance,null,rayHit))
         {
            distance = rayHit.t - COLLISION_OFFSET;
         }
         if(distanceChangeDir != 0)
         {
            this.var_517 = distance;
         }
         if(this.smoothing > 0)
         {
            this.var_516 += (distance - this.var_516) * k;
         }
         else
         {
            this.var_516 = distance;
         }
         this.position.x = 0;
         this.position.y = -this.var_516;
         this.position.z = 0;
         this.rotationMatrix.method_353(this.position,currentPosition);
         camera.x = currentPosition.x;
         camera.y = currentPosition.y;
         camera.z = currentPosition.z;
         var dx:Number = this.var_512.x - camera.x;
         var dy:Number = this.var_512.y - camera.y;
         var dz:Number = this.var_512.z - camera.z;
         camera.rotationX = Math.atan2(dz,Math.sqrt(dx * dx + dy * dy)) - 0.5 * Math.PI;
         camera.rotationY = 0;
         camera.rotationZ = -Math.atan2(dx,dy);
      }
      
      private function set cameraHeight(value:Number) : void
      {
         this.var_510 = name_501.clamp(value,MIN_HEIGHT,MAX_HEIGHT);
         var d:Number = this.getCamDistance(this.var_510);
         this.var_521 = Math.atan2(this.var_510,d);
         this.var_511 = Math.sqrt(this.var_510 * this.var_510 + d * d);
         this.var_522 = 0;
      }
      
      private function getCameraPositionData(targetPosition:name_194, targetDirection:name_194, useReboundDelay:Boolean, dt:Number, result:CameraPositionData) : void
      {
         var angle:Number = NaN;
         var now:int = 0;
         var delta:Number = NaN;
         var actualElevation:Number = this.var_521;
         var xyLength:Number = Number(Math.sqrt(targetDirection.x * targetDirection.x + targetDirection.y * targetDirection.y));
         if(xyLength < 0.00001)
         {
            flatDirection.x = 1;
            flatDirection.y = 0;
         }
         else
         {
            flatDirection.x = targetDirection.x / xyLength;
            flatDirection.y = targetDirection.y / xyLength;
         }
         result.extraPitch = 0;
         result.t = 1;
         var minCollisionDistance:Number = this.var_511;
         rayOrigin.copy(targetPosition);
         elevationAngles[0] = actualElevation;
         axis.x = flatDirection.y;
         axis.y = -flatDirection.x;
         flatDirection.reverse();
         for each(angle in elevationAngles)
         {
            this.rotationMatrix.method_344(axis,-angle);
            this.rotationMatrix.method_345(flatDirection,rayDirection);
            minCollisionDistance = this.getMinCollisionDistance(rayOrigin,rayDirection,this.var_511,minCollisionDistance);
         }
         if(useReboundDelay)
         {
            now = int(getTimer());
            if(minCollisionDistance <= this.var_518 + 0.001)
            {
               this.var_518 = minCollisionDistance;
               this.var_522 = now;
            }
            else if(now - this.var_522 < reboundDelay.value)
            {
               minCollisionDistance = this.var_518;
            }
            else
            {
               this.var_518 = minCollisionDistance;
            }
         }
         if(minCollisionDistance < this.var_511)
         {
            result.t = minCollisionDistance / this.var_511;
            if(minCollisionDistance < MIN_DISTANCE)
            {
               rayOrigin.method_362(minCollisionDistance,rayDirection);
               delta = MIN_DISTANCE - minCollisionDistance;
               if(this.collisionDetector.raycast(rayOrigin,name_194.Z_AXIS,this.collisionMask,delta,null,rayHit))
               {
                  delta = rayHit.t - 10;
                  if(delta < 0)
                  {
                     delta = 0;
                  }
               }
               result.position.copy(rayOrigin).method_362(delta,name_194.Z_AXIS);
            }
            else
            {
               result.position.copy(rayOrigin).method_362(minCollisionDistance,rayDirection);
            }
         }
         else
         {
            result.position.copy(rayOrigin).method_362(this.var_511,rayDirection);
         }
      }
      
      private function getMinCollisionDistance(rayOrigin:name_194, rayDirection:name_194, rayLength:Number, minCollisionDistance:Number) : Number
      {
         var distance:Number = NaN;
         if(this.collisionDetector.raycast(rayOrigin,rayDirection,this.collisionMask,rayLength,null,rayHit))
         {
            distance = rayHit.t;
            if(distance < COLLISION_OFFSET)
            {
               distance = 0;
            }
            else
            {
               distance -= COLLISION_OFFSET;
            }
            if(distance < minCollisionDistance)
            {
               return distance;
            }
         }
         return minCollisionDistance;
      }
      
      private function updateTargetState() : void
      {
         this.setMatrixFromObject(this.var_515.parent,parentMatrix);
         this.setMatrixFromObject(this.var_515,matrix);
         matrix.append(parentMatrix);
         matrix.getAxis(3,this.targetPosition);
         this.targetDirection.reset(matrix.b,matrix.f,matrix.j);
      }
      
      private function setMatrixFromObject(object:name_78, matrix:Matrix4) : void
      {
         matrix.name_196(object.rotationX,object.rotationY,object.rotationZ);
         matrix.name_75(object.x,object.y,object.z);
      }
      
      private function updateHeight() : void
      {
         var heightChangeDir:int = this.input.name_192(KEY_CAMERA_UP) - this.input.name_192(KEY_CAMERA_DOWN);
         if(heightChangeDir != 0)
         {
            this.cameraHeight = this.var_510 + heightChangeDir * HEIGHT_CHANGE_STEP;
         }
      }
      
      private function getCamDistance(h:Number) : Number
      {
         var v:Number = 200 - 1750;
         var k:Number = (1300 - 600) / (v * v);
         return -k * (h - 1750) * (h - 1750) + 1300;
      }
      
      private function getLinearSpeed(positionError:Number) : Number
      {
         return 3 * positionError;
      }
      
      private function getAngularSpeed(angleError:Number, currentSpeed:Number) : Number
      {
         if(angleError < -maxAngleError)
         {
            return 3 * (angleError + maxAngleError);
         }
         if(angleError > maxAngleError)
         {
            return 3 * (angleError - maxAngleError);
         }
         return currentSpeed;
      }
      
      private function snap(value:Number, snapValue:Number, epsilon:Number) : Number
      {
         if(value > snapValue - epsilon && value < snapValue + epsilon)
         {
            return snapValue;
         }
         return value;
      }
      
      private function getPitchAngle(cameraPositionData:CameraPositionData) : Number
      {
         var angle:Number = this.var_521 - fixedPitch.value;
         if(angle < 0)
         {
            angle = 0;
         }
         var t:Number = cameraPositionData.t;
         if(t >= 1 || angle < MIN_CAMERA_ANGLE || noPitchCorrection.value == 1)
         {
            return cameraPositionData.extraPitch - angle;
         }
         return cameraPositionData.extraPitch - Math.atan2(t * this.var_510,pitchCorrectionCoeff.value * this.var_510 * (1 / Math.tan(angle) - (1 - t) / Math.tan(this.var_521)));
      }
   }
}

import package_46.name_194;

class CameraPositionData
{
   public var t:Number;
   
   public var extraPitch:Number;
   
   public var position:name_194 = new name_194();
   
   public function CameraPositionData()
   {
      super();
   }
}
