package package_9
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
   import package_22.name_87;
   import package_27.name_501;
   import package_45.name_182;
   import package_46.Matrix3;
   import package_46.Matrix4;
   import package_46.name_194;
   import package_47.name_193;
   import package_76.name_256;
   import package_90.name_273;
   
   public class name_299 extends class_32 implements name_102
   {
      private static var parentMatrix:Matrix4 = new Matrix4();
      
      private static var matrix:Matrix4 = new Matrix4();
      
      public static var maxPositionError:Number = 10;
      
      public static var maxAngleError:Number = Math.PI / 180;
      
      public static var camSpeedThreshold:Number = 10;
      
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
      
      private static const ALT_KEY_CAMERA_UP:uint = 221;
      
      private static const KEY_CAMERA_DOWN:uint = Keyboard.PAGE_DOWN;
      
      private static const ALT_KEY_CAMERA_DOWN:uint = 219;
      
      private static const HEIGHT_CHANGE_STEP:Number = 50;
      
      private static const MIN_HEIGHT:Number = 150;
      
      private static const MAX_HEIGHT:Number = 3100;
      
      private static const MIN_DISTANCE:Number = 300;
      
      private static const COLLISION_OFFSET:Number = 50;
      
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
      
      private var var_528:Number = 0;
      
      private var input:name_87;
      
      private var var_515:name_380;
      
      public function name_299(camera:name_90, collisionDetector:name_256, collisionMask:int, input:name_87)
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
         this.method_534 = 600;
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
      
      public function method_545() : void
      {
         noPitchCorrection.value = 1;
      }
      
      public function method_544() : void
      {
         noPitchCorrection.value = 0;
      }
      
      public function method_548(targetPosition:name_194, targetDirection:name_194) : void
      {
         this.targetPosition.copy(targetPosition);
         this.targetDirection.copy(targetDirection);
         this.var_522 = 0;
         this.method_540(targetPosition,targetDirection,false,10000,this.cameraPositionData);
         this.position.copy(this.cameraPositionData.position);
         this.rotation.x = this.method_542(this.cameraPositionData) - 0.5 * Math.PI;
         this.rotation.z = Math.atan2(-targetDirection.x,targetDirection.y);
         name_201(this.position);
         name_352(this.rotation);
      }
      
      public function method_549() : void
      {
         this.position.reset(camera.x,camera.y,camera.z);
         this.rotation.reset(camera.rotationX,camera.rotationY,camera.rotationZ);
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
         this.method_538();
         if(!this.locked)
         {
            this.method_114();
         }
         this.method_540(this.targetPosition,this.targetDirection,true,dt,this.cameraPositionData);
         positionDelta.method_366(this.cameraPositionData.position,this.position);
         var positionError:Number = positionDelta.length();
         if(positionError > maxPositionError)
         {
            this.var_526 = this.method_539(positionError - maxPositionError);
         }
         var distance:Number = this.var_526 * dt;
         if(distance > positionError)
         {
            distance = positionError;
         }
         positionDelta.normalize().scale(distance);
         var targetPitchAngle:Number = this.method_542(this.cameraPositionData);
         var targetYawAngle:Number = Number(Math.atan2(-this.targetDirection.x,this.targetDirection.y));
         var currentPitchAngle:Number = name_501.name_506(this.rotation.x + 0.5 * Math.PI);
         var currentYawAngle:Number = name_501.name_506(this.rotation.z);
         var pitchError:Number = name_501.name_628(targetPitchAngle - currentPitchAngle);
         this.var_525 = this.method_537(pitchError,this.var_525);
         var deltaPitch:Number = this.var_525 * dt;
         if(pitchError > 0 && deltaPitch > pitchError || pitchError < 0 && deltaPitch < pitchError)
         {
            deltaPitch = pitchError;
         }
         var yawError:Number = name_501.name_628(targetYawAngle - currentYawAngle);
         this.var_527 = this.method_537(yawError,this.var_527);
         var deltaYaw:Number = this.var_527 * dt;
         if(yawError > 0 && deltaYaw > yawError || yawError < 0 && deltaYaw < yawError)
         {
            deltaYaw = yawError;
         }
         this.var_526 = this.method_541(this.var_526,0,camSpeedThreshold);
         this.var_525 = this.method_541(this.var_525,0,camSpeedThreshold);
         this.var_527 = this.method_541(this.var_527,0,camSpeedThreshold);
         this.position.add(positionDelta);
         this.rotation.x += deltaPitch;
         this.rotation.z += deltaYaw;
         currentPosition.copy(this.position);
         currentRotation.copy(this.rotation);
         name_201(currentPosition);
         name_352(currentRotation);
      }
      
      public function method_550(locked:Boolean) : void
      {
         this.locked = locked;
      }
      
      public function get method_534() : Number
      {
         return this.var_510;
      }
      
      public function set method_534(value:Number) : void
      {
         this.var_510 = name_501.clamp(value,MIN_HEIGHT,MAX_HEIGHT);
         var d:Number = this.method_535(this.var_510);
         this.var_521 = Math.atan2(this.var_510,d);
         this.var_511 = Math.sqrt(this.var_510 * this.var_510 + d * d);
         this.var_522 = 0;
      }
      
      public function method_546(targetPosition:name_194, targetDirection:name_194, resultingPosition:name_194, resultingAngles:name_194) : void
      {
         this.method_540(targetPosition,targetDirection,false,10000,this.cameraPositionData);
         resultingAngles.x = this.method_542(this.cameraPositionData) - 0.5 * Math.PI;
         resultingAngles.z = Math.atan2(-targetDirection.x,targetDirection.y);
         resultingPosition.copy(this.cameraPositionData.position);
      }
      
      private function method_540(targetPosition:name_194, targetDirection:name_194, useReboundDelay:Boolean, dt:Number, result:CameraPositionData) : void
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
            rotationMatrix.method_344(axis,-angle);
            rotationMatrix.method_345(flatDirection,rayDirection);
            minCollisionDistance = this.method_543(rayOrigin,rayDirection,this.var_511,minCollisionDistance);
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
      
      private function method_543(rayOrigin:name_194, rayDirection:name_194, rayLength:Number, minCollisionDistance:Number) : Number
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
      
      private function method_114() : void
      {
         this.setMatrix(this.var_515.parent,parentMatrix);
         this.setMatrix(this.var_515,matrix);
         matrix.append(parentMatrix);
         matrix.getAxis(3,this.targetPosition);
         this.targetDirection.reset(matrix.b,matrix.f,matrix.j);
      }
      
      private function setMatrix(object:name_78, matrix:Matrix4) : void
      {
         matrix.name_196(object.rotationX,object.rotationY,object.rotationZ);
         matrix.name_75(object.x,object.y,object.z);
      }
      
      private function method_538() : void
      {
         var heightChangeDir:int = this.input.name_192(KEY_CAMERA_UP) - this.input.name_192(KEY_CAMERA_DOWN);
         if(heightChangeDir != 0)
         {
            this.method_534 = this.var_510 + heightChangeDir * HEIGHT_CHANGE_STEP;
         }
      }
      
      private function method_535(h:Number) : Number
      {
         var hMid:Number = 0.5 * (3300 + 200);
         var a:Number = hMid;
         var v:Number = 200 - hMid;
         var k:Number = (1300 - 600) / (v * v);
         return -k * (h - a) * (h - a) + 1300;
      }
      
      private function method_539(positionError:Number) : Number
      {
         return 3 * positionError;
      }
      
      private function method_537(angleError:Number, currentSpeed:Number) : Number
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
      
      private function method_541(value:Number, snapValue:Number, epsilon:Number) : Number
      {
         if(value > snapValue - epsilon && value < snapValue + epsilon)
         {
            return snapValue;
         }
         return value;
      }
      
      private function method_542(cameraPositionData:CameraPositionData) : Number
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
      
      private function method_547(value:Number, targetValue:Number, delta:Number) : Number
      {
         if(value < targetValue)
         {
            value += delta;
            return value > targetValue ? targetValue : value;
         }
         if(value > targetValue)
         {
            value -= delta;
            return value < targetValue ? targetValue : value;
         }
         return value;
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
