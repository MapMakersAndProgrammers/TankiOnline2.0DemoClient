package alternativa.physics
{
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.physics.collision.ICollisionDetector;
   import alternativa.physics.collision.name_508;
   import alternativa.physics.constraints.Constraint;
   
   public class PhysicsScene
   {
      private static var lastBodyId:int;
      
      public const const_2:int = 1000;
      
      public var var_608:int = 10;
      
      public var name_360:Number = 0.1;
      
      public var name_365:Number = 0.5;
      
      public var var_605:int = 5;
      
      public var var_602:int = 5;
      
      public var name_366:Boolean = false;
      
      public var var_604:int = 10;
      
      public var var_606:Number = 1;
      
      public var var_603:Number = 0.01;
      
      public var name_403:Vector3 = new Vector3(0,0,-9.8);
      
      public var var_607:Number = 9.8;
      
      public var collisionDetector:ICollisionDetector;
      
      public var name_438:BodyList = new BodyList();
      
      public var contacts:Contact;
      
      public var var_599:Vector.<Constraint> = new Vector.<Constraint>();
      
      public var var_598:int;
      
      public var var_601:int;
      
      public var time:int;
      
      private var var_600:Contact;
      
      private var var_597:Vector3 = new Vector3();
      
      private var _v:Vector3 = new Vector3();
      
      public function PhysicsScene()
      {
         super();
         this.contacts = new Contact(0);
         var contact:Contact = this.contacts;
         for(var i:int = 1; i < this.const_2; i++)
         {
            contact.next = new Contact(i);
            contact = contact.next;
         }
         this.collisionDetector = new name_508();
      }
      
      public function get gravity() : Vector3
      {
         return this.name_403.clone();
      }
      
      public function set gravity(value:Vector3) : void
      {
         this.name_403.copy(value);
         this.var_607 = this.name_403.length();
      }
      
      public function addBody(body:Body) : void
      {
         body.id = lastBodyId++;
         body.scene = this;
         this.name_438.append(body);
      }
      
      public function removeBody(body:Body) : void
      {
         if(this.name_438.remove(body))
         {
            body.scene = null;
         }
      }
      
      public function addConstraint(c:Constraint) : void
      {
         var _loc2_:* = this.var_598++;
         this.var_599[_loc2_] = c;
         c.world = this;
      }
      
      public function removeConstraint(c:Constraint) : Boolean
      {
         var idx:int = int(this.var_599.indexOf(c));
         if(idx < 0)
         {
            return false;
         }
         this.var_599.splice(idx,1);
         --this.var_598;
         c.world = null;
         return true;
      }
      
      private function applyForces(dt:Number) : void
      {
         var body:Body = null;
         for(var item:BodyListItem = this.name_438.head; item != null; )
         {
            body = item.body;
            body.calcAccelerations();
            if(body.var_501 && body.var_500 && !body.var_498)
            {
               body.var_496.x += this.name_403.x;
               body.var_496.y += this.name_403.y;
               body.var_496.z += this.name_403.z;
            }
            item = item.next;
         }
      }
      
      private function detectCollisions(dt:Number) : void
      {
         var body:Body = null;
         var b1:Body = null;
         var b2:Body = null;
         var j:int = 0;
         var cp:ContactPoint = null;
         var bPos:Vector3 = null;
         for(var item:BodyListItem = this.name_438.head; item != null; )
         {
            body = item.body;
            if(!body.var_498)
            {
               body.saveState();
               if(this.name_366)
               {
                  body.integrateVelocity(dt);
                  body.integratePosition(dt);
               }
               body.calcDerivedData();
            }
            item = item.next;
         }
         this.var_600 = this.collisionDetector.getAllContacts(this.contacts);
         for(var contact:Contact = this.contacts; contact != this.var_600; )
         {
            b1 = contact.body1;
            b2 = contact.body2;
            for(j = 0; j < contact.name_506; )
            {
               cp = contact.points[j];
               bPos = b1.state.position;
               cp.r1.x = cp.pos.x - bPos.x;
               cp.r1.y = cp.pos.y - bPos.y;
               cp.r1.z = cp.pos.z - bPos.z;
               if(b2 != null)
               {
                  bPos = b2.state.position;
                  cp.r2.x = cp.pos.x - bPos.x;
                  cp.r2.y = cp.pos.y - bPos.y;
                  cp.r2.z = cp.pos.z - bPos.z;
               }
               j++;
            }
            contact = contact.next;
         }
         if(this.name_366)
         {
            for(item = this.name_438.head; item != null; )
            {
               body = item.body;
               if(!body.var_498)
               {
                  body.restoreState();
                  body.calcDerivedData();
               }
               item = item.next;
            }
         }
      }
      
      private function preProcessContacts(dt:Number) : void
      {
         var b1:Body = null;
         var b2:Body = null;
         var j:int = 0;
         var cp:ContactPoint = null;
         var constraint:Constraint = null;
         for(var contact:Contact = this.contacts; contact != this.var_600; )
         {
            b1 = contact.body1;
            b2 = contact.body2;
            if(b1.var_498)
            {
               b1.var_498 = false;
               b1.var_502 = 0;
            }
            if(b2 != null && b2.var_498)
            {
               b2.var_498 = false;
               b2.var_502 = 0;
            }
            contact.name_501 = b1.material.name_501;
            if(b2 != null && b2.material.name_501 < contact.name_501)
            {
               contact.name_501 = b2.material.name_501;
            }
            contact.name_422 = b1.material.name_422;
            if(b2 != null && b2.material.name_422 < contact.name_422)
            {
               contact.name_422 = b2.material.name_422;
            }
            for(j = 0; j < contact.name_506; )
            {
               cp = contact.points[j];
               cp.name_504 = 0;
               cp.name_502 = 0;
               if(b1.var_500)
               {
                  cp.angularInertia1 = this._v.cross2(cp.r1,contact.normal).transform3(b1.var_495).cross(cp.r1).dot(contact.normal);
                  cp.name_502 += b1.invMass + cp.angularInertia1;
               }
               if(b2 != null && b2.var_500)
               {
                  cp.angularInertia2 = this._v.cross2(cp.r2,contact.normal).transform3(b2.var_495).cross(cp.r2).dot(contact.normal);
                  cp.name_502 += b2.invMass + cp.angularInertia2;
               }
               this.calcSepVelocity(b1,b2,cp,this._v);
               cp.name_503 = this._v.dot(contact.normal);
               if(cp.name_503 < 0)
               {
                  cp.name_503 = -contact.name_501 * cp.name_503;
               }
               cp.name_505 = cp.penetration > this.name_360 ? (cp.penetration - this.name_360) / (this.var_608 * dt) : 0;
               if(cp.name_505 > this.name_365)
               {
                  cp.name_505 = this.name_365;
               }
               j++;
            }
            contact = contact.next;
         }
         for(var i:int = 0; i < this.var_598; i++)
         {
            constraint = this.var_599[i];
            constraint.preProcess(dt);
         }
      }
      
      private function processContacts(dt:Number, forceInelastic:Boolean) : void
      {
         var i:int = 0;
         var contact:Contact = null;
         var constraint:Constraint = null;
         var iterNum:int = forceInelastic ? this.var_602 : this.var_605;
         var forwardLoop:Boolean = false;
         for(var iter:int = 0; iter < iterNum; iter++)
         {
            forwardLoop = !forwardLoop;
            for(contact = this.contacts; contact != this.var_600; )
            {
               this.resolveContact(contact,forceInelastic,forwardLoop);
               contact = contact.next;
            }
            for(i = 0; i < this.var_598; i++)
            {
               constraint = this.var_599[i];
               constraint.apply(dt);
            }
         }
      }
      
      private function resolveContact(contactInfo:Contact, forceInelastic:Boolean, forwardLoop:Boolean) : void
      {
         var i:int = 0;
         var b1:Body = contactInfo.body1;
         var b2:Body = contactInfo.body2;
         var normal:Vector3 = contactInfo.normal;
         if(forwardLoop)
         {
            for(i = 0; i < contactInfo.name_506; this.resolveContactPoint(i,b1,b2,contactInfo,normal,forceInelastic),i++)
            {
            }
         }
         else
         {
            for(i = contactInfo.name_506 - 1; i >= 0; this.resolveContactPoint(i,b1,b2,contactInfo,normal,forceInelastic),i--)
            {
            }
         }
      }
      
      private function resolveContactPoint(idx:int, b1:Body, b2:Body, contact:Contact, normal:Vector3, forceInelastic:Boolean) : void
      {
         var r:Vector3 = null;
         var m:Matrix3 = null;
         var xx:Number = NaN;
         var yy:Number = NaN;
         var zz:Number = NaN;
         var minSpeVel:Number = NaN;
         var cp:ContactPoint = contact.points[idx];
         if(!forceInelastic)
         {
            cp.name_507 = true;
         }
         var newVel:Number = 0;
         this.calcSepVelocity(b1,b2,cp,this._v);
         var cnormal:Vector3 = contact.normal;
         var sepVel:Number = this._v.x * cnormal.x + this._v.y * cnormal.y + this._v.z * cnormal.z;
         if(forceInelastic)
         {
            minSpeVel = cp.name_505;
            if(sepVel < minSpeVel)
            {
               cp.name_507 = false;
            }
            else if(cp.name_507)
            {
               return;
            }
            newVel = minSpeVel;
         }
         else
         {
            newVel = cp.name_503;
         }
         var deltaVel:Number = newVel - sepVel;
         var impulse:Number = deltaVel / cp.name_502;
         var accumImpulse:Number = cp.name_504 + impulse;
         if(accumImpulse < 0)
         {
            accumImpulse = 0;
         }
         var deltaImpulse:Number = accumImpulse - cp.name_504;
         cp.name_504 = accumImpulse;
         if(b1.var_500)
         {
            b1.applyRelPosWorldImpulse(cp.r1,normal,deltaImpulse);
         }
         if(b2 != null && b2.var_500)
         {
            b2.applyRelPosWorldImpulse(cp.r2,normal,-deltaImpulse);
         }
         this.calcSepVelocity(b1,b2,cp,this._v);
         var tanSpeedByUnitImpulse:Number = 0;
         var dot:Number = this._v.x * cnormal.x + this._v.y * cnormal.y + this._v.z * cnormal.z;
         this._v.x -= dot * cnormal.x;
         this._v.y -= dot * cnormal.y;
         this._v.z -= dot * cnormal.z;
         var tanSpeed:Number = this._v.length();
         if(tanSpeed < 0.001)
         {
            return;
         }
         this.var_597.x = -this._v.x;
         this.var_597.y = -this._v.y;
         this.var_597.z = -this._v.z;
         this.var_597.normalize();
         if(b1.var_500)
         {
            r = cp.r1;
            m = b1.var_495;
            this._v.x = r.y * this.var_597.z - r.z * this.var_597.y;
            this._v.y = r.z * this.var_597.x - r.x * this.var_597.z;
            this._v.z = r.x * this.var_597.y - r.y * this.var_597.x;
            xx = m.a * this._v.x + m.b * this._v.y + m.c * this._v.z;
            yy = m.e * this._v.x + m.f * this._v.y + m.g * this._v.z;
            zz = m.i * this._v.x + m.j * this._v.y + m.k * this._v.z;
            this._v.x = yy * r.z - zz * r.y;
            this._v.y = zz * r.x - xx * r.z;
            this._v.z = xx * r.y - yy * r.x;
            tanSpeedByUnitImpulse += b1.invMass + this._v.x * this.var_597.x + this._v.y * this.var_597.y + this._v.z * this.var_597.z;
         }
         if(b2 != null && b2.var_500)
         {
            r = cp.r2;
            m = b2.var_495;
            this._v.x = r.y * this.var_597.z - r.z * this.var_597.y;
            this._v.y = r.z * this.var_597.x - r.x * this.var_597.z;
            this._v.z = r.x * this.var_597.y - r.y * this.var_597.x;
            xx = m.a * this._v.x + m.b * this._v.y + m.c * this._v.z;
            yy = m.e * this._v.x + m.f * this._v.y + m.g * this._v.z;
            zz = m.i * this._v.x + m.j * this._v.y + m.k * this._v.z;
            this._v.x = yy * r.z - zz * r.y;
            this._v.y = zz * r.x - xx * r.z;
            this._v.z = xx * r.y - yy * r.x;
            tanSpeedByUnitImpulse += b2.invMass + this._v.x * this.var_597.x + this._v.y * this.var_597.y + this._v.z * this.var_597.z;
         }
         var tanImpulse:Number = tanSpeed / tanSpeedByUnitImpulse;
         var max:Number = contact.name_422 * cp.name_504;
         if(max < 0)
         {
            if(tanImpulse < max)
            {
               tanImpulse = max;
            }
         }
         else if(tanImpulse > max)
         {
            tanImpulse = max;
         }
         if(b1.var_500)
         {
            b1.applyRelPosWorldImpulse(cp.r1,this.var_597,tanImpulse);
         }
         if(b2 != null && b2.var_500)
         {
            b2.applyRelPosWorldImpulse(cp.r2,this.var_597,-tanImpulse);
         }
      }
      
      private function calcSepVelocity(body1:Body, body2:Body, cp:ContactPoint, result:Vector3) : void
      {
         var rot:Vector3 = body1.state.rotation;
         var v:Vector3 = cp.r1;
         var x:Number = rot.y * v.z - rot.z * v.y;
         var y:Number = rot.z * v.x - rot.x * v.z;
         var z:Number = rot.x * v.y - rot.y * v.x;
         v = body1.state.velocity;
         result.x = v.x + x;
         result.y = v.y + y;
         result.z = v.z + z;
         if(body2 != null)
         {
            rot = body2.state.rotation;
            v = cp.r2;
            x = rot.y * v.z - rot.z * v.y;
            y = rot.z * v.x - rot.x * v.z;
            z = rot.x * v.y - rot.y * v.x;
            v = body2.state.velocity;
            result.x -= v.x + x;
            result.y -= v.y + y;
            result.z -= v.z + z;
         }
      }
      
      private function intergateVelocities(dt:Number) : void
      {
         for(var item:BodyListItem = this.name_438.head; item != null; )
         {
            item.body.integrateVelocity(dt);
            item = item.next;
         }
      }
      
      private function integratePositions(dt:Number) : void
      {
         var body:Body = null;
         for(var item:BodyListItem = this.name_438.head; item != null; )
         {
            body = item.body;
            if(body.var_500 && !body.var_498)
            {
               body.integratePosition(dt);
            }
            item = item.next;
         }
      }
      
      private function postPhysics() : void
      {
         var body:Body = null;
         for(var item:BodyListItem = this.name_438.head; item != null; )
         {
            body = item.body;
            body.clearAccumulators();
            body.calcDerivedData();
            if(body.var_499)
            {
               if(body.state.velocity.length() < this.var_606 && body.state.rotation.length() < this.var_603)
               {
                  if(!body.var_498)
                  {
                     ++body.var_502;
                     if(body.var_502 >= this.var_604)
                     {
                        body.var_498 = true;
                     }
                  }
               }
               else
               {
                  body.var_502 = 0;
                  body.var_498 = false;
               }
            }
            item = item.next;
         }
      }
      
      public function update(delta:int) : void
      {
         ++this.var_601;
         this.time += delta;
         var dt:Number = 0.001 * delta;
         this.applyForces(dt);
         this.detectCollisions(dt);
         this.preProcessContacts(dt);
         this.processContacts(dt,false);
         this.intergateVelocities(dt);
         this.processContacts(dt,true);
         this.integratePositions(dt);
         this.postPhysics();
      }
   }
}

