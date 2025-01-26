package package_76
{
   import package_90.name_386;
   
   public class name_663
   {
      private static const nodeBoundBoxThreshold:name_386 = new name_386();
      
      private static const splitCoordsX:Vector.<Number> = new Vector.<Number>();
      
      private static const splitCoordsY:Vector.<Number> = new Vector.<Number>();
      
      private static const splitCoordsZ:Vector.<Number> = new Vector.<Number>();
      
      private static const _nodeBB:Vector.<Number> = new Vector.<Number>(6);
      
      private static const _bb:Vector.<Number> = new Vector.<Number>(6);
      
      public var threshold:Number = 0.1;
      
      public var var_681:int = 1;
      
      public var name_659:name_656;
      
      public var name_661:Vector.<name_235>;
      
      public var var_679:int;
      
      public var staticBoundBoxes:Vector.<name_386> = new Vector.<name_386>();
      
      private var var_678:int;
      
      private var var_677:Number;
      
      private var var_680:Number;
      
      public function name_663()
      {
         super();
      }
      
      public function name_669(collisionPrimitives:Vector.<name_235>, boundBox:name_386 = null) : void
      {
         var child:name_235 = null;
         var childBoundBox:name_386 = null;
         this.name_661 = collisionPrimitives.concat();
         this.var_679 = this.name_661.length;
         this.name_659 = new name_656();
         this.name_659.indices = new Vector.<int>();
         var rootNodeBoundBox:name_386 = this.name_659.boundBox = boundBox != null ? boundBox : new name_386();
         for(var i:int = 0; i < this.var_679; i++)
         {
            child = this.name_661[i];
            childBoundBox = this.staticBoundBoxes[i] = child.calculateAABB();
            rootNodeBoundBox.name_583(childBoundBox);
            this.name_659.indices[i] = i;
         }
         this.staticBoundBoxes.length = this.var_679;
         this.splitNode(this.name_659);
         splitCoordsX.length = splitCoordsY.length = splitCoordsZ.length = 0;
      }
      
      private function splitNode(node:name_656) : void
      {
         var nodeBoundBox:name_386 = null;
         var i:int = 0;
         var j:int = 0;
         var boundBox:name_386 = null;
         var min:Number = NaN;
         var max:Number = NaN;
         var indices:Vector.<int> = node.indices;
         var numPrimitives:int = int(indices.length);
         if(numPrimitives <= this.var_681)
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
         this.var_678 = -1;
         this.var_680 = 1e+308;
         _nodeBB[0] = nodeBoundBox.minX;
         _nodeBB[1] = nodeBoundBox.minY;
         _nodeBB[2] = nodeBoundBox.minZ;
         _nodeBB[3] = nodeBoundBox.maxX;
         _nodeBB[4] = nodeBoundBox.maxY;
         _nodeBB[5] = nodeBoundBox.maxZ;
         this.method_834(node,0,numSplitCoordsX,splitCoordsX,_nodeBB);
         this.method_834(node,1,numSplitCoordsY,splitCoordsY,_nodeBB);
         this.method_834(node,2,numSplitCoordsZ,splitCoordsZ,_nodeBB);
         if(this.var_678 < 0)
         {
            return;
         }
         var axisX:Boolean = this.var_678 == 0;
         var axisY:Boolean = this.var_678 == 1;
         node.axis = this.var_678;
         node.coord = this.var_677;
         node.name_657 = new name_656();
         node.name_657.parent = node;
         node.name_657.boundBox = nodeBoundBox.clone();
         node.name_658 = new name_656();
         node.name_658.parent = node;
         node.name_658.boundBox = nodeBoundBox.clone();
         if(axisX)
         {
            node.name_657.boundBox.maxX = node.name_658.boundBox.minX = this.var_677;
         }
         else if(axisY)
         {
            node.name_657.boundBox.maxY = node.name_658.boundBox.minY = this.var_677;
         }
         else
         {
            node.name_657.boundBox.maxZ = node.name_658.boundBox.minZ = this.var_677;
         }
         var coordMin:Number = this.var_677 - this.threshold;
         var coordMax:Number = this.var_677 + this.threshold;
         for(i = 0; i < numPrimitives; )
         {
            boundBox = this.staticBoundBoxes[indices[i]];
            min = axisX ? boundBox.minX : (axisY ? boundBox.minY : boundBox.minZ);
            max = axisX ? boundBox.maxX : (axisY ? boundBox.maxY : boundBox.maxZ);
            if(max <= coordMax)
            {
               if(min < coordMin)
               {
                  if(node.name_657.indices == null)
                  {
                     node.name_657.indices = new Vector.<int>();
                  }
                  node.name_657.indices.push(indices[i]);
                  indices[i] = -1;
               }
               else
               {
                  if(node.var_674 == null)
                  {
                     node.var_674 = new Vector.<int>();
                  }
                  node.var_674.push(indices[i]);
                  indices[i] = -1;
               }
            }
            else if(min >= coordMin)
            {
               if(node.name_658.indices == null)
               {
                  node.name_658.indices = new Vector.<int>();
               }
               node.name_658.indices.push(indices[i]);
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
         if(node.var_674 != null)
         {
            node.name_660 = new CollisionKdTree2D(this,node);
            node.name_660.name_669();
         }
         if(node.name_657.indices != null)
         {
            this.splitNode(node.name_657);
         }
         if(node.name_658.indices != null)
         {
            this.splitNode(node.name_658);
         }
      }
      
      private function method_834(node:name_656, axis:int, numSplitCoords:int, splitCoords:Vector.<Number>, bb:Vector.<Number>) : void
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
         var boundBox:name_386 = null;
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
                  if(cost < this.var_680 && numNegative > 0 && numPositive > 0)
                  {
                     this.var_678 = axis;
                     this.var_680 = cost;
                     this.var_677 = currSplitCoord;
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
      
      public function method_835() : void
      {
         this.method_833("",this.name_659);
      }
      
      private function method_833(str:String, node:name_656) : void
      {
         if(node == null)
         {
            return;
         }
         trace(str,node.axis == -1 ? "end" : (node.axis == 0 ? "X" : (node.axis == 1 ? "Y" : "Z")),"splitCoord=" + this.var_677,"bound",node.boundBox,"objs:",node.indices);
         this.method_833(str + "-",node.name_657);
         this.method_833(str + "+",node.name_658);
      }
   }
}

