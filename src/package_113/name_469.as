package package_113
{
   import package_109.name_377;
   import package_121.name_666;
   import package_121.name_667;
   import package_121.name_668;
   import package_46.name_194;
   import package_76.name_235;
   import package_76.name_631;
   import package_76.name_665;
   import package_86.*;
   import package_90.name_273;
   import package_90.name_386;
   import package_92.name_271;
   import package_92.name_630;
   
   public class name_469 implements name_468
   {
      private static var timestamp:int;
      
      private static const MAX_OBJECTS:int = 200;
      
      private static var BIG_VALUE:Number = 1000000;
      
      private static var EPSILON:Number = 0.0001;
      
      private static var normal:name_194 = new name_194();
      
      private static var collisionBox:name_377 = new name_377(new name_194(),4294967295,0);
      
      private var cellSize:Number;
      
      private var var_609:name_386 = new name_386();
      
      private var denseArray:Vector.<name_235>;
      
      private var denseCellIndices:Vector.<int>;
      
      private var var_613:int;
      
      private var numCellsX:int;
      
      private var numCellsY:int;
      
      private var numCellsZ:int;
      
      private var var_616:int;
      
      private var var_615:Vector.<int>;
      
      private var var_618:int;
      
      private var var_611:Vector.<name_685>;
      
      private var var_612:int;
      
      private var bodyCellEntries:Vector.<BodyCellEntry>;
      
      private var var_596:Object;
      
      private var var_610:RaycastCellVisitor;
      
      private var var_614:OccupiedCellIndex;
      
      private var var_617:Boolean;
      
      public function name_469()
      {
         super();
         this.var_611 = new Vector.<name_685>();
         this.var_610 = new RaycastCellVisitor();
         this.method_690();
         this.method_686();
      }
      
      private function method_655(type1:int, type2:int, collider:name_665) : void
      {
         this.var_596[type1 | type2] = collider;
      }
      
      public function name_591(bodyCollisionData:name_568) : void
      {
         if(this.method_683(bodyCollisionData.body) >= 0)
         {
            throw new Error("Body collision data already exists");
         }
         var bodyCollisionGridData:name_685 = name_685.create();
         bodyCollisionGridData.body = bodyCollisionData.body;
         bodyCollisionGridData.detailedPrimitives = bodyCollisionData.detailedPrimitives;
         bodyCollisionGridData.simplePrimitives = bodyCollisionData.simplePrimitives;
         bodyCollisionGridData.index = this.var_612;
         var _loc3_:* = this.var_612++;
         this.var_611[_loc3_] = bodyCollisionGridData;
         this.var_617 = true;
      }
      
      public function name_590(bodyCollisionData:name_568) : void
      {
         var index:int = this.method_683(bodyCollisionData.body);
         if(index < 0)
         {
            throw new Error("Body collision data not found");
         }
         --this.var_612;
         var lastBodyEntry:name_685 = this.var_611[this.var_612];
         lastBodyEntry.index = index;
         name_685(this.var_611[index]).destroy();
         this.var_611[index] = lastBodyEntry;
         this.var_611[this.var_612] = null;
         this.var_617 = true;
      }
      
      public function name_470() : void
      {
         this.method_680();
      }
      
      public function method_696() : Number
      {
         return this.cellSize;
      }
      
      public function method_700() : name_386
      {
         return this.var_609.clone();
      }
      
      public function method_697() : int
      {
         return this.numCellsX;
      }
      
      public function method_699() : int
      {
         return this.numCellsY;
      }
      
      public function method_698() : int
      {
         return this.numCellsZ;
      }
      
      public function method_701() : int
      {
         return this.var_616;
      }
      
      public function method_695(x:int, y:int, z:int) : int
      {
         var cellIndex:int = x * this.numCellsY * this.numCellsZ + y * this.numCellsZ + z;
         return this.denseCellIndices[cellIndex] >>> 24;
      }
      
      public function name_472(cellSize:Number, staticPrimitives:Vector.<name_235>) : void
      {
         this.method_693(staticPrimitives,cellSize);
         this.method_684(staticPrimitives);
         this.method_689();
      }
      
      public function method_651(center:name_194, radius:Number, filter:name_655) : Vector.<name_654>
      {
         var result:Vector.<name_654> = null;
         var j:int = 0;
         var k:int = 0;
         var index:int = 0;
         var bodyCellEntry:BodyCellEntry = null;
         var data:name_685 = null;
         var body:name_271 = null;
         var position:name_194 = null;
         var dx:Number = NaN;
         var dy:Number = NaN;
         var dz:Number = NaN;
         var d:Number = NaN;
         var imin:int = this.clamp((center.x - radius - this.var_609.minX) / this.cellSize,0,this.numCellsX - 1);
         var imax:int = this.clamp((center.x + radius - this.var_609.minX) / this.cellSize,0,this.numCellsX - 1);
         var jmin:int = this.clamp((center.y - radius - this.var_609.minY) / this.cellSize,0,this.numCellsY - 1);
         var jmax:int = this.clamp((center.y + radius - this.var_609.minY) / this.cellSize,0,this.numCellsY - 1);
         var kmin:int = this.clamp((center.z - radius - this.var_609.minZ) / this.cellSize,0,this.numCellsZ - 1);
         var kmax:int = this.clamp((center.z + radius - this.var_609.minZ) / this.cellSize,0,this.numCellsZ - 1);
         var ts:int = int(++timestamp);
         var radiusSqr:Number = radius * radius;
         for(var i:int = imin; i <= imax; i++)
         {
            for(j = jmin; j <= jmax; j++)
            {
               for(k = kmin; k <= kmax; k++)
               {
                  index = i * this.numCellsY * this.numCellsZ + j * this.numCellsZ + k;
                  for(bodyCellEntry = this.bodyCellEntries[index]; bodyCellEntry != null; )
                  {
                     data = bodyCellEntry.data;
                     if(data.timestamp != ts)
                     {
                        data.timestamp = ts;
                        body = data.body;
                        position = body.state.position;
                        dx = position.x - center.x;
                        dy = position.y - center.y;
                        dz = position.z - center.z;
                        d = dx * dx + dy * dy + dz * dz;
                        if(d < radiusSqr)
                        {
                           if(filter == null || Boolean(filter.name_670(center,body)))
                           {
                              if(result == null)
                              {
                                 result = new Vector.<name_654>();
                              }
                              result.push(new name_654(body,Math.sqrt(d)));
                           }
                        }
                     }
                     bodyCellEntry = bodyCellEntry.next;
                  }
               }
            }
         }
         return result;
      }
      
      public function method_553(contacts:name_630) : name_630
      {
         var bodyCollisionData:name_685 = null;
         this.method_680();
         for(var i:int = 0; i < this.var_612; i++)
         {
            bodyCollisionData = this.var_611[i];
            contacts = this.method_687(bodyCollisionData,contacts);
         }
         return this.method_692(contacts);
      }
      
      private function method_689() : void
      {
         this.var_610.denseArray = this.denseArray;
         this.var_610.denseCellIndices = this.denseCellIndices;
         this.var_610.numCellsX = this.numCellsX;
         this.var_610.numCellsY = this.numCellsY;
         this.var_610.numCellsZ = this.numCellsZ;
      }
      
      private function method_693(staticPrimitives:Vector.<name_235>, cellSize:Number) : void
      {
         var collisionPrimitive:name_235 = null;
         this.cellSize = cellSize;
         this.var_609.name_584();
         for each(collisionPrimitive in staticPrimitives)
         {
            this.var_609.name_583(collisionPrimitive.calculateAABB());
         }
         this.var_609.name_686(cellSize + EPSILON);
         this.numCellsX = int(this.var_609.name_689() / cellSize) + 1;
         this.numCellsY = int(this.var_609.name_688() / cellSize) + 1;
         this.numCellsZ = int(this.var_609.name_690() / cellSize) + 1;
         this.var_613 = this.numCellsX * this.numCellsY * this.numCellsZ;
         this.var_609.maxX = this.var_609.minX + this.numCellsX * cellSize;
         this.var_609.maxY = this.var_609.minY + this.numCellsY * cellSize;
         this.var_609.maxZ = this.var_609.minZ + this.numCellsZ * cellSize;
         this.bodyCellEntries = new Vector.<BodyCellEntry>(this.var_613);
      }
      
      private function method_684(staticPrimitives:Vector.<name_235>) : void
      {
         var index:int = 0;
         var denseArraySize:int = 0;
         var lastIndex:int = 0;
         var numCellPrimitives:int = 0;
         var collisionPrimitive:name_235 = null;
         var bb:name_386 = null;
         var imin:int = 0;
         var imax:int = 0;
         var jmin:int = 0;
         var jmax:int = 0;
         var kmin:int = 0;
         var kmax:int = 0;
         var i:int = 0;
         var j:int = 0;
         var k:int = 0;
         var cellIndex:int = 0;
         var denseCellIndex:int = 0;
         var cellCounters:Vector.<int> = this.method_685(staticPrimitives);
         this.var_616 = 0;
         this.denseCellIndices = new Vector.<int>(this.var_613);
         for(index = 0; index < this.var_613; index++)
         {
            numCellPrimitives = cellCounters[index];
            if(numCellPrimitives > this.var_616)
            {
               this.var_616 = numCellPrimitives;
            }
            denseArraySize += numCellPrimitives;
            this.denseCellIndices[index] = numCellPrimitives << 24 | lastIndex;
            lastIndex += numCellPrimitives;
            cellCounters[index] = 0;
         }
         this.denseArray = new Vector.<name_235>(denseArraySize);
         var numPrimitives:int = int(staticPrimitives.length);
         for(index = 0; index < numPrimitives; index++)
         {
            collisionPrimitive = staticPrimitives[index];
            bb = collisionPrimitive.aabb;
            imin = (bb.minX - this.var_609.minX) / this.cellSize;
            imax = (bb.maxX - this.var_609.minX) / this.cellSize;
            jmin = (bb.minY - this.var_609.minY) / this.cellSize;
            jmax = (bb.maxY - this.var_609.minY) / this.cellSize;
            kmin = (bb.minZ - this.var_609.minZ) / this.cellSize;
            kmax = (bb.maxZ - this.var_609.minZ) / this.cellSize;
            for(i = imin; i <= imax; i++)
            {
               for(j = jmin; j <= jmax; j++)
               {
                  for(k = kmin; k <= kmax; k++)
                  {
                     cellIndex = i * this.numCellsY * this.numCellsZ + j * this.numCellsZ + k;
                     denseCellIndex = this.denseCellIndices[cellIndex] & 0xFFFFFF;
                     this.denseArray[denseCellIndex + cellCounters[cellIndex]] = collisionPrimitive;
                     ++cellCounters[cellIndex];
                  }
               }
            }
         }
      }
      
      private function method_685(staticPrimitives:Vector.<name_235>) : Vector.<int>
      {
         var bb:name_386 = null;
         var imin:int = 0;
         var imax:int = 0;
         var jmin:int = 0;
         var jmax:int = 0;
         var kmin:int = 0;
         var kmax:int = 0;
         var i:int = 0;
         var j:int = 0;
         var k:int = 0;
         var cellIndex:int = 0;
         var cellPrimitiveCounters:Vector.<int> = new Vector.<int>(this.var_613);
         var numPrimitives:int = int(staticPrimitives.length);
         for(var index:int = 0; index < numPrimitives; index++)
         {
            bb = staticPrimitives[index].aabb;
            imin = (bb.minX - this.var_609.minX) / this.cellSize;
            imax = (bb.maxX - this.var_609.minX) / this.cellSize;
            jmin = (bb.minY - this.var_609.minY) / this.cellSize;
            jmax = (bb.maxY - this.var_609.minY) / this.cellSize;
            kmin = (bb.minZ - this.var_609.minZ) / this.cellSize;
            kmax = (bb.maxZ - this.var_609.minZ) / this.cellSize;
            for(i = imin; i <= imax; i++)
            {
               for(j = jmin; j <= jmax; j++)
               {
                  for(k = kmin; k <= kmax; k++)
                  {
                     cellIndex = i * this.numCellsY * this.numCellsZ + j * this.numCellsZ + k;
                     ++cellPrimitiveCounters[cellIndex];
                  }
               }
            }
         }
         return cellPrimitiveCounters;
      }
      
      private function method_692(contacts:name_630) : name_630
      {
         var currentBodyCellEntry:BodyCellEntry = null;
         var currentBodyData:name_685 = null;
         var bodyCollisionGridData:name_685 = null;
         var imin:int = 0;
         var imax:int = 0;
         var jmin:int = 0;
         var jmax:int = 0;
         var kmin:int = 0;
         var kmax:int = 0;
         var thisCell:int = 0;
         var i:int = 0;
         var j:int = 0;
         var k:int = 0;
         var cellIndex:int = 0;
         this.method_694();
         var numBodies:int = int(this.var_611.length);
         for(var occupiedCell:OccupiedCellIndex = this.var_614; occupiedCell != null; )
         {
            for(currentBodyCellEntry = this.bodyCellEntries[occupiedCell.index]; currentBodyCellEntry != null; )
            {
               currentBodyData = currentBodyCellEntry.data;
               contacts = this.method_682(currentBodyData.body,currentBodyData.index,currentBodyData.simplePrimitives,currentBodyCellEntry.next,numBodies,contacts);
               bodyCollisionGridData = currentBodyCellEntry.data;
               imin = bodyCollisionGridData.i & 0xFFFF;
               imax = bodyCollisionGridData.i >>> 16;
               jmin = bodyCollisionGridData.j & 0xFFFF;
               jmax = bodyCollisionGridData.j >>> 16;
               kmin = bodyCollisionGridData.k & 0xFFFF;
               kmax = bodyCollisionGridData.k >>> 16;
               thisCell = imin * this.numCellsY * this.numCellsZ + jmin * this.numCellsZ + kmin;
               for(i = imin; i <= imax; i++)
               {
                  for(j = jmin; j <= jmax; j++)
                  {
                     for(k = kmin; k <= kmax; )
                     {
                        cellIndex = i * this.numCellsY * this.numCellsZ + j * this.numCellsZ + k;
                        if(cellIndex != thisCell)
                        {
                           contacts = this.method_682(currentBodyData.body,currentBodyData.index,currentBodyData.simplePrimitives,this.bodyCellEntries[cellIndex],numBodies,contacts);
                        }
                        k++;
                     }
                  }
               }
               currentBodyCellEntry = currentBodyCellEntry.next;
            }
            occupiedCell = occupiedCell.next;
         }
         return contacts;
      }
      
      private function method_682(body:name_271, bodyIndex:int, bodyPrimitives:Vector.<name_235>, cellStartEntry:BodyCellEntry, numBodies:int, contacts:name_630) : name_630
      {
         var index2:int = 0;
         var min:int = 0;
         var max:int = 0;
         var bitIndex:int = 0;
         var mask:int = 0;
         var body2:name_271 = null;
         var bodyPrimitives2:Vector.<name_235> = null;
         var numPrimitives2:int = 0;
         var i:int = 0;
         var collisionPrimitive1:name_235 = null;
         var j:int = 0;
         var collisionPrimitive2:name_235 = null;
         for(var numPrimitives1:int = int(bodyPrimitives.length); cellStartEntry != null; )
         {
            if(cellStartEntry.data.body != body)
            {
               index2 = cellStartEntry.data.index;
               min = bodyIndex;
               max = index2;
               if(bodyIndex > index2)
               {
                  min = index2;
                  max = bodyIndex;
               }
               bitIndex = min * (2 * numBodies - min - 3) / 2 + max - 1;
               mask = 1 << (bitIndex & 0x1F);
               if((this.var_615[bitIndex >>> 5] & mask) == 0)
               {
                  this.var_615[bitIndex >>> 5] |= mask;
                  body2 = cellStartEntry.data.body;
                  if(body2.aabb.intersects(body.aabb,EPSILON))
                  {
                     bodyPrimitives2 = cellStartEntry.data.simplePrimitives;
                     numPrimitives2 = int(bodyPrimitives2.length);
                     for(i = 0; i < numPrimitives1; i++)
                     {
                        collisionPrimitive1 = bodyPrimitives[i];
                        for(j = 0; j < numPrimitives2; j++)
                        {
                           collisionPrimitive2 = bodyPrimitives2[j];
                           if(!((collisionPrimitive1.collisionGroup & collisionPrimitive2.collisionMask) == 0 || (collisionPrimitive1.collisionMask & collisionPrimitive2.collisionGroup) == 0 || !collisionPrimitive1.aabb.intersects(collisionPrimitive2.aabb,EPSILON)))
                           {
                              contacts = this.method_691(body,bodyPrimitives,numPrimitives1,body2,bodyPrimitives2,numPrimitives2,contacts);
                           }
                        }
                     }
                  }
               }
            }
            cellStartEntry = cellStartEntry.next;
         }
         return contacts;
      }
      
      private function method_691(body1:name_271, primitives1:Vector.<name_235>, numPrimitives1:int, body2:name_271, primitives2:Vector.<name_235>, numPrimitives2:int, contact:name_630) : name_630
      {
         var primitive1:name_235 = null;
         var j:int = 0;
         var primitive2:name_235 = null;
         var skipCollision:Boolean = false;
         var firstFilterTest:Boolean = true;
         for(var i:int = 0; i < numPrimitives1; i++)
         {
            primitive1 = primitives1[i];
            for(j = 0; j < numPrimitives2; )
            {
               primitive2 = primitives2[j];
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
      
      private function method_694() : void
      {
         for(var i:int = 0; i < this.var_618; i++)
         {
            this.var_615[i] = 0;
         }
      }
      
      private function method_687(bodyCollisionData:name_685, contacts:name_630) : name_630
      {
         var jj:int = 0;
         var kk:int = 0;
         var cellIndex:int = 0;
         var denseIndexStart:int = 0;
         var denseIndexEnd:int = 0;
         var index:int = 0;
         var staticCollisionPrimitive:name_235 = null;
         var bpi:int = 0;
         var bodyCollisionPrimitive:name_235 = null;
         var imin:int = bodyCollisionData.i & 0xFFFF;
         var imax:int = bodyCollisionData.i >>> 16;
         var jmin:int = bodyCollisionData.j & 0xFFFF;
         var jmax:int = bodyCollisionData.j >>> 16;
         var kmin:int = bodyCollisionData.k & 0xFFFF;
         var kmax:int = bodyCollisionData.k >>> 16;
         var tstamp:int = int(++timestamp);
         var bodyPrimitives:Vector.<name_235> = bodyCollisionData.detailedPrimitives;
         var numBodyPrimitives:int = int(bodyPrimitives.length);
         for(var ii:int = imin; ii <= imax; ii++)
         {
            for(jj = jmin; jj <= jmax; jj++)
            {
               for(kk = kmin; kk <= kmax; kk++)
               {
                  cellIndex = ii * this.numCellsY * this.numCellsZ + jj * this.numCellsZ + kk;
                  denseIndexStart = this.denseCellIndices[cellIndex] & 0xFFFFFF;
                  denseIndexEnd = denseIndexStart + (this.denseCellIndices[cellIndex] >>> 24);
                  for(index = denseIndexStart; index < denseIndexEnd; )
                  {
                     staticCollisionPrimitive = this.denseArray[index];
                     if(staticCollisionPrimitive.timestamp != tstamp)
                     {
                        staticCollisionPrimitive.timestamp = tstamp;
                        for(bpi = 0; bpi < numBodyPrimitives; )
                        {
                           bodyCollisionPrimitive = bodyPrimitives[bpi];
                           if(this.getContact(bodyCollisionPrimitive,staticCollisionPrimitive,contacts))
                           {
                              contacts = contacts.next;
                           }
                           bpi++;
                        }
                     }
                     index++;
                  }
               }
            }
         }
         return contacts;
      }
      
      public function raycast(origin:name_194, direction:name_194, collisionMask:int, maxTime:Number, filter:name_631, result:name_273) : Boolean
      {
         if(this.var_617)
         {
            this.method_680();
         }
         this.var_610.collisionMask = collisionMask;
         this.var_610.filter = filter;
         this.var_610.result = result;
         this.var_610.bodyCellEntries = this.bodyCellEntries;
         this.method_681(origin,direction,maxTime,this.var_610);
         this.var_610.clear();
         if(this.var_610.hasHit)
         {
            if(result.t < maxTime)
            {
               result.position.copy(origin).method_362(result.t,direction);
               return true;
            }
         }
         return false;
      }
      
      public function name_324(origin:name_194, direction:name_194, collisionMask:int, maxTime:Number, filter:name_631, result:name_273) : Boolean
      {
         this.var_610.collisionMask = collisionMask;
         this.var_610.filter = filter;
         this.var_610.result = result;
         this.method_681(origin,direction,maxTime,this.var_610);
         this.var_610.clear();
         if(this.var_610.hasHit)
         {
            if(result.t < maxTime)
            {
               result.position.copy(origin).method_362(result.t,direction);
               return true;
            }
         }
         return false;
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
         return false;
      }
      
      public function method_681(origin:name_194, direction:name_194, maxTime:Number, visitor:class_34) : void
      {
         var t:Number = NaN;
         var i:int = 0;
         var j:int = 0;
         var k:int = 0;
         var cellMaxTime:Number = NaN;
         var tstamp:int = int(++timestamp);
         var x1:Number = origin.x - this.var_609.minX;
         var y1:Number = origin.y - this.var_609.minY;
         var z1:Number = origin.z - this.var_609.minZ;
         var x2:Number = x1 + direction.x * maxTime;
         var y2:Number = y1 + direction.y * maxTime;
         var z2:Number = z1 + direction.z * maxTime;
         var axis:int = -1;
         var entryTime:Number = 0;
         var p:name_194 = new name_194();
         var pointInBounds:Boolean = this.var_609.name_687(origin,EPSILON);
         if(!pointInBounds)
         {
            collisionBox.hs.reset(this.cellSize * this.numCellsX / 2,this.cellSize * this.numCellsY / 2,this.cellSize * this.numCellsZ / 2);
            collisionBox.transform.d = this.var_609.minX + collisionBox.hs.x;
            collisionBox.transform.h = this.var_609.minY + collisionBox.hs.y;
            collisionBox.transform.l = this.var_609.minZ + collisionBox.hs.z;
            collisionBox.calculateAABB();
            t = collisionBox.raycast(origin,direction,EPSILON,normal);
            if(t < 0 || t >= maxTime)
            {
               return;
            }
            p.copy(origin).method_362(t,direction);
            if(normal.x > 0.9999 || normal.x < -0.9999)
            {
               axis = 0;
            }
            else if(normal.y > 0.9999 || normal.y < -0.9999)
            {
               axis = 1;
            }
            else if(normal.z > 0.9999 || normal.z < -0.9999)
            {
               axis = 2;
            }
            entryTime = t;
            i = this.clamp((p.x - this.var_609.minX) / this.cellSize,0,this.numCellsX - 1);
            j = this.clamp((p.y - this.var_609.minY) / this.cellSize,0,this.numCellsY - 1);
            k = this.clamp((p.z - this.var_609.minZ) / this.cellSize,0,this.numCellsZ - 1);
         }
         else
         {
            i = this.clamp(x1 / this.cellSize,0,this.numCellsX - 1);
            j = this.clamp(y1 / this.cellSize,0,this.numCellsY - 1);
            k = this.clamp(z1 / this.cellSize,0,this.numCellsZ - 1);
         }
         var iend:int = this.clamp(x2 / this.cellSize,0,this.numCellsX - 1);
         var jend:int = this.clamp(y2 / this.cellSize,0,this.numCellsY - 1);
         var kend:int = this.clamp(z2 / this.cellSize,0,this.numCellsZ - 1);
         var di:int = x1 < x2 ? 1 : (x1 > x2 ? -1 : 0);
         var dj:int = y1 < y2 ? 1 : (y1 > y2 ? -1 : 0);
         var dk:int = z1 < z2 ? 1 : (z1 > z2 ? -1 : 0);
         var minx:Number = i * this.cellSize;
         var maxx:Number = minx + this.cellSize;
         var tx:Number = x1 < x2 ? (maxx - x1) / (x2 - x1) : (x1 - minx) / (x1 - x2);
         if(isNaN(tx))
         {
            tx = BIG_VALUE;
         }
         var miny:Number = j * this.cellSize;
         var maxy:Number = miny + this.cellSize;
         var ty:Number = y1 < y2 ? (maxy - y1) / (y2 - y1) : (y1 - miny) / (y1 - y2);
         if(isNaN(ty))
         {
            ty = BIG_VALUE;
         }
         var minz:Number = k * this.cellSize;
         var maxz:Number = minz + this.cellSize;
         var tz:Number = z1 < z2 ? (maxz - z1) / (z2 - z1) : (z1 - minz) / (z1 - z2);
         if(isNaN(tz))
         {
            tz = BIG_VALUE;
         }
         var deltatx:Number = this.cellSize / Math.abs(x2 - x1);
         var deltaty:Number = this.cellSize / Math.abs(y2 - y1);
         var deltatz:Number = this.cellSize / Math.abs(z2 - z1);
         while(true)
         {
            cellMaxTime = tx;
            if(cellMaxTime > ty)
            {
               cellMaxTime = ty;
            }
            if(cellMaxTime > tz)
            {
               cellMaxTime = tz;
            }
            if(!visitor.visitCell(i,j,k,axis,entryTime,cellMaxTime * maxTime,tstamp,origin,direction))
            {
               return;
            }
            if(tx <= ty && tx <= tz)
            {
               if(i == iend)
               {
                  break;
               }
               entryTime = tx;
               axis = 0;
               tx += deltatx;
               i += di;
            }
            else if(ty <= tx && ty <= tz)
            {
               if(j == jend)
               {
                  break;
               }
               entryTime = ty;
               axis = 1;
               ty += deltaty;
               j += dj;
            }
            else
            {
               if(k == kend)
               {
                  break;
               }
               entryTime = tz;
               axis = 2;
               tz += deltatz;
               k += dk;
            }
         }
      }
      
      private function clamp(value:int, min:int, max:int) : int
      {
         if(value < min)
         {
            return min;
         }
         if(value > max)
         {
            return max;
         }
         return value;
      }
      
      private function method_688() : void
      {
         var bodyCellEntry:BodyCellEntry = null;
         var nextBodyCellEntry:BodyCellEntry = null;
         var nextOccupiedCell:OccupiedCellIndex = null;
         for(var cellIndex:int = 0; cellIndex < this.var_613; cellIndex++)
         {
            bodyCellEntry = this.bodyCellEntries[cellIndex];
            for(this.bodyCellEntries[cellIndex] = null; bodyCellEntry != null; )
            {
               nextBodyCellEntry = bodyCellEntry.next;
               bodyCellEntry.destroy();
               bodyCellEntry = nextBodyCellEntry;
            }
         }
         var occupiedCell:OccupiedCellIndex = this.var_614;
         for(this.var_614 = null; occupiedCell != null; )
         {
            nextOccupiedCell = occupiedCell.next;
            occupiedCell.destory();
            occupiedCell = nextOccupiedCell;
         }
      }
      
      private function method_680() : void
      {
         var bodyCollisionData:name_685 = null;
         var boundBox:name_386 = null;
         var imin:int = 0;
         var jmin:int = 0;
         var kmin:int = 0;
         var imax:int = 0;
         var jmax:int = 0;
         var kmax:int = 0;
         var cellIndex:int = 0;
         var i:int = 0;
         var occupiedCellIndex:OccupiedCellIndex = null;
         var j:int = 0;
         var k:int = 0;
         var index:int = 0;
         var newEntry:BodyCellEntry = null;
         this.method_688();
         for(var ti:int = 0; ti < this.var_612; ti++)
         {
            bodyCollisionData = this.var_611[ti];
            boundBox = bodyCollisionData.body.aabb;
            imin = (boundBox.minX - this.var_609.minX) / this.cellSize;
            if(!(imin < 0 || imin >= this.numCellsX))
            {
               jmin = (boundBox.minY - this.var_609.minY) / this.cellSize;
               if(!(jmin < 0 || jmin >= this.numCellsY))
               {
                  kmin = (boundBox.minZ - this.var_609.minZ) / this.cellSize;
                  if(!(kmin < 0 || kmin >= this.numCellsZ))
                  {
                     imax = (boundBox.maxX - this.var_609.minX) / this.cellSize;
                     if(imax >= this.numCellsX)
                     {
                        imax = this.numCellsX - 1;
                     }
                     jmax = (boundBox.maxY - this.var_609.minY) / this.cellSize;
                     if(jmax >= this.numCellsY)
                     {
                        jmax = this.numCellsY - 1;
                     }
                     kmax = (boundBox.maxZ - this.var_609.minZ) / this.cellSize;
                     if(kmax >= this.numCellsZ)
                     {
                        kmax = this.numCellsZ - 1;
                     }
                     bodyCollisionData.i = imin | imax << 16;
                     bodyCollisionData.j = jmin | jmax << 16;
                     bodyCollisionData.k = kmin | kmax << 16;
                     cellIndex = imin * this.numCellsY * this.numCellsZ + jmin * this.numCellsZ + kmin;
                     if(this.bodyCellEntries[cellIndex] == null)
                     {
                        occupiedCellIndex = OccupiedCellIndex.create(cellIndex);
                        occupiedCellIndex.next = this.var_614;
                        this.var_614 = occupiedCellIndex;
                     }
                     for(i = imin; i <= imax; )
                     {
                        for(j = jmin; j <= jmax; j++)
                        {
                           for(k = kmin; k <= kmax; k++)
                           {
                              index = i * this.numCellsY * this.numCellsZ + j * this.numCellsZ + k;
                              newEntry = BodyCellEntry.create();
                              newEntry.next = this.bodyCellEntries[index];
                              this.bodyCellEntries[index] = newEntry;
                              newEntry.data = bodyCollisionData;
                           }
                        }
                        i++;
                     }
                  }
               }
            }
         }
         this.var_617 = false;
      }
      
      private function method_683(body:name_271) : int
      {
         var bodyCollisionGridData:name_685 = null;
         for(var i:int = 0; i < this.var_612; )
         {
            bodyCollisionGridData = this.var_611[i];
            if(bodyCollisionGridData.body == body)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      private function method_686() : void
      {
         var maxObjectPairs:int = MAX_OBJECTS * (MAX_OBJECTS - 1) / 2;
         this.var_618 = (maxObjectPairs + 31) / 32;
         this.var_615 = new Vector.<int>(this.var_618);
      }
      
      private function method_690() : void
      {
         this.var_596 = new Object();
         this.method_655(name_235.BOX,name_235.BOX,new name_666());
         this.method_655(name_235.BOX,name_235.RECT,new name_667());
         this.method_655(name_235.BOX,name_235.TRIANGLE,new name_668());
      }
   }
}

import package_46.name_194;
import package_76.name_235;
import package_76.name_631;
import package_90.name_273;

class BodyCellEntry
{
   private static var pool:BodyCellEntry;
   
   public var data:name_685;
   
   public var next:BodyCellEntry;
   
   public function BodyCellEntry()
   {
      super();
   }
   
   public static function create() : BodyCellEntry
   {
      if(pool == null)
      {
         return new BodyCellEntry();
      }
      var bodyEntry:BodyCellEntry = pool;
      pool = bodyEntry.next;
      bodyEntry.next = null;
      return bodyEntry;
   }
   
   public function destroy() : void
   {
      this.data = null;
      this.next = pool;
      pool = this;
   }
}

class RaycastCellVisitor implements class_34
{
   public static var EPSILON:Number = 0.0001;
   
   private static var normal:name_194 = new name_194();
   
   public var denseArray:Vector.<name_235>;
   
   public var denseCellIndices:Vector.<int>;
   
   public var numCellsX:int;
   
   public var numCellsY:int;
   
   public var numCellsZ:int;
   
   public var bodyCellEntries:Vector.<BodyCellEntry>;
   
   public var collisionMask:int;
   
   public var filter:name_631;
   
   public var result:name_273;
   
   public var hasHit:Boolean;
   
   private var nearestPrimitive:name_235;
   
   private var nearestNormal:name_194 = new name_194();
   
   private var nearestTime:Number = 1.7976931348623157e+308;
   
   public function RaycastCellVisitor()
   {
      super();
   }
   
   public function visitCell(celli:int, cellj:int, cellk:int, axis:int, cellEntryTime:Number, cellMaxTime:Number, timestamp:int, rayOrigin:name_194, rayDirection:name_194) : Boolean
   {
      var collisionPrimitive:name_235 = null;
      var time:Number = NaN;
      var bodyCellEntry:BodyCellEntry = null;
      var data:name_685 = null;
      var detailedPrimitives:Vector.<name_235> = null;
      var numPrimitives:uint = 0;
      this.hasHit = false;
      var cellIndex:int = celli * this.numCellsY * this.numCellsZ + cellj * this.numCellsZ + cellk;
      var denseCellIndex:int = int(this.denseCellIndices[cellIndex]);
      var startIndex:int = denseCellIndex & 0xFFFFFF;
      var endIndex:int = startIndex + (denseCellIndex >>> 24);
      var minTime:Number = Number(this.nearestTime);
      for(var i:int = startIndex; i < endIndex; )
      {
         collisionPrimitive = this.denseArray[i];
         if(collisionPrimitive.timestamp != timestamp)
         {
            collisionPrimitive.timestamp = timestamp;
            if((collisionPrimitive.collisionGroup & this.collisionMask) != 0)
            {
               time = collisionPrimitive.raycast(rayOrigin,rayDirection,EPSILON,normal);
               if(time > 0 && time < minTime && (this.filter == null || Boolean(this.filter.name_664(collisionPrimitive))))
               {
                  minTime = time;
                  if(time < cellMaxTime)
                  {
                     this.result.normal.copy(normal);
                     this.result.primitive = collisionPrimitive;
                     this.result.t = time;
                     this.hasHit = true;
                  }
                  else
                  {
                     this.nearestPrimitive = collisionPrimitive;
                     this.nearestTime = time;
                     this.nearestNormal.copy(normal);
                  }
               }
            }
         }
         i++;
      }
      if(this.bodyCellEntries != null)
      {
         for(bodyCellEntry = this.bodyCellEntries[cellIndex]; bodyCellEntry != null; )
         {
            data = bodyCellEntry.data;
            if(data.timestamp != timestamp)
            {
               data.timestamp = timestamp;
               detailedPrimitives = data.detailedPrimitives;
               numPrimitives = uint(detailedPrimitives.length);
               for(i = 0; i < numPrimitives; )
               {
                  collisionPrimitive = detailedPrimitives[i];
                  if((collisionPrimitive.collisionGroup & this.collisionMask) != 0)
                  {
                     time = collisionPrimitive.raycast(rayOrigin,rayDirection,EPSILON,normal);
                     if(time > 0 && time < minTime && (this.filter == null || Boolean(this.filter.name_664(collisionPrimitive))))
                     {
                        minTime = time;
                        if(time < cellMaxTime)
                        {
                           this.result.normal.copy(normal);
                           this.result.primitive = collisionPrimitive;
                           this.result.t = time;
                           this.hasHit = true;
                        }
                        else
                        {
                           this.nearestPrimitive = collisionPrimitive;
                           this.nearestTime = time;
                           this.nearestNormal.copy(normal);
                        }
                     }
                  }
                  i++;
               }
            }
            bodyCellEntry = bodyCellEntry.next;
         }
      }
      if(!this.hasHit && this.nearestTime < cellMaxTime)
      {
         this.hasHit = true;
         this.result.t = this.nearestTime;
         this.result.primitive = this.nearestPrimitive;
         this.result.normal.copy(this.nearestNormal);
         return false;
      }
      return !this.hasHit;
   }
   
   public function clear() : void
   {
      this.filter = null;
      this.result = null;
      this.nearestPrimitive = null;
      this.bodyCellEntries = null;
      this.nearestTime = Number.MAX_VALUE;
   }
}

class OccupiedCellIndex
{
   private static var pool:OccupiedCellIndex;
   
   public var index:int;
   
   public var next:OccupiedCellIndex;
   
   public function OccupiedCellIndex(index:int)
   {
      super();
      this.index = index;
   }
   
   public static function create(index:int) : OccupiedCellIndex
   {
      if(pool == null)
      {
         return new OccupiedCellIndex(index);
      }
      var item:OccupiedCellIndex = pool;
      pool = item.next;
      item.next = null;
      item.index = index;
      return item;
   }
   
   public function destory() : void
   {
      this.next = pool;
      pool = this;
   }
}
