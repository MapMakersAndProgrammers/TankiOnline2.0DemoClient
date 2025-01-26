package package_123
{
   import alternativa.engine3d.*;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.Endian;
   import package_116.name_641;
   import package_124.name_705;
   import package_19.name_528;
   import package_19.name_700;
   import package_21.name_126;
   import package_21.name_78;
   import package_28.name_119;
   
   use namespace collada;
   use namespace alternativa3d;
   
   public class name_735 extends class_43
   {
      private var var_726:Vector.<Vector.<Number>>;
      
      private var var_725:Array;
      
      private var indices:Array;
      
      private var var_728:name_784;
      
      private var var_727:name_784;
      
      private var var_729:int;
      
      private var geometry:name_119;
      
      private var primitives:Vector.<name_768>;
      
      private var var_724:int = 0;
      
      private var var_723:Vector.<Number>;
      
      public function name_735(data:XML, document:name_707)
      {
         super(data,document);
      }
      
      private function get method_912() : name_736
      {
         var geom:name_736 = document.findGeometry(data.skin.@source[0]);
         if(geom == null)
         {
            document.logger.logNotFoundError(data.@source[0]);
         }
         return geom;
      }
      
      override protected function parseImplementation() : Boolean
      {
         var i:int = 0;
         var j:int = 0;
         var count:int = 0;
         var vertices:Vector.<name_770> = null;
         var source:name_119 = null;
         var localMaxJointsPerVertex:int = 0;
         var attributes:Array = null;
         var numSourceAttributes:int = 0;
         var index:int = 0;
         var numMappings:int = 0;
         var sourceData:ByteArray = null;
         var data:ByteArray = null;
         var byteArray:ByteArray = null;
         var attribute:int = 0;
         var vertexWeightsXML:XML = this.data.skin.vertex_weights[0];
         if(vertexWeightsXML == null)
         {
            return false;
         }
         var vcountsXML:XML = vertexWeightsXML.vcount[0];
         if(vcountsXML == null)
         {
            return false;
         }
         this.var_725 = method_867(vcountsXML);
         var indicesXML:XML = vertexWeightsXML.v[0];
         if(indicesXML == null)
         {
            return false;
         }
         this.indices = method_867(indicesXML);
         this.method_909();
         this.method_906();
         for(i = 0; i < this.var_725.length; )
         {
            count = int(this.var_725[i]);
            if(this.var_724 < count)
            {
               this.var_724 = count;
            }
            i++;
         }
         var geom:name_736 = this.method_912;
         this.var_723 = this.method_904();
         if(geom != null)
         {
            geom.method_314();
            vertices = geom.var_716;
            source = geom.geometry;
            localMaxJointsPerVertex = this.var_724 % 2 != 0 ? this.var_724 + 1 : this.var_724;
            this.geometry = new name_119();
            this.geometry.alternativa3d::_indices = source.alternativa3d::_indices.slice();
            attributes = source.method_279(0);
            numSourceAttributes = int(attributes.length);
            index = numSourceAttributes;
            for(i = 0; i < localMaxJointsPerVertex; i += 2)
            {
               attribute = int(name_126.JOINTS[int(i / 2)]);
               attributes[int(index++)] = attribute;
               attributes[int(index++)] = attribute;
               attributes[int(index++)] = attribute;
               attributes[int(index++)] = attribute;
            }
            numMappings = int(attributes.length);
            sourceData = source.alternativa3d::_vertexStreams[0].data;
            data = new ByteArray();
            data.endian = Endian.LITTLE_ENDIAN;
            data.length = 4 * numMappings * source.alternativa3d::_numVertices;
            sourceData.position = 0;
            for(i = 0; i < source.alternativa3d::_numVertices; i++)
            {
               data.position = 4 * numMappings * i;
               for(j = 0; j < numSourceAttributes; j++)
               {
                  data.writeFloat(sourceData.readFloat());
               }
            }
            byteArray = this.createVertexBuffer(vertices,localMaxJointsPerVertex);
            byteArray.position = 0;
            for(i = 0; i < source.alternativa3d::_numVertices; i++)
            {
               data.position = 4 * (numMappings * i + numSourceAttributes);
               for(j = 0; j < localMaxJointsPerVertex; j++)
               {
                  data.writeFloat(byteArray.readFloat());
                  data.writeFloat(byteArray.readFloat());
               }
            }
            this.geometry.addVertexStream(attributes);
            this.geometry.alternativa3d::_vertexStreams[0].data = data;
            this.geometry.alternativa3d::_numVertices = source.alternativa3d::_numVertices;
            this.method_908(this.geometry);
            this.primitives = geom.primitives;
         }
         return true;
      }
      
      private function method_908(geometry:name_119) : void
      {
         var x:Number = NaN;
         var y:Number = NaN;
         var z:Number = NaN;
         var data:ByteArray = geometry.alternativa3d::_vertexStreams[0].data;
         var numMappings:int = int(geometry.alternativa3d::_vertexStreams[0].attributes.length);
         for(var i:int = 0; i < geometry.alternativa3d::_numVertices; i++)
         {
            data.position = 4 * numMappings * i;
            x = Number(data.readFloat());
            y = Number(data.readFloat());
            z = Number(data.readFloat());
            data.position -= 12;
            data.writeFloat(x * this.var_723[0] + y * this.var_723[1] + z * this.var_723[2] + this.var_723[3]);
            data.writeFloat(x * this.var_723[4] + y * this.var_723[5] + z * this.var_723[6] + this.var_723[7]);
            data.writeFloat(x * this.var_723[8] + y * this.var_723[9] + z * this.var_723[10] + this.var_723[11]);
         }
      }
      
      private function createVertexBuffer(vertices:Vector.<name_770>, localMaxJointsPerVertex:int) : ByteArray
      {
         var i:int = 0;
         var count:int = 0;
         var vertexOutIndices:Vector.<uint> = null;
         var vertex:name_770 = null;
         var vec:Vector.<uint> = null;
         var jointsPerVertex:int = 0;
         var j:int = 0;
         var k:int = 0;
         var index:int = 0;
         var jointIndex:int = 0;
         var weightIndex:int = 0;
         var jointsOffset:int = this.var_728.offset;
         var weightsOffset:int = this.var_727.offset;
         var weightsSource:name_740 = this.var_727.prepareSource(1);
         var weights:Vector.<Number> = weightsSource.numbers;
         var weightsStride:int = weightsSource.stride;
         var verticesDict:Dictionary = new Dictionary();
         var byteArray:ByteArray = new ByteArray();
         byteArray.length = vertices.length * localMaxJointsPerVertex * 8;
         byteArray.endian = Endian.LITTLE_ENDIAN;
         for(i = 0,count = int(vertices.length); i < count; i++)
         {
            vertex = vertices[i];
            if(vertex != null)
            {
               vec = verticesDict[vertex.name_785];
               if(vec == null)
               {
                  vec = verticesDict[vertex.name_785] = new Vector.<uint>();
               }
               vec.push(vertex.name_786);
            }
         }
         var vertexIndex:int = 0;
         for(i = 0,count = int(this.var_725.length); i < count; i++)
         {
            jointsPerVertex = int(this.var_725[i]);
            vertexOutIndices = verticesDict[i];
            for(j = 0; j < vertexOutIndices.length; j++)
            {
               byteArray.position = vertexOutIndices[j] * localMaxJointsPerVertex * 8;
               for(k = 0; k < jointsPerVertex; k++)
               {
                  index = this.var_729 * (vertexIndex + k);
                  jointIndex = int(this.indices[int(index + jointsOffset)]);
                  if(jointIndex >= 0)
                  {
                     byteArray.writeFloat(jointIndex * 3);
                     weightIndex = int(this.indices[int(index + weightsOffset)]);
                     byteArray.writeFloat(weights[int(weightsStride * weightIndex)]);
                  }
                  else
                  {
                     byteArray.position += 8;
                  }
               }
            }
            vertexIndex += jointsPerVertex;
         }
         byteArray.position = 0;
         return byteArray;
      }
      
      private function method_909() : void
      {
         var input:name_784 = null;
         var semantic:String = null;
         var offset:int = 0;
         var inputsList:XMLList = data.skin.vertex_weights.input;
         var maxInputOffset:int = 0;
         for(var i:int = 0,var count:int = int(inputsList.length()); i < count; offset = input.offset,maxInputOffset = offset > maxInputOffset ? offset : maxInputOffset,i++)
         {
            input = new name_784(inputsList[i],document);
            semantic = input.semantic;
            if(semantic == null)
            {
               continue;
            }
            switch(semantic)
            {
               case "JOINT":
                  if(this.var_728 == null)
                  {
                     this.var_728 = input;
                  }
                  break;
               case "WEIGHT":
                  if(this.var_727 == null)
                  {
                     this.var_727 = input;
                  }
                  break;
            }
         }
         this.var_729 = maxInputOffset + 1;
      }
      
      private function method_906() : void
      {
         var jointsXML:XML = null;
         var jointsSource:name_740 = null;
         var stride:int = 0;
         var count:int = 0;
         var i:int = 0;
         var index:int = 0;
         var matrix:Vector.<Number> = null;
         var j:int = 0;
         jointsXML = data.skin.joints.input.(@semantic == "INV_BIND_MATRIX")[0];
         if(jointsXML != null)
         {
            jointsSource = document.findSource(jointsXML.@source[0]);
            if(jointsSource != null)
            {
               if(jointsSource.method_314() && jointsSource.numbers != null && jointsSource.stride >= 16)
               {
                  stride = jointsSource.stride;
                  count = jointsSource.numbers.length / stride;
                  this.var_726 = new Vector.<Vector.<Number>>(count);
                  for(i = 0; i < count; i++)
                  {
                     index = stride * i;
                     matrix = new Vector.<Number>(16);
                     this.var_726[i] = matrix;
                     for(j = 0; j < 16; j++)
                     {
                        matrix[j] = jointsSource.numbers[int(index + j)];
                     }
                  }
               }
            }
            else
            {
               document.logger.logNotFoundError(jointsXML.@source[0]);
            }
         }
      }
      
      public function method_429(materials:Object, topmostJoints:Vector.<name_706>, skeletons:Vector.<name_706>) : name_711
      {
         var numJoints:int = 0;
         var skin:name_528 = null;
         var joints:Vector.<name_711> = null;
         var i:int = 0;
         var p:name_768 = null;
         var instanceMaterial:name_758 = null;
         var material:name_641 = null;
         var daeMaterial:name_713 = null;
         var skinXML:XML = data.skin[0];
         if(skinXML != null)
         {
            this.var_723 = this.method_904();
            numJoints = int(this.var_726.length);
            skin = new name_528(this.var_724,numJoints);
            skin.geometry = this.geometry;
            joints = this.method_915(skin,topmostJoints,this.method_902(skeletons));
            this.method_910(joints);
            skin.var_631 = this.method_905(joints,numJoints);
            if(this.primitives != null)
            {
               for(i = 0; i < this.primitives.length; i++)
               {
                  p = this.primitives[i];
                  instanceMaterial = materials[p.name_774];
                  if(instanceMaterial != null)
                  {
                     daeMaterial = instanceMaterial.material;
                     if(daeMaterial != null)
                     {
                        daeMaterial.method_314();
                        material = daeMaterial.material;
                        daeMaterial.used = true;
                     }
                  }
                  skin.addSurface(material,p.indexBegin,p.numTriangles);
               }
            }
            return new name_711(skin,this.method_913(skin,joints));
         }
         return null;
      }
      
      private function method_905(joints:Vector.<name_711>, numJoints:int) : Vector.<name_700>
      {
         var result:Vector.<name_700> = new Vector.<name_700>();
         for(var i:int = 0; i < numJoints; i++)
         {
            result[i] = name_700(joints[i].object);
         }
         return result;
      }
      
      private function method_913(skin:name_528, joints:Vector.<name_711>) : name_705
      {
         var animatedObject:name_711 = null;
         var clip:name_705 = null;
         var object:name_78 = null;
         var t:int = 0;
         if(!this.method_911(joints))
         {
            return null;
         }
         var result:name_705 = new name_705();
         var resultObjects:Array = [skin];
         for(var i:int = 0,var count:int = int(joints.length); i < count; i++)
         {
            animatedObject = joints[i];
            clip = animatedObject.animation;
            if(clip != null)
            {
               for(t = 0; t < clip.numTracks; t++)
               {
                  result.name_712(clip.name_716(t));
               }
            }
            else
            {
               result.name_712(animatedObject.jointNode.name_715());
            }
            object = animatedObject.object;
            object.name = animatedObject.jointNode.method_872;
            resultObjects.push(object);
         }
         result.alternativa3d::var_346 = resultObjects;
         return result;
      }
      
      private function method_911(joints:Vector.<name_711>) : Boolean
      {
         var object:name_711 = null;
         for(var i:int = 0,var count:int = int(joints.length); i < count; )
         {
            object = joints[i];
            if(object.animation != null)
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      private function method_910(animatedJoints:Vector.<name_711>) : void
      {
         var animatedJoint:name_711 = null;
         var bindMatrix:Vector.<Number> = null;
         for(var i:int = 0,var count:int = int(this.var_726.length); i < count; i++)
         {
            animatedJoint = animatedJoints[i];
            bindMatrix = this.var_726[i];
            name_700(animatedJoint.object).alternativa3d::name_701(bindMatrix);
         }
      }
      
      private function method_915(skin:name_528, topmostJoints:Vector.<name_706>, nodes:Vector.<name_706>) : Vector.<name_711>
      {
         var i:int = 0;
         var topmostJoint:name_706 = null;
         var animatedJoint:name_711 = null;
         var nodesDictionary:Dictionary = new Dictionary();
         var count:int = int(nodes.length);
         for(i = 0; i < count; i++)
         {
            nodesDictionary[nodes[i]] = i;
         }
         var animatedJoints:Vector.<name_711> = new Vector.<name_711>(count);
         var numTopmostJoints:int = int(topmostJoints.length);
         for(i = 0; i < numTopmostJoints; i++)
         {
            topmostJoint = topmostJoints[i];
            animatedJoint = this.method_914(skin,topmostJoint,animatedJoints,nodesDictionary);
            this.method_901(name_700(animatedJoint.object),animatedJoints,topmostJoint,nodesDictionary);
         }
         return animatedJoints;
      }
      
      private function method_914(skin:name_528, node:name_706, animatedJoints:Vector.<name_711>, nodes:Dictionary) : name_711
      {
         var joint:name_700 = new name_700();
         joint.name = name_708(node.name);
         skin.addChild(joint);
         var animatedJoint:name_711 = node.name_714(node.name_710(joint));
         animatedJoint.jointNode = node;
         if(node in nodes)
         {
            animatedJoints[nodes[node]] = animatedJoint;
         }
         else
         {
            animatedJoints.push(animatedJoint);
         }
         return animatedJoint;
      }
      
      private function method_901(parent:name_700, animatedJoints:Vector.<name_711>, parentNode:name_706, nodes:Dictionary) : void
      {
         var object:name_711 = null;
         var child:name_706 = null;
         var joint:name_700 = null;
         var children:Vector.<name_706> = parentNode.nodes;
         for(var i:int = 0,var count:int = int(children.length); i < count; )
         {
            child = children[i];
            if(child in nodes)
            {
               joint = new name_700();
               joint.name = name_708(child.name);
               object = child.name_714(child.name_710(joint));
               object.jointNode = child;
               animatedJoints[nodes[child]] = object;
               parent.addChild(joint);
               this.method_901(joint,animatedJoints,child,nodes);
            }
            else if(this.method_903(child,nodes))
            {
               joint = new name_700();
               joint.name = name_708(child.name);
               object = child.name_714(child.name_710(joint));
               object.jointNode = child;
               animatedJoints.push(object);
               parent.addChild(joint);
               this.method_901(joint,animatedJoints,child,nodes);
            }
            i++;
         }
      }
      
      private function method_903(parentNode:name_706, nodes:Dictionary) : Boolean
      {
         var child:name_706 = null;
         var children:Vector.<name_706> = parentNode.nodes;
         for(var i:int = 0,var count:int = int(children.length); i < count; )
         {
            child = children[i];
            if(child in nodes || this.method_903(child,nodes))
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      private function method_904() : Vector.<Number>
      {
         var matrix:Array = null;
         var i:int = 0;
         var matrixXML:XML = data.skin.bind_shape_matrix[0];
         var res:Vector.<Number> = new Vector.<Number>(16,true);
         if(matrixXML != null)
         {
            matrix = name_565(matrixXML);
            for(i = 0; i < matrix.length; i++)
            {
               res[i] = Number(matrix[i]);
            }
         }
         return res;
      }
      
      private function method_907(node:name_706, nodes:Dictionary) : Boolean
      {
         for(var parent:name_706 = node.parent; parent != null; )
         {
            if(parent in nodes)
            {
               return false;
            }
            parent = parent.parent;
         }
         return true;
      }
      
      public function method_916(skeletons:Vector.<name_706>) : Vector.<name_706>
      {
         var nodesDictionary:Dictionary = null;
         var rootNodes:Vector.<name_706> = null;
         var node:name_706 = null;
         var nodes:Vector.<name_706> = this.method_902(skeletons);
         var i:int = 0;
         var count:int = int(nodes.length);
         if(count > 0)
         {
            nodesDictionary = new Dictionary();
            for(i = 0; i < count; i++)
            {
               nodesDictionary[nodes[i]] = i;
            }
            rootNodes = new Vector.<name_706>();
            for(i = 0; i < count; )
            {
               node = nodes[i];
               if(this.method_907(node,nodesDictionary))
               {
                  rootNodes.push(node);
               }
               i++;
            }
            return rootNodes;
         }
         return null;
      }
      
      private function findNode(nodeName:String, skeletons:Vector.<name_706>) : name_706
      {
         var node:name_706 = null;
         var count:int = int(skeletons.length);
         for(var i:int = 0; i < count; )
         {
            node = skeletons[i].getNodeBySid(nodeName);
            if(node != null)
            {
               return node;
            }
            i++;
         }
         return null;
      }
      
      private function method_902(skeletons:Vector.<name_706>) : Vector.<name_706>
      {
         var jointsXML:XML = null;
         var jointsSource:name_740 = null;
         var stride:int = 0;
         var count:int = 0;
         var nodes:Vector.<name_706> = null;
         var i:int = 0;
         var node:name_706 = null;
         jointsXML = data.skin.joints.input.(@semantic == "JOINT")[0];
         if(jointsXML != null)
         {
            jointsSource = document.findSource(jointsXML.@source[0]);
            if(jointsSource != null)
            {
               if(jointsSource.method_314() && jointsSource.names != null)
               {
                  stride = jointsSource.stride;
                  count = jointsSource.names.length / stride;
                  nodes = new Vector.<name_706>(count);
                  for(i = 0; i < count; i++)
                  {
                     node = this.findNode(jointsSource.names[int(stride * i)],skeletons);
                     if(node == null)
                     {
                     }
                     nodes[i] = node;
                  }
                  return nodes;
               }
            }
            else
            {
               document.logger.logNotFoundError(jointsXML.@source[0]);
            }
         }
         return null;
      }
   }
}

