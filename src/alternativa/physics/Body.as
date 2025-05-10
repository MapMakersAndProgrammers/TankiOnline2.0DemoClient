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
      
      public var name_Sb:Boolean = true;
      
      public var name_N4:Boolean = false;
      
      public var name_ia:int;
      
      public var name_N0:Boolean = false;
      
      public var name_fA:Boolean = true;
      
      public var aabb:BoundBox = new BoundBox();
      
      public var postCollisionFilter:IBodyCollisionFilter;
      
      public var state:BodyState = new BodyState();
      
      public var name_U3:BodyState = new BodyState();
      
      public var name_1G:Vector3 = new Vector3();
      
      public var name_fR:Vector3 = new Vector3();
      
      public var material:BodyMaterial = new BodyMaterial();
      
      public var invMass:Number = 1;
      
      public var invInertia:Matrix3 = new Matrix3();
      
      public var name_nX:Matrix3 = new Matrix3();
      
      public var baseMatrix:Matrix3 = new Matrix3();
      
      public var collisionPrimitives:CollisionPrimitiveList;
      
      public var name_iu:Vector3 = new Vector3();
      
      public var name_Xr:Vector3 = new Vector3();
      
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
         pos.x = this.name_U3.position.x * t1 + this.state.position.x * t;
         pos.y = this.name_U3.position.y * t1 + this.state.position.y * t;
         pos.z = this.name_U3.position.z * t1 + this.state.position.z * t;
         orientation.w = this.name_U3.orientation.w * t1 + this.state.orientation.w * t;
         orientation.x = this.name_U3.orientation.x * t1 + this.state.orientation.x * t;
         orientation.y = this.name_U3.orientation.y * t1 + this.state.orientation.y * t;
         orientation.z = this.name_U3.orientation.z * t1 + this.state.orientation.z * t;
      }
      
      public function interpolateSLERP(t:Number, pos:Vector3, orientation:Quaternion) : void
      {
         var t1:Number = NaN;
         t1 = 1 - t;
         pos.x = this.name_U3.position.x * t1 + this.state.position.x * t;
         pos.y = this.name_U3.position.y * t1 + this.state.position.y * t;
         pos.z = this.name_U3.position.z * t1 + this.state.position.z * t;
         orientation.slerp(this.name_U3.orientation,this.state.orientation,t);
      }
      
      public function interpolateToMatrix(t:Number, m:Matrix4) : void
      {
         var t1:Number = NaN;
         t1 = 1 - t;
         m.d = this.name_U3.position.x * t1 + this.state.position.x * t;
         m.h = this.name_U3.position.y * t1 + this.state.position.y * t;
         m.l = this.name_U3.position.z * t1 + this.state.position.z * t;
         _q.w = this.name_U3.orientation.w * t1 + this.state.orientation.w * t;
         _q.x = this.name_U3.orientation.x * t1 + this.state.orientation.x * t;
         _q.y = this.name_U3.orientation.y * t1 + this.state.orientation.y * t;
         _q.z = this.name_U3.orientation.z * t1 + this.state.orientation.z * t;
         _q.normalize();
         _q.toMatrix4(m);
      }
      
      public function interpolateToMatrixSLERP(t:Number, m:Matrix4) : void
      {
         var t1:Number = 1 - t;
         m.d = this.name_U3.position.x * t1 + this.state.position.x * t;
         m.h = this.name_U3.position.y * t1 + this.state.position.y * t;
         m.l = this.name_U3.position.z * t1 + this.state.position.z * t;
         _q.slerp(this.name_U3.orientation,this.state.orientation,t);
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
         this.state.rotation.x += this.name_nX.a * x + this.name_nX.b * y + this.name_nX.c * z;
         this.state.rotation.y += this.name_nX.e * x + this.name_nX.f * y + this.name_nX.g * z;
         this.state.rotation.z += this.name_nX.i * x + this.name_nX.j * y + this.name_nX.k * z;
      }
      
      public function addForce(f:Vector3) : void
      {
         this.name_iu.add(f);
      }
      
      public function addForceXYZ(fx:Number, fy:Number, fz:Number) : void
      {
         this.name_iu.x += fx;
         this.name_iu.y += fy;
         this.name_iu.z += fz;
      }
      
      public function addWorldForceXYZ(px:Number, py:Number, pz:Number, fx:Number, fy:Number, fz:Number) : void
      {
         var rx:Number = NaN;
         this.name_iu.x += fx;
         this.name_iu.y += fy;
         this.name_iu.z += fz;
         var pos:Vector3 = this.state.position;
         rx = px - pos.x;
         var ry:Number = py - pos.y;
         var rz:Number = pz - pos.z;
         this.name_Xr.x += ry * fz - rz * fy;
         this.name_Xr.y += rz * fx - rx * fz;
         this.name_Xr.z += rx * fy - ry * fx;
      }
      
      public function addWorldForce(pos:Vector3, force:Vector3) : void
      {
         this.name_iu.add(force);
         this.name_Xr.add(_r.diff(pos,this.state.position).cross(force));
      }
      
      public function addWorldForceScaled(pos:Vector3, force:Vector3, scale:Number) : void
      {
         _f.x = scale * force.x;
         _f.y = scale * force.y;
         _f.z = scale * force.z;
         this.name_iu.add(_f);
         this.name_Xr.add(_r.diff(pos,this.state.position).cross(_f));
      }
      
      public function addLocalForce(pos:Vector3, force:Vector3) : void
      {
         this.baseMatrix.transformVector(pos,_r);
         this.baseMatrix.transformVector(force,_f);
         this.name_iu.add(_f);
         this.name_Xr.add(_r.cross(_f));
      }
      
      public function addWorldForceAtLocalPoint(localPos:Vector3, worldForce:Vector3) : void
      {
         this.baseMatrix.transformVector(localPos,_r);
         this.name_iu.add(worldForce);
         this.name_Xr.add(_r.cross(worldForce));
      }
      
      public function addTorque(t:Vector3) : void
      {
         this.name_Xr.add(t);
      }
      
      internal function clearAccumulators() : void
      {
         this.name_iu.x = this.name_iu.y = this.name_iu.z = 0;
         this.name_Xr.x = this.name_Xr.y = this.name_Xr.z = 0;
      }
      
      internal function calcAccelerations() : void
      {
         this.name_1G.x = this.name_iu.x * this.invMass;
         this.name_1G.y = this.name_iu.y * this.invMass;
         this.name_1G.z = this.name_iu.z * this.invMass;
         this.name_fR.x = this.name_nX.a * this.name_Xr.x + this.name_nX.b * this.name_Xr.y + this.name_nX.c * this.name_Xr.z;
         this.name_fR.y = this.name_nX.e * this.name_Xr.x + this.name_nX.f * this.name_Xr.y + this.name_nX.g * this.name_Xr.z;
         this.name_fR.z = this.name_nX.i * this.name_Xr.x + this.name_nX.j * this.name_Xr.y + this.name_nX.k * this.name_Xr.z;
      }
      
      public function calcDerivedData() : void
      {
         var item:CollisionPrimitiveListItem = null;
         var primitive:CollisionPrimitive = null;
         this.state.orientation.toMatrix3(this.baseMatrix);
         this.name_nX.copy(this.invInertia).append(this.baseMatrix).prependTransposed(this.baseMatrix);
         if(this.collisionPrimitives != null)
         {
            this.aabb.infinity();
            for(item = this.collisionPrimitives.head; item != null; )
            {
               primitive = item.primitive;
               primitive.transform.setFromMatrix3(this.baseMatrix,this.state.position);
               if(primitive.localTransform != null)
               {
                  primitive.transform.prepend(primitive.localTransform);
               }
               primitive.calculateAABB();
               this.aabb.addBoundBox(primitive.aabb);
               item = item.next;
            }
         }
      }
      
      public function saveState() : void
      {
         this.name_U3.copy(this.state);
      }
      
      internal function restoreState() : void
      {
         this.state.copy(this.name_U3);
      }
      
      internal function integrateVelocity(dt:Number) : void
      {
         this.state.velocity.x += this.name_1G.x * dt;
         this.state.velocity.y += this.name_1G.y * dt;
         this.state.velocity.z += this.name_1G.z * dt;
         this.state.rotation.x += this.name_fR.x * dt;
         this.state.rotation.y += this.name_fR.y * dt;
         this.state.rotation.z += this.name_fR.z * dt;
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

