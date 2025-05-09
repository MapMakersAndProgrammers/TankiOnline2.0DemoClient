package package_54
{
   import package_38.name_145;
   import package_51.name_276;
   import package_51.name_481;
   import package_51.name_488;
   import package_51.name_492;
   import package_51.name_494;
   import package_58.name_189;
   import package_58.name_334;
   import package_61.name_186;
   import package_61.name_380;
   import package_61.name_482;
   import package_61.name_489;
   import package_84.name_495;
   import package_84.name_496;
   import package_84.name_497;
   
   public class name_354 implements name_357
   {
      public var var_592:name_492;
      
      public var threshold:Number = 0.0001;
      
      private var var_596:Object;
      
      private var var_591:Vector.<name_406>;
      
      private var var_593:int;
      
      private var name_438:Vector.<name_186>;
      
      private var numBodies:int;
      
      private var var_420:MinMax = new MinMax();
      
      private var var_594:name_145 = new name_145();
      
      private var var_590:name_145 = new name_145();
      
      private var var_595:name_189 = new name_189();
      
      private var _rayAABB:name_334 = new name_334();
      
      public function name_354()
      {
         super();
         this.var_592 = new name_492();
         this.name_438 = new Vector.<name_186>();
         this.var_591 = new Vector.<name_406>();
         this.var_596 = new Object();
         this.method_239(name_276.BOX,name_276.BOX,new name_495());
         this.method_239(name_276.BOX,name_276.RECT,new name_496());
         this.method_239(name_276.BOX,name_276.TRIANGLE,new name_497());
      }
      
      public function method_251(primitive:name_276) : void
      {
      }
      
      public function method_250(primitive:name_276) : void
      {
      }
      
      public function name_359() : void
      {
      }
      
      public function name_364(collisionPrimitives:Vector.<name_276>, boundBox:name_334 = null) : void
      {
         this.var_592.name_499(collisionPrimitives,boundBox);
      }
      
      public function name_434(tankPhysicsEntry:name_406) : void
      {
         if(this.var_591.indexOf(tankPhysicsEntry) >= 0)
         {
            throw new Error("Tank entry already exists");
         }
         var _loc2_:* = this.var_593++;
         this.var_591[_loc2_] = tankPhysicsEntry;
      }
      
      public function name_433(tankPhysicsEntry:name_406) : void
      {
         var index:Number = Number(this.var_591.indexOf(tankPhysicsEntry));
         if(index < 0)
         {
            throw new Error("Tank entry not found");
         }
         this.var_591[index] = this.var_591[--this.var_593];
         this.var_591[this.var_593] = null;
      }
      
      public function name_435(body:name_186) : void
      {
         var _loc2_:* = this.numBodies++;
         this.name_438[_loc2_] = body;
      }
      
      public function name_436(body:name_186) : void
      {
         var index:int = int(this.name_438.indexOf(body));
         if(index < 0)
         {
            throw new Error("Body not found");
         }
         this.name_438[index] = this.name_438[--this.numBodies];
         this.name_438[this.numBodies] = null;
      }
      
      public function method_249(center:name_145, radius:Number, filter:name_498) : Vector.<name_485>
      {
         var result:Vector.<name_485> = null;
         var tankPhysicsEntry:name_406 = null;
         var position:name_145 = null;
         var dx:Number = NaN;
         var dy:Number = NaN;
         var dz:Number = NaN;
         var distance:Number = NaN;
         radius *= radius;
         for(var i:int = 0; i < this.var_593; )
         {
            tankPhysicsEntry = this.var_591[i];
            position = tankPhysicsEntry.body.state.position;
            dx = position.x - center.x;
            dy = position.y - center.y;
            dz = position.z - center.z;
            distance = dx * dx + dy * dy + dz * dz;
            if(distance < radius)
            {
               if(filter == null || Boolean(filter.name_500(center,tankPhysicsEntry.body)))
               {
                  if(result == null)
                  {
                     result = new Vector.<name_485>();
                  }
                  result.push(new name_485(tankPhysicsEntry.body,Math.sqrt(distance)));
               }
            }
            i++;
         }
         return result;
      }
      
      public function method_254(contact:name_482) : name_482
      {
         return this.method_244(contact);
      }
      
      public function getContact(prim1:name_276, prim2:name_276, contact:name_482) : Boolean
      {
         if((prim1.collisionMask & prim2.collisionGroup) == 0 || (prim2.collisionMask & prim1.collisionGroup) == 0 || !prim1.aabb.intersects(prim2.aabb,0.01))
         {
            return false;
         }
         var collider:name_494 = this.var_596[prim1.type | prim2.type];
         if(collider != null && Boolean(collider.getContact(prim1,prim2,contact)))
         {
            if(prim1.postCollisionFilter != null && !prim1.postCollisionFilter.name_491(prim1,prim2))
            {
               return false;
            }
            return !(prim2.postCollisionFilter != null && !prim2.postCollisionFilter.name_491(prim2,prim1));
         }
         return false;
      }
      
      public function method_240(prim1:name_276, prim2:name_276) : Boolean
      {
         if((prim1.collisionMask & prim2.collisionGroup) == 0 || (prim2.collisionMask & prim1.collisionGroup) == 0)
         {
            return false;
         }
         if(prim1.body != null && prim1.body == prim2.body)
         {
            return false;
         }
         if(!prim1.aabb.intersects(prim2.aabb,0.01))
         {
            return false;
         }
         var collider:name_494 = this.var_596[prim1.type | prim2.type];
         if(collider != null && Boolean(collider.haveCollision(prim1,prim2)))
         {
            if(prim1.postCollisionFilter != null && !prim1.postCollisionFilter.name_491(prim1,prim2))
            {
               return false;
            }
            return !(prim2.postCollisionFilter != null && !prim2.postCollisionFilter.name_491(prim2,prim1));
         }
         return false;
      }
      
      public function raycast(origin:name_145, dir:name_145, collisionMask:int, maxTime:Number, filter:name_488, result:name_189) : Boolean
      {
         var hasStaticIntersection:Boolean = this.name_246(origin,dir,collisionMask,maxTime,filter,result);
         var hasDynamicIntersection:Boolean = this.method_243(origin,dir,collisionMask,maxTime,filter,this.var_595);
         if(!(hasDynamicIntersection || hasStaticIntersection))
         {
            return false;
         }
         if(hasDynamicIntersection && hasStaticIntersection)
         {
            if(result.t > this.var_595.t)
            {
               result.copy(this.var_595);
            }
            return true;
         }
         if(hasStaticIntersection)
         {
            return true;
         }
         result.copy(this.var_595);
         return true;
      }
      
      public function name_246(origin:name_145, dir:name_145, collisionMask:int, maxTime:Number, filter:name_488, result:name_189) : Boolean
      {
         if(!this.method_247(origin,dir,this.var_592.name_486.boundBox,this.var_420))
         {
            return false;
         }
         if(this.var_420.max < 0 || this.var_420.min > maxTime)
         {
            return false;
         }
         if(this.var_420.min <= 0)
         {
            this.var_420.min = 0;
            this.var_590.x = origin.x;
            this.var_590.y = origin.y;
            this.var_590.z = origin.z;
         }
         else
         {
            this.var_590.x = origin.x + this.var_420.min * dir.x;
            this.var_590.y = origin.y + this.var_420.min * dir.y;
            this.var_590.z = origin.z + this.var_420.min * dir.z;
         }
         if(this.var_420.max > maxTime)
         {
            this.var_420.max = maxTime;
         }
         var hasIntersection:Boolean = this.method_236(this.var_592.name_486,origin,this.var_590,dir,collisionMask,this.var_420.min,this.var_420.max,filter,result);
         return hasIntersection ? result.t <= maxTime : false;
      }
      
      public function method_242(primitive:name_276) : Boolean
      {
         return this.method_238(primitive,this.var_592.name_486);
      }
      
      private function method_239(type1:int, type2:int, collider:name_494) : void
      {
         this.var_596[type1 | type2] = collider;
      }
      
      private function method_244(contact:name_482) : name_482
      {
         var tankEntry:name_406 = null;
         var body:name_186 = null;
         var listItem:name_380 = null;
         var j:int = 0;
         var otherTankEntry:name_406 = null;
         for(var i:int = 0; i < this.var_593; i++)
         {
            tankEntry = this.var_591[i];
            body = tankEntry.body;
            for(listItem = body.collisionPrimitives.head; listItem != null; )
            {
               contact = this.method_237(this.var_592.name_486,listItem.primitive,contact);
               listItem = listItem.next;
            }
            for(j = i + 1; j < this.var_593; )
            {
               otherTankEntry = this.var_591[j];
               if(body.aabb.intersects(otherTankEntry.body.aabb,0.1))
               {
                  contact = this.method_241(tankEntry,otherTankEntry,contact);
               }
               j++;
            }
         }
         return contact;
      }
      
      private function method_241(tankEntry1:name_406, tankEntry2:name_406, contact:name_482) : name_482
      {
         var primitive1:name_276 = null;
         var numSimplePrimitives2:int = 0;
         var j:int = 0;
         var primitive2:name_276 = null;
         var skipCollision:Boolean = false;
         var body1:name_186 = tankEntry1.body;
         var body2:name_186 = tankEntry2.body;
         var numSimplePrimitives1:int = int(tankEntry1.simplePrimitives.length);
         var firstFilterTest:Boolean = true;
         for(var i:int = 0; i < numSimplePrimitives1; i++)
         {
            primitive1 = tankEntry1.simplePrimitives[i];
            numSimplePrimitives2 = int(tankEntry2.simplePrimitives.length);
            for(j = 0; j < numSimplePrimitives2; )
            {
               primitive2 = tankEntry2.simplePrimitives[j];
               if(this.getContact(primitive1,primitive2,contact))
               {
                  if(firstFilterTest)
                  {
                     firstFilterTest = false;
                     skipCollision = false;
                     if(body1.postCollisionFilter != null && !body1.postCollisionFilter.acceptBodiesCollision(body1,body2))
                     {
                        skipCollision = true;
                     }
                     if(body2.postCollisionFilter != null && !body2.postCollisionFilter.acceptBodiesCollision(body2,body1))
                     {
                        skipCollision = true;
                     }
                     if(skipCollision)
                     {
                        return contact;
                     }
                  }
                  contact = contact.next;
               }
               j++;
            }
         }
         return contact;
      }
      
      private function method_252(primitives1:name_489, primitives2:name_489) : Boolean
      {
         var item2:name_380 = null;
         for(var item1:name_380 = primitives1.head; item1 != null; )
         {
            for(item2 = primitives2.head; item2 != null; )
            {
               if(this.method_240(item1.primitive,item2.primitive))
               {
                  return true;
               }
               item2 = item2.next;
            }
            item1 = item1.next;
         }
         return false;
      }
      
      private function method_253(primitives:name_489) : Boolean
      {
         for(var item:name_380 = primitives.head; item != null; )
         {
            if(this.method_242(item.primitive))
            {
               return true;
            }
            item = item.next;
         }
         return false;
      }
      
      private function method_237(node:name_481, primitive:name_276, contact:name_482) : name_482
      {
         var min:Number = NaN;
         var max:Number = NaN;
         var primitives:Vector.<name_276> = null;
         var indices:Vector.<int> = null;
         var i:int = 0;
         if(node.indices != null)
         {
            primitives = this.var_592.name_490;
            indices = node.indices;
            for(i = indices.length - 1; i >= 0; )
            {
               if(this.getContact(primitive,primitives[indices[i]],contact))
               {
                  contact = contact.next;
               }
               i--;
            }
         }
         if(node.axis == -1)
         {
            return contact;
         }
         switch(node.axis)
         {
            case 0:
               min = Number(primitive.aabb.minX);
               max = Number(primitive.aabb.maxX);
               break;
            case 1:
               min = Number(primitive.aabb.minY);
               max = Number(primitive.aabb.maxY);
               break;
            case 2:
               min = Number(primitive.aabb.minZ);
               max = Number(primitive.aabb.maxZ);
         }
         if(min < node.coord)
         {
            contact = this.method_237(node.name_483,primitive,contact);
         }
         if(max > node.coord)
         {
            contact = this.method_237(node.name_484,primitive,contact);
         }
         if(node.name_487 != null && min < node.coord && max > node.coord)
         {
            contact = this.method_237(node.name_487.name_486,primitive,contact);
         }
         return contact;
      }
      
      private function method_238(primitive:name_276, node:name_481) : Boolean
      {
         var min:Number = NaN;
         var max:Number = NaN;
         var primitives:Vector.<name_276> = null;
         var indices:Vector.<int> = null;
         var i:int = 0;
         if(node.indices != null)
         {
            primitives = this.var_592.name_490;
            indices = node.indices;
            for(i = indices.length - 1; i >= 0; )
            {
               if(this.method_240(primitive,primitives[indices[i]]))
               {
                  return true;
               }
               i--;
            }
         }
         if(node.axis == -1)
         {
            return false;
         }
         switch(node.axis)
         {
            case 0:
               min = Number(primitive.aabb.minX);
               max = Number(primitive.aabb.maxX);
               break;
            case 1:
               min = Number(primitive.aabb.minY);
               max = Number(primitive.aabb.maxY);
               break;
            case 2:
               min = Number(primitive.aabb.minZ);
               max = Number(primitive.aabb.maxZ);
         }
         if(node.name_487 != null && min < node.coord && max > node.coord)
         {
            if(this.method_238(primitive,node.name_487.name_486))
            {
               return true;
            }
         }
         if(min < node.coord)
         {
            if(this.method_238(primitive,node.name_483))
            {
               return true;
            }
         }
         if(max > node.coord)
         {
            if(this.method_238(primitive,node.name_484))
            {
               return true;
            }
         }
         return false;
      }
      
      private function method_243(origin:name_145, dir:name_145, collisionMask:int, maxTime:Number, filter:name_488, result:name_189) : Boolean
      {
         var tankPhysicsEntry:name_406 = null;
         var body:name_186 = null;
         var aabb:name_334 = null;
         var collisionPrimitiveListItem:name_380 = null;
         var primitive:name_276 = null;
         var t:Number = NaN;
         var xx:Number = origin.x + dir.x * maxTime;
         var yy:Number = origin.y + dir.y * maxTime;
         var zz:Number = origin.z + dir.z * maxTime;
         if(xx < origin.x)
         {
            this._rayAABB.minX = xx;
            this._rayAABB.maxX = origin.x;
         }
         else
         {
            this._rayAABB.minX = origin.x;
            this._rayAABB.maxX = xx;
         }
         if(yy < origin.y)
         {
            this._rayAABB.minY = yy;
            this._rayAABB.maxY = origin.y;
         }
         else
         {
            this._rayAABB.minY = origin.y;
            this._rayAABB.maxY = yy;
         }
         if(zz < origin.z)
         {
            this._rayAABB.minZ = zz;
            this._rayAABB.maxZ = origin.z;
         }
         else
         {
            this._rayAABB.minZ = origin.z;
            this._rayAABB.maxZ = zz;
         }
         var minTime:Number = maxTime + 1;
         for(var i:int = 0; i < this.var_593; i++)
         {
            tankPhysicsEntry = this.var_591[i];
            body = tankPhysicsEntry.body;
            if(!(filter != null && !filter.name_493(body.collisionPrimitives.head.primitive)))
            {
               aabb = body.aabb;
               if(!(this._rayAABB.maxX < aabb.minX || this._rayAABB.minX > aabb.maxX || this._rayAABB.maxY < aabb.minY || this._rayAABB.minY > aabb.maxY || this._rayAABB.maxZ < aabb.minZ || this._rayAABB.minZ > aabb.maxZ))
               {
                  for(collisionPrimitiveListItem = body.collisionPrimitives.head; collisionPrimitiveListItem != null; )
                  {
                     primitive = collisionPrimitiveListItem.primitive;
                     if((primitive.collisionGroup & collisionMask) == 0)
                     {
                        collisionPrimitiveListItem = collisionPrimitiveListItem.next;
                     }
                     else
                     {
                        aabb = primitive.aabb;
                        if(this._rayAABB.maxX < aabb.minX || this._rayAABB.minX > aabb.maxX || this._rayAABB.maxY < aabb.minY || this._rayAABB.minY > aabb.maxY || this._rayAABB.maxZ < aabb.minZ || this._rayAABB.minZ > aabb.maxZ)
                        {
                           collisionPrimitiveListItem = collisionPrimitiveListItem.next;
                        }
                        else
                        {
                           t = Number(primitive.raycast(origin,dir,this.threshold,this.var_594));
                           if(t > 0 && t < minTime)
                           {
                              minTime = t;
                              result.primitive = primitive;
                              result.normal.x = this.var_594.x;
                              result.normal.y = this.var_594.y;
                              result.normal.z = this.var_594.z;
                           }
                           collisionPrimitiveListItem = collisionPrimitiveListItem.next;
                        }
                     }
                  }
               }
            }
         }
         if(minTime > maxTime)
         {
            return false;
         }
         result.position.x = origin.x + dir.x * minTime;
         result.position.y = origin.y + dir.y * minTime;
         result.position.z = origin.z + dir.z * minTime;
         result.t = minTime;
         return true;
      }
      
      private function method_247(origin:name_145, dir:name_145, bb:name_334, time:MinMax) : Boolean
      {
         var t1:Number = NaN;
         var t2:Number = NaN;
         time.min = -1;
         time.max = 1e+308;
         for(var i:int = 0; i < 3; i++)
         {
            switch(i)
            {
               case 0:
                  if(!(dir.x < this.threshold && dir.x > -this.threshold))
                  {
                     t1 = (bb.minX - origin.x) / dir.x;
                     t2 = (bb.maxX - origin.x) / dir.x;
                     break;
                  }
                  if(origin.x < bb.minX || origin.x > bb.maxX)
                  {
                     return false;
                  }
                  continue;
               case 1:
                  if(!(dir.y < this.threshold && dir.y > -this.threshold))
                  {
                     t1 = (bb.minY - origin.y) / dir.y;
                     t2 = (bb.maxY - origin.y) / dir.y;
                     break;
                  }
                  if(origin.y < bb.minY || origin.y > bb.maxY)
                  {
                     return false;
                  }
                  continue;
               case 2:
                  if(!(dir.z < this.threshold && dir.z > -this.threshold))
                  {
                     t1 = (bb.minZ - origin.z) / dir.z;
                     t2 = (bb.maxZ - origin.z) / dir.z;
                     break;
                  }
                  if(origin.z < bb.minZ || origin.z > bb.maxZ)
                  {
                     return false;
                  }
                  continue;
            }
            if(t1 < t2)
            {
               if(t1 > time.min)
               {
                  time.min = t1;
               }
               if(t2 < time.max)
               {
                  time.max = t2;
               }
            }
            else
            {
               if(t2 > time.min)
               {
                  time.min = t2;
               }
               if(t1 < time.max)
               {
                  time.max = t1;
               }
            }
            if(time.max < time.min)
            {
               return false;
            }
         }
         return true;
      }
      
      private function method_236(node:name_481, origin:name_145, localOrigin:name_145, dir:name_145, collisionMask:int, t1:Number, t2:Number, filter:name_488, result:name_189) : Boolean
      {
         var splitTime:Number = NaN;
         var currChildNode:name_481 = null;
         var intersects:Boolean = false;
         var splitNode:name_481 = null;
         var i:int = 0;
         var primitive:name_276 = null;
         if(node.indices != null && this.method_245(origin,dir,collisionMask,this.var_592.name_490,node.indices,filter,result))
         {
            return true;
         }
         if(node.axis == -1)
         {
            return false;
         }
         switch(node.axis)
         {
            case 0:
               if(dir.x > -this.threshold && dir.x < this.threshold)
               {
                  splitTime = t2 + 1;
               }
               else
               {
                  splitTime = (node.coord - origin.x) / dir.x;
               }
               currChildNode = localOrigin.x < node.coord ? node.name_483 : node.name_484;
               break;
            case 1:
               if(dir.y > -this.threshold && dir.y < this.threshold)
               {
                  splitTime = t2 + 1;
               }
               else
               {
                  splitTime = (node.coord - origin.y) / dir.y;
               }
               currChildNode = localOrigin.y < node.coord ? node.name_483 : node.name_484;
               break;
            case 2:
               if(dir.z > -this.threshold && dir.z < this.threshold)
               {
                  splitTime = t2 + 1;
               }
               else
               {
                  splitTime = (node.coord - origin.z) / dir.z;
               }
               currChildNode = localOrigin.z < node.coord ? node.name_483 : node.name_484;
         }
         if(splitTime < t1 || splitTime > t2)
         {
            return this.method_236(currChildNode,origin,localOrigin,dir,collisionMask,t1,t2,filter,result);
         }
         intersects = this.method_236(currChildNode,origin,localOrigin,dir,collisionMask,t1,splitTime,filter,result);
         if(intersects)
         {
            return true;
         }
         this.var_590.x = origin.x + splitTime * dir.x;
         this.var_590.y = origin.y + splitTime * dir.y;
         this.var_590.z = origin.z + splitTime * dir.z;
         if(node.name_487 != null)
         {
            splitNode = node.name_487.name_486;
            while(splitNode != null && splitNode.axis != -1)
            {
               switch(splitNode.axis)
               {
                  case 0:
                     splitNode = this.var_590.x < splitNode.coord ? splitNode.name_483 : splitNode.name_484;
                     break;
                  case 1:
                     splitNode = this.var_590.y < splitNode.coord ? splitNode.name_483 : splitNode.name_484;
                     break;
                  case 2:
                     splitNode = this.var_590.z < splitNode.coord ? splitNode.name_483 : splitNode.name_484;
                     break;
               }
            }
            if(splitNode != null && splitNode.indices != null)
            {
               for(i = splitNode.indices.length - 1; i >= 0; )
               {
                  primitive = this.var_592.name_490[splitNode.indices[i]];
                  if((primitive.collisionGroup & collisionMask) != 0)
                  {
                     if(!(filter != null && !filter.name_493(primitive)))
                     {
                        result.t = primitive.raycast(origin,dir,this.threshold,result.normal);
                        if(result.t >= 0)
                        {
                           result.position.copy(this.var_590);
                           result.primitive = primitive;
                           return true;
                        }
                     }
                  }
                  i--;
               }
            }
         }
         return this.method_236(currChildNode == node.name_483 ? node.name_484 : node.name_483,origin,this.var_590,dir,collisionMask,splitTime,t2,filter,result);
      }
      
      private function method_245(origin:name_145, dir:name_145, collisionMask:int, primitives:Vector.<name_276>, indices:Vector.<int>, filter:name_488, intersection:name_189) : Boolean
      {
         var primitive:name_276 = null;
         var t:Number = NaN;
         var pnum:int = int(indices.length);
         var minTime:Number = 1e+308;
         for(var i:int = 0; i < pnum; )
         {
            primitive = primitives[indices[i]];
            if((primitive.collisionGroup & collisionMask) != 0)
            {
               if(!(filter != null && !filter.name_493(primitive)))
               {
                  t = Number(primitive.raycast(origin,dir,this.threshold,this.var_594));
                  if(t > 0 && t < minTime)
                  {
                     minTime = t;
                     intersection.primitive = primitive;
                     intersection.normal.x = this.var_594.x;
                     intersection.normal.y = this.var_594.y;
                     intersection.normal.z = this.var_594.z;
                  }
               }
            }
            i++;
         }
         if(minTime == 1e+308)
         {
            return false;
         }
         intersection.position.x = origin.x + dir.x * minTime;
         intersection.position.y = origin.y + dir.y * minTime;
         intersection.position.z = origin.z + dir.z * minTime;
         intersection.t = minTime;
         return true;
      }
      
      private function method_248(body1:name_186, body2:name_186, contact:name_482) : name_482
      {
         return this.method_246(body1.collisionPrimitives,body2.collisionPrimitives,contact);
      }
      
      private function method_246(primitives1:name_489, primitives2:name_489, contact:name_482) : name_482
      {
         var item2:name_380 = null;
         for(var item1:name_380 = primitives1.head; item1 != null; )
         {
            for(item2 = primitives2.head; item2 != null; )
            {
               if(this.getContact(item1.primitive,item2.primitive,contact))
               {
                  contact = contact.next;
               }
               item2 = item2.next;
            }
            item1 = item1.next;
         }
         return contact;
      }
   }
}

class MinMax
{
   public var min:Number = 0;
   
   public var max:Number = 0;
   
   public function MinMax()
   {
      super();
   }
}
