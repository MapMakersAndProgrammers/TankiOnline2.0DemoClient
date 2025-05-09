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
   
   public class §_-bt§ extends §_-Ww§ implements §_-gb§
   {
      private static var parentMatrix:Matrix4 = new Matrix4();
      
      private static var matrix:Matrix4 = new Matrix4();
      
      private static var maxPositionError:Number = 10;
      
      private static var maxAngleError:Number = Math.PI / 180;
      
      private static var camSpeedThreshold:Number = 10;
      
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
      
      private static const KEY_CAMERA_DOWN:uint = Keyboard.PAGE_DOWN;
      
      private static const HEIGHT_CHANGE_STEP:Number = 50;
      
      private static const MIN_HEIGHT:Number = 150;
      
      private static const MAX_HEIGHT:Number = 3100;
      
      private static const MIN_DISTANCE:Number = 300;
      
      private static const COLLISION_OFFSET:Number = 100;
      
      private static const targetOffset:§_-bj§ = new §_-bj§(0,0,50);
      
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
      
      private var input:§_-Lm§;
      
      private var §_-fZ§:§_-U2§;
      
      private var §_-LT§:Number = 0;
      
      private var §_-mg§:Number = 0;
      
      private var §_-R2§:Number = 1000;
      
      private var §_-Rb§:Number = 0;
      
      private var §_-NW§:Number = 0;
      
      private var §_-1J§:Number = 1000;
      
      public var smoothing:Number = 40;
      
      private var angles:§_-bj§ = new §_-bj§();
      
      private var §_-n9§:§_-bj§ = new §_-bj§();
      
      private var rotationMatrix:Matrix4 = new Matrix4();
      
      private var §_-Ys§:Matrix4 = new Matrix4();
      
      private var §_-b4§:§_-bj§ = new §_-bj§();
      
      public function §_-bt§(camera:§_-RE§, collisionDetector:§_-fx§, collisionMask:int, input:§_-Lm§)
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
         this.§_-1E§();
         matrix.§_-eP§(targetOffset,this.§_-n9§);
         var distanceChangeDir:int = this.input.§_-OO§(KEY_CAMERA_UP) - this.input.§_-OO§(KEY_CAMERA_DOWN) - this.input.§_-i9§();
         if(distanceChangeDir != 0)
         {
            this.§_-1J§ *= Math.pow(10,distanceChangeDir * 0.02);
         }
         if(this.input.§_-an§())
         {
            this.§_-Rb§ -= this.input.§_-ac§() * 0.01;
            this.§_-NW§ -= this.input.§_-ow§() * 0.01;
         }
         var k:Number = 1;
         if(this.smoothing > 0)
         {
            k = 100 / this.smoothing * dt;
            k = k > 1 ? 1 : k;
            this.§_-LT§ += (this.§_-Rb§ - this.§_-LT§) * k;
            this.§_-mg§ += (this.§_-NW§ - this.§_-mg§) * k;
         }
         else
         {
            this.§_-LT§ = this.§_-Rb§;
            this.§_-mg§ = this.§_-NW§;
         }
         this.rotationMatrix.§_-Wl§(this.§_-LT§,0,this.§_-mg§);
         this.rotationMatrix.§_-oa§(matrix.d,matrix.h,matrix.l);
         matrix.getAxis(3,rayOrigin);
         this.rotationMatrix.§_-Uz§(§_-bj§.Y_AXIS,rayDirection);
         rayDirection.reverse();
         var distance:Number = this.§_-1J§;
         if(this.collisionDetector.raycast(rayOrigin,rayDirection,this.collisionMask,distance,null,rayHit))
         {
            distance = rayHit.t - COLLISION_OFFSET;
         }
         if(distanceChangeDir != 0)
         {
            this.§_-1J§ = distance;
         }
         if(this.smoothing > 0)
         {
            this.§_-R2§ += (distance - this.§_-R2§) * k;
         }
         else
         {
            this.§_-R2§ = distance;
         }
         this.position.x = 0;
         this.position.y = -this.§_-R2§;
         this.position.z = 0;
         this.rotationMatrix.§_-eP§(this.position,currentPosition);
         camera.x = currentPosition.x;
         camera.y = currentPosition.y;
         camera.z = currentPosition.z;
         var dx:Number = this.§_-n9§.x - camera.x;
         var dy:Number = this.§_-n9§.y - camera.y;
         var dz:Number = this.§_-n9§.z - camera.z;
         camera.rotationX = Math.atan2(dz,Math.sqrt(dx * dx + dy * dy)) - 0.5 * Math.PI;
         camera.rotationY = 0;
         camera.rotationZ = -Math.atan2(dx,dy);
      }
      
      private function set §_-Tq§(value:Number) : void
      {
         this.§_-U1§ = §_-aY§.clamp(value,MIN_HEIGHT,MAX_HEIGHT);
         var d:Number = this.§_-pq§(this.§_-U1§);
         this.§_-4G§ = Math.atan2(this.§_-U1§,d);
         this.§_-7h§ = Math.sqrt(this.§_-U1§ * this.§_-U1§ + d * d);
         this.§_-kz§ = 0;
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
            this.rotationMatrix.§_-OB§(axis,-angle);
            this.rotationMatrix.§_-Uz§(flatDirection,rayDirection);
            minCollisionDistance = this.§_-LI§(rayOrigin,rayDirection,this.§_-7h§,minCollisionDistance);
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
      
      private function §_-LI§(rayOrigin:§_-bj§, rayDirection:§_-bj§, rayLength:Number, minCollisionDistance:Number) : Number
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
         this.§_-U6§(this.§_-fZ§.parent,parentMatrix);
         this.§_-U6§(this.§_-fZ§,matrix);
         matrix.append(parentMatrix);
         matrix.getAxis(3,this.targetPosition);
         this.targetDirection.reset(matrix.b,matrix.f,matrix.j);
      }
      
      private function §_-U6§(object:§_-OX§, matrix:Matrix4) : void
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
         var v:Number = 200 - 1750;
         var k:Number = (1300 - 600) / (v * v);
         return -k * (h - 1750) * (h - 1750) + 1300;
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
