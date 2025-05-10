package alternativa.tanks.game.camera
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.math.Matrix3;
   import alternativa.math.Matrix4;
   import alternativa.math.Vector3;
   import alternativa.osgi.service.console.variables.ConsoleVarFloat;
   import alternativa.osgi.service.console.variables.ConsoleVarInt;
   import alternativa.physics.collision.ICollisionDetector;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.game.Entity;
   import alternativa.tanks.game.entities.tank.graphics.turret.TurretGraphicsComponent;
   import alternativa.tanks.game.subsystems.inputsystem.IInput;
   import alternativa.tanks.game.subsystems.rendersystem.GameCamera;
   import alternativa.tanks.game.subsystems.rendersystem.ICameraController;
   import alternativa.tanks.game.subsystems.timesystem.TimeSystem;
   import alternativa.tanks.game.utils.GameMathUtils;
   import flash.ui.Keyboard;
   import flash.utils.getTimer;
   
   public class FollowCameraController extends CameraControllerBase implements ICameraController
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
      
      private static var axis:Vector3 = new Vector3();
      
      private static var rayDirection:Vector3 = new Vector3();
      
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
      
      private static var currentPosition:Vector3 = new Vector3();
      
      private static var currentRotation:Vector3 = new Vector3();
      
      private static var rayOrigin:Vector3 = new Vector3();
      
      private static var flatDirection:Vector3 = new Vector3();
      
      private static var positionDelta:Vector3 = new Vector3();
      
      private static var rayHit:RayHit = new RayHit();
      
      private var collisionDetector:ICollisionDetector;
      
      private var collisionMask:int;
      
      private var §_-U1§:Number = 0;
      
      private var §_-7h§:Number = 0;
      
      private var locked:Boolean;
      
      private var position:Vector3 = new Vector3();
      
      private var rotation:Vector3 = new Vector3();
      
      private var targetPosition:Vector3 = new Vector3();
      
      private var targetDirection:Vector3 = new Vector3();
      
      private var §_-Wq§:Number = 0;
      
      private var §_-fq§:Number = 0;
      
      private var §_-qF§:Number = 0;
      
      private var §_-51§:Number = 10000000;
      
      private var §_-kz§:int;
      
      private var cameraPositionData:CameraPositionData = new CameraPositionData();
      
      private var §_-4G§:Number;
      
      private var §_-d9§:Number = 0;
      
      private var input:IInput;
      
      private var §_-fZ§:Mesh;
      
      public function FollowCameraController(camera:GameCamera, collisionDetector:ICollisionDetector, collisionMask:int, input:IInput)
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
      
      public function enable() : void
      {
      }
      
      public function setTarget(target:Entity) : void
      {
         if(target == null)
         {
            this.§_-fZ§ = null;
         }
         else
         {
            this.§_-fZ§ = TurretGraphicsComponent(target.getComponentStrict(TurretGraphicsComponent)).turretMesh;
         }
      }
      
      public function setDefaultSettings() : void
      {
         noPitchCorrection.value = 1;
      }
      
      public function setAlternateSettings() : void
      {
         noPitchCorrection.value = 0;
      }
      
      public function initByTarget(targetPosition:Vector3, targetDirection:Vector3) : void
      {
         this.targetPosition.copy(targetPosition);
         this.targetDirection.copy(targetDirection);
         this.§_-kz§ = 0;
         this.getCameraPositionData(targetPosition,targetDirection,false,10000,this.cameraPositionData);
         this.position.copy(this.cameraPositionData.position);
         this.rotation.x = this.getPitchAngle(this.cameraPositionData) - 0.5 * Math.PI;
         this.rotation.z = Math.atan2(-targetDirection.x,targetDirection.y);
         setPosition(this.position);
         setOrientation(this.rotation);
      }
      
      public function initCameraComponents() : void
      {
         this.position.reset(camera.x,camera.y,camera.z);
         this.rotation.reset(camera.rotationX,camera.rotationY,camera.rotationZ);
      }
      
      public function update() : void
      {
         if(this.§_-fZ§ == null)
         {
            throw new Error("Target is not set");
         }
         if(camera == null)
         {
            throw new Error("Camera is not set");
         }
         var dt:Number = TimeSystem.timeDeltaSeconds;
         if(dt > 0.1)
         {
            dt = 0.1;
         }
         this.updateHeight();
         if(!this.locked)
         {
            this.updateTargetState();
         }
         this.getCameraPositionData(this.targetPosition,this.targetDirection,true,dt,this.cameraPositionData);
         positionDelta.diff(this.cameraPositionData.position,this.position);
         var positionError:Number = positionDelta.length();
         if(positionError > maxPositionError)
         {
            this.§_-Wq§ = this.getLinearSpeed(positionError - maxPositionError);
         }
         var distance:Number = this.§_-Wq§ * dt;
         if(distance > positionError)
         {
            distance = positionError;
         }
         positionDelta.normalize().scale(distance);
         var targetPitchAngle:Number = this.getPitchAngle(this.cameraPositionData);
         var targetYawAngle:Number = Number(Math.atan2(-this.targetDirection.x,this.targetDirection.y));
         var currentPitchAngle:Number = GameMathUtils.clampAngle(this.rotation.x + 0.5 * Math.PI);
         var currentYawAngle:Number = GameMathUtils.clampAngle(this.rotation.z);
         var pitchError:Number = GameMathUtils.clampAngleFast(targetPitchAngle - currentPitchAngle);
         this.§_-fq§ = this.getAngularSpeed(pitchError,this.§_-fq§);
         var deltaPitch:Number = this.§_-fq§ * dt;
         if(pitchError > 0 && deltaPitch > pitchError || pitchError < 0 && deltaPitch < pitchError)
         {
            deltaPitch = pitchError;
         }
         var yawError:Number = GameMathUtils.clampAngleFast(targetYawAngle - currentYawAngle);
         this.§_-qF§ = this.getAngularSpeed(yawError,this.§_-qF§);
         var deltaYaw:Number = this.§_-qF§ * dt;
         if(yawError > 0 && deltaYaw > yawError || yawError < 0 && deltaYaw < yawError)
         {
            deltaYaw = yawError;
         }
         this.§_-Wq§ = this.§each §(this.§_-Wq§,0,camSpeedThreshold);
         this.§_-fq§ = this.§each §(this.§_-fq§,0,camSpeedThreshold);
         this.§_-qF§ = this.§each §(this.§_-qF§,0,camSpeedThreshold);
         this.position.add(positionDelta);
         this.rotation.x += deltaPitch;
         this.rotation.z += deltaYaw;
         currentPosition.copy(this.position);
         currentRotation.copy(this.rotation);
         setPosition(currentPosition);
         setOrientation(currentRotation);
      }
      
      public function setLocked(locked:Boolean) : void
      {
         this.locked = locked;
      }
      
      public function get cameraHeight() : Number
      {
         return this.§_-U1§;
      }
      
      public function set cameraHeight(value:Number) : void
      {
         this.§_-U1§ = GameMathUtils.clamp(value,MIN_HEIGHT,MAX_HEIGHT);
         var d:Number = this.getCamDistance(this.§_-U1§);
         this.§_-4G§ = Math.atan2(this.§_-U1§,d);
         this.§_-7h§ = Math.sqrt(this.§_-U1§ * this.§_-U1§ + d * d);
         this.§_-kz§ = 0;
      }
      
      public function getCameraState(targetPosition:Vector3, targetDirection:Vector3, resultingPosition:Vector3, resultingAngles:Vector3) : void
      {
         this.getCameraPositionData(targetPosition,targetDirection,false,10000,this.cameraPositionData);
         resultingAngles.x = this.getPitchAngle(this.cameraPositionData) - 0.5 * Math.PI;
         resultingAngles.z = Math.atan2(-targetDirection.x,targetDirection.y);
         resultingPosition.copy(this.cameraPositionData.position);
      }
      
      private function getCameraPositionData(targetPosition:Vector3, targetDirection:Vector3, useReboundDelay:Boolean, dt:Number, result:CameraPositionData) : void
      {
         var angle:Number = NaN;
         var now:int = 0;
         var delta:Number = NaN;
         var actualElevation:Number = this.§_-4G§;
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
         var minCollisionDistance:Number = this.§_-7h§;
         rayOrigin.copy(targetPosition);
         elevationAngles[0] = actualElevation;
         axis.x = flatDirection.y;
         axis.y = -flatDirection.x;
         flatDirection.reverse();
         for each(angle in elevationAngles)
         {
            rotationMatrix.fromAxisAngle(axis,-angle);
            rotationMatrix.transformVector(flatDirection,rayDirection);
            minCollisionDistance = this.getCollisionDistance(rayOrigin,rayDirection,this.§_-7h§,minCollisionDistance);
         }
         if(useReboundDelay)
         {
            now = int(getTimer());
            if(minCollisionDistance <= this.§_-51§ + 0.001)
            {
               this.§_-51§ = minCollisionDistance;
               this.§_-kz§ = now;
            }
            else if(now - this.§_-kz§ < reboundDelay.value)
            {
               minCollisionDistance = this.§_-51§;
            }
            else
            {
               this.§_-51§ = minCollisionDistance;
            }
         }
         if(minCollisionDistance < this.§_-7h§)
         {
            result.t = minCollisionDistance / this.§_-7h§;
            if(minCollisionDistance < MIN_DISTANCE)
            {
               rayOrigin.addScaled(minCollisionDistance,rayDirection);
               delta = MIN_DISTANCE - minCollisionDistance;
               if(this.collisionDetector.raycast(rayOrigin,Vector3.Z_AXIS,this.collisionMask,delta,null,rayHit))
               {
                  delta = rayHit.t - 10;
                  if(delta < 0)
                  {
                     delta = 0;
                  }
               }
               result.position.copy(rayOrigin).addScaled(delta,Vector3.Z_AXIS);
            }
            else
            {
               result.position.copy(rayOrigin).addScaled(minCollisionDistance,rayDirection);
            }
         }
         else
         {
            result.position.copy(rayOrigin).addScaled(this.§_-7h§,rayDirection);
         }
      }
      
      private function getCollisionDistance(rayOrigin:Vector3, rayDirection:Vector3, rayLength:Number, minCollisionDistance:Number) : Number
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
         this.setMatrix(this.§_-fZ§.parent,parentMatrix);
         this.setMatrix(this.§_-fZ§,matrix);
         matrix.append(parentMatrix);
         matrix.getAxis(3,this.targetPosition);
         this.targetDirection.reset(matrix.b,matrix.f,matrix.j);
      }
      
      private function setMatrix(object:Object3D, matrix:Matrix4) : void
      {
         matrix.setRotationMatrix(object.rotationX,object.rotationY,object.rotationZ);
         matrix.setPositionXYZ(object.x,object.y,object.z);
      }
      
      private function updateHeight() : void
      {
         var heightChangeDir:int = this.input.getKeyState(KEY_CAMERA_UP) - this.input.getKeyState(KEY_CAMERA_DOWN);
         if(heightChangeDir != 0)
         {
            this.cameraHeight = this.§_-U1§ + heightChangeDir * HEIGHT_CHANGE_STEP;
         }
      }
      
      private function getCamDistance(h:Number) : Number
      {
         var hMid:Number = 0.5 * (3300 + 200);
         var a:Number = hMid;
         var v:Number = 200 - hMid;
         var k:Number = (1300 - 600) / (v * v);
         return -k * (h - a) * (h - a) + 1300;
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
      
      private function §each §(value:Number, snapValue:Number, epsilon:Number) : Number
      {
         if(value > snapValue - epsilon && value < snapValue + epsilon)
         {
            return snapValue;
         }
         return value;
      }
      
      private function getPitchAngle(cameraPositionData:CameraPositionData) : Number
      {
         var angle:Number = this.§_-4G§ - fixedPitch.value;
         if(angle < 0)
         {
            angle = 0;
         }
         var t:Number = cameraPositionData.t;
         if(t >= 1 || angle < MIN_CAMERA_ANGLE || noPitchCorrection.value == 1)
         {
            return cameraPositionData.extraPitch - angle;
         }
         return cameraPositionData.extraPitch - Math.atan2(t * this.§_-U1§,pitchCorrectionCoeff.value * this.§_-U1§ * (1 / Math.tan(angle) - (1 - t) / Math.tan(this.§_-4G§)));
      }
      
      private function moveValueTowards(value:Number, targetValue:Number, delta:Number) : Number
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

import alternativa.math.Vector3;

class CameraPositionData
{
   public var t:Number;
   
   public var extraPitch:Number;
   
   public var position:Vector3 = new Vector3();
   
   public function CameraPositionData()
   {
      super();
   }
}
