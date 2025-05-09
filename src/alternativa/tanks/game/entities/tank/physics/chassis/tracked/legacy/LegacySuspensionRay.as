package alternativa.tanks.game.entities.tank.physics.chassis.tracked.legacy
{
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.physics.BodyState;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.game.physics.SimpleRaycastFilter;
   
   public class LegacySuspensionRay
   {
      private static var _groundUp:Vector3;
      
      private static var _v:Vector3 = new Vector3();
      
      private static var _worldUp:Vector3 = new Vector3();
      
      private static var _groundForward:Vector3 = new Vector3();
      
      private static var _groundRight:Vector3 = new Vector3();
      
      private static var _relVel:Vector3 = new Vector3();
      
      private static var _force:Vector3 = new Vector3();
      
      public var collisionMask:int;
      
      public var §_-bv§:Number = 0;
      
      private var body:Body;
      
      private var relPos:Vector3 = new Vector3();
      
      private var relDir:Vector3 = new Vector3();
      
      public var worldPos:Vector3 = new Vector3();
      
      public var §_-Py§:Vector3 = new Vector3();
      
      public var §_-n3§:Boolean = false;
      
      public var §_-ZA§:RayHit = new RayHit();
      
      private var §_-Du§:Number = 0;
      
      private var § do§:SimpleRaycastFilter;
      
      public function LegacySuspensionRay(body:Body, relPos:Vector3, relDir:Vector3)
      {
         super();
         this.body = body;
         this.relPos.copy(relPos);
         this.relDir.copy(relDir);
         this.§ do§ = new SimpleRaycastFilter(body);
      }
      
      public function getRelativeZ() : Number
      {
         return this.relPos.z;
      }
      
      public function setRelPos(value:Vector3) : void
      {
         this.relPos.copy(value);
      }
      
      public function setRelPosXYZ(x:Number, y:Number, z:Number) : void
      {
         this.relPos.x = x;
         this.relPos.y = y;
         this.relPos.z = z;
      }
      
      public function calculateIntersection(maxLength:Number) : Boolean
      {
         this.body.baseMatrix.transformVector(this.relDir,this.§_-Py§);
         this.body.baseMatrix.transformVector(this.relPos,this.worldPos);
         var p:Vector3 = this.body.state.position;
         this.worldPos.x += p.x;
         this.worldPos.y += p.y;
         this.worldPos.z += p.z;
         if(this.§_-n3§)
         {
            this.§_-Du§ = maxLength - this.§_-ZA§.t;
         }
         this.§_-n3§ = this.body.scene.collisionDetector.raycast(this.worldPos,this.§_-Py§,this.collisionMask,maxLength,this.§ do§,this.§_-ZA§);
         if(this.§_-n3§ && this.§_-ZA§.primitive == null)
         {
            throw new Error("Ray hit error. Body id = " + this.body.id);
         }
         return this.§_-n3§;
      }
      
      public function addForce(dt:Number, throttle:Number, maxSpeed:Number, slipTerm:int, springCoeff:Number, data:SuspensionData, fwdBrake:Boolean) : void
      {
         var bState:BodyState = null;
         var slipSpeed:Number = NaN;
         var sideFriction:Number = NaN;
         var frictionForce:Number = NaN;
         var fwdFriction:Number = NaN;
         this.§_-bv§ = 0;
         if(!this.§_-n3§)
         {
            return;
         }
         _groundUp = this.§_-ZA§.normal;
         _v.x = this.body.baseMatrix.b;
         _v.y = this.body.baseMatrix.f;
         _v.z = this.body.baseMatrix.j;
         _groundRight.x = _v.y * _groundUp.z - _v.z * _groundUp.y;
         _groundRight.y = _v.z * _groundUp.x - _v.x * _groundUp.z;
         _groundRight.z = _v.x * _groundUp.y - _v.y * _groundUp.x;
         var len:Number = _groundRight.x * _groundRight.x + _groundRight.y * _groundRight.y + _groundRight.z * _groundRight.z;
         if(len == 0)
         {
            _groundRight.x = 1;
         }
         else
         {
            len = Number(Math.sqrt(len));
            _groundRight.x /= len;
            _groundRight.y /= len;
            _groundRight.z /= len;
         }
         _groundForward.x = _groundUp.y * _groundRight.z - _groundUp.z * _groundRight.y;
         _groundForward.y = _groundUp.z * _groundRight.x - _groundUp.x * _groundRight.z;
         _groundForward.z = _groundUp.x * _groundRight.y - _groundUp.y * _groundRight.x;
         var state:BodyState = this.body.state;
         _v.x = this.§_-ZA§.position.x - state.position.x;
         _v.y = this.§_-ZA§.position.y - state.position.y;
         _v.z = this.§_-ZA§.position.z - state.position.z;
         var rot:Vector3 = state.rotation;
         _relVel.x = rot.y * _v.z - rot.z * _v.y + state.velocity.x;
         _relVel.y = rot.z * _v.x - rot.x * _v.z + state.velocity.y;
         _relVel.z = rot.x * _v.y - rot.y * _v.x + state.velocity.z;
         if(this.§_-ZA§.primitive.body != null)
         {
            bState = this.§_-ZA§.primitive.body.state;
            _v.x = this.§_-ZA§.position.x - bState.position.x;
            _v.y = this.§_-ZA§.position.y - bState.position.y;
            _v.z = this.§_-ZA§.position.z - bState.position.z;
            rot = bState.rotation;
            _relVel.x -= rot.y * _v.z - rot.z * _v.y + bState.velocity.x;
            _relVel.y -= rot.z * _v.x - rot.x * _v.z + bState.velocity.y;
            _relVel.z -= rot.x * _v.y - rot.y * _v.x + bState.velocity.z;
         }
         var relSpeed:Number = Number(Math.sqrt(_relVel.x * _relVel.x + _relVel.y * _relVel.y + _relVel.z * _relVel.z));
         var fwdSpeed:Number = _relVel.x * _groundForward.x + _relVel.y * _groundForward.y + _relVel.z * _groundForward.z;
         this.§_-bv§ = fwdSpeed;
         if(throttle > 0 && fwdSpeed < maxSpeed || throttle < 0 && -fwdSpeed < maxSpeed)
         {
            _v.x = this.worldPos.x + data.§_-Ko§ * this.§_-Py§.x;
            _v.y = this.worldPos.y + data.§_-Ko§ * this.§_-Py§.y;
            _v.z = this.worldPos.z + data.§_-Ko§ * this.§_-Py§.z;
            _force.x = throttle * _groundForward.x;
            _force.y = throttle * _groundForward.y;
            _force.z = throttle * _groundForward.z;
            this.body.addWorldForce(_v,_force);
         }
         _worldUp.x = this.body.baseMatrix.c;
         _worldUp.y = this.body.baseMatrix.g;
         _worldUp.z = this.body.baseMatrix.k;
         var t:Number = this.§_-ZA§.t;
         var currDisplacement:Number = data.rayLength - t;
         var springForce:Number = springCoeff * currDisplacement * (_worldUp.x * this.§_-ZA§.normal.x + _worldUp.y * this.§_-ZA§.normal.y + _worldUp.z * this.§_-ZA§.normal.z);
         var upSpeed:Number = (currDisplacement - this.§_-Du§) / dt;
         springForce += upSpeed * data.§_-WZ§;
         if(springForce < 0)
         {
            springForce = 0;
         }
         _force.x = -springForce * this.§_-Py§.x;
         _force.y = -springForce * this.§_-Py§.y;
         _force.z = -springForce * this.§_-Py§.z;
         if(relSpeed > 0.001)
         {
            slipSpeed = _relVel.dot(_groundRight);
            sideFriction = slipTerm == 0 || slipSpeed >= 0 && slipTerm > 0 || slipSpeed <= 0 && slipTerm < 0 ? data.§_-4W§ : 2 * data.§_-VW§;
            frictionForce = sideFriction * springForce * slipSpeed / relSpeed;
            if(slipSpeed > -data.§_-d7§ && slipSpeed < data.§_-d7§)
            {
               frictionForce *= slipSpeed / data.§_-d7§;
               if(slipSpeed < 0)
               {
                  frictionForce = -frictionForce;
               }
            }
            _force.x -= frictionForce * _groundRight.x;
            _force.y -= frictionForce * _groundRight.y;
            _force.z -= frictionForce * _groundRight.z;
            if(fwdBrake)
            {
               fwdFriction = 0.3 * data.§_-4W§;
            }
            else if(fwdSpeed * throttle <= 0)
            {
               fwdFriction = 0.5 * data.§_-4W§;
            }
            else
            {
               fwdFriction = data.§_-VW§;
            }
            frictionForce = fwdFriction * springForce * fwdSpeed / relSpeed;
            if(fwdSpeed > -data.§_-d7§ && fwdSpeed < data.§_-d7§)
            {
               frictionForce *= fwdSpeed / data.§_-d7§;
               if(fwdSpeed < 0)
               {
                  frictionForce = -frictionForce;
               }
            }
            _force.x -= frictionForce * _groundForward.x;
            _force.y -= frictionForce * _groundForward.y;
            _force.z -= frictionForce * _groundForward.z;
         }
         _v.x = this.worldPos.x + data.§_-Ko§ * this.§_-Py§.x;
         _v.y = this.worldPos.y + data.§_-Ko§ * this.§_-Py§.y;
         _v.z = this.worldPos.z + data.§_-Ko§ * this.§_-Py§.z;
         this.body.addWorldForce(_v,_force);
      }
   }
}

