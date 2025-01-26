package package_19
{
   import alternativa.engine3d.alternativa3d;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.Endian;
   import package_21.name_116;
   import package_21.name_124;
   import package_21.name_126;
   import package_21.name_135;
   import package_21.name_397;
   import package_21.name_78;
   import package_28.name_119;
   import package_30.name_114;
   import package_30.name_115;
   import package_30.name_121;
   import package_4.class_4;
   
   use namespace alternativa3d;
   
   public class name_528 extends name_380
   {
      private static var _transformProcedures:Dictionary = new Dictionary();
      
      private static var _deltaTransformProcedures:Dictionary = new Dictionary();
      
      public var var_631:Vector.<name_700>;
      
      alternativa3d var var_630:Vector.<Vector.<name_700>>;
      
      alternativa3d var var_633:Vector.<name_114>;
      
      alternativa3d var var_632:Vector.<name_114>;
      
      private var numJoints:int = 0;
      
      private var maxInfluences:int = 0;
      
      public function name_528(maxInfluences:int, numJoints:int)
      {
         super();
         this.numJoints = numJoints;
         this.maxInfluences = maxInfluences;
         this.var_631 = new Vector.<name_700>();
         this.alternativa3d::var_630 = new Vector.<Vector.<name_700>>();
         this.alternativa3d::var_633 = new Vector.<name_114>();
         this.alternativa3d::var_632 = new Vector.<name_114>();
         alternativa3d::transformProcedure = this.method_732(maxInfluences,numJoints);
         alternativa3d::deltaTransformProcedure = this.method_733(maxInfluences,numJoints);
      }
      
      override public function addSurface(material:class_4, indexBegin:uint, numTriangles:uint) : name_117
      {
         this.alternativa3d::var_633[alternativa3d::var_93] = alternativa3d::transformProcedure;
         this.alternativa3d::var_632[alternativa3d::var_93] = alternativa3d::deltaTransformProcedure;
         this.alternativa3d::var_630[alternativa3d::var_93] = this.var_631;
         return super.addSurface(material,indexBegin,numTriangles);
      }
      
      private function method_737(limit:uint, iterations:uint, surface:name_117, jointsOffsets:Vector.<uint>, jointBufferVertexSize:uint, inVertices:ByteArray, outVertices:ByteArray, outIndices:Vector.<uint>, outSurfaces:Vector.<name_117>, outJointsMaps:Vector.<Dictionary>) : uint
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
         var resSurface:name_117 = null;
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
         var facesGroups:Dictionary = this.method_739(groups,limit,iterations);
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
            resSurface = new name_117();
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
      
      private function method_739(groups:Dictionary, limit:uint, iterations:uint = 1) : Dictionary
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
                     like = this.method_738(group1,group2,limit);
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
      
      private function method_738(group1:Dictionary, group2:Dictionary, limit:uint) : Number
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
      
      public function method_740(limit:uint, iterations:uint = 1) : void
      {
         var key:* = undefined;
         var outIndices:Vector.<uint> = null;
         var outVertices:ByteArray = null;
         var outJointsMaps:Vector.<Dictionary> = null;
         var maxIndex:uint = 0;
         var j:int = 0;
         var count:int = 0;
         var maxJoints:uint = 0;
         var vec:Vector.<name_700> = null;
         var joints:Dictionary = null;
         var index:uint = 0;
         var attributes:Array = null;
         var data:ByteArray = null;
         var jointsBuffer:int = geometry.findVertexStreamByAttribute(name_126.JOINTS[0]);
         var jointsOffsets:Vector.<uint> = new Vector.<uint>();
         var jointOffset:int = 0;
         if(jointsBuffer >= 0)
         {
            jointOffset = geometry.getAttributeOffset(name_126.JOINTS[0]) * 4;
            jointsOffsets.push(jointOffset);
            jointsOffsets.push(jointOffset + 8);
            var jbTest:int = geometry.findVertexStreamByAttribute(name_126.JOINTS[1]);
            if(jbTest >= 0)
            {
               jointOffset = geometry.getAttributeOffset(name_126.JOINTS[1]) * 4;
               jointsOffsets.push(jointOffset);
               jointsOffsets.push(jointOffset + 8);
               if(jointsBuffer != jbTest)
               {
                  throw new Error("Cannot divide skin, all joinst must be in the same buffer");
               }
            }
            jbTest = geometry.findVertexStreamByAttribute(name_126.JOINTS[2]);
            if(jbTest >= 0)
            {
               jointOffset = geometry.getAttributeOffset(name_126.JOINTS[2]) * 4;
               jointsOffsets.push(jointOffset);
               jointsOffsets.push(jointOffset + 8);
               if(jointsBuffer != jbTest)
               {
                  throw new Error("Cannot divide skin, all joinst must be in the same buffer");
               }
            }
            jbTest = geometry.findVertexStreamByAttribute(name_126.JOINTS[3]);
            if(jbTest >= 0)
            {
               jointOffset = geometry.getAttributeOffset(name_126.JOINTS[3]) * 4;
               jointsOffsets.push(jointOffset);
               jointsOffsets.push(jointOffset + 8);
               if(jointsBuffer != jbTest)
               {
                  throw new Error("Cannot divide skin, all joinst must be in the same buffer");
               }
            }
            var outSurfaces:Vector.<name_117> = new Vector.<name_117>();
            var totalVertices:ByteArray = new ByteArray();
            totalVertices.endian = Endian.LITTLE_ENDIAN;
            var totalIndices:Vector.<uint> = new Vector.<uint>();
            var totalIndicesLength:uint = 0;
            var lastMaxIndex:uint = 0;
            var lastSurfaceIndex:uint = 0;
            var lastIndicesCount:uint = 0;
            this.alternativa3d::var_630.length = 0;
            var jointsBufferNumMappings:int = int(geometry.alternativa3d::_vertexStreams[jointsBuffer].attributes.length);
            var jointsBufferData:ByteArray = geometry.alternativa3d::_vertexStreams[jointsBuffer].data;
            for(var i:int = 0; i < alternativa3d::var_93; i++)
            {
               outIndices = new Vector.<uint>();
               outVertices = new ByteArray();
               outJointsMaps = new Vector.<Dictionary>();
               outVertices.endian = Endian.LITTLE_ENDIAN;
               maxIndex = this.method_737(limit,iterations,alternativa3d::var_92[i],jointsOffsets,jointsBufferNumMappings * 4,jointsBufferData,outVertices,outIndices,outSurfaces,outJointsMaps);
               for(j = 0,count = int(outIndices.length); j < count; j++)
               {
                  var _loc31_:* = totalIndicesLength++;
                  totalIndices[_loc31_] = lastMaxIndex + outIndices[j];
               }
               for(j = 0,count = int(outJointsMaps.length); j < count; j++)
               {
                  maxJoints = 0;
                  vec = this.alternativa3d::var_630[j + lastSurfaceIndex] = new Vector.<name_700>();
                  joints = outJointsMaps[j];
                  for(key in joints)
                  {
                     index = uint(uint(joints[key] / 3));
                     if(vec.length < index)
                     {
                        vec.length = index + 1;
                     }
                     vec[index] = this.var_631[uint(key / 3)];
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
            alternativa3d::var_92 = outSurfaces;
            alternativa3d::var_93 = outSurfaces.length;
            this.alternativa3d::var_633.length = alternativa3d::var_93;
            this.alternativa3d::var_632.length = alternativa3d::var_93;
            for(i = 0; i < alternativa3d::var_93; i++)
            {
               this.alternativa3d::var_633[i] = this.method_732(this.maxInfluences,this.alternativa3d::var_630[i].length);
               this.alternativa3d::var_632[i] = this.method_733(this.maxInfluences,this.alternativa3d::var_630[i].length);
            }
            var newGeometry:name_119 = new name_119();
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
                  data = new ByteArray();
                  data.endian = Endian.LITTLE_ENDIAN;
                  data.writeBytes(geometry.alternativa3d::_vertexStreams[i].data);
                  newGeometry.alternativa3d::_vertexStreams[i].data = data;
               }
            }
            newGeometry.alternativa3d::_numVertices = totalVertices.length / (newGeometry.alternativa3d::_vertexStreams[0].attributes.length << 2);
            geometry = newGeometry;
            return;
         }
         throw new Error("Cannot divide skin, joints[0] must be binded");
      }
      
      private function method_734(root:name_78) : void
      {
         for(var child:name_78 = root.alternativa3d::childrenList; child != null; child = child.alternativa3d::next)
         {
            if(child.alternativa3d::transformChanged)
            {
               child.alternativa3d::composeTransforms();
            }
            child.alternativa3d::localToGlobalTransform.combine(root.alternativa3d::localToGlobalTransform,child.alternativa3d::transform);
            if(child is name_700)
            {
               name_700(child).alternativa3d::name_703();
            }
            this.method_734(child);
         }
      }
      
      override alternativa3d function collectDraws(camera:name_124, lights:Vector.<name_116>, lightsLength:int) : void
      {
         var surface:name_117 = null;
         var debug:int = 0;
         if(geometry == null)
         {
            return;
         }
         for(var child:name_78 = alternativa3d::childrenList; child != null; )
         {
            if(child.alternativa3d::transformChanged)
            {
               child.alternativa3d::composeTransforms();
            }
            child.alternativa3d::localToGlobalTransform.copy(child.alternativa3d::transform);
            if(child is name_700)
            {
               name_700(child).alternativa3d::name_703();
            }
            this.method_734(child);
            child = child.alternativa3d::next;
         }
         for(var i:int = 0; i < alternativa3d::var_93; )
         {
            surface = alternativa3d::var_92[i];
            alternativa3d::transformProcedure = this.alternativa3d::var_633[i];
            alternativa3d::deltaTransformProcedure = this.alternativa3d::var_632[i];
            if(surface.material != null)
            {
               surface.material.alternativa3d::collectDraws(camera,surface,geometry,lights,lightsLength);
            }
            if(alternativa3d::listening)
            {
               camera.view.alternativa3d::name_398(surface,geometry,alternativa3d::transformProcedure);
            }
            i++;
         }
         if(camera.debug)
         {
            debug = int(camera.alternativa3d::checkInDebug(this));
            if(Boolean(debug & name_397.BOUNDS) && boundBox != null)
            {
               name_397.alternativa3d::name_399(camera,boundBox,alternativa3d::localToCameraTransform);
            }
         }
      }
      
      override alternativa3d function setTransformConstants(drawUnit:name_135, surface:name_117, vertexShader:name_121, camera:name_124) : void
      {
         var i:int = 0;
         var count:int = 0;
         var attribute:int = 0;
         var joint:name_700 = null;
         for(i = 0; i < this.maxInfluences; i += 2)
         {
            attribute = int(name_126.JOINTS[i >> 1]);
            drawUnit.alternativa3d::setVertexBufferAt(vertexShader.getVariableIndex("joint" + i.toString()),geometry.alternativa3d::getVertexBuffer(attribute),geometry.alternativa3d::_attributesOffsets[attribute],name_126.alternativa3d::FORMATS[attribute]);
         }
         var surfaceIndex:int = int(alternativa3d::var_92.indexOf(surface));
         var joints:Vector.<name_700> = this.alternativa3d::var_630[surfaceIndex];
         for(i = 0,count = int(joints.length); i < count; i++)
         {
            joint = joints[i];
            drawUnit.alternativa3d::name_412(i * 3,joint.alternativa3d::name_704);
         }
      }
      
      private function method_732(maxInfluences:int, numJoints:int) : name_114
      {
         var joint:int = 0;
         var res:name_114 = _transformProcedures[maxInfluences | numJoints << 16];
         if(res != null)
         {
            return res;
         }
         res = _transformProcedures[maxInfluences | numJoints << 16] = new name_114(null,"SkinTransformProcedure");
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
         res.name_140(array);
         res.method_290(numJoints * 3);
         for(i = 0; i < maxInfluences; i += 2)
         {
            res.name_122(name_115.ATTRIBUTE,int(i / 2),"joint" + i);
         }
         return res;
      }
      
      private function method_733(maxInfluences:int, numJoints:int) : name_114
      {
         var joint:int = 0;
         var res:name_114 = _deltaTransformProcedures[maxInfluences | numJoints << 16];
         if(res != null)
         {
            return res;
         }
         res = _deltaTransformProcedures[maxInfluences | numJoints << 16] = new name_114(null,"SkinDeltaTransformProcedure");
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
         res.name_140(array);
         for(i = 0; i < maxInfluences; i += 2)
         {
            res.name_122(name_115.ATTRIBUTE,int(i / 2),"joint" + i);
         }
         return res;
      }
      
      override public function clone() : name_78
      {
         var res:name_528 = new name_528(this.maxInfluences,this.numJoints);
         res.clonePropertiesFrom(this);
         return res;
      }
      
      override protected function clonePropertiesFrom(source:name_78) : void
      {
         super.clonePropertiesFrom(source);
         var skin:name_528 = name_528(source);
         if(skin.var_631 != null)
         {
            this.var_631 = this.method_736(skin.var_631,skin);
         }
         for(var i:int = 0; i < alternativa3d::var_93; )
         {
            this.alternativa3d::var_630[i] = this.method_736(skin.alternativa3d::var_630[i],skin);
            this.alternativa3d::var_633[i] = this.method_732(this.maxInfluences,this.alternativa3d::var_630[i].length);
            this.alternativa3d::var_632[i] = this.method_733(this.maxInfluences,this.alternativa3d::var_630[i].length);
            i++;
         }
      }
      
      private function method_736(joints:Vector.<name_700>, skin:name_528) : Vector.<name_700>
      {
         var joint:name_700 = null;
         var count:int = int(joints.length);
         var result:Vector.<name_700> = new Vector.<name_700>();
         for(var i:int = 0; i < count; i++)
         {
            joint = joints[i];
            result[i] = name_700(this.method_735(joint,skin,this));
         }
         return result;
      }
      
      private function method_735(joint:name_700, parentSource:name_78, parentDest:name_78) : name_78
      {
         var j:name_78 = null;
         for(var srcChild:name_78 = parentSource.alternativa3d::childrenList,var dstChild:name_78 = parentDest.alternativa3d::childrenList; srcChild != null; )
         {
            if(srcChild == joint)
            {
               return dstChild;
            }
            if(srcChild.alternativa3d::childrenList != null)
            {
               j = this.method_735(joint,srcChild,dstChild);
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

