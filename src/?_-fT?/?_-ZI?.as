package §_-fT§
{
   import §_-1e§.§_-D-§;
   import §_-1e§.§_-Nh§;
   import §_-1e§.§_-hG§;
   import §_-1e§.§_-jn§;
   import §_-1e§.§_-oZ§;
   import §_-KA§.§_-FW§;
   import §_-KA§.§_-jr§;
   import §_-US§.§_-4q§;
   import §_-US§.§_-6h§;
   import §_-US§.§_-BV§;
   import §_-US§.§_-G2§;
   import §_-nl§.§_-bj§;
   import §while§.§_-GQ§;
   import §while§.§_-Ph§;
   import §while§.§_-hu§;
   
   public class §_-ZI§ implements §_-Zm§
   {
      public var §_-bw§:§_-D-§;
      
      public var threshold:Number = 0.0001;
      
      private var §_-P6§:Object;
      
      private var §_-Wj§:Vector.<§_-YY§>;
      
      private var §_-LK§:int;
      
      private var §_-By§:Vector.<§_-BV§>;
      
      private var numBodies:int;
      
      private var §_-qC§:MinMax = new MinMax();
      
      private var §_-k8§:§_-bj§ = new §_-bj§();
      
      private var §_-0q§:§_-bj§ = new §_-bj§();
      
      private var §_-2P§:§_-jr§ = new §_-jr§();
      
      private var _rayAABB:§_-FW§ = new §_-FW§();
      
      public function §_-ZI§()
      {
         super();
         this.§_-bw§ = new §_-D-§();
         this.§_-By§ = new Vector.<§_-BV§>();
         this.§_-Wj§ = new Vector.<§_-YY§>();
         this.§_-P6§ = new Object();
         this.§_-c2§(§_-Nh§.BOX,§_-Nh§.BOX,new §_-Ph§());
         this.§_-c2§(§_-Nh§.BOX,§_-Nh§.RECT,new §_-GQ§());
         this.§_-c2§(§_-Nh§.BOX,§_-Nh§.TRIANGLE,new §_-hu§());
      }
      
      public function §_-oT§(primitive:§_-Nh§) : void
      {
      }
      
      public function §_-HZ§(primitive:§_-Nh§) : void
      {
      }
      
      public function §_-9F§() : void
      {
      }
      
      public function §_-Vy§(collisionPrimitives:Vector.<§_-Nh§>, boundBox:§_-FW§ = null) : void
      {
         this.§_-bw§.§_-J9§(collisionPrimitives,boundBox);
      }
      
      public function §_-pN§(tankPhysicsEntry:§_-YY§) : void
      {
         if(this.§_-Wj§.indexOf(tankPhysicsEntry) >= 0)
         {
            throw new Error("Tank entry already exists");
         }
         var _loc2_:* = this.§_-LK§++;
         this.§_-Wj§[_loc2_] = tankPhysicsEntry;
      }
      
      public function §_-qP§(tankPhysicsEntry:§_-YY§) : void
      {
         var index:Number = Number(this.§_-Wj§.indexOf(tankPhysicsEntry));
         if(index < 0)
         {
            throw new Error("Tank entry not found");
         }
         this.§_-Wj§[index] = this.§_-Wj§[--this.§_-LK§];
         this.§_-Wj§[this.§_-LK§] = null;
      }
      
      public function §_-D8§(body:§_-BV§) : void
      {
         var _loc2_:* = this.numBodies++;
         this.§_-By§[_loc2_] = body;
      }
      
      public function §_-2x§(body:§_-BV§) : void
      {
         var index:int = int(this.§_-By§.indexOf(body));
         if(index < 0)
         {
            throw new Error("Body not found");
         }
         this.§_-By§[index] = this.§_-By§[--this.numBodies];
         this.§_-By§[this.numBodies] = null;
      }
      
      public function §_-7u§(center:§_-bj§, radius:Number, filter:§_-VN§) : Vector.<§_-bB§>
      {
         var result:Vector.<§_-bB§> = null;
         var tankPhysicsEntry:§_-YY§ = null;
         var position:§_-bj§ = null;
         var dx:Number = NaN;
         var dy:Number = NaN;
         var dz:Number = NaN;
         var distance:Number = NaN;
         radius *= radius;
         for(var i:int = 0; i < this.§_-LK§; )
         {
            tankPhysicsEntry = this.§_-Wj§[i];
            position = tankPhysicsEntry.body.state.position;
            dx = position.x - center.x;
            dy = position.y - center.y;
            dz = position.z - center.z;
            distance = dx * dx + dy * dy + dz * dz;
            if(distance < radius)
            {
               if(filter == null || Boolean(filter.§_-cb§(center,tankPhysicsEntry.body)))
               {
                  if(result == null)
                  {
                     result = new Vector.<§_-bB§>();
                  }
                  result.push(new §_-bB§(tankPhysicsEntry.body,Math.sqrt(distance)));
               }
            }
            i++;
         }
         return result;
      }
      
      public function §_-63§(contact:§_-6h§) : §_-6h§
      {
         return this.§_-Uu§(contact);
      }
      
      public function getContact(prim1:§_-Nh§, prim2:§_-Nh§, contact:§_-6h§) : Boolean
      {
         if((prim1.collisionMask & prim2.collisionGroup) == 0 || (prim2.collisionMask & prim1.collisionGroup) == 0 || !prim1.aabb.intersects(prim2.aabb,0.01))
         {
            return false;
         }
         var collider:§_-hG§ = this.§_-P6§[prim1.type | prim2.type];
         if(collider != null && Boolean(collider.getContact(prim1,prim2,contact)))
         {
            if(prim1.postCollisionFilter != null && !prim1.postCollisionFilter.§_-eZ§(prim1,prim2))
            {
               return false;
            }
            return !(prim2.postCollisionFilter != null && !prim2.postCollisionFilter.§_-eZ§(prim2,prim1));
         }
         return false;
      }
      
      public function §_-A5§(prim1:§_-Nh§, prim2:§_-Nh§) : Boolean
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
         var collider:§_-hG§ = this.§_-P6§[prim1.type | prim2.type];
         if(collider != null && Boolean(collider.haveCollision(prim1,prim2)))
         {
            if(prim1.postCollisionFilter != null && !prim1.postCollisionFilter.§_-eZ§(prim1,prim2))
            {
               return false;
            }
            return !(prim2.postCollisionFilter != null && !prim2.postCollisionFilter.§_-eZ§(prim2,prim1));
         }
         return false;
      }
      
      public function raycast(origin:§_-bj§, dir:§_-bj§, collisionMask:int, maxTime:Number, filter:§_-jn§, result:§_-jr§) : Boolean
      {
         var hasStaticIntersection:Boolean = this.§_-cX§(origin,dir,collisionMask,maxTime,filter,result);
         var hasDynamicIntersection:Boolean = this.§_-eu§(origin,dir,collisionMask,maxTime,filter,this.§_-2P§);
         if(!(hasDynamicIntersection || hasStaticIntersection))
         {
            return false;
         }
         if(hasDynamicIntersection && hasStaticIntersection)
         {
            if(result.t > this.§_-2P§.t)
            {
               result.copy(this.§_-2P§);
            }
            return true;
         }
         if(hasStaticIntersection)
         {
            return true;
         }
         result.copy(this.§_-2P§);
         return true;
      }
      
      public function §_-cX§(origin:§_-bj§, dir:§_-bj§, collisionMask:int, maxTime:Number, filter:§_-jn§, result:§_-jr§) : Boolean
      {
         if(!this.§_-oL§(origin,dir,this.§_-bw§.§_-5H§.boundBox,this.§_-qC§))
         {
            return false;
         }
         if(this.§_-qC§.max < 0 || this.§_-qC§.min > maxTime)
         {
            return false;
         }
         if(this.§_-qC§.min <= 0)
         {
            this.§_-qC§.min = 0;
            this.§_-0q§.x = origin.x;
            this.§_-0q§.y = origin.y;
            this.§_-0q§.z = origin.z;
         }
         else
         {
            this.§_-0q§.x = origin.x + this.§_-qC§.min * dir.x;
            this.§_-0q§.y = origin.y + this.§_-qC§.min * dir.y;
            this.§_-0q§.z = origin.z + this.§_-qC§.min * dir.z;
         }
         if(this.§_-qC§.max > maxTime)
         {
            this.§_-qC§.max = maxTime;
         }
         var hasIntersection:Boolean = this.§_-NC§(this.§_-bw§.§_-5H§,origin,this.§_-0q§,dir,collisionMask,this.§_-qC§.min,this.§_-qC§.max,filter,result);
         return hasIntersection ? result.t <= maxTime : false;
      }
      
      public function §_-TL§(primitive:§_-Nh§) : Boolean
      {
         return this.§_-B8§(primitive,this.§_-bw§.§_-5H§);
      }
      
      private function §_-c2§(type1:int, type2:int, collider:§_-hG§) : void
      {
         this.§_-P6§[type1 | type2] = collider;
      }
      
      private function §_-Uu§(contact:§_-6h§) : §_-6h§
      {
         var tankEntry:§_-YY§ = null;
         var body:§_-BV§ = null;
         var listItem:§_-4q§ = null;
         var j:int = 0;
         var otherTankEntry:§_-YY§ = null;
         for(var i:int = 0; i < this.§_-LK§; i++)
         {
            tankEntry = this.§_-Wj§[i];
            body = tankEntry.body;
            for(listItem = body.collisionPrimitives.head; listItem != null; )
            {
               contact = this.§_-m1§(this.§_-bw§.§_-5H§,listItem.primitive,contact);
               listItem = listItem.next;
            }
            for(j = i + 1; j < this.§_-LK§; )
            {
               otherTankEntry = this.§_-Wj§[j];
               if(body.aabb.intersects(otherTankEntry.body.aabb,0.1))
               {
                  contact = this.§_-4I§(tankEntry,otherTankEntry,contact);
               }
               j++;
            }
         }
         return contact;
      }
      
      private function §_-4I§(tankEntry1:§_-YY§, tankEntry2:§_-YY§, contact:§_-6h§) : §_-6h§
      {
         var primitive1:§_-Nh§ = null;
         var numSimplePrimitives2:int = 0;
         var j:int = 0;
         var primitive2:§_-Nh§ = null;
         var skipCollision:Boolean = false;
         var body1:§_-BV§ = tankEntry1.body;
         var body2:§_-BV§ = tankEntry2.body;
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
      
      private function §_-AX§(primitives1:§_-G2§, primitives2:§_-G2§) : Boolean
      {
         var item2:§_-4q§ = null;
         for(var item1:§_-4q§ = primitives1.head; item1 != null; )
         {
            for(item2 = primitives2.head; item2 != null; )
            {
               if(this.§_-A5§(item1.primitive,item2.primitive))
               {
                  return true;
               }
               item2 = item2.next;
            }
            item1 = item1.next;
         }
         return false;
      }
      
      private function §_-bH§(primitives:§_-G2§) : Boolean
      {
         for(var item:§_-4q§ = primitives.head; item != null; )
         {
            if(this.§_-TL§(item.primitive))
            {
               return true;
            }
            item = item.next;
         }
         return false;
      }
      
      private function §_-m1§(node:§_-oZ§, primitive:§_-Nh§, contact:§_-6h§) : §_-6h§
      {
         var min:Number = NaN;
         var max:Number = NaN;
         var primitives:Vector.<§_-Nh§> = null;
         var indices:Vector.<int> = null;
         var i:int = 0;
         if(node.indices != null)
         {
            primitives = this.§_-bw§.§_-8A§;
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
            contact = this.§_-m1§(node.§_-Gm§,primitive,contact);
         }
         if(max > node.coord)
         {
            contact = this.§_-m1§(node.§_-75§,primitive,contact);
         }
         if(node.§_-da§ != null && min < node.coord && max > node.coord)
         {
            contact = this.§_-m1§(node.§_-da§.§_-5H§,primitive,contact);
         }
         return contact;
      }
      
      private function §_-B8§(primitive:§_-Nh§, node:§_-oZ§) : Boolean
      {
         var min:Number = NaN;
         var max:Number = NaN;
         var primitives:Vector.<§_-Nh§> = null;
         var indices:Vector.<int> = null;
         var i:int = 0;
         if(node.indices != null)
         {
            primitives = this.§_-bw§.§_-8A§;
            indices = node.indices;
            for(i = indices.length - 1; i >= 0; )
            {
               if(this.§_-A5§(primitive,primitives[indices[i]]))
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
         if(node.§_-da§ != null && min < node.coord && max > node.coord)
         {
            if(this.§_-B8§(primitive,node.§_-da§.§_-5H§))
            {
               return true;
            }
         }
         if(min < node.coord)
         {
            if(this.§_-B8§(primitive,node.§_-Gm§))
            {
               return true;
            }
         }
         if(max > node.coord)
         {
            if(this.§_-B8§(primitive,node.§_-75§))
            {
               return true;
            }
         }
         return false;
      }
      
      private function §_-eu§(origin:§_-bj§, dir:§_-bj§, collisionMask:int, maxTime:Number, filter:§_-jn§, result:§_-jr§) : Boolean
      {
         var tankPhysicsEntry:§_-YY§ = null;
         var body:§_-BV§ = null;
         var aabb:§_-FW§ = null;
         var collisionPrimitiveListItem:§_-4q§ = null;
         var primitive:§_-Nh§ = null;
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
         for(var i:int = 0; i < this.§_-LK§; i++)
         {
            tankPhysicsEntry = this.§_-Wj§[i];
            body = tankPhysicsEntry.body;
            if(!(filter != null && !filter.§_-0w§(body.collisionPrimitives.head.primitive)))
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
                           t = Number(primitive.raycast(origin,dir,this.threshold,this.§_-k8§));
                           if(t > 0 && t < minTime)
                           {
                              minTime = t;
                              result.primitive = primitive;
                              result.normal.x = this.§_-k8§.x;
                              result.normal.y = this.§_-k8§.y;
                              result.normal.z = this.§_-k8§.z;
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
      
      private function §_-oL§(origin:§_-bj§, dir:§_-bj§, bb:§_-FW§, time:MinMax) : Boolean
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
      
      private function §_-NC§(node:§_-oZ§, origin:§_-bj§, localOrigin:§_-bj§, dir:§_-bj§, collisionMask:int, t1:Number, t2:Number, filter:§_-jn§, result:§_-jr§) : Boolean
      {
         var splitTime:Number = NaN;
         var currChildNode:§_-oZ§ = null;
         var intersects:Boolean = false;
         var splitNode:§_-oZ§ = null;
         var i:int = 0;
         var primitive:§_-Nh§ = null;
         if(node.indices != null && this.§_-FH§(origin,dir,collisionMask,this.§_-bw§.§_-8A§,node.indices,filter,result))
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
               currChildNode = localOrigin.x < node.coord ? node.§_-Gm§ : node.§_-75§;
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
               currChildNode = localOrigin.y < node.coord ? node.§_-Gm§ : node.§_-75§;
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
               currChildNode = localOrigin.z < node.coord ? node.§_-Gm§ : node.§_-75§;
         }
         if(splitTime < t1 || splitTime > t2)
         {
            return this.§_-NC§(currChildNode,origin,localOrigin,dir,collisionMask,t1,t2,filter,result);
         }
         intersects = this.§_-NC§(currChildNode,origin,localOrigin,dir,collisionMask,t1,splitTime,filter,result);
         if(intersects)
         {
            return true;
         }
         this.§_-0q§.x = origin.x + splitTime * dir.x;
         this.§_-0q§.y = origin.y + splitTime * dir.y;
         this.§_-0q§.z = origin.z + splitTime * dir.z;
         if(node.§_-da§ != null)
         {
            splitNode = node.§_-da§.§_-5H§;
            while(splitNode != null && splitNode.axis != -1)
            {
               switch(splitNode.axis)
               {
                  case 0:
                     splitNode = this.§_-0q§.x < splitNode.coord ? splitNode.§_-Gm§ : splitNode.§_-75§;
                     break;
                  case 1:
                     splitNode = this.§_-0q§.y < splitNode.coord ? splitNode.§_-Gm§ : splitNode.§_-75§;
                     break;
                  case 2:
                     splitNode = this.§_-0q§.z < splitNode.coord ? splitNode.§_-Gm§ : splitNode.§_-75§;
                     break;
               }
            }
            if(splitNode != null && splitNode.indices != null)
            {
               for(i = splitNode.indices.length - 1; i >= 0; )
               {
                  primitive = this.§_-bw§.§_-8A§[splitNode.indices[i]];
                  if((primitive.collisionGroup & collisionMask) != 0)
                  {
                     if(!(filter != null && !filter.§_-0w§(primitive)))
                     {
                        result.t = primitive.raycast(origin,dir,this.threshold,result.normal);
                        if(result.t >= 0)
                        {
                           result.position.copy(this.§_-0q§);
                           result.primitive = primitive;
                           return true;
                        }
                     }
                  }
                  i--;
               }
            }
         }
         return this.§_-NC§(currChildNode == node.§_-Gm§ ? node.§_-75§ : node.§_-Gm§,origin,this.§_-0q§,dir,collisionMask,splitTime,t2,filter,result);
      }
      
      private function §_-FH§(origin:§_-bj§, dir:§_-bj§, collisionMask:int, primitives:Vector.<§_-Nh§>, indices:Vector.<int>, filter:§_-jn§, intersection:§_-jr§) : Boolean
      {
         var primitive:§_-Nh§ = null;
         var t:Number = NaN;
         var pnum:int = int(indices.length);
         var minTime:Number = 1e+308;
         for(var i:int = 0; i < pnum; )
         {
            primitive = primitives[indices[i]];
            if((primitive.collisionGroup & collisionMask) != 0)
            {
               if(!(filter != null && !filter.§_-0w§(primitive)))
               {
                  t = Number(primitive.raycast(origin,dir,this.threshold,this.§_-k8§));
                  if(t > 0 && t < minTime)
                  {
                     minTime = t;
                     intersection.primitive = primitive;
                     intersection.normal.x = this.§_-k8§.x;
                     intersection.normal.y = this.§_-k8§.y;
                     intersection.normal.z = this.§_-k8§.z;
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
      
      private function §_-Yu§(body1:§_-BV§, body2:§_-BV§, contact:§_-6h§) : §_-6h§
      {
         return this.§_-bO§(body1.collisionPrimitives,body2.collisionPrimitives,contact);
      }
      
      private function §_-bO§(primitives1:§_-G2§, primitives2:§_-G2§, contact:§_-6h§) : §_-6h§
      {
         var item2:§_-4q§ = null;
         for(var item1:§_-4q§ = primitives1.head; item1 != null; )
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
