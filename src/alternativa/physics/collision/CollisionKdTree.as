package alternativa.physics.collision
{
   import alternativa.physics.collision.types.BoundBox;
   
   public class CollisionKdTree
   {
      private static const nodeBoundBoxThreshold:BoundBox = new BoundBox();
      
      private static const splitCoordsX:Vector.<Number> = new Vector.<Number>();
      
      private static const splitCoordsY:Vector.<Number> = new Vector.<Number>();
      
      private static const splitCoordsZ:Vector.<Number> = new Vector.<Number>();
      
      private static const _nodeBB:Vector.<Number> = new Vector.<Number>(6);
      
      private static const _bb:Vector.<Number> = new Vector.<Number>(6);
      
      public var threshold:Number = 0.1;
      
      public var name_eV:int = 1;
      
      public var name_5H:CollisionKdNode;
      
      public var name_8A:Vector.<CollisionPrimitive>;
      
      public var name_TO:int;
      
      public var staticBoundBoxes:Vector.<BoundBox> = new Vector.<BoundBox>();
      
      private var name_94:int;
      
      private var name_P5:Number;
      
      private var name_ou:Number;
      
      public function CollisionKdTree()
      {
         super();
      }
      
      public function createTree(collisionPrimitives:Vector.<CollisionPrimitive>, boundBox:BoundBox = null) : void
      {
         var child:CollisionPrimitive = null;
         var childBoundBox:BoundBox = null;
         this.name_8A = collisionPrimitives.concat();
         this.name_TO = this.name_8A.length;
         this.name_5H = new CollisionKdNode();
         this.name_5H.indices = new Vector.<int>();
         var rootNodeBoundBox:BoundBox = this.name_5H.boundBox = boundBox != null ? boundBox : new BoundBox();
         for(var i:int = 0; i < this.name_TO; i++)
         {
            child = this.name_8A[i];
            childBoundBox = this.staticBoundBoxes[i] = child.calculateAABB();
            rootNodeBoundBox.addBoundBox(childBoundBox);
            this.name_5H.indices[i] = i;
         }
         this.staticBoundBoxes.length = this.name_TO;
         this.splitNode(this.name_5H);
         splitCoordsX.length = splitCoordsY.length = splitCoordsZ.length = 0;
      }
      
      private function splitNode(node:CollisionKdNode) : void
      {
         var nodeBoundBox:BoundBox = null;
         var i:int = 0;
         var j:int = 0;
         var boundBox:BoundBox = null;
         var min:Number = NaN;
         var max:Number = NaN;
         var indices:Vector.<int> = node.indices;
         var numPrimitives:int = int(indices.length);
         if(numPrimitives <= this.name_eV)
         {
            return;
         }
         nodeBoundBox = node.boundBox;
         nodeBoundBoxThreshold.minX = nodeBoundBox.minX + this.threshold;
         nodeBoundBoxThreshold.minY = nodeBoundBox.minY + this.threshold;
         nodeBoundBoxThreshold.minZ = nodeBoundBox.minZ + this.threshold;
         nodeBoundBoxThreshold.maxX = nodeBoundBox.maxX - this.threshold;
         nodeBoundBoxThreshold.maxY = nodeBoundBox.maxY - this.threshold;
         nodeBoundBoxThreshold.maxZ = nodeBoundBox.maxZ - this.threshold;
         var doubleThreshold:Number = this.threshold * 2;
         var numSplitCoordsX:int = 0;
         var numSplitCoordsY:int = 0;
         var numSplitCoordsZ:int = 0;
         for(i = 0; i < numPrimitives; )
         {
            boundBox = this.staticBoundBoxes[indices[i]];
            if(boundBox.maxX - boundBox.minX <= doubleThreshold)
            {
               if(boundBox.minX <= nodeBoundBoxThreshold.minX)
               {
                  var _loc18_:* = numSplitCoordsX++;
                  splitCoordsX[_loc18_] = nodeBoundBox.minX;
               }
               else if(boundBox.maxX >= nodeBoundBoxThreshold.maxX)
               {
                  _loc18_ = numSplitCoordsX++;
                  splitCoordsX[_loc18_] = nodeBoundBox.maxX;
               }
               else
               {
                  _loc18_ = numSplitCoordsX++;
                  splitCoordsX[_loc18_] = (boundBox.minX + boundBox.maxX) * 0.5;
               }
            }
            else
            {
               if(boundBox.minX > nodeBoundBoxThreshold.minX)
               {
                  _loc18_ = numSplitCoordsX++;
                  splitCoordsX[_loc18_] = boundBox.minX;
               }
               if(boundBox.maxX < nodeBoundBoxThreshold.maxX)
               {
                  _loc18_ = numSplitCoordsX++;
                  splitCoordsX[_loc18_] = boundBox.maxX;
               }
            }
            if(boundBox.maxY - boundBox.minY <= doubleThreshold)
            {
               if(boundBox.minY <= nodeBoundBoxThreshold.minY)
               {
                  _loc18_ = numSplitCoordsY++;
                  splitCoordsY[_loc18_] = nodeBoundBox.minY;
               }
               else if(boundBox.maxY >= nodeBoundBoxThreshold.maxY)
               {
                  _loc18_ = numSplitCoordsY++;
                  splitCoordsY[_loc18_] = nodeBoundBox.maxY;
               }
               else
               {
                  _loc18_ = numSplitCoordsY++;
                  splitCoordsY[_loc18_] = (boundBox.minY + boundBox.maxY) * 0.5;
               }
            }
            else
            {
               if(boundBox.minY > nodeBoundBoxThreshold.minY)
               {
                  _loc18_ = numSplitCoordsY++;
                  splitCoordsY[_loc18_] = boundBox.minY;
               }
               if(boundBox.maxY < nodeBoundBoxThreshold.maxY)
               {
                  _loc18_ = numSplitCoordsY++;
                  splitCoordsY[_loc18_] = boundBox.maxY;
               }
            }
            if(boundBox.maxZ - boundBox.minZ <= doubleThreshold)
            {
               if(boundBox.minZ <= nodeBoundBoxThreshold.minZ)
               {
                  _loc18_ = numSplitCoordsZ++;
                  splitCoordsZ[_loc18_] = nodeBoundBox.minZ;
               }
               else if(boundBox.maxZ >= nodeBoundBoxThreshold.maxZ)
               {
                  _loc18_ = numSplitCoordsZ++;
                  splitCoordsZ[_loc18_] = nodeBoundBox.maxZ;
               }
               else
               {
                  _loc18_ = numSplitCoordsZ++;
                  splitCoordsZ[_loc18_] = (boundBox.minZ + boundBox.maxZ) * 0.5;
               }
            }
            else
            {
               if(boundBox.minZ > nodeBoundBoxThreshold.minZ)
               {
                  _loc18_ = numSplitCoordsZ++;
                  splitCoordsZ[_loc18_] = boundBox.minZ;
               }
               if(boundBox.maxZ < nodeBoundBoxThreshold.maxZ)
               {
                  _loc18_ = numSplitCoordsZ++;
                  splitCoordsZ[_loc18_] = boundBox.maxZ;
               }
            }
            i++;
         }
         this.name_94 = -1;
         this.name_ou = 1e+308;
         _nodeBB[0] = nodeBoundBox.minX;
         _nodeBB[1] = nodeBoundBox.minY;
         _nodeBB[2] = nodeBoundBox.minZ;
         _nodeBB[3] = nodeBoundBox.maxX;
         _nodeBB[4] = nodeBoundBox.maxY;
         _nodeBB[5] = nodeBoundBox.maxZ;
         this.checkNodeAxis(node,0,numSplitCoordsX,splitCoordsX,_nodeBB);
         this.checkNodeAxis(node,1,numSplitCoordsY,splitCoordsY,_nodeBB);
         this.checkNodeAxis(node,2,numSplitCoordsZ,splitCoordsZ,_nodeBB);
         if(this.name_94 < 0)
         {
            return;
         }
         var axisX:Boolean = this.name_94 == 0;
         var axisY:Boolean = this.name_94 == 1;
         node.axis = this.name_94;
         node.coord = this.name_P5;
         node.name_Gm = new CollisionKdNode();
         node.name_Gm.parent = node;
         node.name_Gm.boundBox = nodeBoundBox.clone();
         node.name_75 = new CollisionKdNode();
         node.name_75.parent = node;
         node.name_75.boundBox = nodeBoundBox.clone();
         if(axisX)
         {
            node.name_Gm.boundBox.maxX = node.name_75.boundBox.minX = this.name_P5;
         }
         else if(axisY)
         {
            node.name_Gm.boundBox.maxY = node.name_75.boundBox.minY = this.name_P5;
         }
         else
         {
            node.name_Gm.boundBox.maxZ = node.name_75.boundBox.minZ = this.name_P5;
         }
         var coordMin:Number = this.name_P5 - this.threshold;
         var coordMax:Number = this.name_P5 + this.threshold;
         for(i = 0; i < numPrimitives; )
         {
            boundBox = this.staticBoundBoxes[indices[i]];
            min = axisX ? boundBox.minX : (axisY ? boundBox.minY : boundBox.minZ);
            max = axisX ? boundBox.maxX : (axisY ? boundBox.maxY : boundBox.maxZ);
            if(max <= coordMax)
            {
               if(min < coordMin)
               {
                  if(node.name_Gm.indices == null)
                  {
                     node.name_Gm.indices = new Vector.<int>();
                  }
                  node.name_Gm.indices.push(indices[i]);
                  indices[i] = -1;
               }
               else
               {
                  if(node.name_Xt == null)
                  {
                     node.name_Xt = new Vector.<int>();
                  }
                  node.name_Xt.push(indices[i]);
                  indices[i] = -1;
               }
            }
            else if(min >= coordMin)
            {
               if(node.name_75.indices == null)
               {
                  node.name_75.indices = new Vector.<int>();
               }
               node.name_75.indices.push(indices[i]);
               indices[i] = -1;
            }
            i++;
         }
         for(i = 0,j = 0; i < numPrimitives; )
         {
            if(indices[i] >= 0)
            {
               _loc18_ = j++;
               indices[_loc18_] = indices[i];
            }
            i++;
         }
         if(j > 0)
         {
            indices.length = j;
         }
         else
         {
            node.indices = null;
         }
         if(node.name_Xt != null)
         {
            node.name_da = new CollisionKdTree2D(this,node);
            node.name_da.createTree();
         }
         if(node.name_Gm.indices != null)
         {
            this.splitNode(node.name_Gm);
         }
         if(node.name_75.indices != null)
         {
            this.splitNode(node.name_75);
         }
      }
      
      private function checkNodeAxis(node:CollisionKdNode, axis:int, numSplitCoords:int, splitCoords:Vector.<Number>, bb:Vector.<Number>) : void
      {
         var currSplitCoord:Number = NaN;
         var minCoord:Number = NaN;
         var maxCoord:Number = NaN;
         var areaNegative:Number = NaN;
         var areaPositive:Number = NaN;
         var numNegative:int = 0;
         var numPositive:int = 0;
         var conflict:Boolean = false;
         var numObjects:int = 0;
         var j:int = 0;
         var cost:Number = NaN;
         var boundBox:BoundBox = null;
         var axis1:int = (axis + 1) % 3;
         var axis2:int = (axis + 2) % 3;
         var area:Number = (bb[axis1 + 3] - bb[axis1]) * (bb[axis2 + 3] - bb[axis2]);
         for(var i:int = 0; i < numSplitCoords; i++)
         {
            currSplitCoord = splitCoords[i];
            if(!isNaN(currSplitCoord))
            {
               minCoord = currSplitCoord - this.threshold;
               maxCoord = currSplitCoord + this.threshold;
               areaNegative = area * (currSplitCoord - bb[axis]);
               areaPositive = area * (bb[int(axis + 3)] - currSplitCoord);
               numNegative = 0;
               numPositive = 0;
               conflict = false;
               numObjects = int(node.indices.length);
               for(j = 0; j < numObjects; )
               {
                  boundBox = this.staticBoundBoxes[node.indices[j]];
                  _bb[0] = boundBox.minX;
                  _bb[1] = boundBox.minY;
                  _bb[2] = boundBox.minZ;
                  _bb[3] = boundBox.maxX;
                  _bb[4] = boundBox.maxY;
                  _bb[5] = boundBox.maxZ;
                  if(_bb[axis + 3] <= maxCoord)
                  {
                     if(_bb[axis] < minCoord)
                     {
                        numNegative++;
                     }
                  }
                  else
                  {
                     if(_bb[axis] < minCoord)
                     {
                        conflict = true;
                        break;
                     }
                     numPositive++;
                  }
                  j++;
               }
               cost = areaNegative * numNegative + areaPositive * numPositive;
               if(!conflict)
               {
                  if(cost < this.name_ou && numNegative > 0 && numPositive > 0)
                  {
                     this.name_94 = axis;
                     this.name_ou = cost;
                     this.name_P5 = currSplitCoord;
                  }
               }
               for(j = i + 1; j < numSplitCoords; )
               {
                  if(splitCoords[j] >= currSplitCoord - this.threshold && splitCoords[j] <= currSplitCoord + this.threshold)
                  {
                     splitCoords[j] = NaN;
                  }
                  j++;
               }
            }
         }
      }
      
      public function traceTree() : void
      {
         this.traceNode("",this.name_5H);
      }
      
      private function traceNode(str:String, node:CollisionKdNode) : void
      {
         if(node == null)
         {
            return;
         }
         trace(str,node.axis == -1 ? "end" : (node.axis == 0 ? "X" : (node.axis == 1 ? "Y" : "Z")),"splitCoord=" + this.name_P5,"bound",node.boundBox,"objs:",node.indices);
         this.traceNode(str + "-",node.name_Gm);
         this.traceNode(str + "+",node.name_75);
      }
   }
}

