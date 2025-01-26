package package_92
{
   import package_122.name_672;
   import package_46.Matrix3;
   import package_46.name_194;
   import package_76.name_256;
   import package_76.name_682;
   
   public class name_467
   {
      private static var lastBodyId:int;
      
      public const const_2:int = 1000;
      
      public var var_605:int = 10;
      
      public var name_471:Number = 0.1;
      
      public var name_474:Number = 0.5;
      
      public var var_608:int = 5;
      
      public var var_603:int = 5;
      
      public var name_475:Boolean = false;
      
      public var var_606:int = 10;
      
      public var var_604:Number = 1;
      
      public var var_607:Number = 0.01;
      
      public var name_567:name_194 = new name_194(0,0,-9.8);
      
      public var var_602:Number = 9.8;
      
      public var collisionDetector:name_256;
      
      public var name_605:name_681 = new name_681();
      
      public var contacts:name_630;
      
      public var var_599:Vector.<name_672> = new Vector.<name_672>();
      
      public var var_598:int;
      
      public var var_601:int;
      
      public var time:int;
      
      private var var_600:name_630;
      
      private var var_597:name_194 = new name_194();
      
      private var _v:name_194 = new name_194();
      
      public function name_467()
      {
         super();
         this.contacts = new name_630(0);
         var contact:name_630 = this.contacts;
         for(var i:int = 1; i < this.const_2; i++)
         {
            contact.next = new name_630(i);
            contact = contact.next;
         }
         this.collisionDetector = new name_682();
      }
      
      public function get gravity() : name_194
      {
         return this.name_567.clone();
      }
      
      public function set gravity(value:name_194) : void
      {
         this.name_567.copy(value);
         this.var_602 = this.name_567.length();
      }
      
      public function name_592(body:name_271) : void
      {
         body.id = lastBodyId++;
         body.scene = this;
         this.name_605.append(body);
      }
      
      public function name_593(body:name_271) : void
      {
         if(this.name_605.remove(body))
         {
            body.scene = null;
         }
      }
      
      public function method_679(c:name_672) : void
      {
         var _loc2_:* = this.var_598++;
         this.var_599[_loc2_] = c;
         c.world = this;
      }
      
      public function method_678(c:name_672) : Boolean
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
      
      private function method_676(dt:Number) : void
      {
         var body:name_271 = null;
         for(var item:name_671 = this.name_605.head; item != null; )
         {
            body = item.body;
            body.method_508();
            if(body.var_500 && body.var_499 && !body.var_501)
            {
               body.var_497.x += this.name_567.x;
               body.var_497.y += this.name_567.y;
               body.var_497.z += this.name_567.z;
            }
            item = item.next;
         }
      }
      
      private function method_673(dt:Number) : void
      {
         var body:name_271 = null;
         var b1:name_271 = null;
         var b2:name_271 = null;
         var j:int = 0;
         var cp:name_674 = null;
         var bPos:name_194 = null;
         for(var item:name_671 = this.name_605.head; item != null; )
         {
            body = item.body;
            if(!body.var_501)
            {
               body.name_586();
               if(this.name_475)
               {
                  body.method_510(dt);
                  body.method_511(dt);
               }
               body.method_512();
            }
            item = item.next;
         }
         this.var_600 = this.collisionDetector.method_553(this.contacts);
         for(var contact:name_630 = this.contacts; contact != this.var_600; )
         {
            b1 = contact.body1;
            b2 = contact.body2;
            for(j = 0; j < contact.name_679; )
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
         if(this.name_475)
         {
            for(item = this.name_605.head; item != null; )
            {
               body = item.body;
               if(!body.var_501)
               {
                  body.method_506();
                  body.method_512();
               }
               item = item.next;
            }
         }
      }
      
      private function method_671(dt:Number) : void
      {
         var b1:name_271 = null;
         var b2:name_271 = null;
         var j:int = 0;
         var cp:name_674 = null;
         var constraint:name_672 = null;
         for(var contact:name_630 = this.contacts; contact != this.var_600; )
         {
            b1 = contact.body1;
            b2 = contact.body2;
            if(b1.var_501)
            {
               b1.var_501 = false;
               b1.var_498 = 0;
            }
            if(b2 != null && b2.var_501)
            {
               b2.var_501 = false;
               b2.var_498 = 0;
            }
            contact.name_673 = b1.material.name_673;
            if(b2 != null && b2.material.name_673 < contact.name_673)
            {
               contact.name_673 = b2.material.name_673;
            }
            contact.name_581 = b1.material.name_581;
            if(b2 != null && b2.material.name_581 < contact.name_581)
            {
               contact.name_581 = b2.material.name_581;
            }
            for(j = 0; j < contact.name_679; )
            {
               cp = contact.points[j];
               cp.name_676 = 0;
               cp.name_675 = 0;
               if(b1.var_499)
               {
                  cp.angularInertia1 = this._v.cross2(cp.r1,contact.normal).transform3(b1.var_495).method_360(cp.r1).dot(contact.normal);
                  cp.name_675 += b1.invMass + cp.angularInertia1;
               }
               if(b2 != null && b2.var_499)
               {
                  cp.angularInertia2 = this._v.cross2(cp.r2,contact.normal).transform3(b2.var_495).method_360(cp.r2).dot(contact.normal);
                  cp.name_675 += b2.invMass + cp.angularInertia2;
               }
               this.method_668(b1,b2,cp,this._v);
               cp.name_677 = this._v.dot(contact.normal);
               if(cp.name_677 < 0)
               {
                  cp.name_677 = -contact.name_673 * cp.name_677;
               }
               cp.name_678 = cp.penetration > this.name_471 ? (cp.penetration - this.name_471) / (this.var_605 * dt) : 0;
               if(cp.name_678 > this.name_474)
               {
                  cp.name_678 = this.name_474;
               }
               j++;
            }
            contact = contact.next;
         }
         for(var i:int = 0; i < this.var_598; i++)
         {
            constraint = this.var_599[i];
            constraint.name_684(dt);
         }
      }
      
      private function method_669(dt:Number, forceInelastic:Boolean) : void
      {
         var i:int = 0;
         var contact:name_630 = null;
         var constraint:name_672 = null;
         var iterNum:int = forceInelastic ? this.var_603 : this.var_608;
         var forwardLoop:Boolean = false;
         for(var iter:int = 0; iter < iterNum; iter++)
         {
            forwardLoop = !forwardLoop;
            for(contact = this.contacts; contact != this.var_600; )
            {
               this.method_675(contact,forceInelastic,forwardLoop);
               contact = contact.next;
            }
            for(i = 0; i < this.var_598; i++)
            {
               constraint = this.var_599[i];
               constraint.name_683(dt);
            }
         }
      }
      
      private function method_675(contactInfo:name_630, forceInelastic:Boolean, forwardLoop:Boolean) : void
      {
         var i:int = 0;
         var b1:name_271 = contactInfo.body1;
         var b2:name_271 = contactInfo.body2;
         var normal:name_194 = contactInfo.normal;
         if(forwardLoop)
         {
            for(i = 0; i < contactInfo.name_679; this.method_670(i,b1,b2,contactInfo,normal,forceInelastic),i++)
            {
            }
         }
         else
         {
            for(i = contactInfo.name_679 - 1; i >= 0; this.method_670(i,b1,b2,contactInfo,normal,forceInelastic),i--)
            {
            }
         }
      }
      
      private function method_670(idx:int, b1:name_271, b2:name_271, contact:name_630, normal:name_194, forceInelastic:Boolean) : void
      {
         var r:name_194 = null;
         var m:Matrix3 = null;
         var xx:Number = NaN;
         var yy:Number = NaN;
         var zz:Number = NaN;
         var minSpeVel:Number = NaN;
         var cp:name_674 = contact.points[idx];
         if(!forceInelastic)
         {
            cp.name_680 = true;
         }
         var newVel:Number = 0;
         this.method_668(b1,b2,cp,this._v);
         var cnormal:name_194 = contact.normal;
         var sepVel:Number = this._v.x * cnormal.x + this._v.y * cnormal.y + this._v.z * cnormal.z;
         if(forceInelastic)
         {
            minSpeVel = cp.name_678;
            if(sepVel < minSpeVel)
            {
               cp.name_680 = false;
            }
            else if(cp.name_680)
            {
               return;
            }
            newVel = minSpeVel;
         }
         else
         {
            newVel = cp.name_677;
         }
         var deltaVel:Number = newVel - sepVel;
         var impulse:Number = deltaVel / cp.name_675;
         var accumImpulse:Number = cp.name_676 + impulse;
         if(accumImpulse < 0)
         {
            accumImpulse = 0;
         }
         var deltaImpulse:Number = accumImpulse - cp.name_676;
         cp.name_676 = accumImpulse;
         if(b1.var_499)
         {
            b1.method_518(cp.r1,normal,deltaImpulse);
         }
         if(b2 != null && b2.var_499)
         {
            b2.method_518(cp.r2,normal,-deltaImpulse);
         }
         this.method_668(b1,b2,cp,this._v);
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
         if(b1.var_499)
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
         if(b2 != null && b2.var_499)
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
         var max:Number = contact.name_581 * cp.name_676;
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
         if(b1.var_499)
         {
            b1.method_518(cp.r1,this.var_597,tanImpulse);
         }
         if(b2 != null && b2.var_499)
         {
            b2.method_518(cp.r2,this.var_597,-tanImpulse);
         }
      }
      
      private function method_668(body1:name_271, body2:name_271, cp:name_674, result:name_194) : void
      {
         var rot:name_194 = body1.state.rotation;
         var v:name_194 = cp.r1;
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
      
      private function method_672(dt:Number) : void
      {
         for(var item:name_671 = this.name_605.head; item != null; )
         {
            item.body.method_510(dt);
            item = item.next;
         }
      }
      
      private function method_677(dt:Number) : void
      {
         var body:name_271 = null;
         for(var item:name_671 = this.name_605.head; item != null; )
         {
            body = item.body;
            if(body.var_499 && !body.var_501)
            {
               body.method_511(dt);
            }
            item = item.next;
         }
      }
      
      private function method_674() : void
      {
         var body:name_271 = null;
         for(var item:name_671 = this.name_605.head; item != null; )
         {
            body = item.body;
            body.method_513();
            body.method_512();
            if(body.var_502)
            {
               if(body.state.velocity.length() < this.var_604 && body.state.rotation.length() < this.var_607)
               {
                  if(!body.var_501)
                  {
                     ++body.var_498;
                     if(body.var_498 >= this.var_606)
                     {
                        body.var_501 = true;
                     }
                  }
               }
               else
               {
                  body.var_498 = 0;
                  body.var_501 = false;
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
         this.method_676(dt);
         this.method_673(dt);
         this.method_671(dt);
         this.method_669(dt,false);
         this.method_672(dt);
         this.method_669(dt,true);
         this.method_677(dt);
         this.method_674();
      }
   }
}

