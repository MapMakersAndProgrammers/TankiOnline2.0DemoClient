package alternativa.physics.collision
{
   import alternativa.physics.collision.types.BoundBox;
   
   public class CollisionKdTree2D
   {
      private static const nodeBoundBoxThreshold:BoundBox = new BoundBox();
      
      private static const splitCoordsX:Vector.<Number> = new Vector.<Number>();
      
      private static const splitCoordsY:Vector.<Number> = new Vector.<Number>();
      
      private static const splitCoordsZ:Vector.<Number> = new Vector.<Number>();
      
      private static const _nodeBB:Vector.<Number> = new Vector.<Number>(6);
      
      private static const _bb:Vector.<Number> = new Vector.<Number>(6);
      
      public var threshold:Number = 0.1;
      
      public var name_eV:int = 1;
      
      public var parentTree:CollisionKdTree;
      
      public var parentNode:CollisionKdNode;
      
      public var name_5H:CollisionKdNode;
      
      private var name_94:int;
      
      private var name_ou:Number;
      
      private var name_P5:Number;
      
      public function CollisionKdTree2D(parentTree:CollisionKdTree, parentNode:CollisionKdNode)
      {
         super();
         this.parentTree = parentTree;
         this.parentNode = parentNode;
      }
      
      public function createTree() : void
      {
         this.name_5H = new CollisionKdNode();
         this.name_5H.boundBox = this.parentNode.boundBox.clone();
         this.name_5H.indices = new Vector.<int>();
         var numObjects:int = int(this.parentNode.name_Xt.length);
         for(var i:int = 0; i < numObjects; this.name_5H.indices[i] = this.parentNode.name_Xt[i],i++)
         {
         }
         this.splitNode(this.name_5H);
         splitCoordsX.length = splitCoordsY.length = splitCoordsZ.length = 0;
      }
      
      private function splitNode(node:CollisionKdNode) : void
      {
         var objects:Vector.<int> = null;
         var i:int = 0;
         var j:int = 0;
         var nodeBoundBox:BoundBox = null;
         var numSplitCoordsX:int = 0;
         var numSplitCoordsY:int = 0;
         var numSplitCoordsZ:int = 0;
         var bb:BoundBox = null;
         var min:Number = NaN;
         var max:Number = NaN;
         if(node.indices.length <= this.name_eV)
         {
            return;
         }
         objects = node.indices;
         nodeBoundBox = node.boundBox;
         nodeBoundBoxThreshold.minX = nodeBoundBox.minX + this.threshold;
         nodeBoundBoxThreshold.minY = nodeBoundBox.minY + this.threshold;
         nodeBoundBoxThreshold.minZ = nodeBoundBox.minZ + this.threshold;
         nodeBoundBoxThreshold.maxX = nodeBoundBox.maxX - this.threshold;
         nodeBoundBoxThreshold.maxY = nodeBoundBox.maxY - this.threshold;
         nodeBoundBoxThreshold.maxZ = nodeBoundBox.maxZ - this.threshold;
         var doubleThreshold:Number = this.threshold * 2;
         var staticBoundBoxes:Vector.<BoundBox> = this.parentTree.staticBoundBoxes;
         var numObjects:int = int(objects.length);
         for(i = 0; i < numObjects; )
         {
            bb = staticBoundBoxes[objects[i]];
            if(this.parentNode.axis != 0)
            {
               if(bb.minX > nodeBoundBoxThreshold.minX)
               {
                  var _loc19_:* = numSplitCoordsX++;
                  splitCoordsX[_loc19_] = bb.minX;
               }
               if(bb.maxX < nodeBoundBoxThreshold.maxX)
               {
                  _loc19_ = numSplitCoordsX++;
                  splitCoordsX[_loc19_] = bb.maxX;
               }
            }
            if(this.parentNode.axis != 1)
            {
               if(bb.minY > nodeBoundBoxThreshold.minY)
               {
                  _loc19_ = numSplitCoordsY++;
                  splitCoordsY[_loc19_] = bb.minY;
               }
               if(bb.maxY < nodeBoundBoxThreshold.maxY)
               {
                  _loc19_ = numSplitCoordsY++;
                  splitCoordsY[_loc19_] = bb.maxY;
               }
            }
            if(this.parentNode.axis != 2)
            {
               if(bb.minZ > nodeBoundBoxThreshold.minZ)
               {
                  _loc19_ = numSplitCoordsZ++;
                  splitCoordsZ[_loc19_] = bb.minZ;
               }
               if(bb.maxZ < nodeBoundBoxThreshold.maxZ)
               {
                  _loc19_ = numSplitCoordsZ++;
                  splitCoordsZ[_loc19_] = bb.maxZ;
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
         if(this.parentNode.axis != 0)
         {
            this.checkNodeAxis(node,0,numSplitCoordsX,splitCoordsX,_nodeBB);
         }
         if(this.parentNode.axis != 1)
         {
            this.checkNodeAxis(node,1,numSplitCoordsY,splitCoordsY,_nodeBB);
         }
         if(this.parentNode.axis != 2)
         {
            this.checkNodeAxis(node,2,numSplitCoordsZ,splitCoordsZ,_nodeBB);
         }
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
         for(i = 0; i < numObjects; )
         {
            bb = staticBoundBoxes[objects[i]];
            min = axisX ? bb.minX : (axisY ? bb.minY : bb.minZ);
            max = axisX ? bb.maxX : (axisY ? bb.maxY : bb.maxZ);
            if(max <= coordMax)
            {
               if(min < coordMin)
               {
                  if(node.name_Gm.indices == null)
                  {
                     node.name_Gm.indices = new Vector.<int>();
                  }
                  node.name_Gm.indices.push(objects[i]);
                  objects[i] = -1;
               }
            }
            else if(min >= coordMin)
            {
               if(max > coordMax)
               {
                  if(node.name_75.indices == null)
                  {
                     node.name_75.indices = new Vector.<int>();
                  }
                  node.name_75.indices.push(objects[i]);
                  objects[i] = -1;
               }
            }
            i++;
         }
         for(i = 0,j = 0; i < numObjects; )
         {
            if(objects[i] >= 0)
            {
               _loc19_ = j++;
               objects[_loc19_] = objects[i];
            }
            i++;
         }
         if(j > 0)
         {
            objects.length = j;
         }
         else
         {
            node.indices = null;
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
         var staticBoundBoxes:Vector.<BoundBox> = this.parentTree.staticBoundBoxes;
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
                  boundBox = staticBoundBoxes[node.indices[j]];
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
               if(!conflict && cost < this.name_ou && numNegative > 0 && numPositive > 0)
               {
                  this.name_94 = axis;
                  this.name_ou = cost;
                  this.name_P5 = currSplitCoord;
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
   }
}

