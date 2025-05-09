package alternativa.physics
{
   import alternativa.math.Matrix3;
   import alternativa.math.Matrix4;
   import alternativa.math.Quaternion;
   import alternativa.math.Vector3;
   import alternativa.physics.collision.CollisionPrimitive;
   import alternativa.physics.collision.IBodyCollisionFilter;
   import alternativa.physics.collision.types.BoundBox;
   
   public class Body
   {
      public static var linDamping:Number = 0.997;
      
      public static var rotDamping:Number = 0.997;
      
      private static var _r:Vector3 = new Vector3();
      
      private static var _f:Vector3 = new Vector3();
      
      private static var _q:Quaternion = new Quaternion();
      
      public var id:int;
      
      public var name:String;
      
      public var scene:PhysicsScene;
      
      public var var_500:Boolean = true;
      
      public var var_499:Boolean = false;
      
      public var var_502:int;
      
      public var var_498:Boolean = false;
      
      public var var_501:Boolean = true;
      
      public var aabb:BoundBox = new BoundBox();
      
      public var postCollisionFilter:IBodyCollisionFilter;
      
      public var state:BodyState = new BodyState();
      
      public var var_492:BodyState = new BodyState();
      
      public var var_496:Vector3 = new Vector3();
      
      public var var_497:Vector3 = new Vector3();
      
      public var material:BodyMaterial = new BodyMaterial();
      
      public var invMass:Number = 1;
      
      public var invInertia:Matrix3 = new Matrix3();
      
      public var var_495:Matrix3 = new Matrix3();
      
      public var baseMatrix:Matrix3 = new Matrix3();
      
      public var collisionPrimitives:CollisionPrimitiveList;
      
      public var var_494:Vector3 = new Vector3();
      
      public var var_493:Vector3 = new Vector3();
      
      public var data:Object;
      
      public function Body(invMass:Number, invInertia:Matrix3)
      {
         super();
         this.invMass = invMass;
         this.invInertia.copy(invInertia);
      }
      
      public function addCollisionPrimitive(primitive:CollisionPrimitive, localTransform:Matrix4 = null) : void
      {
         if(primitive == null)
         {
            throw new ArgumentError("Primitive cannot be null");
         }
         if(this.collisionPrimitives == null)
         {
            this.collisionPrimitives = new CollisionPrimitiveList();
         }
         this.collisionPrimitives.append(primitive);
         primitive.setBody(this,localTransform);
      }
      
      public function removeCollisionPrimitive(primitive:CollisionPrimitive) : void
      {
         if(this.collisionPrimitives == null)
         {
            return;
         }
         primitive.setBody(null);
         this.collisionPrimitives.remove(primitive);
         if(this.collisionPrimitives.size == 0)
         {
            this.collisionPrimitives = null;
         }
      }
      
      public function interpolate(t:Number, pos:Vector3, orientation:Quaternion) : void
      {
         var t1:Number = NaN;
         t1 = 1 - t;
         pos.x = this.var_492.position.x * t1 + this.state.position.x * t;
         pos.y = this.var_492.position.y * t1 + this.state.position.y * t;
         pos.z = this.var_492.position.z * t1 + this.state.position.z * t;
         orientation.w = this.var_492.orientation.w * t1 + this.state.orientation.w * t;
         orientation.x = this.var_492.orientation.x * t1 + this.state.orientation.x * t;
         orientation.y = this.var_492.orientation.y * t1 + this.state.orientation.y * t;
         orientation.z = this.var_492.orientation.z * t1 + this.state.orientation.z * t;
      }
      
      public function interpolateSLERP(t:Number, pos:Vector3, orientation:Quaternion) : void
      {
         var t1:Number = NaN;
         t1 = 1 - t;
         pos.x = this.var_492.position.x * t1 + this.state.position.x * t;
         pos.y = this.var_492.position.y * t1 + this.state.position.y * t;
         pos.z = this.var_492.position.z * t1 + this.state.position.z * t;
         orientation.slerp(this.var_492.orientation,this.state.orientation,t);
      }
      
      public function interpolateToMatrix(t:Number, m:Matrix4) : void
      {
         var t1:Number = NaN;
         t1 = 1 - t;
         m.d = this.var_492.position.x * t1 + this.state.position.x * t;
         m.h = this.var_492.position.y * t1 + this.state.position.y * t;
         m.l = this.var_492.position.z * t1 + this.state.position.z * t;
         _q.w = this.var_492.orientation.w * t1 + this.state.orientation.w * t;
         _q.x = this.var_492.orientation.x * t1 + this.state.orientation.x * t;
         _q.y = this.var_492.orientation.y * t1 + this.state.orientation.y * t;
         _q.z = this.var_492.orientation.z * t1 + this.state.orientation.z * t;
         _q.normalize();
         _q.toMatrix4(m);
      }
      
      public function interpolateToMatrixSLERP(t:Number, m:Matrix4) : void
      {
         var t1:Number = 1 - t;
         m.d = this.var_492.position.x * t1 + this.state.position.x * t;
         m.h = this.var_492.position.y * t1 + this.state.position.y * t;
         m.l = this.var_492.position.z * t1 + this.state.position.z * t;
         _q.slerp(this.var_492.orientation,this.state.orientation,t);
         _q.normalize();
         _q.toMatrix4(m);
      }
      
      public function setPosition(pos:Vector3) : void
      {
         this.state.position.copy(pos);
      }
      
      public function setPositionXYZ(x:Number, y:Number, z:Number) : void
      {
         this.state.position.reset(x,y,z);
      }
      
      public function setVelocity(vel:Vector3) : void
      {
         this.state.velocity.copy(vel);
      }
      
      public function setVelocityXYZ(x:Number, y:Number, z:Number) : void
      {
         this.state.velocity.reset(x,y,z);
      }
      
      public function setRotation(rot:Vector3) : void
      {
         this.state.rotation.copy(rot);
      }
      
      public function setRotationXYZ(x:Number, y:Number, z:Number) : void
      {
         this.state.rotation.reset(x,y,z);
      }
      
      public function setOrientation(q:Quaternion) : void
      {
         this.state.orientation.copy(q);
      }
      
      public function setOrientationWXYZ(w:Number, x:Number, y:Number, z:Number) : void
      {
         this.state.orientation.reset(w,x,y,z);
      }
      
      public function applyRelPosWorldImpulse(r:Vector3, dir:Vector3, magnitude:Number) : void
      {
         var x:Number = NaN;
         var y:Number = NaN;
         var d:Number = magnitude * this.invMass;
         this.state.velocity.x += d * dir.x;
         this.state.velocity.y += d * dir.y;
         this.state.velocity.z += d * dir.z;
         x = (r.y * dir.z - r.z * dir.y) * magnitude;
         y = (r.z * dir.x - r.x * dir.z) * magnitude;
         var z:Number = (r.x * dir.y - r.y * dir.x) * magnitude;
         this.state.rotation.x += this.var_495.a * x + this.var_495.b * y + this.var_495.c * z;
         this.state.rotation.y += this.var_495.e * x + this.var_495.f * y + this.var_495.g * z;
         this.state.rotation.z += this.var_495.i * x + this.var_495.j * y + this.var_495.k * z;
      }
      
      public function addForce(f:Vector3) : void
      {
         this.var_494.add(f);
      }
      
      public function addForceXYZ(fx:Number, fy:Number, fz:Number) : void
      {
         this.var_494.x += fx;
         this.var_494.y += fy;
         this.var_494.z += fz;
      }
      
      public function addWorldForceXYZ(px:Number, py:Number, pz:Number, fx:Number, fy:Number, fz:Number) : void
      {
         var rx:Number = NaN;
         this.var_494.x += fx;
         this.var_494.y += fy;
         this.var_494.z += fz;
         var pos:Vector3 = this.state.position;
         rx = px - pos.x;
         var ry:Number = py - pos.y;
         var rz:Number = pz - pos.z;
         this.var_493.x += ry * fz - rz * fy;
         this.var_493.y += rz * fx - rx * fz;
         this.var_493.z += rx * fy - ry * fx;
      }
      
      public function addWorldForce(pos:Vector3, force:Vector3) : void
      {
         this.var_494.add(force);
         this.var_493.add(_r.diff(pos,this.state.position).cross(force));
      }
      
      public function addWorldForceScaled(pos:Vector3, force:Vector3, scale:Number) : void
      {
         _f.x = scale * force.x;
         _f.y = scale * force.y;
         _f.z = scale * force.z;
         this.var_494.add(_f);
         this.var_493.add(_r.diff(pos,this.state.position).cross(_f));
      }
      
      public function addLocalForce(pos:Vector3, force:Vector3) : void
      {
         this.baseMatrix.transformVector(pos,_r);
         this.baseMatrix.transformVector(force,_f);
         this.var_494.add(_f);
         this.var_493.add(_r.cross(_f));
      }
      
      public function addWorldForceAtLocalPoint(localPos:Vector3, worldForce:Vector3) : void
      {
         this.baseMatrix.transformVector(localPos,_r);
         this.var_494.add(worldForce);
         this.var_493.add(_r.cross(worldForce));
      }
      
      public function addTorque(t:Vector3) : void
      {
         this.var_493.add(t);
      }
      
      internal function clearAccumulators() : void
      {
         this.var_494.x = this.var_494.y = this.var_494.z = 0;
         this.var_493.x = this.var_493.y = this.var_493.z = 0;
      }
      
      internal function calcAccelerations() : void
      {
         this.var_496.x = this.var_494.x * this.invMass;
         this.var_496.y = this.var_494.y * this.invMass;
         this.var_496.z = this.var_494.z * this.invMass;
         this.var_497.x = this.var_495.a * this.var_493.x + this.var_495.b * this.var_493.y + this.var_495.c * this.var_493.z;
         this.var_497.y = this.var_495.e * this.var_493.x + this.var_495.f * this.var_493.y + this.var_495.g * this.var_493.z;
         this.var_497.z = this.var_495.i * this.var_493.x + this.var_495.j * this.var_493.y + this.var_495.k * this.var_493.z;
      }
      
      public function calcDerivedData() : void
      {
         var item:CollisionPrimitiveListItem = null;
         var primitive:CollisionPrimitive = null;
         this.state.orientation.toMatrix3(this.baseMatrix);
         this.var_495.copy(this.invInertia).append(this.baseMatrix).prependTransposed(this.baseMatrix);
         if(this.collisionPrimitives != null)
         {
            this.aabb.name_426();
            for(item = this.collisionPrimitives.head; item != null; )
            {
               primitive = item.primitive;
               primitive.transform.setFromMatrix3(this.baseMatrix,this.state.position);
               if(primitive.localTransform != null)
               {
                  primitive.transform.prepend(primitive.localTransform);
               }
               primitive.calculateAABB();
               this.aabb.name_424(primitive.aabb);
               item = item.next;
            }
         }
      }
      
      public function saveState() : void
      {
         this.var_492.copy(this.state);
      }
      
      internal function restoreState() : void
      {
         this.state.copy(this.var_492);
      }
      
      internal function integrateVelocity(dt:Number) : void
      {
         this.state.velocity.x += this.var_496.x * dt;
         this.state.velocity.y += this.var_496.y * dt;
         this.state.velocity.z += this.var_496.z * dt;
         this.state.rotation.x += this.var_497.x * dt;
         this.state.rotation.y += this.var_497.y * dt;
         this.state.rotation.z += this.var_497.z * dt;
         this.state.velocity.x *= linDamping;
         this.state.velocity.y *= linDamping;
         this.state.velocity.z *= linDamping;
         this.state.rotation.x *= rotDamping;
         this.state.rotation.y *= rotDamping;
         this.state.rotation.z *= rotDamping;
      }
      
      internal function integratePosition(dt:Number) : void
      {
         this.state.position.x += this.state.velocity.x * dt;
         this.state.position.y += this.state.velocity.y * dt;
         this.state.position.z += this.state.velocity.z * dt;
         this.state.orientation.addScaledVector(this.state.rotation,dt);
      }
   }
}

