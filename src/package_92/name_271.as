package package_92
{
   import package_46.Matrix3;
   import package_46.Matrix4;
   import package_46.name_194;
   import package_46.name_566;
   import package_76.name_235;
   import package_76.name_604;
   import package_90.name_386;
   
   public class name_271
   {
      public static var linDamping:Number = 0.997;
      
      public static var rotDamping:Number = 0.997;
      
      private static var _r:name_194 = new name_194();
      
      private static var _f:name_194 = new name_194();
      
      private static var _q:name_566 = new name_566();
      
      public var id:int;
      
      public var name:String;
      
      public var scene:name_467;
      
      public var var_499:Boolean = true;
      
      public var var_502:Boolean = false;
      
      public var var_498:int;
      
      public var var_501:Boolean = false;
      
      public var var_500:Boolean = true;
      
      public var aabb:name_386 = new name_386();
      
      public var postCollisionFilter:name_604;
      
      public var state:name_599 = new name_599();
      
      public var var_492:name_599 = new name_599();
      
      public var var_497:name_194 = new name_194();
      
      public var var_496:name_194 = new name_194();
      
      public var material:name_600 = new name_600();
      
      public var invMass:Number = 1;
      
      public var invInertia:Matrix3 = new Matrix3();
      
      public var var_495:Matrix3 = new Matrix3();
      
      public var baseMatrix:Matrix3 = new Matrix3();
      
      public var collisionPrimitives:name_601;
      
      public var var_494:name_194 = new name_194();
      
      public var var_493:name_194 = new name_194();
      
      public var data:Object;
      
      public function name_271(invMass:Number, invInertia:Matrix3)
      {
         super();
         this.invMass = invMass;
         this.invInertia.copy(invInertia);
      }
      
      public function name_580(primitive:name_235, localTransform:Matrix4 = null) : void
      {
         if(primitive == null)
         {
            throw new ArgumentError("Primitive cannot be null");
         }
         if(this.collisionPrimitives == null)
         {
            this.collisionPrimitives = new name_601();
         }
         this.collisionPrimitives.append(primitive);
         primitive.method_373(this,localTransform);
      }
      
      public function method_509(primitive:name_235) : void
      {
         if(this.collisionPrimitives == null)
         {
            return;
         }
         primitive.method_373(null);
         this.collisionPrimitives.remove(primitive);
         if(this.collisionPrimitives.size == 0)
         {
            this.collisionPrimitives = null;
         }
      }
      
      public function interpolate(t:Number, pos:name_194, orientation:name_566) : void
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
      
      public function method_515(t:Number, pos:name_194, orientation:name_566) : void
      {
         var t1:Number = NaN;
         t1 = 1 - t;
         pos.x = this.var_492.position.x * t1 + this.state.position.x * t;
         pos.y = this.var_492.position.y * t1 + this.state.position.y * t;
         pos.z = this.var_492.position.z * t1 + this.state.position.z * t;
         orientation.name_602(this.var_492.orientation,this.state.orientation,t);
      }
      
      public function method_517(t:Number, m:Matrix4) : void
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
      
      public function method_514(t:Number, m:Matrix4) : void
      {
         var t1:Number = 1 - t;
         m.d = this.var_492.position.x * t1 + this.state.position.x * t;
         m.h = this.var_492.position.y * t1 + this.state.position.y * t;
         m.l = this.var_492.position.z * t1 + this.state.position.z * t;
         _q.name_602(this.var_492.orientation,this.state.orientation,t);
         _q.normalize();
         _q.toMatrix4(m);
      }
      
      public function name_201(pos:name_194) : void
      {
         this.state.position.copy(pos);
      }
      
      public function name_75(x:Number, y:Number, z:Number) : void
      {
         this.state.position.reset(x,y,z);
      }
      
      public function name_587(vel:name_194) : void
      {
         this.state.velocity.copy(vel);
      }
      
      public function name_588(x:Number, y:Number, z:Number) : void
      {
         this.state.velocity.reset(x,y,z);
      }
      
      public function method_368(rot:name_194) : void
      {
         this.state.rotation.copy(rot);
      }
      
      public function name_332(x:Number, y:Number, z:Number) : void
      {
         this.state.rotation.reset(x,y,z);
      }
      
      public function name_352(q:name_566) : void
      {
         this.state.orientation.copy(q);
      }
      
      public function method_484(w:Number, x:Number, y:Number, z:Number) : void
      {
         this.state.orientation.reset(w,x,y,z);
      }
      
      public function method_518(r:name_194, dir:name_194, magnitude:Number) : void
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
      
      public function name_585(f:name_194) : void
      {
         this.var_494.add(f);
      }
      
      public function method_519(fx:Number, fy:Number, fz:Number) : void
      {
         this.var_494.x += fx;
         this.var_494.y += fy;
         this.var_494.z += fz;
      }
      
      public function method_507(px:Number, py:Number, pz:Number, fx:Number, fy:Number, fz:Number) : void
      {
         var rx:Number = NaN;
         this.var_494.x += fx;
         this.var_494.y += fy;
         this.var_494.z += fz;
         var pos:name_194 = this.state.position;
         rx = px - pos.x;
         var ry:Number = py - pos.y;
         var rz:Number = pz - pos.z;
         this.var_493.x += ry * fz - rz * fy;
         this.var_493.y += rz * fx - rx * fz;
         this.var_493.z += rx * fy - ry * fx;
      }
      
      public function name_525(pos:name_194, force:name_194) : void
      {
         this.var_494.add(force);
         this.var_493.add(_r.method_366(pos,this.state.position).method_360(force));
      }
      
      public function name_556(pos:name_194, force:name_194, scale:Number) : void
      {
         _f.x = scale * force.x;
         _f.y = scale * force.y;
         _f.z = scale * force.z;
         this.var_494.add(_f);
         this.var_493.add(_r.method_366(pos,this.state.position).method_360(_f));
      }
      
      public function method_516(pos:name_194, force:name_194) : void
      {
         this.baseMatrix.method_345(pos,_r);
         this.baseMatrix.method_345(force,_f);
         this.var_494.add(_f);
         this.var_493.add(_r.method_360(_f));
      }
      
      public function method_521(localPos:name_194, worldForce:name_194) : void
      {
         this.baseMatrix.method_345(localPos,_r);
         this.var_494.add(worldForce);
         this.var_493.add(_r.method_360(worldForce));
      }
      
      public function method_520(t:name_194) : void
      {
         this.var_493.add(t);
      }
      
      internal function method_513() : void
      {
         this.var_494.x = this.var_494.y = this.var_494.z = 0;
         this.var_493.x = this.var_493.y = this.var_493.z = 0;
      }
      
      internal function method_508() : void
      {
         this.var_497.x = this.var_494.x * this.invMass;
         this.var_497.y = this.var_494.y * this.invMass;
         this.var_497.z = this.var_494.z * this.invMass;
         this.var_496.x = this.var_495.a * this.var_493.x + this.var_495.b * this.var_493.y + this.var_495.c * this.var_493.z;
         this.var_496.y = this.var_495.e * this.var_493.x + this.var_495.f * this.var_493.y + this.var_495.g * this.var_493.z;
         this.var_496.z = this.var_495.i * this.var_493.x + this.var_495.j * this.var_493.y + this.var_495.k * this.var_493.z;
      }
      
      public function method_512() : void
      {
         var item:name_513 = null;
         var primitive:name_235 = null;
         this.state.orientation.toMatrix3(this.baseMatrix);
         this.var_495.copy(this.invInertia).append(this.baseMatrix).method_348(this.baseMatrix);
         if(this.collisionPrimitives != null)
         {
            this.aabb.name_584();
            for(item = this.collisionPrimitives.head; item != null; )
            {
               primitive = item.primitive;
               primitive.transform.method_350(this.baseMatrix,this.state.position);
               if(primitive.localTransform != null)
               {
                  primitive.transform.prepend(primitive.localTransform);
               }
               primitive.calculateAABB();
               this.aabb.name_583(primitive.aabb);
               item = item.next;
            }
         }
      }
      
      public function name_586() : void
      {
         this.var_492.copy(this.state);
      }
      
      internal function method_506() : void
      {
         this.state.copy(this.var_492);
      }
      
      internal function method_510(dt:Number) : void
      {
         this.state.velocity.x += this.var_497.x * dt;
         this.state.velocity.y += this.var_497.y * dt;
         this.state.velocity.z += this.var_497.z * dt;
         this.state.rotation.x += this.var_496.x * dt;
         this.state.rotation.y += this.var_496.y * dt;
         this.state.rotation.z += this.var_496.z * dt;
         this.state.velocity.x *= linDamping;
         this.state.velocity.y *= linDamping;
         this.state.velocity.z *= linDamping;
         this.state.rotation.x *= rotDamping;
         this.state.rotation.y *= rotDamping;
         this.state.rotation.z *= rotDamping;
      }
      
      internal function method_511(dt:Number) : void
      {
         this.state.position.x += this.state.velocity.x * dt;
         this.state.position.y += this.state.velocity.y * dt;
         this.state.position.z += this.state.velocity.z * dt;
         this.state.orientation.name_603(this.state.rotation,dt);
      }
   }
}

