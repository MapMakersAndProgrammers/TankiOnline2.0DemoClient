package package_76
{
   import package_121.name_666;
   import package_121.name_667;
   import package_121.name_668;
   import package_121.name_732;
   import package_121.name_733;
   import package_46.name_194;
   import package_90.name_273;
   import package_90.name_386;
   import package_92.name_271;
   import package_92.name_630;
   
   public class name_682 implements name_256
   {
      private static var _rayAABB:name_386 = new name_386();
      
      public var var_592:name_663;
      
      public var var_684:Vector.<name_235>;
      
      public var var_685:int;
      
      public var threshold:Number = 0.0001;
      
      private var var_596:Object = {};
      
      private var var_420:MinMax = new MinMax();
      
      private var var_594:name_194 = new name_194();
      
      private var var_590:name_194 = new name_194();
      
      private var var_595:name_273 = new name_273();
      
      public function name_682()
      {
         super();
         this.var_592 = new name_663();
         this.var_684 = new Vector.<name_235>();
         this.method_655(name_235.BOX,name_235.BOX,new name_666());
         this.method_655(name_235.BOX,name_235.SPHERE,new name_733());
         this.method_655(name_235.BOX,name_235.RECT,new name_667());
         this.method_655(name_235.BOX,name_235.TRIANGLE,new name_668());
         this.method_655(name_235.SPHERE,name_235.SPHERE,new name_732());
      }
      
      public function method_844(primitive:name_235, isStatic:Boolean = true) : Boolean
      {
         return true;
      }
      
      public function method_843(primitive:name_235, isStatic:Boolean = true) : Boolean
      {
         return true;
      }
      
      public function init(collisionPrimitives:Vector.<name_235>) : void
      {
         this.var_592.name_669(collisionPrimitives);
      }
      
      public function method_553(contacts:name_630) : name_630
      {
         return contacts;
      }
      
      public function getContact(prim1:name_235, prim2:name_235, contact:name_630) : Boolean
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
         var collider:name_665 = this.var_596[prim1.type <= prim2.type ? prim1.type << 16 | prim2.type : prim2.type << 16 | prim1.type] as name_665;
         if(collider != null && Boolean(collider.getContact(prim1,prim2,contact)))
         {
            if(prim1.postCollisionFilter != null && !prim1.postCollisionFilter.name_662(prim1,prim2))
            {
               return false;
            }
            if(prim2.postCollisionFilter != null && !prim2.postCollisionFilter.name_662(prim2,prim1))
            {
               return false;
            }
            return true;
         }
         return false;
      }
      
      public function method_554(prim1:name_235, prim2:name_235) : Boolean
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
         var collider:name_665 = this.var_596[prim1.type <= prim2.type ? prim1.type << 16 | prim2.type : prim2.type << 16 | prim1.type] as name_665;
         if(collider != null && Boolean(collider.haveCollision(prim1,prim2)))
         {
            if(prim1.postCollisionFilter != null && !prim1.postCollisionFilter.name_662(prim1,prim2))
            {
               return false;
            }
            if(prim2.postCollisionFilter != null && !prim2.postCollisionFilter.name_662(prim2,prim1))
            {
               return false;
            }
            return true;
         }
         return false;
      }
      
      public function raycast(origin:name_194, dir:name_194, collisionGroup:int, maxTime:Number, predicate:name_631, result:name_273) : Boolean
      {
         var hasStaticIntersection:Boolean = this.name_324(origin,dir,collisionGroup,maxTime,predicate,result);
         var hasDynamicIntersection:Boolean = this.method_841(origin,dir,collisionGroup,maxTime,predicate,this.var_595);
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
      
      public function name_324(origin:name_194, dir:name_194, collisionGroup:int, maxTime:Number, predicate:name_631, result:name_273) : Boolean
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
         var hasIntersection:Boolean = this.method_652(this.var_592.name_659,origin,this.var_590,dir,collisionGroup,this.var_420.min,this.var_420.max,predicate,result);
         return hasIntersection ? result.t <= maxTime : false;
      }
      
      public function method_842(body:name_271, primitive:name_235) : Boolean
      {
         return false;
      }
      
      private function method_655(type1:int, type2:int, collider:name_665) : void
      {
         this.var_596[type1 <= type2 ? type1 << 16 | type2 : type2 << 16 | type1] = collider;
      }
      
      private function method_653(node:name_656, primitive:name_235, contacts:name_630) : name_630
      {
         return null;
      }
      
      private function method_841(origin:name_194, dir:name_194, collisionGroup:int, maxTime:Number, filter:name_631, result:name_273) : Boolean
      {
         var yy:Number = NaN;
         var minTime:Number = NaN;
         var primitive:name_235 = null;
         var paabb:name_386 = null;
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
                  if(!(filter != null && !filter.name_664(primitive)))
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
      
      private function method_652(node:name_656, origin:name_194, localOrigin:name_194, dir:name_194, collisionGroup:int, t1:Number, t2:Number, predicate:name_631, result:name_273) : Boolean
      {
         var splitTime:Number = NaN;
         var currChildNode:name_656 = null;
         var intersects:Boolean = false;
         if(node.indices != null && this.method_660(origin,dir,collisionGroup,this.var_592.name_661,node.indices,predicate,result))
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
            return this.method_652(currChildNode,origin,localOrigin,dir,collisionGroup,t1,t2,predicate,result);
         }
         intersects = this.method_652(currChildNode,origin,localOrigin,dir,collisionGroup,t1,splitTime,predicate,result);
         if(intersects)
         {
            return true;
         }
         this.var_590.x = origin.x + splitTime * dir.x;
         this.var_590.y = origin.y + splitTime * dir.y;
         this.var_590.z = origin.z + splitTime * dir.z;
         return this.method_652(currChildNode == node.name_657 ? node.name_658 : node.name_657,origin,this.var_590,dir,collisionGroup,splitTime,t2,predicate,result);
      }
      
      private function method_660(origin:name_194, dir:name_194, collisionGroup:int, primitives:Vector.<name_235>, indices:Vector.<int>, filter:name_631, intersection:name_273) : Boolean
      {
         var primitive:name_235 = null;
         var t:Number = NaN;
         var pnum:int = int(indices.length);
         var minTime:Number = 1e+308;
         for(var i:int = 0; i < pnum; )
         {
            primitive = primitives[indices[i]];
            if((primitive.collisionGroup & collisionGroup) != 0)
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
