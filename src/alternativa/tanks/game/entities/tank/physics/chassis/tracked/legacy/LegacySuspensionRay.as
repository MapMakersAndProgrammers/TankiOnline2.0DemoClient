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
      
      public var name_bv:Number = 0;
      
      private var body:Body;
      
      private var relPos:Vector3 = new Vector3();
      
      private var relDir:Vector3 = new Vector3();
      
      public var worldPos:Vector3 = new Vector3();
      
      public var name_Py:Vector3 = new Vector3();
      
      public var name_n3:Boolean = false;
      
      public var name_ZA:RayHit = new RayHit();
      
      private var name_Du:Number = 0;
      
      private var name_do:SimpleRaycastFilter;
      
      public function LegacySuspensionRay(body:Body, relPos:Vector3, relDir:Vector3)
      {
         super();
         this.body = body;
         this.relPos.copy(relPos);
         this.relDir.copy(relDir);
         this.name_do = new SimpleRaycastFilter(body);
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
         this.body.baseMatrix.transformVector(this.relDir,this.name_Py);
         this.body.baseMatrix.transformVector(this.relPos,this.worldPos);
         var p:Vector3 = this.body.state.position;
         this.worldPos.x += p.x;
         this.worldPos.y += p.y;
         this.worldPos.z += p.z;
         if(this.name_n3)
         {
            this.name_Du = maxLength - this.name_ZA.t;
         }
         this.name_n3 = this.body.scene.collisionDetector.raycast(this.worldPos,this.name_Py,this.collisionMask,maxLength,this.name_do,this.name_ZA);
         if(this.name_n3 && this.name_ZA.primitive == null)
         {
            throw new Error("Ray hit error. Body id = " + this.body.id);
         }
         return this.name_n3;
      }
      
      public function addForce(dt:Number, throttle:Number, maxSpeed:Number, slipTerm:int, springCoeff:Number, data:SuspensionData, fwdBrake:Boolean) : void
      {
         var bState:BodyState = null;
         var slipSpeed:Number = NaN;
         var sideFriction:Number = NaN;
         var frictionForce:Number = NaN;
         var fwdFriction:Number = NaN;
         this.name_bv = 0;
         if(!this.name_n3)
         {
            return;
         }
         _groundUp = this.name_ZA.normal;
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
         _v.x = this.name_ZA.position.x - state.position.x;
         _v.y = this.name_ZA.position.y - state.position.y;
         _v.z = this.name_ZA.position.z - state.position.z;
         var rot:Vector3 = state.rotation;
         _relVel.x = rot.y * _v.z - rot.z * _v.y + state.velocity.x;
         _relVel.y = rot.z * _v.x - rot.x * _v.z + state.velocity.y;
         _relVel.z = rot.x * _v.y - rot.y * _v.x + state.velocity.z;
         if(this.name_ZA.primitive.body != null)
         {
            bState = this.name_ZA.primitive.body.state;
            _v.x = this.name_ZA.position.x - bState.position.x;
            _v.y = this.name_ZA.position.y - bState.position.y;
            _v.z = this.name_ZA.position.z - bState.position.z;
            rot = bState.rotation;
            _relVel.x -= rot.y * _v.z - rot.z * _v.y + bState.velocity.x;
            _relVel.y -= rot.z * _v.x - rot.x * _v.z + bState.velocity.y;
            _relVel.z -= rot.x * _v.y - rot.y * _v.x + bState.velocity.z;
         }
         var relSpeed:Number = Number(Math.sqrt(_relVel.x * _relVel.x + _relVel.y * _relVel.y + _relVel.z * _relVel.z));
         var fwdSpeed:Number = _relVel.x * _groundForward.x + _relVel.y * _groundForward.y + _relVel.z * _groundForward.z;
         this.name_bv = fwdSpeed;
         if(throttle > 0 && fwdSpeed < maxSpeed || throttle < 0 && -fwdSpeed < maxSpeed)
         {
            _v.x = this.worldPos.x + data.name_Ko * this.name_Py.x;
            _v.y = this.worldPos.y + data.name_Ko * this.name_Py.y;
            _v.z = this.worldPos.z + data.name_Ko * this.name_Py.z;
            _force.x = throttle * _groundForward.x;
            _force.y = throttle * _groundForward.y;
            _force.z = throttle * _groundForward.z;
            this.body.addWorldForce(_v,_force);
         }
         _worldUp.x = this.body.baseMatrix.c;
         _worldUp.y = this.body.baseMatrix.g;
         _worldUp.z = this.body.baseMatrix.k;
         var t:Number = this.name_ZA.t;
         var currDisplacement:Number = data.rayLength - t;
         var springForce:Number = springCoeff * currDisplacement * (_worldUp.x * this.name_ZA.normal.x + _worldUp.y * this.name_ZA.normal.y + _worldUp.z * this.name_ZA.normal.z);
         var upSpeed:Number = (currDisplacement - this.name_Du) / dt;
         springForce += upSpeed * data.name_WZ;
         if(springForce < 0)
         {
            springForce = 0;
         }
         _force.x = -springForce * this.name_Py.x;
         _force.y = -springForce * this.name_Py.y;
         _force.z = -springForce * this.name_Py.z;
         if(relSpeed > 0.001)
         {
            slipSpeed = _relVel.dot(_groundRight);
            sideFriction = slipTerm == 0 || slipSpeed >= 0 && slipTerm > 0 || slipSpeed <= 0 && slipTerm < 0 ? data.name_4W : 2 * data.name_VW;
            frictionForce = sideFriction * springForce * slipSpeed / relSpeed;
            if(slipSpeed > -data.name_d7 && slipSpeed < data.name_d7)
            {
               frictionForce *= slipSpeed / data.name_d7;
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
               fwdFriction = 0.3 * data.name_4W;
            }
            else if(fwdSpeed * throttle <= 0)
            {
               fwdFriction = 0.5 * data.name_4W;
            }
            else
            {
               fwdFriction = data.name_VW;
            }
            frictionForce = fwdFriction * springForce * fwdSpeed / relSpeed;
            if(fwdSpeed > -data.name_d7 && fwdSpeed < data.name_d7)
            {
               frictionForce *= fwdSpeed / data.name_d7;
               if(fwdSpeed < 0)
               {
                  frictionForce = -frictionForce;
               }
            }
            _force.x -= frictionForce * _groundForward.x;
            _force.y -= frictionForce * _groundForward.y;
            _force.z -= frictionForce * _groundForward.z;
         }
         _v.x = this.worldPos.x + data.name_Ko * this.name_Py.x;
         _v.y = this.worldPos.y + data.name_Ko * this.name_Py.y;
         _v.z = this.worldPos.z + data.name_Ko * this.name_Py.z;
         this.body.addWorldForce(_v,_force);
      }
   }
}

