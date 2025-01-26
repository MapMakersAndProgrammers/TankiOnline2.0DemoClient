package package_77
{
   import package_46.name_194;
   import package_86.name_540;
   import package_90.name_273;
   import package_92.name_271;
   import package_92.name_599;
   
   public class name_510
   {
      private static var _groundUp:name_194;
      
      private static var _v:name_194 = new name_194();
      
      private static var _worldUp:name_194 = new name_194();
      
      private static var _groundForward:name_194 = new name_194();
      
      private static var _groundRight:name_194 = new name_194();
      
      private static var _relVel:name_194 = new name_194();
      
      private static var _force:name_194 = new name_194();
      
      public var collisionMask:int;
      
      public var name_692:Number = 0;
      
      private var body:name_271;
      
      private var relPos:name_194 = new name_194();
      
      private var relDir:name_194 = new name_194();
      
      public var worldPos:name_194 = new name_194();
      
      public var name_512:name_194 = new name_194();
      
      public var name_514:Boolean = false;
      
      public var name_516:name_273 = new name_273();
      
      private var var_626:Number = 0;
      
      private var var_627:name_540;
      
      public function name_510(body:name_271, relPos:name_194, relDir:name_194)
      {
         super();
         this.body = body;
         this.relPos.copy(relPos);
         this.relDir.copy(relDir);
         this.var_627 = new name_540(body);
      }
      
      public function getRelativeZ() : Number
      {
         return this.relPos.z;
      }
      
      public function method_713(value:name_194) : void
      {
         this.relPos.copy(value);
      }
      
      public function method_714(x:Number, y:Number, z:Number) : void
      {
         this.relPos.x = x;
         this.relPos.y = y;
         this.relPos.z = z;
      }
      
      public function name_693(maxLength:Number) : Boolean
      {
         this.body.baseMatrix.method_345(this.relDir,this.name_512);
         this.body.baseMatrix.method_345(this.relPos,this.worldPos);
         var p:name_194 = this.body.state.position;
         this.worldPos.x += p.x;
         this.worldPos.y += p.y;
         this.worldPos.z += p.z;
         if(this.name_514)
         {
            this.var_626 = maxLength - this.name_516.t;
         }
         this.name_514 = this.body.scene.collisionDetector.raycast(this.worldPos,this.name_512,this.collisionMask,maxLength,this.var_627,this.name_516);
         if(this.name_514 && this.name_516.primitive == null)
         {
            throw new Error("Ray hit error. Body id = " + this.body.id);
         }
         return this.name_514;
      }
      
      public function name_585(dt:Number, throttle:Number, maxSpeed:Number, slipTerm:int, springCoeff:Number, data:name_570, fwdBrake:Boolean) : void
      {
         var bState:name_599 = null;
         var slipSpeed:Number = NaN;
         var sideFriction:Number = NaN;
         var frictionForce:Number = NaN;
         var fwdFriction:Number = NaN;
         this.name_692 = 0;
         if(!this.name_514)
         {
            return;
         }
         _groundUp = this.name_516.normal;
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
         var state:name_599 = this.body.state;
         _v.x = this.name_516.position.x - state.position.x;
         _v.y = this.name_516.position.y - state.position.y;
         _v.z = this.name_516.position.z - state.position.z;
         var rot:name_194 = state.rotation;
         _relVel.x = rot.y * _v.z - rot.z * _v.y + state.velocity.x;
         _relVel.y = rot.z * _v.x - rot.x * _v.z + state.velocity.y;
         _relVel.z = rot.x * _v.y - rot.y * _v.x + state.velocity.z;
         if(this.name_516.primitive.body != null)
         {
            bState = this.name_516.primitive.body.state;
            _v.x = this.name_516.position.x - bState.position.x;
            _v.y = this.name_516.position.y - bState.position.y;
            _v.z = this.name_516.position.z - bState.position.z;
            rot = bState.rotation;
            _relVel.x -= rot.y * _v.z - rot.z * _v.y + bState.velocity.x;
            _relVel.y -= rot.z * _v.x - rot.x * _v.z + bState.velocity.y;
            _relVel.z -= rot.x * _v.y - rot.y * _v.x + bState.velocity.z;
         }
         var relSpeed:Number = Number(Math.sqrt(_relVel.x * _relVel.x + _relVel.y * _relVel.y + _relVel.z * _relVel.z));
         var fwdSpeed:Number = _relVel.x * _groundForward.x + _relVel.y * _groundForward.y + _relVel.z * _groundForward.z;
         this.name_692 = fwdSpeed;
         if(throttle > 0 && fwdSpeed < maxSpeed || throttle < 0 && -fwdSpeed < maxSpeed)
         {
            _v.x = this.worldPos.x + data.name_696 * this.name_512.x;
            _v.y = this.worldPos.y + data.name_696 * this.name_512.y;
            _v.z = this.worldPos.z + data.name_696 * this.name_512.z;
            _force.x = throttle * _groundForward.x;
            _force.y = throttle * _groundForward.y;
            _force.z = throttle * _groundForward.z;
            this.body.name_525(_v,_force);
         }
         _worldUp.x = this.body.baseMatrix.c;
         _worldUp.y = this.body.baseMatrix.g;
         _worldUp.z = this.body.baseMatrix.k;
         var t:Number = this.name_516.t;
         var currDisplacement:Number = data.rayLength - t;
         var springForce:Number = springCoeff * currDisplacement * (_worldUp.x * this.name_516.normal.x + _worldUp.y * this.name_516.normal.y + _worldUp.z * this.name_516.normal.z);
         var upSpeed:Number = (currDisplacement - this.var_626) / dt;
         springForce += upSpeed * data.name_582;
         if(springForce < 0)
         {
            springForce = 0;
         }
         _force.x = -springForce * this.name_512.x;
         _force.y = -springForce * this.name_512.y;
         _force.z = -springForce * this.name_512.z;
         if(relSpeed > 0.001)
         {
            slipSpeed = _relVel.dot(_groundRight);
            sideFriction = slipTerm == 0 || slipSpeed >= 0 && slipTerm > 0 || slipSpeed <= 0 && slipTerm < 0 ? data.name_698 : 2 * data.name_699;
            frictionForce = sideFriction * springForce * slipSpeed / relSpeed;
            if(slipSpeed > -data.name_697 && slipSpeed < data.name_697)
            {
               frictionForce *= slipSpeed / data.name_697;
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
               fwdFriction = 0.3 * data.name_698;
            }
            else if(fwdSpeed * throttle <= 0)
            {
               fwdFriction = 0.5 * data.name_698;
            }
            else
            {
               fwdFriction = data.name_699;
            }
            frictionForce = fwdFriction * springForce * fwdSpeed / relSpeed;
            if(fwdSpeed > -data.name_697 && fwdSpeed < data.name_697)
            {
               frictionForce *= fwdSpeed / data.name_697;
               if(fwdSpeed < 0)
               {
                  frictionForce = -frictionForce;
               }
            }
            _force.x -= frictionForce * _groundForward.x;
            _force.y -= frictionForce * _groundForward.y;
            _force.z -= frictionForce * _groundForward.z;
         }
         _v.x = this.worldPos.x + data.name_696 * this.name_512.x;
         _v.y = this.worldPos.y + data.name_696 * this.name_512.y;
         _v.z = this.worldPos.z + data.name_696 * this.name_512.z;
         this.body.name_525(_v,_force);
      }
   }
}

