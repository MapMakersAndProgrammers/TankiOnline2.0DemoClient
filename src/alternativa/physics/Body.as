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
      
      public var §_-Sb§:Boolean = true;
      
      public var §_-N4§:Boolean = false;
      
      public var §_-ia§:int;
      
      public var §_-N0§:Boolean = false;
      
      public var §_-fA§:Boolean = true;
      
      public var aabb:BoundBox = new BoundBox();
      
      public var postCollisionFilter:IBodyCollisionFilter;
      
      public var state:BodyState = new BodyState();
      
      public var §_-U3§:BodyState = new BodyState();
      
      public var §_-1G§:Vector3 = new Vector3();
      
      public var §_-fR§:Vector3 = new Vector3();
      
      public var material:BodyMaterial = new BodyMaterial();
      
      public var invMass:Number = 1;
      
      public var invInertia:Matrix3 = new Matrix3();
      
      public var §_-nX§:Matrix3 = new Matrix3();
      
      public var baseMatrix:Matrix3 = new Matrix3();
      
      public var collisionPrimitives:CollisionPrimitiveList;
      
      public var §_-iu§:Vector3 = new Vector3();
      
      public var §_-Xr§:Vector3 = new Vector3();
      
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
         pos.x = this.§_-U3§.position.x * t1 + this.state.position.x * t;
         pos.y = this.§_-U3§.position.y * t1 + this.state.position.y * t;
         pos.z = this.§_-U3§.position.z * t1 + this.state.position.z * t;
         orientation.w = this.§_-U3§.orientation.w * t1 + this.state.orientation.w * t;
         orientation.x = this.§_-U3§.orientation.x * t1 + this.state.orientation.x * t;
         orientation.y = this.§_-U3§.orientation.y * t1 + this.state.orientation.y * t;
         orientation.z = this.§_-U3§.orientation.z * t1 + this.state.orientation.z * t;
      }
      
      public function interpolateSLERP(t:Number, pos:Vector3, orientation:Quaternion) : void
      {
         var t1:Number = NaN;
         t1 = 1 - t;
         pos.x = this.§_-U3§.position.x * t1 + this.state.position.x * t;
         pos.y = this.§_-U3§.position.y * t1 + this.state.position.y * t;
         pos.z = this.§_-U3§.position.z * t1 + this.state.position.z * t;
         orientation.slerp(this.§_-U3§.orientation,this.state.orientation,t);
      }
      
      public function interpolateToMatrix(t:Number, m:Matrix4) : void
      {
         var t1:Number = NaN;
         t1 = 1 - t;
         m.d = this.§_-U3§.position.x * t1 + this.state.position.x * t;
         m.h = this.§_-U3§.position.y * t1 + this.state.position.y * t;
         m.l = this.§_-U3§.position.z * t1 + this.state.position.z * t;
         _q.w = this.§_-U3§.orientation.w * t1 + this.state.orientation.w * t;
         _q.x = this.§_-U3§.orientation.x * t1 + this.state.orientation.x * t;
         _q.y = this.§_-U3§.orientation.y * t1 + this.state.orientation.y * t;
         _q.z = this.§_-U3§.orientation.z * t1 + this.state.orientation.z * t;
         _q.normalize();
         _q.toMatrix4(m);
      }
      
      public function interpolateToMatrixSLERP(t:Number, m:Matrix4) : void
      {
         var t1:Number = 1 - t;
         m.d = this.§_-U3§.position.x * t1 + this.state.position.x * t;
         m.h = this.§_-U3§.position.y * t1 + this.state.position.y * t;
         m.l = this.§_-U3§.position.z * t1 + this.state.position.z * t;
         _q.slerp(this.§_-U3§.orientation,this.state.orientation,t);
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
         this.state.rotation.x += this.§_-nX§.a * x + this.§_-nX§.b * y + this.§_-nX§.c * z;
         this.state.rotation.y += this.§_-nX§.e * x + this.§_-nX§.f * y + this.§_-nX§.g * z;
         this.state.rotation.z += this.§_-nX§.i * x + this.§_-nX§.j * y + this.§_-nX§.k * z;
      }
      
      public function addForce(f:Vector3) : void
      {
         this.§_-iu§.add(f);
      }
      
      public function addForceXYZ(fx:Number, fy:Number, fz:Number) : void
      {
         this.§_-iu§.x += fx;
         this.§_-iu§.y += fy;
         this.§_-iu§.z += fz;
      }
      
      public function addWorldForceXYZ(px:Number, py:Number, pz:Number, fx:Number, fy:Number, fz:Number) : void
      {
         var rx:Number = NaN;
         this.§_-iu§.x += fx;
         this.§_-iu§.y += fy;
         this.§_-iu§.z += fz;
         var pos:Vector3 = this.state.position;
         rx = px - pos.x;
         var ry:Number = py - pos.y;
         var rz:Number = pz - pos.z;
         this.§_-Xr§.x += ry * fz - rz * fy;
         this.§_-Xr§.y += rz * fx - rx * fz;
         this.§_-Xr§.z += rx * fy - ry * fx;
      }
      
      public function addWorldForce(pos:Vector3, force:Vector3) : void
      {
         this.§_-iu§.add(force);
         this.§_-Xr§.add(_r.diff(pos,this.state.position).cross(force));
      }
      
      public function addWorldForceScaled(pos:Vector3, force:Vector3, scale:Number) : void
      {
         _f.x = scale * force.x;
         _f.y = scale * force.y;
         _f.z = scale * force.z;
         this.§_-iu§.add(_f);
         this.§_-Xr§.add(_r.diff(pos,this.state.position).cross(_f));
      }
      
      public function addLocalForce(pos:Vector3, force:Vector3) : void
      {
         this.baseMatrix.transformVector(pos,_r);
         this.baseMatrix.transformVector(force,_f);
         this.§_-iu§.add(_f);
         this.§_-Xr§.add(_r.cross(_f));
      }
      
      public function addWorldForceAtLocalPoint(localPos:Vector3, worldForce:Vector3) : void
      {
         this.baseMatrix.transformVector(localPos,_r);
         this.§_-iu§.add(worldForce);
         this.§_-Xr§.add(_r.cross(worldForce));
      }
      
      public function addTorque(t:Vector3) : void
      {
         this.§_-Xr§.add(t);
      }
      
      internal function clearAccumulators() : void
      {
         this.§_-iu§.x = this.§_-iu§.y = this.§_-iu§.z = 0;
         this.§_-Xr§.x = this.§_-Xr§.y = this.§_-Xr§.z = 0;
      }
      
      internal function calcAccelerations() : void
      {
         this.§_-1G§.x = this.§_-iu§.x * this.invMass;
         this.§_-1G§.y = this.§_-iu§.y * this.invMass;
         this.§_-1G§.z = this.§_-iu§.z * this.invMass;
         this.§_-fR§.x = this.§_-nX§.a * this.§_-Xr§.x + this.§_-nX§.b * this.§_-Xr§.y + this.§_-nX§.c * this.§_-Xr§.z;
         this.§_-fR§.y = this.§_-nX§.e * this.§_-Xr§.x + this.§_-nX§.f * this.§_-Xr§.y + this.§_-nX§.g * this.§_-Xr§.z;
         this.§_-fR§.z = this.§_-nX§.i * this.§_-Xr§.x + this.§_-nX§.j * this.§_-Xr§.y + this.§_-nX§.k * this.§_-Xr§.z;
      }
      
      public function calcDerivedData() : void
      {
         var item:CollisionPrimitiveListItem = null;
         var primitive:CollisionPrimitive = null;
         this.state.orientation.toMatrix3(this.baseMatrix);
         this.§_-nX§.copy(this.invInertia).append(this.baseMatrix).prependTransposed(this.baseMatrix);
         if(this.collisionPrimitives != null)
         {
            this.aabb.§_-GT§();
            for(item = this.collisionPrimitives.head; item != null; )
            {
               primitive = item.primitive;
               primitive.transform.setFromMatrix3(this.baseMatrix,this.state.position);
               if(primitive.localTransform != null)
               {
                  primitive.transform.prepend(primitive.localTransform);
               }
               primitive.calculateAABB();
               this.aabb.§_-EH§(primitive.aabb);
               item = item.next;
            }
         }
      }
      
      public function saveState() : void
      {
         this.§_-U3§.copy(this.state);
      }
      
      internal function restoreState() : void
      {
         this.state.copy(this.§_-U3§);
      }
      
      internal function integrateVelocity(dt:Number) : void
      {
         this.state.velocity.x += this.§_-1G§.x * dt;
         this.state.velocity.y += this.§_-1G§.y * dt;
         this.state.velocity.z += this.§_-1G§.z * dt;
         this.state.rotation.x += this.§_-fR§.x * dt;
         this.state.rotation.y += this.§_-fR§.y * dt;
         this.state.rotation.z += this.§_-fR§.z * dt;
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

