package alternativa.physics
{
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.physics.collision.ICollisionDetector;
   import alternativa.physics.collision.KdTreeCollisionDetector;
   import alternativa.physics.constraints.Constraint;
   
   public class PhysicsScene
   {
      private static var lastBodyId:int;
      
      public const §_-ga§:int = 1000;
      
      public var §_-kv§:int = 10;
      
      public var §_-YB§:Number = 0.1;
      
      public var dynamic:Number = 0.5;
      
      public var §_-Yi§:int = 5;
      
      public var §_-2I§:int = 5;
      
      public var §_-06§:Boolean = false;
      
      public var §_-Y6§:int = 10;
      
      public var §_-cc§:Number = 1;
      
      public var §_-GG§:Number = 0.01;
      
      public var §_-MX§:Vector3 = new Vector3(0,0,-9.8);
      
      public var §_-fz§:Number = 9.8;
      
      public var collisionDetector:ICollisionDetector;
      
      public var §_-By§:BodyList = new BodyList();
      
      public var contacts:Contact;
      
      public var §_-7e§:Vector.<Constraint> = new Vector.<Constraint>();
      
      public var §_-0v§:int;
      
      public var §_-hA§:int;
      
      public var time:int;
      
      private var §_-lh§:Contact;
      
      private var §_-MN§:Vector3 = new Vector3();
      
      private var _v:Vector3 = new Vector3();
      
      public function PhysicsScene()
      {
         super();
         this.contacts = new Contact(0);
         var contact:Contact = this.contacts;
         for(var i:int = 1; i < this.§_-ga§; i++)
         {
            contact.next = new Contact(i);
            contact = contact.next;
         }
         this.collisionDetector = new KdTreeCollisionDetector();
      }
      
      public function get gravity() : Vector3
      {
         return this.§_-MX§.clone();
      }
      
      public function set gravity(value:Vector3) : void
      {
         this.§_-MX§.copy(value);
         this.§_-fz§ = this.§_-MX§.length();
      }
      
      public function addBody(body:Body) : void
      {
         body.id = lastBodyId++;
         body.scene = this;
         this.§_-By§.append(body);
      }
      
      public function removeBody(body:Body) : void
      {
         if(this.§_-By§.remove(body))
         {
            body.scene = null;
         }
      }
      
      public function addConstraint(c:Constraint) : void
      {
         var _loc2_:* = this.§_-0v§++;
         this.§_-7e§[_loc2_] = c;
         c.world = this;
      }
      
      public function removeConstraint(c:Constraint) : Boolean
      {
         var idx:int = int(this.§_-7e§.indexOf(c));
         if(idx < 0)
         {
            return false;
         }
         this.§_-7e§.splice(idx,1);
         --this.§_-0v§;
         c.world = null;
         return true;
      }
      
      private function applyForces(dt:Number) : void
      {
         var body:Body = null;
         for(var item:BodyListItem = this.§_-By§.head; item != null; )
         {
            body = item.body;
            body.calcAccelerations();
            if(body.§_-fA§ && body.§_-Sb§ && !body.§_-N0§)
            {
               body.§_-1G§.x += this.§_-MX§.x;
               body.§_-1G§.y += this.§_-MX§.y;
               body.§_-1G§.z += this.§_-MX§.z;
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
         for(var item:BodyListItem = this.§_-By§.head; item != null; )
         {
            body = item.body;
            if(!body.§_-N0§)
            {
               body.saveState();
               if(this.§_-06§)
               {
                  body.integrateVelocity(dt);
                  body.integratePosition(dt);
               }
               body.calcDerivedData();
            }
            item = item.next;
         }
         this.§_-lh§ = this.collisionDetector.getAllContacts(this.contacts);
         for(var contact:Contact = this.contacts; contact != this.§_-lh§; )
         {
            b1 = contact.body1;
            b2 = contact.body2;
            for(j = 0; j < contact.§_-P3§; )
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
         if(this.§_-06§)
         {
            for(item = this.§_-By§.head; item != null; )
            {
               body = item.body;
               if(!body.§_-N0§)
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
         for(var contact:Contact = this.contacts; contact != this.§_-lh§; )
         {
            b1 = contact.body1;
            b2 = contact.body2;
            if(b1.§_-N0§)
            {
               b1.§_-N0§ = false;
               b1.§_-ia§ = 0;
            }
            if(b2 != null && b2.§_-N0§)
            {
               b2.§_-N0§ = false;
               b2.§_-ia§ = 0;
            }
            contact.§_-Pe§ = b1.material.§_-Pe§;
            if(b2 != null && b2.material.§_-Pe§ < contact.§_-Pe§)
            {
               contact.§_-Pe§ = b2.material.§_-Pe§;
            }
            contact.§_-J1§ = b1.material.§_-J1§;
            if(b2 != null && b2.material.§_-J1§ < contact.§_-J1§)
            {
               contact.§_-J1§ = b2.material.§_-J1§;
            }
            for(j = 0; j < contact.§_-P3§; )
            {
               cp = contact.points[j];
               cp.§_-Dv§ = 0;
               cp.§_-DS§ = 0;
               if(b1.§_-Sb§)
               {
                  cp.angularInertia1 = this._v.cross2(cp.r1,contact.normal).transform3(b1.§_-nX§).cross(cp.r1).dot(contact.normal);
                  cp.§_-DS§ += b1.invMass + cp.angularInertia1;
               }
               if(b2 != null && b2.§_-Sb§)
               {
                  cp.angularInertia2 = this._v.cross2(cp.r2,contact.normal).transform3(b2.§_-nX§).cross(cp.r2).dot(contact.normal);
                  cp.§_-DS§ += b2.invMass + cp.angularInertia2;
               }
               this.calcSepVelocity(b1,b2,cp,this._v);
               cp.§_-0C§ = this._v.dot(contact.normal);
               if(cp.§_-0C§ < 0)
               {
                  cp.§_-0C§ = -contact.§_-Pe§ * cp.§_-0C§;
               }
               cp.§_-A-§ = cp.penetration > this.§_-YB§ ? (cp.penetration - this.§_-YB§) / (this.§_-kv§ * dt) : 0;
               if(cp.§_-A-§ > this.dynamic)
               {
                  cp.§_-A-§ = this.dynamic;
               }
               j++;
            }
            contact = contact.next;
         }
         for(var i:int = 0; i < this.§_-0v§; i++)
         {
            constraint = this.§_-7e§[i];
            constraint.preProcess(dt);
         }
      }
      
      private function processContacts(dt:Number, forceInelastic:Boolean) : void
      {
         var i:int = 0;
         var contact:Contact = null;
         var constraint:Constraint = null;
         var iterNum:int = forceInelastic ? this.§_-2I§ : this.§_-Yi§;
         var forwardLoop:Boolean = false;
         for(var iter:int = 0; iter < iterNum; iter++)
         {
            forwardLoop = !forwardLoop;
            for(contact = this.contacts; contact != this.§_-lh§; )
            {
               this.resolveContact(contact,forceInelastic,forwardLoop);
               contact = contact.next;
            }
            for(i = 0; i < this.§_-0v§; i++)
            {
               constraint = this.§_-7e§[i];
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
            for(i = 0; i < contactInfo.§_-P3§; this.resolveContactPoint(i,b1,b2,contactInfo,normal,forceInelastic),i++)
            {
            }
         }
         else
         {
            for(i = contactInfo.§_-P3§ - 1; i >= 0; this.resolveContactPoint(i,b1,b2,contactInfo,normal,forceInelastic),i--)
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
            cp.§_-CV§ = true;
         }
         var newVel:Number = 0;
         this.calcSepVelocity(b1,b2,cp,this._v);
         var cnormal:Vector3 = contact.normal;
         var sepVel:Number = this._v.x * cnormal.x + this._v.y * cnormal.y + this._v.z * cnormal.z;
         if(forceInelastic)
         {
            minSpeVel = cp.§_-A-§;
            if(sepVel < minSpeVel)
            {
               cp.§_-CV§ = false;
            }
            else if(cp.§_-CV§)
            {
               return;
            }
            newVel = minSpeVel;
         }
         else
         {
            newVel = cp.§_-0C§;
         }
         var deltaVel:Number = newVel - sepVel;
         var impulse:Number = deltaVel / cp.§_-DS§;
         var accumImpulse:Number = cp.§_-Dv§ + impulse;
         if(accumImpulse < 0)
         {
            accumImpulse = 0;
         }
         var deltaImpulse:Number = accumImpulse - cp.§_-Dv§;
         cp.§_-Dv§ = accumImpulse;
         if(b1.§_-Sb§)
         {
            b1.applyRelPosWorldImpulse(cp.r1,normal,deltaImpulse);
         }
         if(b2 != null && b2.§_-Sb§)
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
         this.§_-MN§.x = -this._v.x;
         this.§_-MN§.y = -this._v.y;
         this.§_-MN§.z = -this._v.z;
         this.§_-MN§.normalize();
         if(b1.§_-Sb§)
         {
            r = cp.r1;
            m = b1.§_-nX§;
            this._v.x = r.y * this.§_-MN§.z - r.z * this.§_-MN§.y;
            this._v.y = r.z * this.§_-MN§.x - r.x * this.§_-MN§.z;
            this._v.z = r.x * this.§_-MN§.y - r.y * this.§_-MN§.x;
            xx = m.a * this._v.x + m.b * this._v.y + m.c * this._v.z;
            yy = m.e * this._v.x + m.f * this._v.y + m.g * this._v.z;
            zz = m.i * this._v.x + m.j * this._v.y + m.k * this._v.z;
            this._v.x = yy * r.z - zz * r.y;
            this._v.y = zz * r.x - xx * r.z;
            this._v.z = xx * r.y - yy * r.x;
            tanSpeedByUnitImpulse += b1.invMass + this._v.x * this.§_-MN§.x + this._v.y * this.§_-MN§.y + this._v.z * this.§_-MN§.z;
         }
         if(b2 != null && b2.§_-Sb§)
         {
            r = cp.r2;
            m = b2.§_-nX§;
            this._v.x = r.y * this.§_-MN§.z - r.z * this.§_-MN§.y;
            this._v.y = r.z * this.§_-MN§.x - r.x * this.§_-MN§.z;
            this._v.z = r.x * this.§_-MN§.y - r.y * this.§_-MN§.x;
            xx = m.a * this._v.x + m.b * this._v.y + m.c * this._v.z;
            yy = m.e * this._v.x + m.f * this._v.y + m.g * this._v.z;
            zz = m.i * this._v.x + m.j * this._v.y + m.k * this._v.z;
            this._v.x = yy * r.z - zz * r.y;
            this._v.y = zz * r.x - xx * r.z;
            this._v.z = xx * r.y - yy * r.x;
            tanSpeedByUnitImpulse += b2.invMass + this._v.x * this.§_-MN§.x + this._v.y * this.§_-MN§.y + this._v.z * this.§_-MN§.z;
         }
         var tanImpulse:Number = tanSpeed / tanSpeedByUnitImpulse;
         var max:Number = contact.§_-J1§ * cp.§_-Dv§;
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
         if(b1.§_-Sb§)
         {
            b1.applyRelPosWorldImpulse(cp.r1,this.§_-MN§,tanImpulse);
         }
         if(b2 != null && b2.§_-Sb§)
         {
            b2.applyRelPosWorldImpulse(cp.r2,this.§_-MN§,-tanImpulse);
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
         for(var item:BodyListItem = this.§_-By§.head; item != null; )
         {
            item.body.integrateVelocity(dt);
            item = item.next;
         }
      }
      
      private function integratePositions(dt:Number) : void
      {
         var body:Body = null;
         for(var item:BodyListItem = this.§_-By§.head; item != null; )
         {
            body = item.body;
            if(body.§_-Sb§ && !body.§_-N0§)
            {
               body.integratePosition(dt);
            }
            item = item.next;
         }
      }
      
      private function postPhysics() : void
      {
         var body:Body = null;
         for(var item:BodyListItem = this.§_-By§.head; item != null; )
         {
            body = item.body;
            body.clearAccumulators();
            body.calcDerivedData();
            if(body.§_-N4§)
            {
               if(body.state.velocity.length() < this.§_-cc§ && body.state.rotation.length() < this.§_-GG§)
               {
                  if(!body.§_-N0§)
                  {
                     ++body.§_-ia§;
                     if(body.§_-ia§ >= this.§_-Y6§)
                     {
                        body.§_-N0§ = true;
                     }
                  }
               }
               else
               {
                  body.§_-ia§ = 0;
                  body.§_-N0§ = false;
               }
            }
            item = item.next;
         }
      }
      
      public function update(delta:int) : void
      {
         ++this.§_-hA§;
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

