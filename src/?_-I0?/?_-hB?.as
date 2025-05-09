package §_-I0§
{
   import §_-1e§.§_-fx§;
   import §_-8D§.§_-OX§;
   import §_-Ex§.§_-U2§;
   import §_-KA§.§_-jr§;
   import §_-KT§.§_-Ju§;
   import §_-KT§.§_-UT§;
   import §_-OR§.§_-om§;
   import §_-V-§.§_-aY§;
   import §_-aM§.§_-Lm§;
   import §_-az§.§_-gw§;
   import §_-e6§.§_-RE§;
   import §_-e6§.§_-gb§;
   import §_-lS§.§_-h2§;
   import §_-nl§.Matrix3;
   import §_-nl§.Matrix4;
   import §_-nl§.§_-bj§;
   import flash.ui.Keyboard;
   import flash.utils.getTimer;
   
   public class §_-hB§ extends §_-Ww§ implements §_-gb§
   {
      private static var parentMatrix:Matrix4 = new Matrix4();
      
      private static var matrix:Matrix4 = new Matrix4();
      
      public static var maxPositionError:Number = 10;
      
      public static var maxAngleError:Number = Math.PI / 180;
      
      public static var camSpeedThreshold:Number = 10;
      
      private static var fixedPitch:§_-Ju§ = new §_-Ju§("cam_fixedpitch",10 * Math.PI / 180,-1,1);
      
      private static var noPitchCorrection:§_-UT§ = new §_-UT§("cam_nopitchcorrection",1,0,1);
      
      private static var pitchCorrectionCoeff:§_-Ju§ = new §_-Ju§("cam_pitchcorrectioncoeff",1,0,10);
      
      private static var reboundDelay:§_-UT§ = new §_-UT§("cam_rebound",1000,0,2000);
      
      private static var elevationAngles:Vector.<Number> = new Vector.<Number>(1,true);
      
      private static var rotationMatrix:Matrix3 = new Matrix3();
      
      private static var axis:§_-bj§ = new §_-bj§();
      
      private static var rayDirection:§_-bj§ = new §_-bj§();
      
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
      
      private static var currentPosition:§_-bj§ = new §_-bj§();
      
      private static var currentRotation:§_-bj§ = new §_-bj§();
      
      private static var rayOrigin:§_-bj§ = new §_-bj§();
      
      private static var flatDirection:§_-bj§ = new §_-bj§();
      
      private static var positionDelta:§_-bj§ = new §_-bj§();
      
      private static var rayHit:§_-jr§ = new §_-jr§();
      
      private var collisionDetector:§_-fx§;
      
      private var collisionMask:int;
      
      private var §_-U1§:Number = 0;
      
      private var §_-7h§:Number = 0;
      
      private var locked:Boolean;
      
      private var position:§_-bj§ = new §_-bj§();
      
      private var rotation:§_-bj§ = new §_-bj§();
      
      private var targetPosition:§_-bj§ = new §_-bj§();
      
      private var targetDirection:§_-bj§ = new §_-bj§();
      
      private var §_-Wq§:Number = 0;
      
      private var §_-fq§:Number = 0;
      
      private var §_-qF§:Number = 0;
      
      private var §_-51§:Number = 10000000;
      
      private var §_-kz§:int;
      
      private var cameraPositionData:CameraPositionData = new CameraPositionData();
      
      private var §_-4G§:Number;
      
      private var §_-d9§:Number = 0;
      
      private var input:§_-Lm§;
      
      private var §_-fZ§:§_-U2§;
      
      public function §_-hB§(camera:§_-RE§, collisionDetector:§_-fx§, collisionMask:int, input:§_-Lm§)
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
         this.§_-Tq§ = 600;
      }
      
      public function §_-eA§() : void
      {
      }
      
      public function §_-O-§(target:§_-gw§) : void
      {
         if(target == null)
         {
            this.§_-fZ§ = null;
         }
         else
         {
            this.§_-fZ§ = §_-om§(target.getComponentStrict(§_-om§)).§_-dW§;
         }
      }
      
      public function §_-7o§() : void
      {
         noPitchCorrection.value = 1;
      }
      
      public function §_-hI§() : void
      {
         noPitchCorrection.value = 0;
      }
      
      public function §_-WF§(targetPosition:§_-bj§, targetDirection:§_-bj§) : void
      {
         this.targetPosition.copy(targetPosition);
         this.targetDirection.copy(targetDirection);
         this.§_-kz§ = 0;
         this.§_-TS§(targetPosition,targetDirection,false,10000,this.cameraPositionData);
         this.position.copy(this.cameraPositionData.position);
         this.rotation.x = this.§_-Xv§(this.cameraPositionData) - 0.5 * Math.PI;
         this.rotation.z = Math.atan2(-targetDirection.x,targetDirection.y);
         §_-Vi§(this.position);
         §_-LV§(this.rotation);
      }
      
      public function §_-5p§() : void
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
         var dt:Number = Number(§_-h2§.timeDeltaSeconds);
         if(dt > 0.1)
         {
            dt = 0.1;
         }
         this.§_-K4§();
         if(!this.locked)
         {
            this.§_-1E§();
         }
         this.§_-TS§(this.targetPosition,this.targetDirection,true,dt,this.cameraPositionData);
         positionDelta.§_-hL§(this.cameraPositionData.position,this.position);
         var positionError:Number = Number(positionDelta.length());
         if(positionError > maxPositionError)
         {
            this.§_-Wq§ = this.§_-Tu§(positionError - maxPositionError);
         }
         var distance:Number = this.§_-Wq§ * dt;
         if(distance > positionError)
         {
            distance = positionError;
         }
         positionDelta.normalize().scale(distance);
         var targetPitchAngle:Number = this.§_-Xv§(this.cameraPositionData);
         var targetYawAngle:Number = Number(Math.atan2(-this.targetDirection.x,this.targetDirection.y));
         var currentPitchAngle:Number = Number(§_-aY§.§_-d§(this.rotation.x + 0.5 * Math.PI));
         var currentYawAngle:Number = Number(§_-aY§.§_-d§(this.rotation.z));
         var pitchError:Number = Number(§_-aY§.§_-Bu§(targetPitchAngle - currentPitchAngle));
         this.§_-fq§ = this.§_-NP§(pitchError,this.§_-fq§);
         var deltaPitch:Number = this.§_-fq§ * dt;
         if(pitchError > 0 && deltaPitch > pitchError || pitchError < 0 && deltaPitch < pitchError)
         {
            deltaPitch = pitchError;
         }
         var yawError:Number = Number(§_-aY§.§_-Bu§(targetYawAngle - currentYawAngle));
         this.§_-qF§ = this.§_-NP§(yawError,this.§_-qF§);
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
         §_-Vi§(currentPosition);
         §_-LV§(currentRotation);
      }
      
      public function §_-qb§(locked:Boolean) : void
      {
         this.locked = locked;
      }
      
      public function get §_-Tq§() : Number
      {
         return this.§_-U1§;
      }
      
      public function set §_-Tq§(value:Number) : void
      {
         this.§_-U1§ = §_-aY§.clamp(value,MIN_HEIGHT,MAX_HEIGHT);
         var d:Number = this.§_-pq§(this.§_-U1§);
         this.§_-4G§ = Math.atan2(this.§_-U1§,d);
         this.§_-7h§ = Math.sqrt(this.§_-U1§ * this.§_-U1§ + d * d);
         this.§_-kz§ = 0;
      }
      
      public function §_-Ls§(targetPosition:§_-bj§, targetDirection:§_-bj§, resultingPosition:§_-bj§, resultingAngles:§_-bj§) : void
      {
         this.§_-TS§(targetPosition,targetDirection,false,10000,this.cameraPositionData);
         resultingAngles.x = this.§_-Xv§(this.cameraPositionData) - 0.5 * Math.PI;
         resultingAngles.z = Math.atan2(-targetDirection.x,targetDirection.y);
         resultingPosition.copy(this.cameraPositionData.position);
      }
      
      private function §_-TS§(targetPosition:§_-bj§, targetDirection:§_-bj§, useReboundDelay:Boolean, dt:Number, result:CameraPositionData) : void
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
            rotationMatrix.§_-OB§(axis,-angle);
            rotationMatrix.§_-Uz§(flatDirection,rayDirection);
            minCollisionDistance = this.§_-5y§(rayOrigin,rayDirection,this.§_-7h§,minCollisionDistance);
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
               rayOrigin.§_-LQ§(minCollisionDistance,rayDirection);
               delta = MIN_DISTANCE - minCollisionDistance;
               if(this.collisionDetector.raycast(rayOrigin,§_-bj§.Z_AXIS,this.collisionMask,delta,null,rayHit))
               {
                  delta = rayHit.t - 10;
                  if(delta < 0)
                  {
                     delta = 0;
                  }
               }
               result.position.copy(rayOrigin).§_-LQ§(delta,§_-bj§.Z_AXIS);
            }
            else
            {
               result.position.copy(rayOrigin).§_-LQ§(minCollisionDistance,rayDirection);
            }
         }
         else
         {
            result.position.copy(rayOrigin).§_-LQ§(this.§_-7h§,rayDirection);
         }
      }
      
      private function §_-5y§(rayOrigin:§_-bj§, rayDirection:§_-bj§, rayLength:Number, minCollisionDistance:Number) : Number
      {
         var distance:Number = NaN;
         if(this.collisionDetector.raycast(rayOrigin,rayDirection,this.collisionMask,rayLength,null,rayHit))
         {
            distance = Number(rayHit.t);
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
      
      private function §_-1E§() : void
      {
         this.setMatrix(this.§_-fZ§.parent,parentMatrix);
         this.setMatrix(this.§_-fZ§,matrix);
         matrix.append(parentMatrix);
         matrix.getAxis(3,this.targetPosition);
         this.targetDirection.reset(matrix.b,matrix.f,matrix.j);
      }
      
      private function setMatrix(object:§_-OX§, matrix:Matrix4) : void
      {
         matrix.§_-Wl§(object.rotationX,object.rotationY,object.rotationZ);
         matrix.§_-oa§(object.x,object.y,object.z);
      }
      
      private function §_-K4§() : void
      {
         var heightChangeDir:int = this.input.§_-OO§(KEY_CAMERA_UP) - this.input.§_-OO§(KEY_CAMERA_DOWN);
         if(heightChangeDir != 0)
         {
            this.§_-Tq§ = this.§_-U1§ + heightChangeDir * HEIGHT_CHANGE_STEP;
         }
      }
      
      private function §_-pq§(h:Number) : Number
      {
         var hMid:Number = 0.5 * (3300 + 200);
         var a:Number = hMid;
         var v:Number = 200 - hMid;
         var k:Number = (1300 - 600) / (v * v);
         return -k * (h - a) * (h - a) + 1300;
      }
      
      private function §_-Tu§(positionError:Number) : Number
      {
         return 3 * positionError;
      }
      
      private function §_-NP§(angleError:Number, currentSpeed:Number) : Number
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
      
      private function §_-Xv§(cameraPositionData:CameraPositionData) : Number
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
      
      private function §_-PD§(value:Number, targetValue:Number, delta:Number) : Number
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

import §_-nl§.§_-bj§;

class CameraPositionData
{
   public var t:Number;
   
   public var extraPitch:Number;
   
   public var position:§_-bj§ = new §_-bj§();
   
   public function CameraPositionData()
   {
      super();
   }
}
