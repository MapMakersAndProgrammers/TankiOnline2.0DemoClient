package alternativa.tanks.game.physics.collision.uniformgrid
{
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.physics.Contact;
   import alternativa.physics.collision.CollisionPrimitive;
   import alternativa.physics.collision.ICollider;
   import alternativa.physics.collision.IRaycastFilter;
   import alternativa.physics.collision.colliders.BoxBoxCollider;
   import alternativa.physics.collision.colliders.BoxRectCollider;
   import alternativa.physics.collision.colliders.BoxTriangleCollider;
   import alternativa.physics.collision.primitives.CollisionBox;
   import alternativa.physics.collision.types.BoundBox;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.game.physics.*;
   
   public class UniformGridCollisionDetector implements ITanksCollisionDetector
   {
      private static var timestamp:int;
      
      private static const MAX_OBJECTS:int = 200;
      
      private static var BIG_VALUE:Number = 1000000;
      
      private static var EPSILON:Number = 0.0001;
      
      private static var normal:Vector3 = new Vector3();
      
      private static var collisionBox:CollisionBox = new CollisionBox(new Vector3(),4294967295,0);
      
      private var cellSize:Number;
      
      private var name_aq:BoundBox = new BoundBox();
      
      private var denseArray:Vector.<CollisionPrimitive>;
      
      private var denseCellIndices:Vector.<int>;
      
      private var name_00:int;
      
      private var numCellsX:int;
      
      private var numCellsY:int;
      
      private var numCellsZ:int;
      
      private var name_Sp:int;
      
      private var name_48:Vector.<int>;
      
      private var name_81:int;
      
      private var name_3Q:Vector.<BodyCollisionGridData>;
      
      private var name_VV:int;
      
      private var bodyCellEntries:Vector.<BodyCellEntry>;
      
      private var name_P6:Object;
      
      private var name_SI:RaycastCellVisitor;
      
      private var name_Qp:OccupiedCellIndex;
      
      private var name_WJ:Boolean;
      
      public function UniformGridCollisionDetector()
      {
         super();
         this.name_3Q = new Vector.<BodyCollisionGridData>();
         this.name_SI = new RaycastCellVisitor();
         this.initColliders();
         this.initPairBitArray();
      }
      
      private function addCollider(type1:int, type2:int, collider:ICollider) : void
      {
         this.name_P6[type1 | type2] = collider;
      }
      
      public function addBodyCollisionData(bodyCollisionData:BodyCollisionData) : void
      {
         if(this.findBodyEntry(bodyCollisionData.body) >= 0)
         {
            throw new Error("Body collision data already exists");
         }
         var bodyCollisionGridData:BodyCollisionGridData = BodyCollisionGridData.create();
         bodyCollisionGridData.body = bodyCollisionData.body;
         bodyCollisionGridData.detailedPrimitives = bodyCollisionData.detailedPrimitives;
         bodyCollisionGridData.simplePrimitives = bodyCollisionData.simplePrimitives;
         bodyCollisionGridData.index = this.name_VV;
         var _loc3_:* = this.name_VV++;
         this.name_3Q[_loc3_] = bodyCollisionGridData;
         this.name_WJ = true;
      }
      
      public function removeBodyCollisionData(bodyCollisionData:BodyCollisionData) : void
      {
         var index:int = this.findBodyEntry(bodyCollisionData.body);
         if(index < 0)
         {
            throw new Error("Body collision data not found");
         }
         --this.name_VV;
         var lastBodyEntry:BodyCollisionGridData = this.name_3Q[this.name_VV];
         lastBodyEntry.index = index;
         BodyCollisionGridData(this.name_3Q[index]).destroy();
         this.name_3Q[index] = lastBodyEntry;
         this.name_3Q[this.name_VV] = null;
         this.name_WJ = true;
      }
      
      public function prepareForRaycasts() : void
      {
         this.fillDynamicBodyCells();
      }
      
      public function getCellSize() : Number
      {
         return this.cellSize;
      }
      
      public function getGridBoundBox() : BoundBox
      {
         return this.name_aq.clone();
      }
      
      public function getNumCellsX() : int
      {
         return this.numCellsX;
      }
      
      public function getNumCellsY() : int
      {
         return this.numCellsY;
      }
      
      public function getNumCellsZ() : int
      {
         return this.numCellsZ;
      }
      
      public function getMaxCellPrimitiveCount() : int
      {
         return this.name_Sp;
      }
      
      public function getNumlPrimitivesInCell(x:int, y:int, z:int) : int
      {
         var cellIndex:int = x * this.numCellsY * this.numCellsZ + y * this.numCellsZ + z;
         return this.denseCellIndices[cellIndex] >>> 24;
      }
      
      public function createGrid(cellSize:Number, staticPrimitives:Vector.<CollisionPrimitive>) : void
      {
         this.setupGridParameters(staticPrimitives,cellSize);
         this.prepareDenseArray(staticPrimitives);
         this.initRaycastCellVisitor();
      }
      
      public function getObjectsInRadius(center:Vector3, radius:Number, filter:IRadiusQueryFilter) : Vector.<BodyDistance>
      {
         var result:Vector.<BodyDistance> = null;
         var j:int = 0;
         var k:int = 0;
         var index:int = 0;
         var bodyCellEntry:BodyCellEntry = null;
         var data:BodyCollisionGridData = null;
         var body:Body = null;
         var position:Vector3 = null;
         var dx:Number = NaN;
         var dy:Number = NaN;
         var dz:Number = NaN;
         var d:Number = NaN;
         var imin:int = this.clamp((center.x - radius - this.name_aq.minX) / this.cellSize,0,this.numCellsX - 1);
         var imax:int = this.clamp((center.x + radius - this.name_aq.minX) / this.cellSize,0,this.numCellsX - 1);
         var jmin:int = this.clamp((center.y - radius - this.name_aq.minY) / this.cellSize,0,this.numCellsY - 1);
         var jmax:int = this.clamp((center.y + radius - this.name_aq.minY) / this.cellSize,0,this.numCellsY - 1);
         var kmin:int = this.clamp((center.z - radius - this.name_aq.minZ) / this.cellSize,0,this.numCellsZ - 1);
         var kmax:int = this.clamp((center.z + radius - this.name_aq.minZ) / this.cellSize,0,this.numCellsZ - 1);
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
                           if(filter == null || Boolean(filter.acceptBody(center,body)))
                           {
                              if(result == null)
                              {
                                 result = new Vector.<BodyDistance>();
                              }
                              result.push(new BodyDistance(body,Math.sqrt(d)));
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
      
      public function getAllContacts(contacts:Contact) : Contact
      {
         var bodyCollisionData:BodyCollisionGridData = null;
         this.fillDynamicBodyCells();
         for(var i:int = 0; i < this.name_VV; i++)
         {
            bodyCollisionData = this.name_3Q[i];
            contacts = this.getBodyStaticContacts(bodyCollisionData,contacts);
         }
         return this.getDynamicContacts(contacts);
      }
      
      private function initRaycastCellVisitor() : void
      {
         this.name_SI.denseArray = this.denseArray;
         this.name_SI.denseCellIndices = this.denseCellIndices;
         this.name_SI.numCellsX = this.numCellsX;
         this.name_SI.numCellsY = this.numCellsY;
         this.name_SI.numCellsZ = this.numCellsZ;
      }
      
      private function setupGridParameters(staticPrimitives:Vector.<CollisionPrimitive>, cellSize:Number) : void
      {
         var collisionPrimitive:CollisionPrimitive = null;
         this.cellSize = cellSize;
         this.name_aq.infinity();
         for each(collisionPrimitive in staticPrimitives)
         {
            this.name_aq.addBoundBox(collisionPrimitive.calculateAABB());
         }
         this.name_aq.increase(cellSize + EPSILON);
         this.numCellsX = int(this.name_aq.getSizeX() / cellSize) + 1;
         this.numCellsY = int(this.name_aq.getSizeY() / cellSize) + 1;
         this.numCellsZ = int(this.name_aq.getSizeZ() / cellSize) + 1;
         this.name_00 = this.numCellsX * this.numCellsY * this.numCellsZ;
         this.name_aq.maxX = this.name_aq.minX + this.numCellsX * cellSize;
         this.name_aq.maxY = this.name_aq.minY + this.numCellsY * cellSize;
         this.name_aq.maxZ = this.name_aq.minZ + this.numCellsZ * cellSize;
         this.bodyCellEntries = new Vector.<BodyCellEntry>(this.name_00);
      }
      
      private function prepareDenseArray(staticPrimitives:Vector.<CollisionPrimitive>) : void
      {
         var index:int = 0;
         var denseArraySize:int = 0;
         var lastIndex:int = 0;
         var numCellPrimitives:int = 0;
         var collisionPrimitive:CollisionPrimitive = null;
         var bb:BoundBox = null;
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
         var cellCounters:Vector.<int> = this.calculateNumPrimitivesForEachCell(staticPrimitives);
         this.name_Sp = 0;
         this.denseCellIndices = new Vector.<int>(this.name_00);
         for(index = 0; index < this.name_00; index++)
         {
            numCellPrimitives = cellCounters[index];
            if(numCellPrimitives > this.name_Sp)
            {
               this.name_Sp = numCellPrimitives;
            }
            denseArraySize += numCellPrimitives;
            this.denseCellIndices[index] = numCellPrimitives << 24 | lastIndex;
            lastIndex += numCellPrimitives;
            cellCounters[index] = 0;
         }
         this.denseArray = new Vector.<CollisionPrimitive>(denseArraySize);
         var numPrimitives:int = int(staticPrimitives.length);
         for(index = 0; index < numPrimitives; index++)
         {
            collisionPrimitive = staticPrimitives[index];
            bb = collisionPrimitive.aabb;
            imin = (bb.minX - this.name_aq.minX) / this.cellSize;
            imax = (bb.maxX - this.name_aq.minX) / this.cellSize;
            jmin = (bb.minY - this.name_aq.minY) / this.cellSize;
            jmax = (bb.maxY - this.name_aq.minY) / this.cellSize;
            kmin = (bb.minZ - this.name_aq.minZ) / this.cellSize;
            kmax = (bb.maxZ - this.name_aq.minZ) / this.cellSize;
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
      
      private function calculateNumPrimitivesForEachCell(staticPrimitives:Vector.<CollisionPrimitive>) : Vector.<int>
      {
         var bb:BoundBox = null;
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
         var cellPrimitiveCounters:Vector.<int> = new Vector.<int>(this.name_00);
         var numPrimitives:int = int(staticPrimitives.length);
         for(var index:int = 0; index < numPrimitives; index++)
         {
            bb = staticPrimitives[index].aabb;
            imin = (bb.minX - this.name_aq.minX) / this.cellSize;
            imax = (bb.maxX - this.name_aq.minX) / this.cellSize;
            jmin = (bb.minY - this.name_aq.minY) / this.cellSize;
            jmax = (bb.maxY - this.name_aq.minY) / this.cellSize;
            kmin = (bb.minZ - this.name_aq.minZ) / this.cellSize;
            kmax = (bb.maxZ - this.name_aq.minZ) / this.cellSize;
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
      
      private function getDynamicContacts(contacts:Contact) : Contact
      {
         var currentBodyCellEntry:BodyCellEntry = null;
         var currentBodyData:BodyCollisionGridData = null;
         var bodyCollisionGridData:BodyCollisionGridData = null;
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
         this.clearPairBits();
         var numBodies:int = int(this.name_3Q.length);
         for(var occupiedCell:OccupiedCellIndex = this.name_Qp; occupiedCell != null; )
         {
            for(currentBodyCellEntry = this.bodyCellEntries[occupiedCell.index]; currentBodyCellEntry != null; )
            {
               currentBodyData = currentBodyCellEntry.data;
               contacts = this.getDynamicBodyCellContacts(currentBodyData.body,currentBodyData.index,currentBodyData.simplePrimitives,currentBodyCellEntry.next,numBodies,contacts);
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
                           contacts = this.getDynamicBodyCellContacts(currentBodyData.body,currentBodyData.index,currentBodyData.simplePrimitives,this.bodyCellEntries[cellIndex],numBodies,contacts);
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
      
      private function getDynamicBodyCellContacts(body:Body, bodyIndex:int, bodyPrimitives:Vector.<CollisionPrimitive>, cellStartEntry:BodyCellEntry, numBodies:int, contacts:Contact) : Contact
      {
         var index2:int = 0;
         var min:int = 0;
         var max:int = 0;
         var bitIndex:int = 0;
         var mask:int = 0;
         var body2:Body = null;
         var bodyPrimitives2:Vector.<CollisionPrimitive> = null;
         var numPrimitives2:int = 0;
         var i:int = 0;
         var collisionPrimitive1:CollisionPrimitive = null;
         var j:int = 0;
         var collisionPrimitive2:CollisionPrimitive = null;
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
               if((this.name_48[bitIndex >>> 5] & mask) == 0)
               {
                  this.name_48[bitIndex >>> 5] |= mask;
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
                              contacts = this.getBodiesCollision(body,bodyPrimitives,numPrimitives1,body2,bodyPrimitives2,numPrimitives2,contacts);
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
      
      private function getBodiesCollision(body1:Body, primitives1:Vector.<CollisionPrimitive>, numPrimitives1:int, body2:Body, primitives2:Vector.<CollisionPrimitive>, numPrimitives2:int, contact:Contact) : Contact
      {
         var primitive1:CollisionPrimitive = null;
         var j:int = 0;
         var primitive2:CollisionPrimitive = null;
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
      
      private function clearPairBits() : void
      {
         for(var i:int = 0; i < this.name_81; i++)
         {
            this.name_48[i] = 0;
         }
      }
      
      private function getBodyStaticContacts(bodyCollisionData:BodyCollisionGridData, contacts:Contact) : Contact
      {
         var jj:int = 0;
         var kk:int = 0;
         var cellIndex:int = 0;
         var denseIndexStart:int = 0;
         var denseIndexEnd:int = 0;
         var index:int = 0;
         var staticCollisionPrimitive:CollisionPrimitive = null;
         var bpi:int = 0;
         var bodyCollisionPrimitive:CollisionPrimitive = null;
         var imin:int = bodyCollisionData.i & 0xFFFF;
         var imax:int = bodyCollisionData.i >>> 16;
         var jmin:int = bodyCollisionData.j & 0xFFFF;
         var jmax:int = bodyCollisionData.j >>> 16;
         var kmin:int = bodyCollisionData.k & 0xFFFF;
         var kmax:int = bodyCollisionData.k >>> 16;
         var tstamp:int = int(++timestamp);
         var bodyPrimitives:Vector.<CollisionPrimitive> = bodyCollisionData.detailedPrimitives;
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
      
      public function raycast(origin:Vector3, direction:Vector3, collisionMask:int, maxTime:Number, filter:IRaycastFilter, result:RayHit) : Boolean
      {
         if(this.name_WJ)
         {
            this.fillDynamicBodyCells();
         }
         this.name_SI.collisionMask = collisionMask;
         this.name_SI.filter = filter;
         this.name_SI.result = result;
         this.name_SI.bodyCellEntries = this.bodyCellEntries;
         this.doRaycast(origin,direction,maxTime,this.name_SI);
         this.name_SI.clear();
         if(this.name_SI.hasHit)
         {
            if(result.t < maxTime)
            {
               result.position.copy(origin).addScaled(result.t,direction);
               return true;
            }
         }
         return false;
      }
      
      public function raycastStatic(origin:Vector3, direction:Vector3, collisionMask:int, maxTime:Number, filter:IRaycastFilter, result:RayHit) : Boolean
      {
         this.name_SI.collisionMask = collisionMask;
         this.name_SI.filter = filter;
         this.name_SI.result = result;
         this.doRaycast(origin,direction,maxTime,this.name_SI);
         this.name_SI.clear();
         if(this.name_SI.hasHit)
         {
            if(result.t < maxTime)
            {
               result.position.copy(origin).addScaled(result.t,direction);
               return true;
            }
         }
         return false;
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
         return false;
      }
      
      public function doRaycast(origin:Vector3, direction:Vector3, maxTime:Number, visitor:IRaycastCellVisitor) : void
      {
         var t:Number = NaN;
         var i:int = 0;
         var j:int = 0;
         var k:int = 0;
         var cellMaxTime:Number = NaN;
         var tstamp:int = int(++timestamp);
         var x1:Number = origin.x - this.name_aq.minX;
         var y1:Number = origin.y - this.name_aq.minY;
         var z1:Number = origin.z - this.name_aq.minZ;
         var x2:Number = x1 + direction.x * maxTime;
         var y2:Number = y1 + direction.y * maxTime;
         var z2:Number = z1 + direction.z * maxTime;
         var axis:int = -1;
         var entryTime:Number = 0;
         var p:Vector3 = new Vector3();
         var pointInBounds:Boolean = Boolean(this.name_aq.containsPoint(origin,EPSILON));
         if(!pointInBounds)
         {
            collisionBox.hs.reset(this.cellSize * this.numCellsX / 2,this.cellSize * this.numCellsY / 2,this.cellSize * this.numCellsZ / 2);
            collisionBox.transform.d = this.name_aq.minX + collisionBox.hs.x;
            collisionBox.transform.h = this.name_aq.minY + collisionBox.hs.y;
            collisionBox.transform.l = this.name_aq.minZ + collisionBox.hs.z;
            collisionBox.calculateAABB();
            t = Number(collisionBox.raycast(origin,direction,EPSILON,normal));
            if(t < 0 || t >= maxTime)
            {
               return;
            }
            p.copy(origin).addScaled(t,direction);
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
            i = this.clamp((p.x - this.name_aq.minX) / this.cellSize,0,this.numCellsX - 1);
            j = this.clamp((p.y - this.name_aq.minY) / this.cellSize,0,this.numCellsY - 1);
            k = this.clamp((p.z - this.name_aq.minZ) / this.cellSize,0,this.numCellsZ - 1);
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
      
      private function clearDynamicBodyCells() : void
      {
         var bodyCellEntry:BodyCellEntry = null;
         var nextBodyCellEntry:BodyCellEntry = null;
         var nextOccupiedCell:OccupiedCellIndex = null;
         for(var cellIndex:int = 0; cellIndex < this.name_00; cellIndex++)
         {
            bodyCellEntry = this.bodyCellEntries[cellIndex];
            for(this.bodyCellEntries[cellIndex] = null; bodyCellEntry != null; )
            {
               nextBodyCellEntry = bodyCellEntry.next;
               bodyCellEntry.destroy();
               bodyCellEntry = nextBodyCellEntry;
            }
         }
         var occupiedCell:OccupiedCellIndex = this.name_Qp;
         for(this.name_Qp = null; occupiedCell != null; )
         {
            nextOccupiedCell = occupiedCell.next;
            occupiedCell.destory();
            occupiedCell = nextOccupiedCell;
         }
      }
      
      private function fillDynamicBodyCells() : void
      {
         var bodyCollisionData:BodyCollisionGridData = null;
         var boundBox:BoundBox = null;
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
         this.clearDynamicBodyCells();
         for(var ti:int = 0; ti < this.name_VV; ti++)
         {
            bodyCollisionData = this.name_3Q[ti];
            boundBox = bodyCollisionData.body.aabb;
            imin = (boundBox.minX - this.name_aq.minX) / this.cellSize;
            if(!(imin < 0 || imin >= this.numCellsX))
            {
               jmin = (boundBox.minY - this.name_aq.minY) / this.cellSize;
               if(!(jmin < 0 || jmin >= this.numCellsY))
               {
                  kmin = (boundBox.minZ - this.name_aq.minZ) / this.cellSize;
                  if(!(kmin < 0 || kmin >= this.numCellsZ))
                  {
                     imax = (boundBox.maxX - this.name_aq.minX) / this.cellSize;
                     if(imax >= this.numCellsX)
                     {
                        imax = this.numCellsX - 1;
                     }
                     jmax = (boundBox.maxY - this.name_aq.minY) / this.cellSize;
                     if(jmax >= this.numCellsY)
                     {
                        jmax = this.numCellsY - 1;
                     }
                     kmax = (boundBox.maxZ - this.name_aq.minZ) / this.cellSize;
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
                        occupiedCellIndex.next = this.name_Qp;
                        this.name_Qp = occupiedCellIndex;
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
         this.name_WJ = false;
      }
      
      private function findBodyEntry(body:Body) : int
      {
         var bodyCollisionGridData:BodyCollisionGridData = null;
         for(var i:int = 0; i < this.name_VV; )
         {
            bodyCollisionGridData = this.name_3Q[i];
            if(bodyCollisionGridData.body == body)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      private function initPairBitArray() : void
      {
         var maxObjectPairs:int = MAX_OBJECTS * (MAX_OBJECTS - 1) / 2;
         this.name_81 = (maxObjectPairs + 31) / 32;
         this.name_48 = new Vector.<int>(this.name_81);
      }
      
      private function initColliders() : void
      {
         this.name_P6 = new Object();
         this.addCollider(CollisionPrimitive.BOX,CollisionPrimitive.BOX,new BoxBoxCollider());
         this.addCollider(CollisionPrimitive.BOX,CollisionPrimitive.RECT,new BoxRectCollider());
         this.addCollider(CollisionPrimitive.BOX,CollisionPrimitive.TRIANGLE,new BoxTriangleCollider());
      }
   }
}

import alternativa.math.Vector3;
import alternativa.physics.collision.CollisionPrimitive;
import alternativa.physics.collision.IRaycastFilter;
import alternativa.physics.collision.types.RayHit;
import alternativa.tanks.game.physics.collision.uniformgrid.IRaycastCellVisitor;
import alternativa.tanks.game.physics.collision.uniformgrid.BodyCollisionGridData;

class BodyCellEntry
{
   private static var pool:BodyCellEntry;
   
   public var data:BodyCollisionGridData;
   
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

class RaycastCellVisitor implements IRaycastCellVisitor
{
   public static var EPSILON:Number = 0.0001;
   
   private static var normal:Vector3 = new Vector3();
   
   public var denseArray:Vector.<CollisionPrimitive>;
   
   public var denseCellIndices:Vector.<int>;
   
   public var numCellsX:int;
   
   public var numCellsY:int;
   
   public var numCellsZ:int;
   
   public var bodyCellEntries:Vector.<BodyCellEntry>;
   
   public var collisionMask:int;
   
   public var filter:IRaycastFilter;
   
   public var result:RayHit;
   
   public var hasHit:Boolean;
   
   private var nearestPrimitive:CollisionPrimitive;
   
   private var nearestNormal:Vector3 = new Vector3();
   
   private var nearestTime:Number = 1.7976931348623157e+308;
   
   public function RaycastCellVisitor()
   {
      super();
   }
   
   public function visitCell(celli:int, cellj:int, cellk:int, axis:int, cellEntryTime:Number, cellMaxTime:Number, timestamp:int, rayOrigin:Vector3, rayDirection:Vector3) : Boolean
   {
      var collisionPrimitive:CollisionPrimitive = null;
      var time:Number = NaN;
      var bodyCellEntry:BodyCellEntry = null;
      var data:BodyCollisionGridData = null;
      var detailedPrimitives:Vector.<CollisionPrimitive> = null;
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
               if(time > 0 && time < minTime && (this.filter == null || Boolean(this.filter.acceptRayHit(collisionPrimitive))))
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
                     if(time > 0 && time < minTime && (this.filter == null || Boolean(this.filter.acceptRayHit(collisionPrimitive))))
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
