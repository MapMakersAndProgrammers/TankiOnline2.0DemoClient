package alternativa.physics.collision
{
   import alternativa.physics.collision.types.BoundBox;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.physics.Contact;
   import alternativa.physics.Body;
   import alternativa.math.Vector3;
   import alternativa.physics.collision.colliders.SphereSphereCollider;
   import alternativa.physics.collision.colliders.BoxRectCollider;
   import alternativa.physics.collision.colliders.BoxSphereCollider;
   import alternativa.physics.collision.colliders.BoxBoxCollider;
   import alternativa.physics.collision.colliders.BoxTriangleCollider;
   
   public class KdTreeCollisionDetector implements ICollisionDetector
   {
      private static var _rayAABB:BoundBox = new BoundBox();
      
      public var §_-bw§:CollisionKdTree;
      
      public var §_-Fz§:Vector.<CollisionPrimitive>;
      
      public var §_-iH§:int;
      
      public var threshold:Number = 0.0001;
      
      private var §_-P6§:Object = {};
      
      private var §_-qC§:MinMax = new MinMax();
      
      private var §_-k8§:Vector3 = new Vector3();
      
      private var §_-0q§:Vector3 = new Vector3();
      
      private var §_-2P§:RayHit = new RayHit();
      
      public function KdTreeCollisionDetector()
      {
         super();
         this.§_-bw§ = new CollisionKdTree();
         this.§_-Fz§ = new Vector.<CollisionPrimitive>();
         this.addCollider(CollisionPrimitive.BOX,CollisionPrimitive.BOX,new BoxBoxCollider());
         this.addCollider(CollisionPrimitive.BOX,CollisionPrimitive.SPHERE,new BoxSphereCollider());
         this.addCollider(CollisionPrimitive.BOX,CollisionPrimitive.RECT,new BoxRectCollider());
         this.addCollider(CollisionPrimitive.BOX,CollisionPrimitive.TRIANGLE,new BoxTriangleCollider());
         this.addCollider(CollisionPrimitive.SPHERE,CollisionPrimitive.SPHERE,new SphereSphereCollider());
      }
      
      public function addPrimitive(primitive:CollisionPrimitive, isStatic:Boolean = true) : Boolean
      {
         return true;
      }
      
      public function removePrimitive(primitive:CollisionPrimitive, isStatic:Boolean = true) : Boolean
      {
         return true;
      }
      
      public function init(collisionPrimitives:Vector.<CollisionPrimitive>) : void
      {
         this.§_-bw§.createTree(collisionPrimitives);
      }
      
      public function getAllContacts(contacts:Contact) : Contact
      {
         return contacts;
      }
      
      public function getContact(prim1:CollisionPrimitive, prim2:CollisionPrimitive, contact:Contact) : Boolean
      {
         if((prim1.collisionGroup & prim2.collisionGroup) == 0)
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
         var collider:ICollider = this.§_-P6§[prim1.type <= prim2.type ? prim1.type << 16 | prim2.type : prim2.type << 16 | prim1.type] as ICollider;
         if(collider != null && Boolean(collider.getContact(prim1,prim2,contact)))
         {
            if(prim1.postCollisionFilter != null && !prim1.postCollisionFilter.§_-eZ§(prim1,prim2))
            {
               return false;
            }
            if(prim2.postCollisionFilter != null && !prim2.postCollisionFilter.§_-eZ§(prim2,prim1))
            {
               return false;
            }
            return true;
         }
         return false;
      }
      
      public function testCollision(prim1:CollisionPrimitive, prim2:CollisionPrimitive) : Boolean
      {
         if((prim1.collisionGroup & prim2.collisionGroup) == 0)
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
         var collider:ICollider = this.§_-P6§[prim1.type <= prim2.type ? prim1.type << 16 | prim2.type : prim2.type << 16 | prim1.type] as ICollider;
         if(collider != null && Boolean(collider.haveCollision(prim1,prim2)))
         {
            if(prim1.postCollisionFilter != null && !prim1.postCollisionFilter.§_-eZ§(prim1,prim2))
            {
               return false;
            }
            if(prim2.postCollisionFilter != null && !prim2.postCollisionFilter.§_-eZ§(prim2,prim1))
            {
               return false;
            }
            return true;
         }
         return false;
      }
      
      public function raycast(origin:Vector3, dir:Vector3, collisionGroup:int, maxTime:Number, predicate:IRaycastFilter, result:RayHit) : Boolean
      {
         var hasStaticIntersection:Boolean = this.raycastStatic(origin,dir,collisionGroup,maxTime,predicate,result);
         var hasDynamicIntersection:Boolean = this.intersectRayWithDynamic(origin,dir,collisionGroup,maxTime,predicate,this.§_-2P§);
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
      
      public function raycastStatic(origin:Vector3, dir:Vector3, collisionGroup:int, maxTime:Number, predicate:IRaycastFilter, result:RayHit) : Boolean
      {
         if(!this.getRayBoundBoxIntersection(origin,dir,this.§_-bw§.§_-5H§.boundBox,this.§_-qC§))
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
         var hasIntersection:Boolean = this.testRayAgainstNode(this.§_-bw§.§_-5H§,origin,this.§_-0q§,dir,collisionGroup,this.§_-qC§.min,this.§_-qC§.max,predicate,result);
         return hasIntersection ? result.t <= maxTime : false;
      }
      
      public function testBodyPrimitiveCollision(body:Body, primitive:CollisionPrimitive) : Boolean
      {
         return false;
      }
      
      private function addCollider(type1:int, type2:int, collider:ICollider) : void
      {
         this.§_-P6§[type1 <= type2 ? type1 << 16 | type2 : type2 << 16 | type1] = collider;
      }
      
      private function getPrimitiveNodeCollisions(node:CollisionKdNode, primitive:CollisionPrimitive, contacts:Contact) : Contact
      {
         return null;
      }
      
      private function intersectRayWithDynamic(origin:Vector3, dir:Vector3, collisionGroup:int, maxTime:Number, filter:IRaycastFilter, result:RayHit) : Boolean
      {
         var yy:Number = NaN;
         var minTime:Number = NaN;
         var primitive:CollisionPrimitive = null;
         var paabb:BoundBox = null;
         var t:Number = NaN;
         var xx:Number = origin.x + dir.x * maxTime;
         yy = origin.y + dir.y * maxTime;
         var zz:Number = origin.z + dir.z * maxTime;
         if(xx < origin.x)
         {
            _rayAABB.minX = xx;
            _rayAABB.maxX = origin.x;
         }
         else
         {
            _rayAABB.minX = origin.x;
            _rayAABB.maxX = xx;
         }
         if(yy < origin.y)
         {
            _rayAABB.minY = yy;
            _rayAABB.maxY = origin.y;
         }
         else
         {
            _rayAABB.minY = origin.y;
            _rayAABB.maxY = yy;
         }
         if(zz < origin.z)
         {
            _rayAABB.minZ = zz;
            _rayAABB.maxZ = origin.z;
         }
         else
         {
            _rayAABB.minZ = origin.z;
            _rayAABB.maxZ = zz;
         }
         minTime = maxTime + 1;
         for(var i:int = 0; i < this.§_-iH§; )
         {
            primitive = this.§_-Fz§[i];
            if((primitive.collisionGroup & collisionGroup) != 0)
            {
               paabb = primitive.aabb;
               if(!(_rayAABB.maxX < paabb.minX || _rayAABB.minX > paabb.maxX || _rayAABB.maxY < paabb.minY || _rayAABB.minY > paabb.maxY || _rayAABB.maxZ < paabb.minZ || _rayAABB.minZ > paabb.maxZ))
               {
                  if(!(filter != null && !filter.§_-0w§(primitive)))
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
                  }
               }
            }
            i++;
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
      
      private function testRayAgainstNode(node:CollisionKdNode, origin:Vector3, localOrigin:Vector3, dir:Vector3, collisionGroup:int, t1:Number, t2:Number, predicate:IRaycastFilter, result:RayHit) : Boolean
      {
         var splitTime:Number = NaN;
         var currChildNode:CollisionKdNode = null;
         var intersects:Boolean = false;
         if(node.indices != null && this.getRayNodeIntersection(origin,dir,collisionGroup,this.§_-bw§.§_-8A§,node.indices,predicate,result))
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
            return this.testRayAgainstNode(currChildNode,origin,localOrigin,dir,collisionGroup,t1,t2,predicate,result);
         }
         intersects = this.testRayAgainstNode(currChildNode,origin,localOrigin,dir,collisionGroup,t1,splitTime,predicate,result);
         if(intersects)
         {
            return true;
         }
         this.§_-0q§.x = origin.x + splitTime * dir.x;
         this.§_-0q§.y = origin.y + splitTime * dir.y;
         this.§_-0q§.z = origin.z + splitTime * dir.z;
         return this.testRayAgainstNode(currChildNode == node.§_-Gm§ ? node.§_-75§ : node.§_-Gm§,origin,this.§_-0q§,dir,collisionGroup,splitTime,t2,predicate,result);
      }
      
      private function getRayNodeIntersection(origin:Vector3, dir:Vector3, collisionGroup:int, primitives:Vector.<CollisionPrimitive>, indices:Vector.<int>, filter:IRaycastFilter, intersection:RayHit) : Boolean
      {
         var primitive:CollisionPrimitive = null;
         var t:Number = NaN;
         var pnum:int = int(indices.length);
         var minTime:Number = 1e+308;
         for(var i:int = 0; i < pnum; )
         {
            primitive = primitives[indices[i]];
            if((primitive.collisionGroup & collisionGroup) != 0)
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
