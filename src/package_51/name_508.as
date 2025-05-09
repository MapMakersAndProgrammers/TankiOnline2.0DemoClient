package package_51
{
   import package_38.name_145;
   import package_58.name_189;
   import package_58.name_334;
   import package_61.name_186;
   import package_61.name_482;
   import package_84.name_495;
   import package_84.name_496;
   import package_84.name_497;
   import package_84.name_581;
   import package_84.name_582;
   
   public class name_508 implements name_169
   {
      private static var _rayAABB:name_334 = new name_334();
      
      public var var_592:name_492;
      
      public var var_684:Vector.<name_276>;
      
      public var var_685:int;
      
      public var threshold:Number = 0.0001;
      
      private var var_596:Object = {};
      
      private var var_420:MinMax = new MinMax();
      
      private var var_594:name_145 = new name_145();
      
      private var var_590:name_145 = new name_145();
      
      private var var_595:name_189 = new name_189();
      
      public function name_508()
      {
         super();
         this.var_592 = new name_492();
         this.var_684 = new Vector.<name_276>();
         this.method_239(name_276.BOX,name_276.BOX,new name_495());
         this.method_239(name_276.BOX,name_276.SPHERE,new name_582());
         this.method_239(name_276.BOX,name_276.RECT,new name_496());
         this.method_239(name_276.BOX,name_276.TRIANGLE,new name_497());
         this.method_239(name_276.SPHERE,name_276.SPHERE,new name_581());
      }
      
      public function method_349(primitive:name_276, isStatic:Boolean = true) : Boolean
      {
         return true;
      }
      
      public function method_348(primitive:name_276, isStatic:Boolean = true) : Boolean
      {
         return true;
      }
      
      public function init(collisionPrimitives:Vector.<name_276>) : void
      {
         this.var_592.name_499(collisionPrimitives);
      }
      
      public function method_254(contacts:name_482) : name_482
      {
         return contacts;
      }
      
      public function getContact(prim1:name_276, prim2:name_276, contact:name_482) : Boolean
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
         var collider:name_494 = this.var_596[prim1.type <= prim2.type ? prim1.type << 16 | prim2.type : prim2.type << 16 | prim1.type] as name_494;
         if(collider != null && Boolean(collider.getContact(prim1,prim2,contact)))
         {
            if(prim1.postCollisionFilter != null && !prim1.postCollisionFilter.name_491(prim1,prim2))
            {
               return false;
            }
            if(prim2.postCollisionFilter != null && !prim2.postCollisionFilter.name_491(prim2,prim1))
            {
               return false;
            }
            return true;
         }
         return false;
      }
      
      public function method_240(prim1:name_276, prim2:name_276) : Boolean
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
         var collider:name_494 = this.var_596[prim1.type <= prim2.type ? prim1.type << 16 | prim2.type : prim2.type << 16 | prim1.type] as name_494;
         if(collider != null && Boolean(collider.haveCollision(prim1,prim2)))
         {
            if(prim1.postCollisionFilter != null && !prim1.postCollisionFilter.name_491(prim1,prim2))
            {
               return false;
            }
            if(prim2.postCollisionFilter != null && !prim2.postCollisionFilter.name_491(prim2,prim1))
            {
               return false;
            }
            return true;
         }
         return false;
      }
      
      public function raycast(origin:name_145, dir:name_145, collisionGroup:int, maxTime:Number, predicate:name_488, result:name_189) : Boolean
      {
         var hasStaticIntersection:Boolean = this.name_246(origin,dir,collisionGroup,maxTime,predicate,result);
         var hasDynamicIntersection:Boolean = this.method_346(origin,dir,collisionGroup,maxTime,predicate,this.var_595);
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
      
      public function name_246(origin:name_145, dir:name_145, collisionGroup:int, maxTime:Number, predicate:name_488, result:name_189) : Boolean
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
         var hasIntersection:Boolean = this.method_236(this.var_592.name_486,origin,this.var_590,dir,collisionGroup,this.var_420.min,this.var_420.max,predicate,result);
         return hasIntersection ? result.t <= maxTime : false;
      }
      
      public function method_347(body:name_186, primitive:name_276) : Boolean
      {
         return false;
      }
      
      private function method_239(type1:int, type2:int, collider:name_494) : void
      {
         this.var_596[type1 <= type2 ? type1 << 16 | type2 : type2 << 16 | type1] = collider;
      }
      
      private function method_237(node:name_481, primitive:name_276, contacts:name_482) : name_482
      {
         return null;
      }
      
      private function method_346(origin:name_145, dir:name_145, collisionGroup:int, maxTime:Number, filter:name_488, result:name_189) : Boolean
      {
         var yy:Number = NaN;
         var minTime:Number = NaN;
         var primitive:name_276 = null;
         var paabb:name_334 = null;
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
         for(var i:int = 0; i < this.var_685; )
         {
            primitive = this.var_684[i];
            if((primitive.collisionGroup & collisionGroup) != 0)
            {
               paabb = primitive.aabb;
               if(!(_rayAABB.maxX < paabb.minX || _rayAABB.minX > paabb.maxX || _rayAABB.maxY < paabb.minY || _rayAABB.minY > paabb.maxY || _rayAABB.maxZ < paabb.minZ || _rayAABB.minZ > paabb.maxZ))
               {
                  if(!(filter != null && !filter.name_493(primitive)))
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
      
      private function method_236(node:name_481, origin:name_145, localOrigin:name_145, dir:name_145, collisionGroup:int, t1:Number, t2:Number, predicate:name_488, result:name_189) : Boolean
      {
         var splitTime:Number = NaN;
         var currChildNode:name_481 = null;
         var intersects:Boolean = false;
         if(node.indices != null && this.method_245(origin,dir,collisionGroup,this.var_592.name_490,node.indices,predicate,result))
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
            return this.method_236(currChildNode,origin,localOrigin,dir,collisionGroup,t1,t2,predicate,result);
         }
         intersects = this.method_236(currChildNode,origin,localOrigin,dir,collisionGroup,t1,splitTime,predicate,result);
         if(intersects)
         {
            return true;
         }
         this.var_590.x = origin.x + splitTime * dir.x;
         this.var_590.y = origin.y + splitTime * dir.y;
         this.var_590.z = origin.z + splitTime * dir.z;
         return this.method_236(currChildNode == node.name_483 ? node.name_484 : node.name_483,origin,this.var_590,dir,collisionGroup,splitTime,t2,predicate,result);
      }
      
      private function method_245(origin:name_145, dir:name_145, collisionGroup:int, primitives:Vector.<name_276>, indices:Vector.<int>, filter:name_488, intersection:name_189) : Boolean
      {
         var primitive:name_276 = null;
         var t:Number = NaN;
         var pnum:int = int(indices.length);
         var minTime:Number = 1e+308;
         for(var i:int = 0; i < pnum; )
         {
            primitive = primitives[indices[i]];
            if((primitive.collisionGroup & collisionGroup) != 0)
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
