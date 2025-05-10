package alternativa.tanks.game.physics
{
   import alternativa.physics.collision.CollisionKdTree;
   import alternativa.physics.collision.CollisionPrimitive;
   import alternativa.physics.collision.ICollider;
   import alternativa.physics.collision.IRaycastFilter;
   import alternativa.physics.collision.CollisionKdNode;
   import alternativa.physics.collision.types.BoundBox;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.physics.CollisionPrimitiveListItem;
   import alternativa.physics.Contact;
   import alternativa.physics.Body;
   import alternativa.physics.CollisionPrimitiveList;
   import alternativa.math.Vector3;
   import alternativa.physics.collision.colliders.BoxRectCollider;
   import alternativa.physics.collision.colliders.BoxBoxCollider;
   import alternativa.physics.collision.colliders.BoxTriangleCollider;
   
   public class TanksCollisionDetector implements ITanksCollisionDetector
   {
      public var name_bw:CollisionKdTree;
      
      public var threshold:Number = 0.0001;
      
      private var name_P6:Object;
      
      private var name_Wj:Vector.<BodyCollisionData>;
      
      private var name_LK:int;
      
      private var name_By:Vector.<Body>;
      
      private var numBodies:int;
      
      private var name_qC:MinMax = new MinMax();
      
      private var name_k8:Vector3 = new Vector3();
      
      private var name_0q:Vector3 = new Vector3();
      
      private var name_2P:RayHit = new RayHit();
      
      private var _rayAABB:BoundBox = new BoundBox();
      
      public function TanksCollisionDetector()
      {
         super();
         this.name_bw = new CollisionKdTree();
         this.name_By = new Vector.<Body>();
         this.name_Wj = new Vector.<BodyCollisionData>();
         this.name_P6 = new Object();
         this.addCollider(CollisionPrimitive.BOX,CollisionPrimitive.BOX,new BoxBoxCollider());
         this.addCollider(CollisionPrimitive.BOX,CollisionPrimitive.RECT,new BoxRectCollider());
         this.addCollider(CollisionPrimitive.BOX,CollisionPrimitive.TRIANGLE,new BoxTriangleCollider());
      }
      
      public function addStaticPrimitive(primitive:CollisionPrimitive) : void
      {
      }
      
      public function removeStaticPrimitive(primitive:CollisionPrimitive) : void
      {
      }
      
      public function prepareForRaycasts() : void
      {
      }
      
      public function buildKdTree(collisionPrimitives:Vector.<CollisionPrimitive>, boundBox:BoundBox = null) : void
      {
         this.name_bw.createTree(collisionPrimitives,boundBox);
      }
      
      public function addBodyCollisionData(tankPhysicsEntry:BodyCollisionData) : void
      {
         if(this.name_Wj.indexOf(tankPhysicsEntry) >= 0)
         {
            throw new Error("Tank entry already exists");
         }
         var _loc2_:* = this.name_LK++;
         this.name_Wj[_loc2_] = tankPhysicsEntry;
      }
      
      public function removeBodyCollisionData(tankPhysicsEntry:BodyCollisionData) : void
      {
         var index:Number = Number(this.name_Wj.indexOf(tankPhysicsEntry));
         if(index < 0)
         {
            throw new Error("Tank entry not found");
         }
         this.name_Wj[index] = this.name_Wj[--this.name_LK];
         this.name_Wj[this.name_LK] = null;
      }
      
      public function addBody(body:Body) : void
      {
         var _loc2_:* = this.numBodies++;
         this.name_By[_loc2_] = body;
      }
      
      public function removeBody(body:Body) : void
      {
         var index:int = int(this.name_By.indexOf(body));
         if(index < 0)
         {
            throw new Error("Body not found");
         }
         this.name_By[index] = this.name_By[--this.numBodies];
         this.name_By[this.numBodies] = null;
      }
      
      public function getObjectsInRadius(center:Vector3, radius:Number, filter:IRadiusQueryFilter) : Vector.<BodyDistance>
      {
         var result:Vector.<BodyDistance> = null;
         var tankPhysicsEntry:BodyCollisionData = null;
         var position:Vector3 = null;
         var dx:Number = NaN;
         var dy:Number = NaN;
         var dz:Number = NaN;
         var distance:Number = NaN;
         radius *= radius;
         for(var i:int = 0; i < this.name_LK; )
         {
            tankPhysicsEntry = this.name_Wj[i];
            position = tankPhysicsEntry.body.state.position;
            dx = position.x - center.x;
            dy = position.y - center.y;
            dz = position.z - center.z;
            distance = dx * dx + dy * dy + dz * dz;
            if(distance < radius)
            {
               if(filter == null || Boolean(filter.acceptBody(center,tankPhysicsEntry.body)))
               {
                  if(result == null)
                  {
                     result = new Vector.<BodyDistance>();
                  }
                  result.push(new BodyDistance(tankPhysicsEntry.body,Math.sqrt(distance)));
               }
            }
            i++;
         }
         return result;
      }
      
      public function getAllContacts(contact:Contact) : Contact
      {
         return this.getTankContacts(contact);
      }
      
      public function getContact(prim1:CollisionPrimitive, prim2:CollisionPrimitive, contact:Contact) : Boolean
      {
         if((prim1.collisionMask & prim2.collisionGroup) == 0 || (prim2.collisionMask & prim1.collisionGroup) == 0 || !prim1.aabb.intersects(prim2.aabb,0.01))
         {
            return false;
         }
         var collider:ICollider = this.name_P6[prim1.type | prim2.type];
         if(collider != null && Boolean(collider.getContact(prim1,prim2,contact)))
         {
            if(prim1.postCollisionFilter != null && !prim1.postCollisionFilter.acceptPrimitivesCollision(prim1,prim2))
            {
               return false;
            }
            return !(prim2.postCollisionFilter != null && !prim2.postCollisionFilter.acceptPrimitivesCollision(prim2,prim1));
         }
         return false;
      }
      
      public function testCollision(prim1:CollisionPrimitive, prim2:CollisionPrimitive) : Boolean
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
         var collider:ICollider = this.name_P6[prim1.type | prim2.type];
         if(collider != null && Boolean(collider.haveCollision(prim1,prim2)))
         {
            if(prim1.postCollisionFilter != null && !prim1.postCollisionFilter.acceptPrimitivesCollision(prim1,prim2))
            {
               return false;
            }
            return !(prim2.postCollisionFilter != null && !prim2.postCollisionFilter.acceptPrimitivesCollision(prim2,prim1));
         }
         return false;
      }
      
      public function raycast(origin:Vector3, dir:Vector3, collisionMask:int, maxTime:Number, filter:IRaycastFilter, result:RayHit) : Boolean
      {
         var hasStaticIntersection:Boolean = this.raycastStatic(origin,dir,collisionMask,maxTime,filter,result);
         var hasDynamicIntersection:Boolean = this.raycastTanks(origin,dir,collisionMask,maxTime,filter,this.name_2P);
         if(!(hasDynamicIntersection || hasStaticIntersection))
         {
            return false;
         }
         if(hasDynamicIntersection && hasStaticIntersection)
         {
            if(result.t > this.name_2P.t)
            {
               result.copy(this.name_2P);
            }
            return true;
         }
         if(hasStaticIntersection)
         {
            return true;
         }
         result.copy(this.name_2P);
         return true;
      }
      
      public function raycastStatic(origin:Vector3, dir:Vector3, collisionMask:int, maxTime:Number, filter:IRaycastFilter, result:RayHit) : Boolean
      {
         if(!this.getRayBoundBoxIntersection(origin,dir,this.name_bw.name_5H.boundBox,this.name_qC))
         {
            return false;
         }
         if(this.name_qC.max < 0 || this.name_qC.min > maxTime)
         {
            return false;
         }
         if(this.name_qC.min <= 0)
         {
            this.name_qC.min = 0;
            this.name_0q.x = origin.x;
            this.name_0q.y = origin.y;
            this.name_0q.z = origin.z;
         }
         else
         {
            this.name_0q.x = origin.x + this.name_qC.min * dir.x;
            this.name_0q.y = origin.y + this.name_qC.min * dir.y;
            this.name_0q.z = origin.z + this.name_qC.min * dir.z;
         }
         if(this.name_qC.max > maxTime)
         {
            this.name_qC.max = maxTime;
         }
         var hasIntersection:Boolean = this.testRayAgainstNode(this.name_bw.name_5H,origin,this.name_0q,dir,collisionMask,this.name_qC.min,this.name_qC.max,filter,result);
         return hasIntersection ? result.t <= maxTime : false;
      }
      
      public function testPrimitiveTreeCollision(primitive:CollisionPrimitive) : Boolean
      {
         return this.testPrimitiveNodeCollision(primitive,this.name_bw.name_5H);
      }
      
      private function addCollider(type1:int, type2:int, collider:ICollider) : void
      {
         this.name_P6[type1 | type2] = collider;
      }
      
      private function getTankContacts(contact:Contact) : Contact
      {
         var tankEntry:BodyCollisionData = null;
         var body:Body = null;
         var listItem:CollisionPrimitiveListItem = null;
         var j:int = 0;
         var otherTankEntry:BodyCollisionData = null;
         for(var i:int = 0; i < this.name_LK; i++)
         {
            tankEntry = this.name_Wj[i];
            body = tankEntry.body;
            for(listItem = body.collisionPrimitives.head; listItem != null; )
            {
               contact = this.getPrimitiveNodeCollisions(this.name_bw.name_5H,listItem.primitive,contact);
               listItem = listItem.next;
            }
            for(j = i + 1; j < this.name_LK; )
            {
               otherTankEntry = this.name_Wj[j];
               if(body.aabb.intersects(otherTankEntry.body.aabb,0.1))
               {
                  contact = this.getTanksCollision(tankEntry,otherTankEntry,contact);
               }
               j++;
            }
         }
         return contact;
      }
      
      private function getTanksCollision(tankEntry1:BodyCollisionData, tankEntry2:BodyCollisionData, contact:Contact) : Contact
      {
         var primitive1:CollisionPrimitive = null;
         var numSimplePrimitives2:int = 0;
         var j:int = 0;
         var primitive2:CollisionPrimitive = null;
         var skipCollision:Boolean = false;
         var body1:Body = tankEntry1.body;
         var body2:Body = tankEntry2.body;
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
      
      private function testContacts2(primitives1:CollisionPrimitiveList, primitives2:CollisionPrimitiveList) : Boolean
      {
         var item2:CollisionPrimitiveListItem = null;
         for(var item1:CollisionPrimitiveListItem = primitives1.head; item1 != null; )
         {
            for(item2 = primitives2.head; item2 != null; )
            {
               if(this.testCollision(item1.primitive,item2.primitive))
               {
                  return true;
               }
               item2 = item2.next;
            }
            item1 = item1.next;
         }
         return false;
      }
      
      private function primitivesHaveCollision(primitives:CollisionPrimitiveList) : Boolean
      {
         for(var item:CollisionPrimitiveListItem = primitives.head; item != null; )
         {
            if(this.testPrimitiveTreeCollision(item.primitive))
            {
               return true;
            }
            item = item.next;
         }
         return false;
      }
      
      private function getPrimitiveNodeCollisions(node:CollisionKdNode, primitive:CollisionPrimitive, contact:Contact) : Contact
      {
         var min:Number = NaN;
         var max:Number = NaN;
         var primitives:Vector.<CollisionPrimitive> = null;
         var indices:Vector.<int> = null;
         var i:int = 0;
         if(node.indices != null)
         {
            primitives = this.name_bw.name_8A;
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
            contact = this.getPrimitiveNodeCollisions(node.name_Gm,primitive,contact);
         }
         if(max > node.coord)
         {
            contact = this.getPrimitiveNodeCollisions(node.name_75,primitive,contact);
         }
         if(node.name_da != null && min < node.coord && max > node.coord)
         {
            contact = this.getPrimitiveNodeCollisions(node.name_da.name_5H,primitive,contact);
         }
         return contact;
      }
      
      private function testPrimitiveNodeCollision(primitive:CollisionPrimitive, node:CollisionKdNode) : Boolean
      {
         var min:Number = NaN;
         var max:Number = NaN;
         var primitives:Vector.<CollisionPrimitive> = null;
         var indices:Vector.<int> = null;
         var i:int = 0;
         if(node.indices != null)
         {
            primitives = this.name_bw.name_8A;
            indices = node.indices;
            for(i = indices.length - 1; i >= 0; )
            {
               if(this.testCollision(primitive,primitives[indices[i]]))
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
         if(node.name_da != null && min < node.coord && max > node.coord)
         {
            if(this.testPrimitiveNodeCollision(primitive,node.name_da.name_5H))
            {
               return true;
            }
         }
         if(min < node.coord)
         {
            if(this.testPrimitiveNodeCollision(primitive,node.name_Gm))
            {
               return true;
            }
         }
         if(max > node.coord)
         {
            if(this.testPrimitiveNodeCollision(primitive,node.name_75))
            {
               return true;
            }
         }
         return false;
      }
      
      private function raycastTanks(origin:Vector3, dir:Vector3, collisionMask:int, maxTime:Number, filter:IRaycastFilter, result:RayHit) : Boolean
      {
         var tankPhysicsEntry:BodyCollisionData = null;
         var body:Body = null;
         var aabb:BoundBox = null;
         var collisionPrimitiveListItem:CollisionPrimitiveListItem = null;
         var primitive:CollisionPrimitive = null;
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
         for(var i:int = 0; i < this.name_LK; i++)
         {
            tankPhysicsEntry = this.name_Wj[i];
            body = tankPhysicsEntry.body;
            if(!(filter != null && !filter.acceptRayHit(body.collisionPrimitives.head.primitive)))
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
                           t = Number(primitive.raycast(origin,dir,this.threshold,this.name_k8));
                           if(t > 0 && t < minTime)
                           {
                              minTime = t;
                              result.primitive = primitive;
                              result.normal.x = this.name_k8.x;
                              result.normal.y = this.name_k8.y;
                              result.normal.z = this.name_k8.z;
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
      
      private function getRayBoundBoxIntersection(origin:Vector3, dir:Vector3, bb:BoundBox, time:MinMax) : Boolean
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
      
      private function testRayAgainstNode(node:CollisionKdNode, origin:Vector3, localOrigin:Vector3, dir:Vector3, collisionMask:int, t1:Number, t2:Number, filter:IRaycastFilter, result:RayHit) : Boolean
      {
         var splitTime:Number = NaN;
         var currChildNode:CollisionKdNode = null;
         var intersects:Boolean = false;
         var splitNode:CollisionKdNode = null;
         var i:int = 0;
         var primitive:CollisionPrimitive = null;
         if(node.indices != null && this.getRayNodeIntersection(origin,dir,collisionMask,this.name_bw.name_8A,node.indices,filter,result))
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
               currChildNode = localOrigin.x < node.coord ? node.name_Gm : node.name_75;
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
               currChildNode = localOrigin.y < node.coord ? node.name_Gm : node.name_75;
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
               currChildNode = localOrigin.z < node.coord ? node.name_Gm : node.name_75;
         }
         if(splitTime < t1 || splitTime > t2)
         {
            return this.testRayAgainstNode(currChildNode,origin,localOrigin,dir,collisionMask,t1,t2,filter,result);
         }
         intersects = this.testRayAgainstNode(currChildNode,origin,localOrigin,dir,collisionMask,t1,splitTime,filter,result);
         if(intersects)
         {
            return true;
         }
         this.name_0q.x = origin.x + splitTime * dir.x;
         this.name_0q.y = origin.y + splitTime * dir.y;
         this.name_0q.z = origin.z + splitTime * dir.z;
         if(node.name_da != null)
         {
            splitNode = node.name_da.name_5H;
            while(splitNode != null && splitNode.axis != -1)
            {
               switch(splitNode.axis)
               {
                  case 0:
                     splitNode = this.name_0q.x < splitNode.coord ? splitNode.name_Gm : splitNode.name_75;
                     break;
                  case 1:
                     splitNode = this.name_0q.y < splitNode.coord ? splitNode.name_Gm : splitNode.name_75;
                     break;
                  case 2:
                     splitNode = this.name_0q.z < splitNode.coord ? splitNode.name_Gm : splitNode.name_75;
                     break;
               }
            }
            if(splitNode != null && splitNode.indices != null)
            {
               for(i = splitNode.indices.length - 1; i >= 0; )
               {
                  primitive = this.name_bw.name_8A[splitNode.indices[i]];
                  if((primitive.collisionGroup & collisionMask) != 0)
                  {
                     if(!(filter != null && !filter.acceptRayHit(primitive)))
                     {
                        result.t = primitive.raycast(origin,dir,this.threshold,result.normal);
                        if(result.t >= 0)
                        {
                           result.position.copy(this.name_0q);
                           result.primitive = primitive;
                           return true;
                        }
                     }
                  }
                  i--;
               }
            }
         }
         return this.testRayAgainstNode(currChildNode == node.name_Gm ? node.name_75 : node.name_Gm,origin,this.name_0q,dir,collisionMask,splitTime,t2,filter,result);
      }
      
      private function getRayNodeIntersection(origin:Vector3, dir:Vector3, collisionMask:int, primitives:Vector.<CollisionPrimitive>, indices:Vector.<int>, filter:IRaycastFilter, intersection:RayHit) : Boolean
      {
         var primitive:CollisionPrimitive = null;
         var t:Number = NaN;
         var pnum:int = int(indices.length);
         var minTime:Number = 1e+308;
         for(var i:int = 0; i < pnum; )
         {
            primitive = primitives[indices[i]];
            if((primitive.collisionGroup & collisionMask) != 0)
            {
               if(!(filter != null && !filter.acceptRayHit(primitive)))
               {
                  t = Number(primitive.raycast(origin,dir,this.threshold,this.name_k8));
                  if(t > 0 && t < minTime)
                  {
                     minTime = t;
                     intersection.primitive = primitive;
                     intersection.normal.x = this.name_k8.x;
                     intersection.normal.y = this.name_k8.y;
                     intersection.normal.z = this.name_k8.z;
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
      
      private function collideBodies(body1:Body, body2:Body, contact:Contact) : Contact
      {
         return this.getContacts2(body1.collisionPrimitives,body2.collisionPrimitives,contact);
      }
      
      private function getContacts2(primitives1:CollisionPrimitiveList, primitives2:CollisionPrimitiveList, contact:Contact) : Contact
      {
         var item2:CollisionPrimitiveListItem = null;
         for(var item1:CollisionPrimitiveListItem = primitives1.head; item1 != null; )
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
