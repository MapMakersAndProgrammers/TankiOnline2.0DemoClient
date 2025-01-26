package package_86
{
   import package_121.name_666;
   import package_121.name_667;
   import package_121.name_668;
   import package_46.name_194;
   import package_76.name_235;
   import package_76.name_631;
   import package_76.name_656;
   import package_76.name_663;
   import package_76.name_665;
   import package_90.name_273;
   import package_90.name_386;
   import package_92.name_271;
   import package_92.name_513;
   import package_92.name_601;
   import package_92.name_630;
   
   public class name_466 implements name_468
   {
      public var var_592:name_663;
      
      public var threshold:Number = 0.0001;
      
      private var var_596:Object;
      
      private var var_591:Vector.<name_568>;
      
      private var var_593:int;
      
      private var name_605:Vector.<name_271>;
      
      private var numBodies:int;
      
      private var var_420:MinMax = new MinMax();
      
      private var var_594:name_194 = new name_194();
      
      private var var_590:name_194 = new name_194();
      
      private var var_595:name_273 = new name_273();
      
      private var _rayAABB:name_386 = new name_386();
      
      public function name_466()
      {
         super();
         this.var_592 = new name_663();
         this.name_605 = new Vector.<name_271>();
         this.var_591 = new Vector.<name_568>();
         this.var_596 = new Object();
         this.method_655(name_235.BOX,name_235.BOX,new name_666());
         this.method_655(name_235.BOX,name_235.RECT,new name_667());
         this.method_655(name_235.BOX,name_235.TRIANGLE,new name_668());
      }
      
      public function method_665(primitive:name_235) : void
      {
      }
      
      public function method_664(primitive:name_235) : void
      {
      }
      
      public function name_470() : void
      {
      }
      
      public function name_473(collisionPrimitives:Vector.<name_235>, boundBox:name_386 = null) : void
      {
         this.var_592.name_669(collisionPrimitives,boundBox);
      }
      
      public function name_591(tankPhysicsEntry:name_568) : void
      {
         if(this.var_591.indexOf(tankPhysicsEntry) >= 0)
         {
            throw new Error("Tank entry already exists");
         }
         var _loc2_:* = this.var_593++;
         this.var_591[_loc2_] = tankPhysicsEntry;
      }
      
      public function name_590(tankPhysicsEntry:name_568) : void
      {
         var index:Number = Number(this.var_591.indexOf(tankPhysicsEntry));
         if(index < 0)
         {
            throw new Error("Tank entry not found");
         }
         this.var_591[index] = this.var_591[--this.var_593];
         this.var_591[this.var_593] = null;
      }
      
      public function name_592(body:name_271) : void
      {
         var _loc2_:* = this.numBodies++;
         this.name_605[_loc2_] = body;
      }
      
      public function name_593(body:name_271) : void
      {
         var index:int = int(this.name_605.indexOf(body));
         if(index < 0)
         {
            throw new Error("Body not found");
         }
         this.name_605[index] = this.name_605[--this.numBodies];
         this.name_605[this.numBodies] = null;
      }
      
      public function method_651(center:name_194, radius:Number, filter:name_655) : Vector.<name_654>
      {
         var result:Vector.<name_654> = null;
         var tankPhysicsEntry:name_568 = null;
         var position:name_194 = null;
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
               if(filter == null || Boolean(filter.name_670(center,tankPhysicsEntry.body)))
               {
                  if(result == null)
                  {
                     result = new Vector.<name_654>();
                  }
                  result.push(new name_654(tankPhysicsEntry.body,Math.sqrt(distance)));
               }
            }
            i++;
         }
         return result;
      }
      
      public function method_553(contact:name_630) : name_630
      {
         return this.method_659(contact);
      }
      
      public function getContact(prim1:name_235, prim2:name_235, contact:name_630) : Boolean
      {
         if((prim1.collisionMask & prim2.collisionGroup) == 0 || (prim2.collisionMask & prim1.collisionGroup) == 0 || !prim1.aabb.intersects(prim2.aabb,0.01))
         {
            return false;
         }
         var collider:name_665 = this.var_596[prim1.type | prim2.type];
         if(collider != null && Boolean(collider.getContact(prim1,prim2,contact)))
         {
            if(prim1.postCollisionFilter != null && !prim1.postCollisionFilter.name_662(prim1,prim2))
            {
               return false;
            }
            return !(prim2.postCollisionFilter != null && !prim2.postCollisionFilter.name_662(prim2,prim1));
         }
         return false;
      }
      
      public function method_554(prim1:name_235, prim2:name_235) : Boolean
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
         var collider:name_665 = this.var_596[prim1.type | prim2.type];
         if(collider != null && Boolean(collider.haveCollision(prim1,prim2)))
         {
            if(prim1.postCollisionFilter != null && !prim1.postCollisionFilter.name_662(prim1,prim2))
            {
               return false;
            }
            return !(prim2.postCollisionFilter != null && !prim2.postCollisionFilter.name_662(prim2,prim1));
         }
         return false;
      }
      
      public function raycast(origin:name_194, dir:name_194, collisionMask:int, maxTime:Number, filter:name_631, result:name_273) : Boolean
      {
         var hasStaticIntersection:Boolean = this.name_324(origin,dir,collisionMask,maxTime,filter,result);
         var hasDynamicIntersection:Boolean = this.method_658(origin,dir,collisionMask,maxTime,filter,this.var_595);
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
      
      public function name_324(origin:name_194, dir:name_194, collisionMask:int, maxTime:Number, filter:name_631, result:name_273) : Boolean
      {
         if(!this.method_662(origin,dir,this.var_592.name_659.boundBox,this.var_420))
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
         var hasIntersection:Boolean = this.method_652(this.var_592.name_659,origin,this.var_590,dir,collisionMask,this.var_420.min,this.var_420.max,filter,result);
         return hasIntersection ? result.t <= maxTime : false;
      }
      
      public function method_657(primitive:name_235) : Boolean
      {
         return this.method_654(primitive,this.var_592.name_659);
      }
      
      private function method_655(type1:int, type2:int, collider:name_665) : void
      {
         this.var_596[type1 | type2] = collider;
      }
      
      private function method_659(contact:name_630) : name_630
      {
         var tankEntry:name_568 = null;
         var body:name_271 = null;
         var listItem:name_513 = null;
         var j:int = 0;
         var otherTankEntry:name_568 = null;
         for(var i:int = 0; i < this.var_593; i++)
         {
            tankEntry = this.var_591[i];
            body = tankEntry.body;
            for(listItem = body.collisionPrimitives.head; listItem != null; )
            {
               contact = this.method_653(this.var_592.name_659,listItem.primitive,contact);
               listItem = listItem.next;
            }
            for(j = i + 1; j < this.var_593; )
            {
               otherTankEntry = this.var_591[j];
               if(body.aabb.intersects(otherTankEntry.body.aabb,0.1))
               {
                  contact = this.method_656(tankEntry,otherTankEntry,contact);
               }
               j++;
            }
         }
         return contact;
      }
      
      private function method_656(tankEntry1:name_568, tankEntry2:name_568, contact:name_630) : name_630
      {
         var primitive1:name_235 = null;
         var numSimplePrimitives2:int = 0;
         var j:int = 0;
         var primitive2:name_235 = null;
         var skipCollision:Boolean = false;
         var body1:name_271 = tankEntry1.body;
         var body2:name_271 = tankEntry2.body;
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
      
      private function method_666(primitives1:name_601, primitives2:name_601) : Boolean
      {
         var item2:name_513 = null;
         for(var item1:name_513 = primitives1.head; item1 != null; )
         {
            for(item2 = primitives2.head; item2 != null; )
            {
               if(this.method_554(item1.primitive,item2.primitive))
               {
                  return true;
               }
               item2 = item2.next;
            }
            item1 = item1.next;
         }
         return false;
      }
      
      private function method_667(primitives:name_601) : Boolean
      {
         for(var item:name_513 = primitives.head; item != null; )
         {
            if(this.method_657(item.primitive))
            {
               return true;
            }
            item = item.next;
         }
         return false;
      }
      
      private function method_653(node:name_656, primitive:name_235, contact:name_630) : name_630
      {
         var min:Number = NaN;
         var max:Number = NaN;
         var primitives:Vector.<name_235> = null;
         var indices:Vector.<int> = null;
         var i:int = 0;
         if(node.indices != null)
         {
            primitives = this.var_592.name_661;
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
               min = primitive.aabb.minX;
               max = primitive.aabb.maxX;
               break;
            case 1:
               min = primitive.aabb.minY;
               max = primitive.aabb.maxY;
               break;
            case 2:
               min = primitive.aabb.minZ;
               max = primitive.aabb.maxZ;
         }
         if(min < node.coord)
         {
            contact = this.method_653(node.name_657,primitive,contact);
         }
         if(max > node.coord)
         {
            contact = this.method_653(node.name_658,primitive,contact);
         }
         if(node.name_660 != null && min < node.coord && max > node.coord)
         {
            contact = this.method_653(node.name_660.name_659,primitive,contact);
         }
         return contact;
      }
      
      private function method_654(primitive:name_235, node:name_656) : Boolean
      {
         var min:Number = NaN;
         var max:Number = NaN;
         var primitives:Vector.<name_235> = null;
         var indices:Vector.<int> = null;
         var i:int = 0;
         if(node.indices != null)
         {
            primitives = this.var_592.name_661;
            indices = node.indices;
            for(i = indices.length - 1; i >= 0; )
            {
               if(this.method_554(primitive,primitives[indices[i]]))
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
               min = primitive.aabb.minX;
               max = primitive.aabb.maxX;
               break;
            case 1:
               min = primitive.aabb.minY;
               max = primitive.aabb.maxY;
               break;
            case 2:
               min = primitive.aabb.minZ;
               max = primitive.aabb.maxZ;
         }
         if(node.name_660 != null && min < node.coord && max > node.coord)
         {
            if(this.method_654(primitive,node.name_660.name_659))
            {
               return true;
            }
         }
         if(min < node.coord)
         {
            if(this.method_654(primitive,node.name_657))
            {
               return true;
            }
         }
         if(max > node.coord)
         {
            if(this.method_654(primitive,node.name_658))
            {
               return true;
            }
         }
         return false;
      }
      
      private function method_658(origin:name_194, dir:name_194, collisionMask:int, maxTime:Number, filter:name_631, result:name_273) : Boolean
      {
         var tankPhysicsEntry:name_568 = null;
         var body:name_271 = null;
         var aabb:name_386 = null;
         var collisionPrimitiveListItem:name_513 = null;
         var primitive:name_235 = null;
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
            if(!(filter != null && !filter.name_664(body.collisionPrimitives.head.primitive)))
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
                           t = primitive.raycast(origin,dir,this.threshold,this.var_594);
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
      
      private function method_662(origin:name_194, dir:name_194, bb:name_386, time:MinMax) : Boolean
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
      
      private function method_652(node:name_656, origin:name_194, localOrigin:name_194, dir:name_194, collisionMask:int, t1:Number, t2:Number, filter:name_631, result:name_273) : Boolean
      {
         var splitTime:Number = NaN;
         var currChildNode:name_656 = null;
         var intersects:Boolean = false;
         var splitNode:name_656 = null;
         var i:int = 0;
         var primitive:name_235 = null;
         if(node.indices != null && this.method_660(origin,dir,collisionMask,this.var_592.name_661,node.indices,filter,result))
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
               currChildNode = localOrigin.x < node.coord ? node.name_657 : node.name_658;
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
               currChildNode = localOrigin.y < node.coord ? node.name_657 : node.name_658;
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
               currChildNode = localOrigin.z < node.coord ? node.name_657 : node.name_658;
         }
         if(splitTime < t1 || splitTime > t2)
         {
            return this.method_652(currChildNode,origin,localOrigin,dir,collisionMask,t1,t2,filter,result);
         }
         intersects = this.method_652(currChildNode,origin,localOrigin,dir,collisionMask,t1,splitTime,filter,result);
         if(intersects)
         {
            return true;
         }
         this.var_590.x = origin.x + splitTime * dir.x;
         this.var_590.y = origin.y + splitTime * dir.y;
         this.var_590.z = origin.z + splitTime * dir.z;
         if(node.name_660 != null)
         {
            splitNode = node.name_660.name_659;
            while(splitNode != null && splitNode.axis != -1)
            {
               switch(splitNode.axis)
               {
                  case 0:
                     splitNode = this.var_590.x < splitNode.coord ? splitNode.name_657 : splitNode.name_658;
                     break;
                  case 1:
                     splitNode = this.var_590.y < splitNode.coord ? splitNode.name_657 : splitNode.name_658;
                     break;
                  case 2:
                     splitNode = this.var_590.z < splitNode.coord ? splitNode.name_657 : splitNode.name_658;
                     break;
               }
            }
            if(splitNode != null && splitNode.indices != null)
            {
               for(i = splitNode.indices.length - 1; i >= 0; )
               {
                  primitive = this.var_592.name_661[splitNode.indices[i]];
                  if((primitive.collisionGroup & collisionMask) != 0)
                  {
                     if(!(filter != null && !filter.name_664(primitive)))
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
         return this.method_652(currChildNode == node.name_657 ? node.name_658 : node.name_657,origin,this.var_590,dir,collisionMask,splitTime,t2,filter,result);
      }
      
      private function method_660(origin:name_194, dir:name_194, collisionMask:int, primitives:Vector.<name_235>, indices:Vector.<int>, filter:name_631, intersection:name_273) : Boolean
      {
         var primitive:name_235 = null;
         var t:Number = NaN;
         var pnum:int = int(indices.length);
         var minTime:Number = 1e+308;
         for(var i:int = 0; i < pnum; )
         {
            primitive = primitives[indices[i]];
            if((primitive.collisionGroup & collisionMask) != 0)
            {
               if(!(filter != null && !filter.name_664(primitive)))
               {
                  t = primitive.raycast(origin,dir,this.threshold,this.var_594);
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
      
      private function method_663(body1:name_271, body2:name_271, contact:name_630) : name_630
      {
         return this.method_661(body1.collisionPrimitives,body2.collisionPrimitives,contact);
      }
      
      private function method_661(primitives1:name_601, primitives2:name_601, contact:name_630) : name_630
      {
         var item2:name_513 = null;
         for(var item1:name_513 = primitives1.head; item1 != null; )
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
