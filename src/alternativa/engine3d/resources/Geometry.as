package alternativa.engine3d.resources
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.BoundBox;
   import alternativa.engine3d.core.RayIntersectionData;
   import alternativa.engine3d.core.Resource;
   import alternativa.engine3d.core.Transform3D;
   import alternativa.engine3d.core.VertexAttributes;
   import alternativa.engine3d.core.VertexStream;
   import flash.display3D.Context3D;
   import flash.display3D.IndexBuffer3D;
   import flash.display3D.VertexBuffer3D;
   import flash.geom.Point;
   import flash.geom.Vector3D;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   use namespace alternativa3d;
   
   public class Geometry extends Resource
   {
      alternativa3d var _vertexStreams:Vector.<VertexStream> = new Vector.<VertexStream>();
      
      alternativa3d var name_EM:IndexBuffer3D;
      
      alternativa3d var _numVertices:int;
      
      alternativa3d var _indices:Vector.<uint> = new Vector.<uint>();
      
      alternativa3d var name_GM:Vector.<VertexStream> = new Vector.<VertexStream>();
      
      alternativa3d var _attributesOffsets:Vector.<int> = new Vector.<int>();
      
      private var name_QD:Vector.<int> = new Vector.<int>();
      
      public function Geometry(numVertices:int = 0)
      {
         super();
         this.alternativa3d::_numVertices = numVertices;
      }
      
      public function get numTriangles() : int
      {
         return this.alternativa3d::_indices.length / 3;
      }
      
      public function get indices() : Vector.<uint>
      {
         return this.alternativa3d::_indices.slice();
      }
      
      public function set indices(value:Vector.<uint>) : void
      {
         if(value == null)
         {
            this.alternativa3d::_indices.length = 0;
         }
         else
         {
            this.alternativa3d::_indices = value.slice();
         }
      }
      
      public function get numVertices() : int
      {
         return this.alternativa3d::_numVertices;
      }
      
      public function set numVertices(value:int) : void
      {
         var vBuffer:VertexStream = null;
         var numMappings:int = 0;
         if(this.alternativa3d::_numVertices != value)
         {
            for each(vBuffer in this.alternativa3d::_vertexStreams)
            {
               numMappings = int(vBuffer.attributes.length);
               vBuffer.data.length = 4 * numMappings * value;
            }
            this.alternativa3d::_numVertices = value;
         }
      }
      
      public function addVertexStream(attributes:Array) : int
      {
         var next:uint = 0;
         var numStandartFloats:int = 0;
         var startIndex:int = 0;
         var numMappings:int = int(attributes.length);
         if(numMappings < 1)
         {
            throw new Error("Must be at least one attribute ​​to create the buffer.");
         }
         var vBuffer:VertexStream = new VertexStream();
         var newBufferIndex:int = int(this.alternativa3d::_vertexStreams.length);
         var attribute:uint = uint(attributes[0]);
         var stride:int = 1;
         for(var i:int = 1; i <= numMappings; i++)
         {
            next = i < numMappings ? uint(attributes[i]) : 0;
            if(next != attribute)
            {
               if(attribute != 0)
               {
                  if(attribute < this.name_GM.length && this.name_GM[attribute] != null)
                  {
                     throw new Error("Attribute " + attribute + " already used in this geometry.");
                  }
                  numStandartFloats = VertexAttributes.getAttributeStride(attribute);
                  if(numStandartFloats != 0 && numStandartFloats != stride)
                  {
                     throw new Error("Standard attributes must be predefined size.");
                  }
                  if(this.name_GM.length < attribute)
                  {
                     this.name_GM.length = attribute + 1;
                     this.alternativa3d::_attributesOffsets.length = attribute + 1;
                     this.name_QD.length = attribute + 1;
                  }
                  startIndex = i - stride;
                  this.name_GM[attribute] = vBuffer;
                  this.alternativa3d::_attributesOffsets[attribute] = startIndex;
                  this.name_QD[attribute] = stride;
               }
               stride = 1;
            }
            else
            {
               stride++;
            }
            attribute = next;
         }
         vBuffer.attributes = attributes.slice();
         vBuffer.data = new ByteArray();
         vBuffer.data.endian = Endian.LITTLE_ENDIAN;
         vBuffer.data.length = 4 * numMappings * this.alternativa3d::_numVertices;
         this.alternativa3d::_vertexStreams[newBufferIndex] = vBuffer;
         return newBufferIndex;
      }
      
      public function get numVertexStreams() : int
      {
         return this.alternativa3d::_vertexStreams.length;
      }
      
      public function getVertexStreamAttributes(index:int) : Array
      {
         return this.alternativa3d::_vertexStreams[index].attributes.slice();
      }
      
      public function hasAttribute(attribute:uint) : Boolean
      {
         return attribute < this.name_GM.length && this.name_GM[attribute] != null;
      }
      
      public function findVertexStreamByAttribute(attribute:uint) : int
      {
         var i:int = 0;
         var vBuffer:VertexStream = attribute < this.name_GM.length ? this.name_GM[attribute] : null;
         if(vBuffer != null)
         {
            for(i = 0; i < this.alternativa3d::_vertexStreams.length; )
            {
               if(this.alternativa3d::_vertexStreams[i] == vBuffer)
               {
                  return i;
               }
               i++;
            }
         }
         return -1;
      }
      
      public function getAttributeOffset(attribute:uint) : int
      {
         var vBuffer:VertexStream = attribute < this.name_GM.length ? this.name_GM[attribute] : null;
         if(vBuffer == null)
         {
            throw new Error("Attribute not found.");
         }
         return this.alternativa3d::_attributesOffsets[attribute];
      }
      
      public function setAttributeValues(attribute:uint, values:Vector.<Number>) : void
      {
         var srcIndex:int = 0;
         var j:int = 0;
         var vBuffer:VertexStream = attribute < this.name_GM.length ? this.name_GM[attribute] : null;
         if(vBuffer == null)
         {
            throw new Error("Attribute not found.");
         }
         var stride:int = this.name_QD[attribute];
         if(values == null || values.length != stride * this.alternativa3d::_numVertices)
         {
            throw new Error("Values count must be the same.");
         }
         var numMappings:int = int(vBuffer.attributes.length);
         var data:ByteArray = vBuffer.data;
         var offset:int = this.alternativa3d::_attributesOffsets[attribute];
         for(var i:int = 0; i < this.alternativa3d::_numVertices; i++)
         {
            srcIndex = stride * i;
            data.position = 4 * (numMappings * i + offset);
            for(j = 0; j < stride; j++)
            {
               data.writeFloat(values[int(srcIndex + j)]);
            }
         }
      }
      
      public function getAttributeValues(attribute:uint) : Vector.<Number>
      {
         var dstIndex:int = 0;
         var j:int = 0;
         var vBuffer:VertexStream = attribute < this.name_GM.length ? this.name_GM[attribute] : null;
         if(vBuffer == null)
         {
            throw new Error("Attribute not found.");
         }
         var data:ByteArray = vBuffer.data;
         var stride:int = this.name_QD[attribute];
         var result:Vector.<Number> = new Vector.<Number>(stride * this.alternativa3d::_numVertices);
         var numMappings:int = int(vBuffer.attributes.length);
         var offset:int = this.alternativa3d::_attributesOffsets[attribute];
         for(var i:int = 0; i < this.alternativa3d::_numVertices; i++)
         {
            data.position = 4 * (numMappings * i + offset);
            dstIndex = stride * i;
            for(j = 0; j < stride; j++)
            {
               result[int(dstIndex + j)] = data.readFloat();
            }
         }
         return result;
      }
      
      override public function get isUploaded() : Boolean
      {
         return this.name_EM != null;
      }
      
      override public function upload(context3D:Context3D) : void
      {
         var vBuffer:VertexStream = null;
         var i:int = 0;
         var numMappings:int = 0;
         var data:ByteArray = null;
         var numBuffers:int = int(this.alternativa3d::_vertexStreams.length);
         if(this.name_EM != null)
         {
            this.name_EM.dispose();
            this.name_EM = null;
            for(i = 0; i < numBuffers; i++)
            {
               vBuffer = this.alternativa3d::_vertexStreams[i];
               vBuffer.buffer.dispose();
               vBuffer.buffer = null;
            }
         }
         if(this.alternativa3d::_indices.length <= 0 || this.alternativa3d::_numVertices <= 0)
         {
            return;
         }
         for(i = 0; i < numBuffers; )
         {
            vBuffer = this.alternativa3d::_vertexStreams[i];
            numMappings = int(vBuffer.attributes.length);
            data = vBuffer.data;
            if(data == null)
            {
               throw new Error("Cannot upload without vertex buffer data.");
            }
            vBuffer.buffer = context3D.createVertexBuffer(this.alternativa3d::_numVertices,numMappings);
            vBuffer.buffer.uploadFromByteArray(data,0,0,this.alternativa3d::_numVertices);
            i++;
         }
         var numIndices:int = int(this.alternativa3d::_indices.length);
         this.name_EM = context3D.createIndexBuffer(numIndices);
         this.name_EM.uploadFromVector(this.alternativa3d::_indices,0,numIndices);
      }
      
      override public function dispose() : void
      {
         var numBuffers:int = 0;
         var i:int = 0;
         var vBuffer:VertexStream = null;
         if(this.name_EM != null)
         {
            this.name_EM.dispose();
            this.name_EM = null;
            numBuffers = int(this.alternativa3d::_vertexStreams.length);
            for(i = 0; i < numBuffers; i++)
            {
               vBuffer = this.alternativa3d::_vertexStreams[i];
               vBuffer.buffer.dispose();
               vBuffer.buffer = null;
            }
         }
      }
      
      public function updateIndexBufferInContextFromVector(data:Vector.<uint>, startOffset:int, count:int) : void
      {
         if(this.name_EM == null)
         {
            throw new Error("Geometry must be uploaded.");
         }
         this.name_EM.uploadFromVector(data,startOffset,count);
      }
      
      public function updateIndexBufferInContextFromByteArray(data:ByteArray, byteArrayOffset:int, startOffset:int, count:int) : void
      {
         if(this.name_EM == null)
         {
            throw new Error("Geometry must be uploaded.");
         }
         this.name_EM.uploadFromByteArray(data,byteArrayOffset,startOffset,count);
      }
      
      public function updateVertexBufferInContextFromVector(index:int, data:Vector.<Number>, startVertex:int, numVertices:int) : void
      {
         if(this.name_EM == null)
         {
            throw new Error("Geometry must be uploaded.");
         }
         this.alternativa3d::_vertexStreams[index].buffer.uploadFromVector(data,startVertex,numVertices);
      }
      
      public function updateVertexBufferInContextFromByteArray(index:int, data:ByteArray, byteArrayOffset:int, startVertex:int, numVertices:int) : void
      {
         if(this.name_EM == null)
         {
            throw new Error("Geometry must be uploaded.");
         }
         this.alternativa3d::_vertexStreams[index].buffer.uploadFromByteArray(data,byteArrayOffset,startVertex,numVertices);
      }
      
      alternativa3d function intersectRay(origin:Vector3D, direction:Vector3D, indexBegin:uint, numTriangles:uint) : RayIntersectionData
      {
         var nax:Number = NaN;
         var nay:Number = NaN;
         var naz:Number = NaN;
         var nau:Number = NaN;
         var nav:Number = NaN;
         var nbx:Number = NaN;
         var nby:Number = NaN;
         var nbz:Number = NaN;
         var nbu:Number = NaN;
         var nbv:Number = NaN;
         var ncx:Number = NaN;
         var ncy:Number = NaN;
         var ncz:Number = NaN;
         var ncu:Number = NaN;
         var ncv:Number = NaN;
         var nrmX:Number = NaN;
         var nrmY:Number = NaN;
         var nrmZ:Number = NaN;
         var point:Vector3D = null;
         var positionStream:VertexStream = null;
         var uvStream:VertexStream = null;
         var uvBuffer:ByteArray = null;
         var uvOffset:uint = 0;
         var uvStride:uint = 0;
         var indexA:uint = 0;
         var indexB:uint = 0;
         var indexC:uint = 0;
         var ax:Number = NaN;
         var ay:Number = NaN;
         var az:Number = NaN;
         var au:Number = NaN;
         var av:Number = NaN;
         var bx:Number = NaN;
         var by:Number = NaN;
         var bz:Number = NaN;
         var bu:Number = NaN;
         var bv:Number = NaN;
         var cx:Number = NaN;
         var cy:Number = NaN;
         var cz:Number = NaN;
         var cu:Number = NaN;
         var cv:Number = NaN;
         var abx:Number = NaN;
         var aby:Number = NaN;
         var abz:Number = NaN;
         var acx:Number = NaN;
         var acy:Number = NaN;
         var acz:Number = NaN;
         var normalX:Number = NaN;
         var normalY:Number = NaN;
         var normalZ:Number = NaN;
         var len:Number = NaN;
         var dot:Number = NaN;
         var offset:Number = NaN;
         var time:Number = NaN;
         var rx:Number = NaN;
         var ry:Number = NaN;
         var rz:Number = NaN;
         var res:RayIntersectionData = null;
         var abu:Number = NaN;
         var abv:Number = NaN;
         var acu:Number = NaN;
         var acv:Number = NaN;
         var det:Number = NaN;
         var ima:Number = NaN;
         var imb:Number = NaN;
         var imc:Number = NaN;
         var imd:Number = NaN;
         var ime:Number = NaN;
         var imf:Number = NaN;
         var img:Number = NaN;
         var imh:Number = NaN;
         var ma:Number = NaN;
         var mb:Number = NaN;
         var mc:Number = NaN;
         var md:Number = NaN;
         var me:Number = NaN;
         var mf:Number = NaN;
         var mg:Number = NaN;
         var mh:Number = NaN;
         var ox:Number = Number(origin.x);
         var oy:Number = Number(origin.y);
         var oz:Number = Number(origin.z);
         var dx:Number = Number(direction.x);
         var dy:Number = Number(direction.y);
         var dz:Number = Number(direction.z);
         var minTime:Number = 1e+22;
         var posAttribute:int = int(VertexAttributes.POSITION);
         var uvAttribute:int = int(VertexAttributes.TEXCOORDS[0]);
         if(VertexAttributes.POSITION >= this.name_GM.length || (positionStream = this.name_GM[posAttribute]) == null)
         {
            throw new Error("Raycast require POSITION attribute");
         }
         var positionBuffer:ByteArray = positionStream.data;
         var positionOffset:uint = uint(this.alternativa3d::_attributesOffsets[posAttribute] * 4);
         var stride:uint = positionStream.attributes.length * 4;
         var hasUV:Boolean = uvAttribute < this.name_GM.length && (uvStream = this.name_GM[uvAttribute]) != null;
         if(hasUV)
         {
            uvBuffer = uvStream.data;
            uvOffset = uint(this.alternativa3d::_attributesOffsets[uvAttribute] * 4);
            uvStride = uvStream.attributes.length * 4;
         }
         if(numTriangles * 3 > this.indices.length)
         {
            throw new ArgumentError("index is out of bounds");
         }
         for(var i:int = int(indexBegin),var count:int = indexBegin + numTriangles * 3; i < count; )
         {
            indexA = this.indices[i];
            indexB = this.indices[int(i + 1)];
            indexC = this.indices[int(i + 2)];
            positionBuffer.position = indexA * stride + positionOffset;
            ax = Number(positionBuffer.readFloat());
            ay = Number(positionBuffer.readFloat());
            az = Number(positionBuffer.readFloat());
            positionBuffer.position = indexB * stride + positionOffset;
            bx = Number(positionBuffer.readFloat());
            by = Number(positionBuffer.readFloat());
            bz = Number(positionBuffer.readFloat());
            positionBuffer.position = indexC * stride + positionOffset;
            cx = Number(positionBuffer.readFloat());
            cy = Number(positionBuffer.readFloat());
            cz = Number(positionBuffer.readFloat());
            if(hasUV)
            {
               uvBuffer.position = indexA * uvStride + uvOffset;
               au = Number(uvBuffer.readFloat());
               av = Number(uvBuffer.readFloat());
               uvBuffer.position = indexB * uvStride + uvOffset;
               bu = Number(uvBuffer.readFloat());
               bv = Number(uvBuffer.readFloat());
               uvBuffer.position = indexC * uvStride + uvOffset;
               cu = Number(uvBuffer.readFloat());
               cv = Number(uvBuffer.readFloat());
            }
            abx = bx - ax;
            aby = by - ay;
            abz = bz - az;
            acx = cx - ax;
            acy = cy - ay;
            acz = cz - az;
            normalX = acz * aby - acy * abz;
            normalY = acx * abz - acz * abx;
            normalZ = acy * abx - acx * aby;
            len = normalX * normalX + normalY * normalY + normalZ * normalZ;
            if(len > 0.001)
            {
               len = 1 / Math.sqrt(len);
               normalX *= len;
               normalY *= len;
               normalZ *= len;
            }
            dot = dx * normalX + dy * normalY + dz * normalZ;
            if(dot < 0)
            {
               offset = ox * normalX + oy * normalY + oz * normalZ - (ax * normalX + ay * normalY + az * normalZ);
               if(offset > 0)
               {
                  time = -offset / dot;
                  if(point == null || time < minTime)
                  {
                     rx = ox + dx * time;
                     ry = oy + dy * time;
                     rz = oz + dz * time;
                     abx = bx - ax;
                     aby = by - ay;
                     abz = bz - az;
                     acx = rx - ax;
                     acy = ry - ay;
                     acz = rz - az;
                     if((acz * aby - acy * abz) * normalX + (acx * abz - acz * abx) * normalY + (acy * abx - acx * aby) * normalZ >= 0)
                     {
                        abx = cx - bx;
                        aby = cy - by;
                        abz = cz - bz;
                        acx = rx - bx;
                        acy = ry - by;
                        acz = rz - bz;
                        if((acz * aby - acy * abz) * normalX + (acx * abz - acz * abx) * normalY + (acy * abx - acx * aby) * normalZ >= 0)
                        {
                           abx = ax - cx;
                           aby = ay - cy;
                           abz = az - cz;
                           acx = rx - cx;
                           acy = ry - cy;
                           acz = rz - cz;
                           if((acz * aby - acy * abz) * normalX + (acx * abz - acz * abx) * normalY + (acy * abx - acx * aby) * normalZ >= 0)
                           {
                              if(time < minTime)
                              {
                                 minTime = time;
                                 if(point == null)
                                 {
                                    point = new Vector3D();
                                 }
                                 point.x = rx;
                                 point.y = ry;
                                 point.z = rz;
                                 nax = ax;
                                 nay = ay;
                                 naz = az;
                                 nau = au;
                                 nav = av;
                                 nrmX = normalX;
                                 nbx = bx;
                                 nby = by;
                                 nbz = bz;
                                 nbu = bu;
                                 nbv = bv;
                                 nrmY = normalY;
                                 ncx = cx;
                                 ncy = cy;
                                 ncz = cz;
                                 ncu = cu;
                                 ncv = cv;
                                 nrmZ = normalZ;
                              }
                           }
                        }
                     }
                  }
               }
            }
            i += 3;
         }
         if(point != null)
         {
            res = new RayIntersectionData();
            res.point = point;
            res.time = minTime;
            if(hasUV)
            {
               abx = nbx - nax;
               aby = nby - nay;
               abz = nbz - naz;
               abu = nbu - nau;
               abv = nbv - nav;
               acx = ncx - nax;
               acy = ncy - nay;
               acz = ncz - naz;
               acu = ncu - nau;
               acv = ncv - nav;
               det = -nrmX * acy * abz + acx * nrmY * abz + nrmX * aby * acz - abx * nrmY * acz - acx * aby * nrmZ + abx * acy * nrmZ;
               ima = (-nrmY * acz + acy * nrmZ) / det;
               imb = (nrmX * acz - acx * nrmZ) / det;
               imc = (-nrmX * acy + acx * nrmY) / det;
               imd = (nax * nrmY * acz - nrmX * nay * acz - nax * acy * nrmZ + acx * nay * nrmZ + nrmX * acy * naz - acx * nrmY * naz) / det;
               ime = (nrmY * abz - aby * nrmZ) / det;
               imf = (-nrmX * abz + abx * nrmZ) / det;
               img = (nrmX * aby - abx * nrmY) / det;
               imh = (nrmX * nay * abz - nax * nrmY * abz + nax * aby * nrmZ - abx * nay * nrmZ - nrmX * aby * naz + abx * nrmY * naz) / det;
               ma = abu * ima + acu * ime;
               mb = abu * imb + acu * imf;
               mc = abu * imc + acu * img;
               md = abu * imd + acu * imh + nau;
               me = abv * ima + acv * ime;
               mf = abv * imb + acv * imf;
               mg = abv * imc + acv * img;
               mh = abv * imd + acv * imh + nav;
               res.uv = new Point(ma * point.x + mb * point.y + mc * point.z + md,me * point.x + mf * point.y + mg * point.z + mh);
            }
            return res;
         }
         return null;
      }
      
      alternativa3d function getVertexBuffer(attribute:int) : VertexBuffer3D
      {
         var stream:VertexStream = null;
         if(attribute < this.name_GM.length)
         {
            stream = this.name_GM[attribute];
            return stream != null ? stream.buffer : null;
         }
         return null;
      }
      
      alternativa3d function updateBoundBox(boundBox:BoundBox, transform:Transform3D = null) : void
      {
         var vx:Number = NaN;
         var vy:Number = NaN;
         var vz:Number = NaN;
         var x:Number = NaN;
         var y:Number = NaN;
         var z:Number = NaN;
         var vBuffer:VertexStream = VertexAttributes.POSITION < this.name_GM.length ? this.name_GM[VertexAttributes.POSITION] : null;
         if(vBuffer == null)
         {
            throw new Error("Cannot calculate BoundBox without data.");
         }
         var offset:int = this.alternativa3d::_attributesOffsets[VertexAttributes.POSITION];
         var numMappings:int = int(vBuffer.attributes.length);
         var data:ByteArray = vBuffer.data;
         for(var i:int = 0; i < this.alternativa3d::_numVertices; )
         {
            data.position = 4 * (numMappings * i + offset);
            vx = Number(data.readFloat());
            vy = Number(data.readFloat());
            vz = Number(data.readFloat());
            if(transform != null)
            {
               x = transform.a * vx + transform.b * vy + transform.c * vz + transform.d;
               y = transform.e * vx + transform.f * vy + transform.g * vz + transform.h;
               z = transform.i * vx + transform.j * vy + transform.k * vz + transform.l;
            }
            else
            {
               x = vx;
               y = vy;
               z = vz;
            }
            if(x < boundBox.minX)
            {
               boundBox.minX = x;
            }
            if(x > boundBox.maxX)
            {
               boundBox.maxX = x;
            }
            if(y < boundBox.minY)
            {
               boundBox.minY = y;
            }
            if(y > boundBox.maxY)
            {
               boundBox.maxY = y;
            }
            if(z < boundBox.minZ)
            {
               boundBox.minZ = z;
            }
            if(z > boundBox.maxZ)
            {
               boundBox.maxZ = z;
            }
            i++;
         }
      }
   }
}

