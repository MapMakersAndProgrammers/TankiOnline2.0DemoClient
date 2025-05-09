package package_51
{
   import package_58.name_334;
   
   public class name_492
   {
      private static const nodeBoundBoxThreshold:name_334 = new name_334();
      
      private static const splitCoordsX:Vector.<Number> = new Vector.<Number>();
      
      private static const splitCoordsY:Vector.<Number> = new Vector.<Number>();
      
      private static const splitCoordsZ:Vector.<Number> = new Vector.<Number>();
      
      private static const _nodeBB:Vector.<Number> = new Vector.<Number>(6);
      
      private static const _bb:Vector.<Number> = new Vector.<Number>(6);
      
      public var threshold:Number = 0.1;
      
      public var var_681:int = 1;
      
      public var name_486:name_481;
      
      public var name_490:Vector.<name_276>;
      
      public var var_679:int;
      
      public var staticBoundBoxes:Vector.<name_334> = new Vector.<name_334>();
      
      private var var_678:int;
      
      private var var_677:Number;
      
      private var var_680:Number;
      
      public function name_492()
      {
         super();
      }
      
      public function name_499(collisionPrimitives:Vector.<name_276>, boundBox:name_334 = null) : void
      {
         var child:name_276 = null;
         var childBoundBox:name_334 = null;
         this.name_490 = collisionPrimitives.concat();
         this.var_679 = this.name_490.length;
         this.name_486 = new name_481();
         this.name_486.indices = new Vector.<int>();
         var rootNodeBoundBox:name_334 = this.name_486.boundBox = boundBox != null ? boundBox : new name_334();
         for(var i:int = 0; i < this.var_679; i++)
         {
            child = this.name_490[i];
            childBoundBox = this.staticBoundBoxes[i] = child.calculateAABB();
            rootNodeBoundBox.name_424(childBoundBox);
            this.name_486.indices[i] = i;
         }
         this.staticBoundBoxes.length = this.var_679;
         this.splitNode(this.name_486);
         splitCoordsX.length = splitCoordsY.length = splitCoordsZ.length = 0;
      }
      
      private function splitNode(node:name_481) : void
      {
         var nodeBoundBox:name_334 = null;
         var i:int = 0;
         var j:int = 0;
         var boundBox:name_334 = null;
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
         this.method_332(node,0,numSplitCoordsX,splitCoordsX,_nodeBB);
         this.method_332(node,1,numSplitCoordsY,splitCoordsY,_nodeBB);
         this.method_332(node,2,numSplitCoordsZ,splitCoordsZ,_nodeBB);
         if(this.var_678 < 0)
         {
            return;
         }
         var axisX:Boolean = this.var_678 == 0;
         var axisY:Boolean = this.var_678 == 1;
         node.axis = this.var_678;
         node.coord = this.var_677;
         node.name_483 = new name_481();
         node.name_483.parent = node;
         node.name_483.boundBox = nodeBoundBox.clone();
         node.name_484 = new name_481();
         node.name_484.parent = node;
         node.name_484.boundBox = nodeBoundBox.clone();
         if(axisX)
         {
            node.name_483.boundBox.maxX = node.name_484.boundBox.minX = this.var_677;
         }
         else if(axisY)
         {
            node.name_483.boundBox.maxY = node.name_484.boundBox.minY = this.var_677;
         }
         else
         {
            node.name_483.boundBox.maxZ = node.name_484.boundBox.minZ = this.var_677;
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
                  if(node.name_483.indices == null)
                  {
                     node.name_483.indices = new Vector.<int>();
                  }
                  node.name_483.indices.push(indices[i]);
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
               if(node.name_484.indices == null)
               {
                  node.name_484.indices = new Vector.<int>();
               }
               node.name_484.indices.push(indices[i]);
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
            node.name_487 = new CollisionKdTree2D(this,node);
            node.name_487.name_499();
         }
         if(node.name_483.indices != null)
         {
            this.splitNode(node.name_483);
         }
         if(node.name_484.indices != null)
         {
            this.splitNode(node.name_484);
         }
      }
      
      private function method_332(node:name_481, axis:int, numSplitCoords:int, splitCoords:Vector.<Number>, bb:Vector.<Number>) : void
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
         var boundBox:name_334 = null;
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
      
      public function method_333() : void
      {
         this.method_331("",this.name_486);
      }
      
      private function method_331(str:String, node:name_481) : void
      {
         if(node == null)
         {
            return;
         }
         trace(str,node.axis == -1 ? "end" : (node.axis == 0 ? "X" : (node.axis == 1 ? "Y" : "Z")),"splitCoord=" + this.var_677,"bound",node.boundBox,"objs:",node.indices);
         this.method_331(str + "-",node.name_483);
         this.method_331(str + "+",node.name_484);
      }
   }
}

