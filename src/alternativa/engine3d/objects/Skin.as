package alternativa.engine3d.objects
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.Camera3D;
   import alternativa.engine3d.core.Debug;
   import alternativa.engine3d.core.DrawUnit;
   import alternativa.engine3d.core.Light3D;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.VertexAttributes;
   import alternativa.engine3d.materials.Material;
   import alternativa.engine3d.materials.compiler.Linker;
   import alternativa.engine3d.materials.compiler.Procedure;
   import alternativa.engine3d.materials.compiler.VariableType;
   import alternativa.engine3d.resources.Geometry;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.Endian;
   
   use namespace alternativa3d;
   
   public class Skin extends Mesh
   {
      private static var _transformProcedures:Dictionary = new Dictionary();
      
      private static var _deltaTransformProcedures:Dictionary = new Dictionary();
      
      public var §_-WA§:Vector.<Joint>;
      
      alternativa3d var §_-Cq§:Vector.<Vector.<Joint>>;
      
      alternativa3d var §_-fB§:Vector.<Procedure>;
      
      alternativa3d var §do §:Vector.<Procedure>;
      
      private var numJoints:int = 0;
      
      private var maxInfluences:int = 0;
      
      public function Skin(maxInfluences:int, numJoints:int)
      {
         super();
         this.numJoints = numJoints;
         this.maxInfluences = maxInfluences;
         this.§_-WA§ = new Vector.<Joint>();
         this.alternativa3d::_-Cq = new Vector.<Vector.<Joint>>();
         this.alternativa3d::_-fB = new Vector.<Procedure>();
         this.alternativa3d::do  = new Vector.<Procedure>();
         alternativa3d::transformProcedure = this.calculateTransformProcedure(maxInfluences,numJoints);
         alternativa3d::deltaTransformProcedure = this.calculateDeltaTransformProcedure(maxInfluences,numJoints);
      }
      
      override public function addSurface(material:Material, indexBegin:uint, numTriangles:uint) : Surface
      {
         this.alternativa3d::_-fB[alternativa3d::_-Oy] = alternativa3d::transformProcedure;
         this.alternativa3d::do [alternativa3d::_-Oy] = alternativa3d::deltaTransformProcedure;
         this.alternativa3d::_-Cq[alternativa3d::_-Oy] = this.§_-WA§;
         return super.addSurface(material,indexBegin,numTriangles);
      }
      
      private function divideSurface(limit:uint, iterations:uint, surface:Surface, jointsOffsets:Vector.<uint>, jointBufferVertexSize:uint, inVertices:ByteArray, outVertices:ByteArray, outIndices:Vector.<uint>, outSurfaces:Vector.<Surface>, outJointsMaps:Vector.<Dictionary>) : uint
      {
         var i:int = 0;
         var j:int = 0;
         var count:int = 0;
         var jointsLength:int = 0;
         var index:uint = 0;
         var group:Dictionary = null;
         var key:* = undefined;
         var key2:* = undefined;
         var jointIndex:uint = 0;
         var weight:Number = NaN;
         var localNumJoints:uint = 0;
         var newIndexBegin:uint = 0;
         var jointsGroupLength:uint = 0;
         var n:int = 0;
         var faces:Dictionary = null;
         var locatedIndices:Dictionary = null;
         var resSurface:Surface = null;
         var origin:uint = 0;
         var sumWeight:Number = NaN;
         var indexBegin:uint = uint(surface.indexBegin);
         var indexCount:uint = uint(surface.numTriangles * 3);
         var indices:Vector.<uint> = geometry.alternativa3d::_indices;
         var groups:Dictionary = new Dictionary();
         for(i = int(indexBegin),count = int(indexBegin + indexCount); i < count; )
         {
            group = groups[i] = new Dictionary();
            jointsGroupLength = 0;
            for(n = 0; n < 3; n++)
            {
               index = indices[int(i + n)];
               for(j = 0,jointsLength = int(jointsOffsets.length); j < jointsLength; )
               {
                  inVertices.position = jointBufferVertexSize * index + jointsOffsets[j];
                  jointIndex = uint(uint(inVertices.readFloat()));
                  weight = Number(inVertices.readFloat());
                  if(weight > 0)
                  {
                     group[jointIndex] = true;
                  }
                  j++;
               }
            }
            for(key in group)
            {
               jointsGroupLength++;
            }
            if(jointsGroupLength > limit)
            {
               throw new Error("Unable to divide Skin.");
            }
            i += 3;
         }
         var facesGroups:Dictionary = this.optimizeGroups(groups,limit,iterations);
         var newIndex:uint = 0;
         for(key in facesGroups)
         {
            faces = facesGroups[key];
            localNumJoints = 0;
            group = groups[key];
            for(key2 in group)
            {
               if(group[key2] is Boolean)
               {
                  group[key2] = 3 * localNumJoints++;
               }
            }
            locatedIndices = new Dictionary();
            for(key2 in faces)
            {
               for(i = 0; i < 3; i++)
               {
                  index = indices[int(key2 + i)];
                  if(locatedIndices[index] != null)
                  {
                     outIndices.push(locatedIndices[index]);
                  }
                  else
                  {
                     locatedIndices[index] = newIndex;
                     outIndices.push(newIndex++);
                     outVertices.writeBytes(inVertices,index * jointBufferVertexSize,jointBufferVertexSize);
                     outVertices.position -= jointBufferVertexSize;
                     origin = uint(outVertices.position);
                     sumWeight = 0;
                     for(j = 0; j < jointsLength; )
                     {
                        outVertices.position = origin + jointsOffsets[j];
                        jointIndex = uint(uint(outVertices.readFloat()));
                        weight = Number(outVertices.readFloat());
                        outVertices.position -= 8;
                        if(weight > 0)
                        {
                           outVertices.writeFloat(group[jointIndex]);
                           outVertices.writeFloat(weight);
                           sumWeight += weight;
                        }
                        j++;
                     }
                     if(sumWeight != 1)
                     {
                        for(j = 0; j < jointsLength; )
                        {
                           outVertices.position = origin + jointsOffsets[j] + 4;
                           weight = Number(outVertices.readFloat());
                           if(weight > 0)
                           {
                              outVertices.position -= 4;
                              outVertices.writeFloat(weight / sumWeight);
                           }
                           j++;
                        }
                     }
                     outVertices.position = origin + jointBufferVertexSize;
                  }
               }
            }
            resSurface = new Surface();
            resSurface.alternativa3d::object = this;
            resSurface.material = surface.material;
            resSurface.indexBegin = newIndexBegin;
            resSurface.numTriangles = (outIndices.length - newIndexBegin) / 3;
            outSurfaces.push(resSurface);
            outJointsMaps.push(group);
            newIndexBegin = uint(outIndices.length);
         }
         return newIndex;
      }
      
      private function optimizeGroups(groups:Dictionary, limit:uint, iterations:uint = 1) : Dictionary
      {
         var key:* = undefined;
         var inKey:* = undefined;
         var minLike:Number = NaN;
         var group1:Dictionary = null;
         var group2:Dictionary = null;
         var like:Number = NaN;
         var copyKey:* = undefined;
         var indices:Dictionary = null;
         var indices2:Dictionary = null;
         var facesGroups:Dictionary = new Dictionary();
         for(var i:int = 1; i < iterations + 1; i++)
         {
            minLike = 1 - i / iterations;
            for(key in groups)
            {
               group1 = groups[key];
               for(inKey in groups)
               {
                  if(key != inKey)
                  {
                     group2 = groups[inKey];
                     like = this.calculateLikeFactor(group1,group2,limit);
                     if(like >= minLike)
                     {
                        delete groups[inKey];
                        for(copyKey in group2)
                        {
                           group1[copyKey] = true;
                        }
                        indices = facesGroups[key];
                        if(indices == null)
                        {
                           indices = facesGroups[key] = new Dictionary();
                           indices[key] = true;
                        }
                        indices2 = facesGroups[inKey];
                        if(indices2 != null)
                        {
                           delete facesGroups[inKey];
                           for(copyKey in indices2)
                           {
                              indices[copyKey] = true;
                           }
                        }
                        else
                        {
                           indices[inKey] = true;
                        }
                     }
                  }
               }
            }
         }
         return facesGroups;
      }
      
      private function calculateLikeFactor(group1:Dictionary, group2:Dictionary, limit:uint) : Number
      {
         var key:* = undefined;
         var unionCount:uint = 0;
         var intersectCount:uint = 0;
         var group1Count:uint = 0;
         var group2Count:uint = 0;
         for(key in group1)
         {
            unionCount++;
            if(group2[key] != null)
            {
               intersectCount++;
            }
            group1Count++;
         }
         for(key in group2)
         {
            if(group1[key] == null)
            {
               unionCount++;
            }
            group2Count++;
         }
         if(unionCount > limit)
         {
            return -1;
         }
         return intersectCount / unionCount;
      }
      
      public function divide(limit:uint, iterations:uint = 1) : void
      {
         var key:* = undefined;
         var outIndices:Vector.<uint> = null;
         var outVertices:ByteArray = null;
         var outJointsMaps:Vector.<Dictionary> = null;
         var maxIndex:uint = 0;
         var j:int = 0;
         var count:int = 0;
         var maxJoints:uint = 0;
         var vec:Vector.<Joint> = null;
         var joints:Dictionary = null;
         var index:uint = 0;
         var attributes:Array = null;
         var _loc30_:ByteArray = null;
         var jointsBuffer:int = geometry.findVertexStreamByAttribute(VertexAttributes.JOINTS[0]);
         var jointsOffsets:Vector.<uint> = new Vector.<uint>();
         var jointOffset:int = 0;
         if(jointsBuffer >= 0)
         {
            jointOffset = geometry.getAttributeOffset(VertexAttributes.JOINTS[0]) * 4;
            jointsOffsets.push(jointOffset);
            jointsOffsets.push(jointOffset + 8);
            var jbTest:int = geometry.findVertexStreamByAttribute(VertexAttributes.JOINTS[1]);
            if(jbTest >= 0)
            {
               jointOffset = geometry.getAttributeOffset(VertexAttributes.JOINTS[1]) * 4;
               jointsOffsets.push(jointOffset);
               jointsOffsets.push(jointOffset + 8);
               if(jointsBuffer != jbTest)
               {
                  throw new Error("Cannot divide skin, all joinst must be in the same buffer");
               }
            }
            jbTest = geometry.findVertexStreamByAttribute(VertexAttributes.JOINTS[2]);
            if(jbTest >= 0)
            {
               jointOffset = geometry.getAttributeOffset(VertexAttributes.JOINTS[2]) * 4;
               jointsOffsets.push(jointOffset);
               jointsOffsets.push(jointOffset + 8);
               if(jointsBuffer != jbTest)
               {
                  throw new Error("Cannot divide skin, all joinst must be in the same buffer");
               }
            }
            jbTest = geometry.findVertexStreamByAttribute(VertexAttributes.JOINTS[3]);
            if(jbTest >= 0)
            {
               jointOffset = geometry.getAttributeOffset(VertexAttributes.JOINTS[3]) * 4;
               jointsOffsets.push(jointOffset);
               jointsOffsets.push(jointOffset + 8);
               if(jointsBuffer != jbTest)
               {
                  throw new Error("Cannot divide skin, all joinst must be in the same buffer");
               }
            }
            var outSurfaces:Vector.<Surface> = new Vector.<Surface>();
            var totalVertices:ByteArray = new ByteArray();
            totalVertices.endian = Endian.LITTLE_ENDIAN;
            var totalIndices:Vector.<uint> = new Vector.<uint>();
            var totalIndicesLength:uint = 0;
            var lastMaxIndex:uint = 0;
            var lastSurfaceIndex:uint = 0;
            var lastIndicesCount:uint = 0;
            this.alternativa3d::_-Cq.length = 0;
            var jointsBufferNumMappings:int = int(geometry.alternativa3d::_vertexStreams[jointsBuffer].attributes.length);
            var jointsBufferData:ByteArray = geometry.alternativa3d::_vertexStreams[jointsBuffer].data;
            for(var i:int = 0; i < alternativa3d::_-Oy; i++)
            {
               outIndices = new Vector.<uint>();
               outVertices = new ByteArray();
               outJointsMaps = new Vector.<Dictionary>();
               outVertices.endian = Endian.LITTLE_ENDIAN;
               maxIndex = this.divideSurface(limit,iterations,alternativa3d::_-eW[i],jointsOffsets,jointsBufferNumMappings * 4,jointsBufferData,outVertices,outIndices,outSurfaces,outJointsMaps);
               for(j = 0,count = int(outIndices.length); j < count; j++)
               {
                  var _loc31_:* = totalIndicesLength++;
                  totalIndices[_loc31_] = lastMaxIndex + outIndices[j];
               }
               for(j = 0,count = int(outJointsMaps.length); j < count; j++)
               {
                  maxJoints = 0;
                  vec = this.alternativa3d::_-Cq[j + lastSurfaceIndex] = new Vector.<Joint>();
                  joints = outJointsMaps[j];
                  for(key in joints)
                  {
                     index = uint(uint(joints[key] / 3));
                     if(vec.length < index)
                     {
                        vec.length = index + 1;
                     }
                     vec[index] = this.§_-WA§[uint(key / 3)];
                     maxJoints++;
                  }
               }
               for(j = int(lastSurfaceIndex); j < outSurfaces.length; j++)
               {
                  outSurfaces[j].indexBegin += lastIndicesCount;
               }
               lastSurfaceIndex += outJointsMaps.length;
               lastIndicesCount += outIndices.length;
               totalVertices.writeBytes(outVertices,0,outVertices.length);
               lastMaxIndex += maxIndex;
            }
            alternativa3d::_-eW = outSurfaces;
            alternativa3d::_-Oy = outSurfaces.length;
            this.alternativa3d::_-fB.length = alternativa3d::_-Oy;
            this.alternativa3d::do .length = alternativa3d::_-Oy;
            for(i = 0; i < alternativa3d::_-Oy; i++)
            {
               this.alternativa3d::_-fB[i] = this.calculateTransformProcedure(this.maxInfluences,this.alternativa3d::_-Cq[i].length);
               this.alternativa3d::do [i] = this.calculateDeltaTransformProcedure(this.maxInfluences,this.alternativa3d::_-Cq[i].length);
            }
            var newGeometry:Geometry = new Geometry();
            newGeometry.alternativa3d::_indices = totalIndices;
            for(i = 0; i < geometry.alternativa3d::_vertexStreams.length; i++)
            {
               attributes = geometry.alternativa3d::_vertexStreams[i].attributes;
               newGeometry.addVertexStream(attributes);
               if(i == jointsBuffer)
               {
                  newGeometry.alternativa3d::_vertexStreams[i].data = totalVertices;
               }
               else
               {
                  _loc30_ = new ByteArray();
                  _loc30_.endian = Endian.LITTLE_ENDIAN;
                  _loc30_.writeBytes(geometry.alternativa3d::_vertexStreams[i].data);
                  newGeometry.alternativa3d::_vertexStreams[i].data = _loc30_;
               }
            }
            newGeometry.alternativa3d::_numVertices = totalVertices.length / (newGeometry.alternativa3d::_vertexStreams[0].attributes.length << 2);
            geometry = newGeometry;
            return;
         }
         throw new Error("Cannot divide skin, joints[0] must be binded");
      }
      
      private function calculateJointsTransforms(root:Object3D) : void
      {
         for(var child:Object3D = root.alternativa3d::childrenList; child != null; child = child.alternativa3d::next)
         {
            if(child.alternativa3d::transformChanged)
            {
               child.alternativa3d::composeTransforms();
            }
            child.alternativa3d::localToGlobalTransform.combine(root.alternativa3d::localToGlobalTransform,child.alternativa3d::transform);
            if(child is Joint)
            {
               Joint(child).alternativa3d::calculateTransform();
            }
            this.calculateJointsTransforms(child);
         }
      }
      
      override alternativa3d function collectDraws(camera:Camera3D, lights:Vector.<Light3D>, lightsLength:int) : void
      {
         var surface:Surface = null;
         var debug:int = 0;
         if(geometry == null)
         {
            return;
         }
         for(var child:Object3D = alternativa3d::childrenList; child != null; )
         {
            if(child.alternativa3d::transformChanged)
            {
               child.alternativa3d::composeTransforms();
            }
            child.alternativa3d::localToGlobalTransform.copy(child.alternativa3d::transform);
            if(child is Joint)
            {
               Joint(child).alternativa3d::calculateTransform();
            }
            this.calculateJointsTransforms(child);
            child = child.alternativa3d::next;
         }
         for(var i:int = 0; i < alternativa3d::_-Oy; )
         {
            surface = alternativa3d::_-eW[i];
            alternativa3d::transformProcedure = this.alternativa3d::_-fB[i];
            alternativa3d::deltaTransformProcedure = this.alternativa3d::do [i];
            if(surface.material != null)
            {
               surface.material.alternativa3d::collectDraws(camera,surface,geometry,lights,lightsLength);
            }
            if(alternativa3d::listening)
            {
               camera.view.alternativa3d::addSurfaceToMouseEvents(surface,geometry,alternativa3d::transformProcedure);
            }
            i++;
         }
         if(camera.debug)
         {
            debug = camera.alternativa3d::checkInDebug(this);
            if(Boolean(debug & Debug.BOUNDS) && boundBox != null)
            {
               Debug.alternativa3d::drawBoundBox(camera,boundBox,alternativa3d::localToCameraTransform);
            }
         }
      }
      
      override alternativa3d function setTransformConstants(drawUnit:DrawUnit, surface:Surface, vertexShader:Linker, camera:Camera3D) : void
      {
         var i:int = 0;
         var count:int = 0;
         var attribute:int = 0;
         var joint:Joint = null;
         for(i = 0; i < this.maxInfluences; i += 2)
         {
            attribute = int(VertexAttributes.JOINTS[i >> 1]);
            drawUnit.alternativa3d::setVertexBufferAt(vertexShader.getVariableIndex("joint" + i.toString()),geometry.alternativa3d::getVertexBuffer(attribute),geometry.alternativa3d::_attributesOffsets[attribute],VertexAttributes.alternativa3d::FORMATS[attribute]);
         }
         var surfaceIndex:int = int(alternativa3d::_-eW.indexOf(surface));
         var joints:Vector.<Joint> = this.alternativa3d::_-Cq[surfaceIndex];
         for(i = 0,count = int(joints.length); i < count; i++)
         {
            joint = joints[i];
            drawUnit.alternativa3d::setVertexConstantsFromTransform(i * 3,joint.alternativa3d::_-Dy);
         }
      }
      
      private function calculateTransformProcedure(maxInfluences:int, numJoints:int) : Procedure
      {
         var joint:int = 0;
         var res:Procedure = _transformProcedures[maxInfluences | numJoints << 16];
         if(res != null)
         {
            return res;
         }
         res = _transformProcedures[maxInfluences | numJoints << 16] = new Procedure(null,"SkinTransformProcedure");
         var array:Array = [];
         var j:int = 0;
         for(var i:int = 0; i < maxInfluences; i++)
         {
            joint = int(int(i / 2));
            if(i % 2 == 0)
            {
               if(i == 0)
               {
                  var _loc8_:* = j++;
                  array[_loc8_] = "m34 t0.xyz, i0, c[a" + joint + ".x]";
                  var _loc9_:* = j++;
                  array[_loc9_] = "mul o0, t0.xyz, a" + joint + ".y";
               }
               else
               {
                  _loc8_ = j++;
                  array[_loc8_] = "m34 t0.xyz, i0, c[a" + joint + ".x]";
                  _loc9_ = j++;
                  array[_loc9_] = "mul t0.xyz, t0.xyz, a" + joint + ".y";
                  var _loc10_:* = j++;
                  array[_loc10_] = "add o0, o0, t0.xyz";
               }
            }
            else
            {
               _loc8_ = j++;
               array[_loc8_] = "m34 t0.xyz, i0, c[a" + joint + ".z]";
               _loc9_ = j++;
               array[_loc9_] = "mul t0.xyz, t0.xyz, a" + joint + ".w";
               _loc10_ = j++;
               array[_loc10_] = "add o0, o0, t0.xyz";
            }
         }
         _loc8_ = j++;
         array[_loc8_] = "mov o0.w, i0.w";
         res.compileFromArray(array);
         res.assignConstantsArray(numJoints * 3);
         for(i = 0; i < maxInfluences; i += 2)
         {
            res.assignVariableName(VariableType.ATTRIBUTE,int(i / 2),"joint" + i);
         }
         return res;
      }
      
      private function calculateDeltaTransformProcedure(maxInfluences:int, numJoints:int) : Procedure
      {
         var joint:int = 0;
         var res:Procedure = _deltaTransformProcedures[maxInfluences | numJoints << 16];
         if(res != null)
         {
            return res;
         }
         res = _deltaTransformProcedures[maxInfluences | numJoints << 16] = new Procedure(null,"SkinDeltaTransformProcedure");
         var array:Array = [];
         var j:int = 0;
         for(var i:int = 0; i < maxInfluences; i++)
         {
            joint = int(int(i / 2));
            if(i % 2 == 0)
            {
               if(i == 0)
               {
                  var _loc8_:* = j++;
                  array[_loc8_] = "m33 t0.xyz, i0, c[a" + joint + ".x]";
                  var _loc9_:* = j++;
                  array[_loc9_] = "mul o0, t0.xyz, a" + joint + ".y";
               }
               else
               {
                  _loc8_ = j++;
                  array[_loc8_] = "m33 t0.xyz, i0, c[a" + joint + ".x]";
                  _loc9_ = j++;
                  array[_loc9_] = "mul t0.xyz, t0.xyz, a" + joint + ".y";
                  var _loc10_:* = j++;
                  array[_loc10_] = "add o0, o0, t0.xyz";
               }
            }
            else
            {
               _loc8_ = j++;
               array[_loc8_] = "m33 t0.xyz, i0, c[a" + joint + ".z]";
               _loc9_ = j++;
               array[_loc9_] = "mul t0.xyz, t0.xyz, a" + joint + ".w";
               _loc10_ = j++;
               array[_loc10_] = "add o0, o0, t0.xyz";
            }
         }
         _loc8_ = j++;
         array[_loc8_] = "mov o0.w, i0.w";
         _loc9_ = j++;
         array[_loc9_] = "nrm o0.xyz, o0.xyz";
         res.compileFromArray(array);
         for(i = 0; i < maxInfluences; i += 2)
         {
            res.assignVariableName(VariableType.ATTRIBUTE,int(i / 2),"joint" + i);
         }
         return res;
      }
      
      override public function clone() : Object3D
      {
         var res:Skin = new Skin(this.maxInfluences,this.numJoints);
         res.clonePropertiesFrom(this);
         return res;
      }
      
      override protected function clonePropertiesFrom(source:Object3D) : void
      {
         super.clonePropertiesFrom(source);
         var skin:Skin = Skin(source);
         if(skin.§_-WA§ != null)
         {
            this.§_-WA§ = this.cloneJointsVector(skin.§_-WA§,skin);
         }
         for(var i:int = 0; i < alternativa3d::_-Oy; )
         {
            this.alternativa3d::_-Cq[i] = this.cloneJointsVector(skin.alternativa3d::_-Cq[i],skin);
            this.alternativa3d::_-fB[i] = this.calculateTransformProcedure(this.maxInfluences,this.alternativa3d::_-Cq[i].length);
            this.alternativa3d::do [i] = this.calculateDeltaTransformProcedure(this.maxInfluences,this.alternativa3d::_-Cq[i].length);
            i++;
         }
      }
      
      private function cloneJointsVector(joints:Vector.<Joint>, skin:Skin) : Vector.<Joint>
      {
         var joint:Joint = null;
         var count:int = int(joints.length);
         var result:Vector.<Joint> = new Vector.<Joint>();
         for(var i:int = 0; i < count; i++)
         {
            joint = joints[i];
            result[i] = Joint(this.findClonedJoint(joint,skin,this));
         }
         return result;
      }
      
      private function findClonedJoint(joint:Joint, parentSource:Object3D, parentDest:Object3D) : Object3D
      {
         var j:Object3D = null;
         for(var srcChild:Object3D = parentSource.alternativa3d::childrenList,var dstChild:Object3D = parentDest.alternativa3d::childrenList; srcChild != null; )
         {
            if(srcChild == joint)
            {
               return dstChild;
            }
            if(srcChild.alternativa3d::childrenList != null)
            {
               j = this.findClonedJoint(joint,srcChild,dstChild);
               if(j != null)
               {
                  return j;
               }
            }
            srcChild = srcChild.alternativa3d::next;
            dstChild = dstChild.alternativa3d::next;
         }
         return null;
      }
   }
}

