package alternativa.engine3d.loaders.collada
{
   import alternativa.engine3d.*;
   import alternativa.engine3d.animation.name_550;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.VertexAttributes;
   import alternativa.engine3d.loaders.ParserMaterial;
   import alternativa.engine3d.objects.Joint;
   import alternativa.engine3d.objects.Skin;
   import alternativa.engine3d.resources.Geometry;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.Endian;
   
   use namespace collada;
   use namespace alternativa3d;
   
   public class DaeController extends DaeElement
   {
      private var var_725:Vector.<Vector.<Number>>;
      
      private var var_724:Array;
      
      private var indices:Array;
      
      private var var_727:DaeInput;
      
      private var var_726:DaeInput;
      
      private var var_728:int;
      
      private var geometry:Geometry;
      
      private var primitives:Vector.<DaePrimitive>;
      
      private var var_723:int = 0;
      
      private var var_722:Vector.<Number>;
      
      public function DaeController(data:XML, document:DaeDocument)
      {
         super(data,document);
      }
      
      private function get daeGeometry() : DaeGeometry
      {
         var geom:DaeGeometry = document.findGeometry(data.skin.@source[0]);
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
         var vertices:Vector.<DaeVertex> = null;
         var source:Geometry = null;
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
         this.var_724 = parseIntsArray(vcountsXML);
         var indicesXML:XML = vertexWeightsXML.v[0];
         if(indicesXML == null)
         {
            return false;
         }
         this.indices = parseIntsArray(indicesXML);
         this.parseInputs();
         this.parseJointsBindMatrices();
         for(i = 0; i < this.var_724.length; )
         {
            count = int(this.var_724[i]);
            if(this.var_723 < count)
            {
               this.var_723 = count;
            }
            i++;
         }
         var geom:DaeGeometry = this.daeGeometry;
         this.var_722 = this.getBindShapeMatrix();
         if(geom != null)
         {
            geom.parse();
            vertices = geom.var_715;
            source = geom.geometry;
            localMaxJointsPerVertex = this.var_723 % 2 != 0 ? this.var_723 + 1 : this.var_723;
            this.geometry = new Geometry();
            this.geometry.alternativa3d::_indices = source.alternativa3d::_indices.slice();
            attributes = source.getVertexStreamAttributes(0);
            numSourceAttributes = int(attributes.length);
            index = numSourceAttributes;
            for(i = 0; i < localMaxJointsPerVertex; i += 2)
            {
               attribute = int(VertexAttributes.JOINTS[int(i / 2)]);
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
            this.transformVertices(this.geometry);
            this.primitives = geom.primitives;
         }
         return true;
      }
      
      private function transformVertices(geometry:Geometry) : void
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
            data.writeFloat(x * this.var_722[0] + y * this.var_722[1] + z * this.var_722[2] + this.var_722[3]);
            data.writeFloat(x * this.var_722[4] + y * this.var_722[5] + z * this.var_722[6] + this.var_722[7]);
            data.writeFloat(x * this.var_722[8] + y * this.var_722[9] + z * this.var_722[10] + this.var_722[11]);
         }
      }
      
      private function createVertexBuffer(vertices:Vector.<DaeVertex>, localMaxJointsPerVertex:int) : ByteArray
      {
         var i:int = 0;
         var count:int = 0;
         var vertexOutIndices:Vector.<uint> = null;
         var vertex:DaeVertex = null;
         var vec:Vector.<uint> = null;
         var jointsPerVertex:int = 0;
         var j:int = 0;
         var k:int = 0;
         var index:int = 0;
         var jointIndex:int = 0;
         var weightIndex:int = 0;
         var jointsOffset:int = this.var_727.offset;
         var weightsOffset:int = this.var_726.offset;
         var weightsSource:DaeSource = this.var_726.prepareSource(1);
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
               vec = verticesDict[vertex.name_600];
               if(vec == null)
               {
                  vec = verticesDict[vertex.name_600] = new Vector.<uint>();
               }
               vec.push(vertex.name_601);
            }
         }
         var vertexIndex:int = 0;
         for(i = 0,count = int(this.var_724.length); i < count; i++)
         {
            jointsPerVertex = int(this.var_724[i]);
            vertexOutIndices = verticesDict[i];
            for(j = 0; j < vertexOutIndices.length; j++)
            {
               byteArray.position = vertexOutIndices[j] * localMaxJointsPerVertex * 8;
               for(k = 0; k < jointsPerVertex; k++)
               {
                  index = this.var_728 * (vertexIndex + k);
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
      
      private function parseInputs() : void
      {
         var input:DaeInput = null;
         var semantic:String = null;
         var offset:int = 0;
         var inputsList:XMLList = data.skin.vertex_weights.input;
         var maxInputOffset:int = 0;
         for(var i:int = 0,var count:int = int(inputsList.length()); i < count; offset = input.offset,maxInputOffset = offset > maxInputOffset ? offset : maxInputOffset,i++)
         {
            input = new DaeInput(inputsList[i],document);
            semantic = input.semantic;
            if(semantic == null)
            {
               continue;
            }
            switch(semantic)
            {
               case "JOINT":
                  if(this.var_727 == null)
                  {
                     this.var_727 = input;
                  }
                  break;
               case "WEIGHT":
                  if(this.var_726 == null)
                  {
                     this.var_726 = input;
                  }
                  break;
            }
         }
         this.var_728 = maxInputOffset + 1;
      }
      
      private function parseJointsBindMatrices() : void
      {
         var jointsXML:XML = null;
         var jointsSource:DaeSource = null;
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
               if(jointsSource.parse() && jointsSource.numbers != null && jointsSource.stride >= 16)
               {
                  stride = jointsSource.stride;
                  count = jointsSource.numbers.length / stride;
                  this.var_725 = new Vector.<Vector.<Number>>(count);
                  for(i = 0; i < count; i++)
                  {
                     index = stride * i;
                     matrix = new Vector.<Number>(16);
                     this.var_725[i] = matrix;
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
      
      public function parseSkin(materials:Object, topmostJoints:Vector.<DaeNode>, skeletons:Vector.<DaeNode>) : DaeObject
      {
         var numJoints:int = 0;
         var skin:Skin = null;
         var joints:Vector.<DaeObject> = null;
         var i:int = 0;
         var p:DaePrimitive = null;
         var instanceMaterial:DaeInstanceMaterial = null;
         var material:ParserMaterial = null;
         var daeMaterial:DaeMaterial = null;
         var skinXML:XML = data.skin[0];
         if(skinXML != null)
         {
            this.var_722 = this.getBindShapeMatrix();
            numJoints = int(this.var_725.length);
            skin = new Skin(this.var_723,numJoints);
            skin.geometry = this.geometry;
            joints = this.addJointsToSkin(skin,topmostJoints,this.findNodes(skeletons));
            this.setJointsBindMatrices(joints);
            skin.var_633 = this.collectRenderedJoints(joints,numJoints);
            if(this.primitives != null)
            {
               for(i = 0; i < this.primitives.length; i++)
               {
                  p = this.primitives[i];
                  instanceMaterial = materials[p.materialSymbol];
                  if(instanceMaterial != null)
                  {
                     daeMaterial = instanceMaterial.material;
                     if(daeMaterial != null)
                     {
                        daeMaterial.parse();
                        material = daeMaterial.material;
                        daeMaterial.used = true;
                     }
                  }
                  skin.addSurface(material,p.indexBegin,p.numTriangles);
               }
            }
            return new DaeObject(skin,this.mergeJointsClips(skin,joints));
         }
         return null;
      }
      
      private function collectRenderedJoints(joints:Vector.<DaeObject>, numJoints:int) : Vector.<Joint>
      {
         var result:Vector.<Joint> = new Vector.<Joint>();
         for(var i:int = 0; i < numJoints; i++)
         {
            result[i] = Joint(joints[i].object);
         }
         return result;
      }
      
      private function mergeJointsClips(skin:Skin, joints:Vector.<DaeObject>) : name_550
      {
         var animatedObject:DaeObject = null;
         var clip:name_550 = null;
         var object:Object3D = null;
         var t:int = 0;
         if(!this.hasJointsAnimation(joints))
         {
            return null;
         }
         var result:name_550 = new name_550();
         var resultObjects:Array = [skin];
         for(var i:int = 0,var count:int = int(joints.length); i < count; i++)
         {
            animatedObject = joints[i];
            clip = animatedObject.animation;
            if(clip != null)
            {
               for(t = 0; t < clip.numTracks; t++)
               {
                  result.name_551(clip.name_553(t));
               }
            }
            else
            {
               result.name_551(animatedObject.jointNode.createStaticTransformTrack());
            }
            object = animatedObject.object;
            object.name = animatedObject.jointNode.animName;
            resultObjects.push(object);
         }
         result.alternativa3d::var_348 = resultObjects;
         return result;
      }
      
      private function hasJointsAnimation(joints:Vector.<DaeObject>) : Boolean
      {
         var object:DaeObject = null;
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
      
      private function setJointsBindMatrices(animatedJoints:Vector.<DaeObject>) : void
      {
         var animatedJoint:DaeObject = null;
         var bindMatrix:Vector.<Number> = null;
         for(var i:int = 0,var count:int = int(this.var_725.length); i < count; i++)
         {
            animatedJoint = animatedJoints[i];
            bindMatrix = this.var_725[i];
            Joint(animatedJoint.object).alternativa3d::setBindPoseMatrix(bindMatrix);
         }
      }
      
      private function addJointsToSkin(skin:Skin, topmostJoints:Vector.<DaeNode>, nodes:Vector.<DaeNode>) : Vector.<DaeObject>
      {
         var i:int = 0;
         var topmostJoint:DaeNode = null;
         var animatedJoint:DaeObject = null;
         var nodesDictionary:Dictionary = new Dictionary();
         var count:int = int(nodes.length);
         for(i = 0; i < count; i++)
         {
            nodesDictionary[nodes[i]] = i;
         }
         var animatedJoints:Vector.<DaeObject> = new Vector.<DaeObject>(count);
         var numTopmostJoints:int = int(topmostJoints.length);
         for(i = 0; i < numTopmostJoints; i++)
         {
            topmostJoint = topmostJoints[i];
            animatedJoint = this.addRootJointToSkin(skin,topmostJoint,animatedJoints,nodesDictionary);
            this.addJointChildren(Joint(animatedJoint.object),animatedJoints,topmostJoint,nodesDictionary);
         }
         return animatedJoints;
      }
      
      private function addRootJointToSkin(skin:Skin, node:DaeNode, animatedJoints:Vector.<DaeObject>, nodes:Dictionary) : DaeObject
      {
         var joint:Joint = new Joint();
         joint.name = cloneString(node.name);
         skin.addChild(joint);
         var animatedJoint:DaeObject = node.applyAnimation(node.applyTransformations(joint));
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
      
      private function addJointChildren(parent:Joint, animatedJoints:Vector.<DaeObject>, parentNode:DaeNode, nodes:Dictionary) : void
      {
         var object:DaeObject = null;
         var child:DaeNode = null;
         var joint:Joint = null;
         var children:Vector.<DaeNode> = parentNode.nodes;
         for(var i:int = 0,var count:int = int(children.length); i < count; )
         {
            child = children[i];
            if(child in nodes)
            {
               joint = new Joint();
               joint.name = cloneString(child.name);
               object = child.applyAnimation(child.applyTransformations(joint));
               object.jointNode = child;
               animatedJoints[nodes[child]] = object;
               parent.addChild(joint);
               this.addJointChildren(joint,animatedJoints,child,nodes);
            }
            else if(this.hasJointInDescendants(child,nodes))
            {
               joint = new Joint();
               joint.name = cloneString(child.name);
               object = child.applyAnimation(child.applyTransformations(joint));
               object.jointNode = child;
               animatedJoints.push(object);
               parent.addChild(joint);
               this.addJointChildren(joint,animatedJoints,child,nodes);
            }
            i++;
         }
      }
      
      private function hasJointInDescendants(parentNode:DaeNode, nodes:Dictionary) : Boolean
      {
         var child:DaeNode = null;
         var children:Vector.<DaeNode> = parentNode.nodes;
         for(var i:int = 0,var count:int = int(children.length); i < count; )
         {
            child = children[i];
            if(child in nodes || this.hasJointInDescendants(child,nodes))
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      private function getBindShapeMatrix() : Vector.<Number>
      {
         var matrix:Array = null;
         var i:int = 0;
         var matrixXML:XML = data.skin.bind_shape_matrix[0];
         var res:Vector.<Number> = new Vector.<Number>(16,true);
         if(matrixXML != null)
         {
            matrix = parseStringArray(matrixXML);
            for(i = 0; i < matrix.length; i++)
            {
               res[i] = Number(matrix[i]);
            }
         }
         return res;
      }
      
      private function isRootJointNode(node:DaeNode, nodes:Dictionary) : Boolean
      {
         for(var parent:DaeNode = node.parent; parent != null; )
         {
            if(parent in nodes)
            {
               return false;
            }
            parent = parent.parent;
         }
         return true;
      }
      
      public function findRootJointNodes(skeletons:Vector.<DaeNode>) : Vector.<DaeNode>
      {
         var nodesDictionary:Dictionary = null;
         var rootNodes:Vector.<DaeNode> = null;
         var node:DaeNode = null;
         var nodes:Vector.<DaeNode> = this.findNodes(skeletons);
         var i:int = 0;
         var count:int = int(nodes.length);
         if(count > 0)
         {
            nodesDictionary = new Dictionary();
            for(i = 0; i < count; i++)
            {
               nodesDictionary[nodes[i]] = i;
            }
            rootNodes = new Vector.<DaeNode>();
            for(i = 0; i < count; )
            {
               node = nodes[i];
               if(this.isRootJointNode(node,nodesDictionary))
               {
                  rootNodes.push(node);
               }
               i++;
            }
            return rootNodes;
         }
         return null;
      }
      
      private function findNode(nodeName:String, skeletons:Vector.<DaeNode>) : DaeNode
      {
         var node:DaeNode = null;
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
      
      private function findNodes(skeletons:Vector.<DaeNode>) : Vector.<DaeNode>
      {
         var jointsXML:XML = null;
         var jointsSource:DaeSource = null;
         var stride:int = 0;
         var count:int = 0;
         var nodes:Vector.<DaeNode> = null;
         var i:int = 0;
         var node:DaeNode = null;
         jointsXML = data.skin.joints.input.(@semantic == "JOINT")[0];
         if(jointsXML != null)
         {
            jointsSource = document.findSource(jointsXML.@source[0]);
            if(jointsSource != null)
            {
               if(jointsSource.parse() && jointsSource.names != null)
               {
                  stride = jointsSource.stride;
                  count = jointsSource.names.length / stride;
                  nodes = new Vector.<DaeNode>(count);
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

