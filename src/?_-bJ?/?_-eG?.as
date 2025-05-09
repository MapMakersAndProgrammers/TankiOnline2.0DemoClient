package §_-bJ§
{
   import §_-1e§.§_-Nh§;
   import §_-1e§.§_-hG§;
   import §_-1e§.§_-jn§;
   import §_-KA§.§_-FW§;
   import §_-KA§.§_-jr§;
   import §_-US§.§_-6h§;
   import §_-US§.§_-BV§;
   import §_-fT§.*;
   import §_-nl§.§_-bj§;
   import §_-pe§.§_-m3§;
   import §while§.§_-GQ§;
   import §while§.§_-Ph§;
   import §while§.§_-hu§;
   
   public class §_-eG§ implements §_-Zm§
   {
      private static var timestamp:int;
      
      private static const MAX_OBJECTS:int = 200;
      
      private static var BIG_VALUE:Number = 1000000;
      
      private static var EPSILON:Number = 0.0001;
      
      private static var normal:§_-bj§ = new §_-bj§();
      
      private static var collisionBox:§_-m3§ = new §_-m3§(new §_-bj§(),4294967295,0);
      
      private var cellSize:Number;
      
      private var §_-aq§:§_-FW§ = new §_-FW§();
      
      private var denseArray:Vector.<§_-Nh§>;
      
      private var denseCellIndices:Vector.<int>;
      
      private var §_-00§:int;
      
      private var numCellsX:int;
      
      private var numCellsY:int;
      
      private var numCellsZ:int;
      
      private var §_-Sp§:int;
      
      private var §_-48§:Vector.<int>;
      
      private var §_-81§:int;
      
      private var §_-3Q§:Vector.<§_-Pg§>;
      
      private var §_-VV§:int;
      
      private var bodyCellEntries:Vector.<BodyCellEntry>;
      
      private var §_-P6§:Object;
      
      private var §_-SI§:RaycastCellVisitor;
      
      private var §_-Qp§:OccupiedCellIndex;
      
      private var §_-WJ§:Boolean;
      
      public function §_-eG§()
      {
         super();
         this.§_-3Q§ = new Vector.<§_-Pg§>();
         this.§_-SI§ = new RaycastCellVisitor();
         this.§_-kL§();
         this.§_-8J§();
      }
      
      private function §_-c2§(type1:int, type2:int, collider:§_-hG§) : void
      {
         this.§_-P6§[type1 | type2] = collider;
      }
      
      public function §_-pN§(bodyCollisionData:§_-YY§) : void
      {
         if(this.§_-OL§(bodyCollisionData.body) >= 0)
         {
            throw new Error("Body collision data already exists");
         }
         var bodyCollisionGridData:§_-Pg§ = §_-Pg§.create();
         bodyCollisionGridData.body = bodyCollisionData.body;
         bodyCollisionGridData.detailedPrimitives = bodyCollisionData.detailedPrimitives;
         bodyCollisionGridData.simplePrimitives = bodyCollisionData.simplePrimitives;
         bodyCollisionGridData.index = this.§_-VV§;
         var _loc3_:* = this.§_-VV§++;
         this.§_-3Q§[_loc3_] = bodyCollisionGridData;
         this.§_-WJ§ = true;
      }
      
      public function §_-qP§(bodyCollisionData:§_-YY§) : void
      {
         var index:int = this.§_-OL§(bodyCollisionData.body);
         if(index < 0)
         {
            throw new Error("Body collision data not found");
         }
         --this.§_-VV§;
         var lastBodyEntry:§_-Pg§ = this.§_-3Q§[this.§_-VV§];
         lastBodyEntry.index = index;
         §_-Pg§(this.§_-3Q§[index]).destroy();
         this.§_-3Q§[index] = lastBodyEntry;
         this.§_-3Q§[this.§_-VV§] = null;
         this.§_-WJ§ = true;
      }
      
      public function §_-9F§() : void
      {
         this.§_-nT§();
      }
      
      public function §_-OA§() : Number
      {
         return this.cellSize;
      }
      
      public function §_-8t§() : §_-FW§
      {
         return this.§_-aq§.clone();
      }
      
      public function §_-9i§() : int
      {
         return this.numCellsX;
      }
      
      public function §_-PM§() : int
      {
         return this.numCellsY;
      }
      
      public function §_-5F§() : int
      {
         return this.numCellsZ;
      }
      
      public function §_-Bo§() : int
      {
         return this.§_-Sp§;
      }
      
      public function §_-D6§(x:int, y:int, z:int) : int
      {
         var cellIndex:int = x * this.numCellsY * this.numCellsZ + y * this.numCellsZ + z;
         return this.denseCellIndices[cellIndex] >>> 24;
      }
      
      public function §_-hS§(cellSize:Number, staticPrimitives:Vector.<§_-Nh§>) : void
      {
         this.§_-SQ§(staticPrimitives,cellSize);
         this.§_-hH§(staticPrimitives);
         this.§_-EF§();
      }
      
      public function §_-7u§(center:§_-bj§, radius:Number, filter:§_-VN§) : Vector.<§_-bB§>
      {
         var result:Vector.<§_-bB§> = null;
         var j:int = 0;
         var k:int = 0;
         var index:int = 0;
         var bodyCellEntry:BodyCellEntry = null;
         var data:§_-Pg§ = null;
         var body:§_-BV§ = null;
         var position:§_-bj§ = null;
         var dx:Number = NaN;
         var dy:Number = NaN;
         var dz:Number = NaN;
         var d:Number = NaN;
         var imin:int = this.clamp((center.x - radius - this.§_-aq§.minX) / this.cellSize,0,this.numCellsX - 1);
         var imax:int = this.clamp((center.x + radius - this.§_-aq§.minX) / this.cellSize,0,this.numCellsX - 1);
         var jmin:int = this.clamp((center.y - radius - this.§_-aq§.minY) / this.cellSize,0,this.numCellsY - 1);
         var jmax:int = this.clamp((center.y + radius - this.§_-aq§.minY) / this.cellSize,0,this.numCellsY - 1);
         var kmin:int = this.clamp((center.z - radius - this.§_-aq§.minZ) / this.cellSize,0,this.numCellsZ - 1);
         var kmax:int = this.clamp((center.z + radius - this.§_-aq§.minZ) / this.cellSize,0,this.numCellsZ - 1);
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
                           if(filter == null || Boolean(filter.§_-cb§(center,body)))
                           {
                              if(result == null)
                              {
                                 result = new Vector.<§_-bB§>();
                              }
                              result.push(new §_-bB§(body,Math.sqrt(d)));
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
      
      public function §_-63§(contacts:§_-6h§) : §_-6h§
      {
         var bodyCollisionData:§_-Pg§ = null;
         this.§_-nT§();
         for(var i:int = 0; i < this.§_-VV§; i++)
         {
            bodyCollisionData = this.§_-3Q§[i];
            contacts = this.§_-RK§(bodyCollisionData,contacts);
         }
         return this.§_-aE§(contacts);
      }
      
      private function §_-EF§() : void
      {
         this.§_-SI§.denseArray = this.denseArray;
         this.§_-SI§.denseCellIndices = this.denseCellIndices;
         this.§_-SI§.numCellsX = this.numCellsX;
         this.§_-SI§.numCellsY = this.numCellsY;
         this.§_-SI§.numCellsZ = this.numCellsZ;
      }
      
      private function §_-SQ§(staticPrimitives:Vector.<§_-Nh§>, cellSize:Number) : void
      {
         var collisionPrimitive:§_-Nh§ = null;
         this.cellSize = cellSize;
         this.§_-aq§.§_-GT§();
         for each(collisionPrimitive in staticPrimitives)
         {
            this.§_-aq§.§_-EH§(collisionPrimitive.calculateAABB());
         }
         this.§_-aq§.§_-Gd§(cellSize + EPSILON);
         this.numCellsX = int(this.§_-aq§.§_-ot§() / cellSize) + 1;
         this.numCellsY = int(this.§_-aq§.§_-jP§() / cellSize) + 1;
         this.numCellsZ = int(this.§_-aq§.§_-Ix§() / cellSize) + 1;
         this.§_-00§ = this.numCellsX * this.numCellsY * this.numCellsZ;
         this.§_-aq§.maxX = this.§_-aq§.minX + this.numCellsX * cellSize;
         this.§_-aq§.maxY = this.§_-aq§.minY + this.numCellsY * cellSize;
         this.§_-aq§.maxZ = this.§_-aq§.minZ + this.numCellsZ * cellSize;
         this.bodyCellEntries = new Vector.<BodyCellEntry>(this.§_-00§);
      }
      
      private function §_-hH§(staticPrimitives:Vector.<§_-Nh§>) : void
      {
         var index:int = 0;
         var denseArraySize:int = 0;
         var lastIndex:int = 0;
         var numCellPrimitives:int = 0;
         var collisionPrimitive:§_-Nh§ = null;
         var bb:§_-FW§ = null;
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
         var cellCounters:Vector.<int> = this.§_-VK§(staticPrimitives);
         this.§_-Sp§ = 0;
         this.denseCellIndices = new Vector.<int>(this.§_-00§);
         for(index = 0; index < this.§_-00§; index++)
         {
            numCellPrimitives = cellCounters[index];
            if(numCellPrimitives > this.§_-Sp§)
            {
               this.§_-Sp§ = numCellPrimitives;
            }
            denseArraySize += numCellPrimitives;
            this.denseCellIndices[index] = numCellPrimitives << 24 | lastIndex;
            lastIndex += numCellPrimitives;
            cellCounters[index] = 0;
         }
         this.denseArray = new Vector.<§_-Nh§>(denseArraySize);
         var numPrimitives:int = int(staticPrimitives.length);
         for(index = 0; index < numPrimitives; index++)
         {
            collisionPrimitive = staticPrimitives[index];
            bb = collisionPrimitive.aabb;
            imin = (bb.minX - this.§_-aq§.minX) / this.cellSize;
            imax = (bb.maxX - this.§_-aq§.minX) / this.cellSize;
            jmin = (bb.minY - this.§_-aq§.minY) / this.cellSize;
            jmax = (bb.maxY - this.§_-aq§.minY) / this.cellSize;
            kmin = (bb.minZ - this.§_-aq§.minZ) / this.cellSize;
            kmax = (bb.maxZ - this.§_-aq§.minZ) / this.cellSize;
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
      
      private function §_-VK§(staticPrimitives:Vector.<§_-Nh§>) : Vector.<int>
      {
         var bb:§_-FW§ = null;
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
         var cellPrimitiveCounters:Vector.<int> = new Vector.<int>(this.§_-00§);
         var numPrimitives:int = int(staticPrimitives.length);
         for(var index:int = 0; index < numPrimitives; index++)
         {
            bb = staticPrimitives[index].aabb;
            imin = (bb.minX - this.§_-aq§.minX) / this.cellSize;
            imax = (bb.maxX - this.§_-aq§.minX) / this.cellSize;
            jmin = (bb.minY - this.§_-aq§.minY) / this.cellSize;
            jmax = (bb.maxY - this.§_-aq§.minY) / this.cellSize;
            kmin = (bb.minZ - this.§_-aq§.minZ) / this.cellSize;
            kmax = (bb.maxZ - this.§_-aq§.minZ) / this.cellSize;
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
      
      private function §_-aE§(contacts:§_-6h§) : §_-6h§
      {
         var currentBodyCellEntry:BodyCellEntry = null;
         var currentBodyData:§_-Pg§ = null;
         var bodyCollisionGridData:§_-Pg§ = null;
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
         this.§_-KE§();
         var numBodies:int = int(this.§_-3Q§.length);
         for(var occupiedCell:OccupiedCellIndex = this.§_-Qp§; occupiedCell != null; )
         {
            for(currentBodyCellEntry = this.bodyCellEntries[occupiedCell.index]; currentBodyCellEntry != null; )
            {
               currentBodyData = currentBodyCellEntry.data;
               contacts = this.§_-AZ§(currentBodyData.body,currentBodyData.index,currentBodyData.simplePrimitives,currentBodyCellEntry.next,numBodies,contacts);
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
                           contacts = this.§_-AZ§(currentBodyData.body,currentBodyData.index,currentBodyData.simplePrimitives,this.bodyCellEntries[cellIndex],numBodies,contacts);
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
      
      private function §_-AZ§(body:§_-BV§, bodyIndex:int, bodyPrimitives:Vector.<§_-Nh§>, cellStartEntry:BodyCellEntry, numBodies:int, contacts:§_-6h§) : §_-6h§
      {
         var index2:int = 0;
         var min:int = 0;
         var max:int = 0;
         var bitIndex:int = 0;
         var mask:int = 0;
         var body2:§_-BV§ = null;
         var bodyPrimitives2:Vector.<§_-Nh§> = null;
         var numPrimitives2:int = 0;
         var i:int = 0;
         var collisionPrimitive1:§_-Nh§ = null;
         var j:int = 0;
         var collisionPrimitive2:§_-Nh§ = null;
         for(var numPrimitives1:int = int(bodyPrimitives.length); cellStartEntry != null; )
         {
            if(cellStartEntry.data.body != body)
            {
               index2 = int(cellStartEntry.data.index);
               min = bodyIndex;
               max = index2;
               if(bodyIndex > index2)
               {
                  min = index2;
                  max = bodyIndex;
               }
               bitIndex = min * (2 * numBodies - min - 3) / 2 + max - 1;
               mask = 1 << (bitIndex & 0x1F);
               if((this.§_-48§[bitIndex >>> 5] & mask) == 0)
               {
                  this.§_-48§[bitIndex >>> 5] |= mask;
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
                              contacts = this.§_-1p§(body,bodyPrimitives,numPrimitives1,body2,bodyPrimitives2,numPrimitives2,contacts);
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
      
      private function §_-1p§(body1:§_-BV§, primitives1:Vector.<§_-Nh§>, numPrimitives1:int, body2:§_-BV§, primitives2:Vector.<§_-Nh§>, numPrimitives2:int, contact:§_-6h§) : §_-6h§
      {
         var primitive1:§_-Nh§ = null;
         var j:int = 0;
         var primitive2:§_-Nh§ = null;
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
      
      private function §_-KE§() : void
      {
         for(var i:int = 0; i < this.§_-81§; i++)
         {
            this.§_-48§[i] = 0;
         }
      }
      
      private function §_-RK§(bodyCollisionData:§_-Pg§, contacts:§_-6h§) : §_-6h§
      {
         var jj:int = 0;
         var kk:int = 0;
         var cellIndex:int = 0;
         var denseIndexStart:int = 0;
         var denseIndexEnd:int = 0;
         var index:int = 0;
         var staticCollisionPrimitive:§_-Nh§ = null;
         var bpi:int = 0;
         var bodyCollisionPrimitive:§_-Nh§ = null;
         var imin:int = bodyCollisionData.i & 0xFFFF;
         var imax:int = bodyCollisionData.i >>> 16;
         var jmin:int = bodyCollisionData.j & 0xFFFF;
         var jmax:int = bodyCollisionData.j >>> 16;
         var kmin:int = bodyCollisionData.k & 0xFFFF;
         var kmax:int = bodyCollisionData.k >>> 16;
         var tstamp:int = int(++timestamp);
         var bodyPrimitives:Vector.<§_-Nh§> = bodyCollisionData.detailedPrimitives;
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
      
      public function raycast(origin:§_-bj§, direction:§_-bj§, collisionMask:int, maxTime:Number, filter:§_-jn§, result:§_-jr§) : Boolean
      {
         if(this.§_-WJ§)
         {
            this.§_-nT§();
         }
         this.§_-SI§.collisionMask = collisionMask;
         this.§_-SI§.filter = filter;
         this.§_-SI§.result = result;
         this.§_-SI§.bodyCellEntries = this.bodyCellEntries;
         this.§_-e0§(origin,direction,maxTime,this.§_-SI§);
         this.§_-SI§.clear();
         if(this.§_-SI§.hasHit)
         {
            if(result.t < maxTime)
            {
               result.position.copy(origin).§_-LQ§(result.t,direction);
               return true;
            }
         }
         return false;
      }
      
      public function §_-cX§(origin:§_-bj§, direction:§_-bj§, collisionMask:int, maxTime:Number, filter:§_-jn§, result:§_-jr§) : Boolean
      {
         this.§_-SI§.collisionMask = collisionMask;
         this.§_-SI§.filter = filter;
         this.§_-SI§.result = result;
         this.§_-e0§(origin,direction,maxTime,this.§_-SI§);
         this.§_-SI§.clear();
         if(this.§_-SI§.hasHit)
         {
            if(result.t < maxTime)
            {
               result.position.copy(origin).§_-LQ§(result.t,direction);
               return true;
            }
         }
         return false;
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
         return false;
      }
      
      public function §_-e0§(origin:§_-bj§, direction:§_-bj§, maxTime:Number, visitor:§_-hm§) : void
      {
         var t:Number = NaN;
         var i:int = 0;
         var j:int = 0;
         var k:int = 0;
         var cellMaxTime:Number = NaN;
         var tstamp:int = int(++timestamp);
         var x1:Number = origin.x - this.§_-aq§.minX;
         var y1:Number = origin.y - this.§_-aq§.minY;
         var z1:Number = origin.z - this.§_-aq§.minZ;
         var x2:Number = x1 + direction.x * maxTime;
         var y2:Number = y1 + direction.y * maxTime;
         var z2:Number = z1 + direction.z * maxTime;
         var axis:int = -1;
         var entryTime:Number = 0;
         var p:§_-bj§ = new §_-bj§();
         var pointInBounds:Boolean = this.§_-aq§.§_-Wu§(origin,EPSILON);
         if(!pointInBounds)
         {
            collisionBox.hs.reset(this.cellSize * this.numCellsX / 2,this.cellSize * this.numCellsY / 2,this.cellSize * this.numCellsZ / 2);
            collisionBox.transform.d = this.§_-aq§.minX + collisionBox.hs.x;
            collisionBox.transform.h = this.§_-aq§.minY + collisionBox.hs.y;
            collisionBox.transform.l = this.§_-aq§.minZ + collisionBox.hs.z;
            collisionBox.calculateAABB();
            t = collisionBox.raycast(origin,direction,EPSILON,normal);
            if(t < 0 || t >= maxTime)
            {
               return;
            }
            p.copy(origin).§_-LQ§(t,direction);
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
            i = this.clamp((p.x - this.§_-aq§.minX) / this.cellSize,0,this.numCellsX - 1);
            j = this.clamp((p.y - this.§_-aq§.minY) / this.cellSize,0,this.numCellsY - 1);
            k = this.clamp((p.z - this.§_-aq§.minZ) / this.cellSize,0,this.numCellsZ - 1);
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
      
      private function §_-Oi§() : void
      {
         var bodyCellEntry:BodyCellEntry = null;
         var nextBodyCellEntry:BodyCellEntry = null;
         var nextOccupiedCell:OccupiedCellIndex = null;
         for(var cellIndex:int = 0; cellIndex < this.§_-00§; cellIndex++)
         {
            bodyCellEntry = this.bodyCellEntries[cellIndex];
            for(this.bodyCellEntries[cellIndex] = null; bodyCellEntry != null; )
            {
               nextBodyCellEntry = bodyCellEntry.next;
               bodyCellEntry.destroy();
               bodyCellEntry = nextBodyCellEntry;
            }
         }
         var occupiedCell:OccupiedCellIndex = this.§_-Qp§;
         for(this.§_-Qp§ = null; occupiedCell != null; )
         {
            nextOccupiedCell = occupiedCell.next;
            occupiedCell.destory();
            occupiedCell = nextOccupiedCell;
         }
      }
      
      private function §_-nT§() : void
      {
         var bodyCollisionData:§_-Pg§ = null;
         var boundBox:§_-FW§ = null;
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
         this.§_-Oi§();
         for(var ti:int = 0; ti < this.§_-VV§; ti++)
         {
            bodyCollisionData = this.§_-3Q§[ti];
            boundBox = bodyCollisionData.body.aabb;
            imin = (boundBox.minX - this.§_-aq§.minX) / this.cellSize;
            if(!(imin < 0 || imin >= this.numCellsX))
            {
               jmin = (boundBox.minY - this.§_-aq§.minY) / this.cellSize;
               if(!(jmin < 0 || jmin >= this.numCellsY))
               {
                  kmin = (boundBox.minZ - this.§_-aq§.minZ) / this.cellSize;
                  if(!(kmin < 0 || kmin >= this.numCellsZ))
                  {
                     imax = (boundBox.maxX - this.§_-aq§.minX) / this.cellSize;
                     if(imax >= this.numCellsX)
                     {
                        imax = this.numCellsX - 1;
                     }
                     jmax = (boundBox.maxY - this.§_-aq§.minY) / this.cellSize;
                     if(jmax >= this.numCellsY)
                     {
                        jmax = this.numCellsY - 1;
                     }
                     kmax = (boundBox.maxZ - this.§_-aq§.minZ) / this.cellSize;
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
                        occupiedCellIndex.next = this.§_-Qp§;
                        this.§_-Qp§ = occupiedCellIndex;
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
         this.§_-WJ§ = false;
      }
      
      private function §_-OL§(body:§_-BV§) : int
      {
         var bodyCollisionGridData:§_-Pg§ = null;
         for(var i:int = 0; i < this.§_-VV§; )
         {
            bodyCollisionGridData = this.§_-3Q§[i];
            if(bodyCollisionGridData.body == body)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      private function §_-8J§() : void
      {
         var maxObjectPairs:int = MAX_OBJECTS * (MAX_OBJECTS - 1) / 2;
         this.§_-81§ = (maxObjectPairs + 31) / 32;
         this.§_-48§ = new Vector.<int>(this.§_-81§);
      }
      
      private function §_-kL§() : void
      {
         this.§_-P6§ = new Object();
         this.§_-c2§(§_-Nh§.BOX,§_-Nh§.BOX,new §_-Ph§());
         this.§_-c2§(§_-Nh§.BOX,§_-Nh§.RECT,new §_-GQ§());
         this.§_-c2§(§_-Nh§.BOX,§_-Nh§.TRIANGLE,new §_-hu§());
      }
   }
}

import §_-1e§.§_-Nh§;
import §_-1e§.§_-jn§;
import §_-KA§.§_-jr§;
import §_-nl§.§_-bj§;

class BodyCellEntry
{
   private static var pool:BodyCellEntry;
   
   public var data:§_-Pg§;
   
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

class RaycastCellVisitor implements §_-hm§
{
   public static var EPSILON:Number = 0.0001;
   
   private static var normal:§_-bj§ = new §_-bj§();
   
   public var denseArray:Vector.<§_-Nh§>;
   
   public var denseCellIndices:Vector.<int>;
   
   public var numCellsX:int;
   
   public var numCellsY:int;
   
   public var numCellsZ:int;
   
   public var bodyCellEntries:Vector.<BodyCellEntry>;
   
   public var collisionMask:int;
   
   public var filter:§_-jn§;
   
   public var result:§_-jr§;
   
   public var hasHit:Boolean;
   
   private var nearestPrimitive:§_-Nh§;
   
   private var nearestNormal:§_-bj§ = new §_-bj§();
   
   private var nearestTime:Number = 1.7976931348623157e+308;
   
   public function RaycastCellVisitor()
   {
      super();
   }
   
   public function visitCell(celli:int, cellj:int, cellk:int, axis:int, cellEntryTime:Number, cellMaxTime:Number, timestamp:int, rayOrigin:§_-bj§, rayDirection:§_-bj§) : Boolean
   {
      var collisionPrimitive:§_-Nh§ = null;
      var time:Number = NaN;
      var bodyCellEntry:BodyCellEntry = null;
      var data:§_-Pg§ = null;
      var detailedPrimitives:Vector.<§_-Nh§> = null;
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
               time = Number(collisionPrimitive.raycast(rayOrigin,rayDirection,EPSILON,normal));
               if(time > 0 && time < minTime && (this.filter == null || Boolean(this.filter.§_-0w§(collisionPrimitive))))
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
                     time = Number(collisionPrimitive.raycast(rayOrigin,rayDirection,EPSILON,normal));
                     if(time > 0 && time < minTime && (this.filter == null || Boolean(this.filter.§_-0w§(collisionPrimitive))))
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
