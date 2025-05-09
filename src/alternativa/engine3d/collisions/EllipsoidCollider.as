package alternativa.engine3d.collisions
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.*;
   import alternativa.engine3d.resources.Geometry;
   import flash.geom.Vector3D;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   use namespace alternativa3d;
   
   public class EllipsoidCollider
   {
      public var radiusX:Number;
      
      public var radiusY:Number;
      
      public var radiusZ:Number;
      
      public var threshold:Number = 0.001;
      
      private var matrix:Transform3D = new Transform3D();
      
      private var §_-jX§:Transform3D = new Transform3D();
      
      alternativa3d var geometries:Vector.<Geometry> = new Vector.<Geometry>();
      
      alternativa3d var §_-QK§:Vector.<Transform3D> = new Vector.<Transform3D>();
      
      private var vertices:Vector.<Number> = new Vector.<Number>();
      
      private var §_-g0§:Vector.<Number> = new Vector.<Number>();
      
      private var indices:Vector.<int> = new Vector.<int>();
      
      private var numTriangles:int;
      
      private var radius:Number;
      
      private var src:Vector3D = new Vector3D();
      
      private var §_-o5§:Vector3D = new Vector3D();
      
      private var dest:Vector3D = new Vector3D();
      
      private var §_-SE§:Vector3D = new Vector3D();
      
      private var §_-pU§:Vector3D = new Vector3D();
      
      alternativa3d var sphere:Vector3D = new Vector3D();
      
      private var §_-SZ§:Vector3D = new Vector3D();
      
      private var §_-1v§:Vector3D = new Vector3D();
      
      private var §_-L9§:Vector3D = new Vector3D();
      
      private var §_-8B§:Vector3D = new Vector3D();
      
      public function EllipsoidCollider(radiusX:Number, radiusY:Number, radiusZ:Number)
      {
         super();
         this.radiusX = radiusX;
         this.radiusY = radiusY;
         this.radiusZ = radiusZ;
      }
      
      alternativa3d function calculateSphere(transform:Transform3D) : void
      {
         this.alternativa3d::sphere.x = transform.d;
         this.alternativa3d::sphere.y = transform.h;
         this.alternativa3d::sphere.z = transform.l;
         var sax:Number = transform.a * this.§_-SZ§.x + transform.b * this.§_-SZ§.y + transform.c * this.§_-SZ§.z + transform.d;
         var say:Number = transform.e * this.§_-SZ§.x + transform.f * this.§_-SZ§.y + transform.g * this.§_-SZ§.z + transform.h;
         var saz:Number = transform.i * this.§_-SZ§.x + transform.j * this.§_-SZ§.y + transform.k * this.§_-SZ§.z + transform.l;
         var sbx:Number = transform.a * this.§_-1v§.x + transform.b * this.§_-1v§.y + transform.c * this.§_-1v§.z + transform.d;
         var sby:Number = transform.e * this.§_-1v§.x + transform.f * this.§_-1v§.y + transform.g * this.§_-1v§.z + transform.h;
         var sbz:Number = transform.i * this.§_-1v§.x + transform.j * this.§_-1v§.y + transform.k * this.§_-1v§.z + transform.l;
         var scx:Number = transform.a * this.§_-L9§.x + transform.b * this.§_-L9§.y + transform.c * this.§_-L9§.z + transform.d;
         var scy:Number = transform.e * this.§_-L9§.x + transform.f * this.§_-L9§.y + transform.g * this.§_-L9§.z + transform.h;
         var scz:Number = transform.i * this.§_-L9§.x + transform.j * this.§_-L9§.y + transform.k * this.§_-L9§.z + transform.l;
         var sdx:Number = transform.a * this.§_-8B§.x + transform.b * this.§_-8B§.y + transform.c * this.§_-8B§.z + transform.d;
         var sdy:Number = transform.e * this.§_-8B§.x + transform.f * this.§_-8B§.y + transform.g * this.§_-8B§.z + transform.h;
         var sdz:Number = transform.i * this.§_-8B§.x + transform.j * this.§_-8B§.y + transform.k * this.§_-8B§.z + transform.l;
         var dx:Number = sax - this.alternativa3d::sphere.x;
         var dy:Number = say - this.alternativa3d::sphere.y;
         var dz:Number = saz - this.alternativa3d::sphere.z;
         this.alternativa3d::sphere.w = dx * dx + dy * dy + dz * dz;
         dx = sbx - this.alternativa3d::sphere.x;
         dy = sby - this.alternativa3d::sphere.y;
         dz = sbz - this.alternativa3d::sphere.z;
         var dxyz:Number = dx * dx + dy * dy + dz * dz;
         if(dxyz > this.alternativa3d::sphere.w)
         {
            this.alternativa3d::sphere.w = dxyz;
         }
         dx = scx - this.alternativa3d::sphere.x;
         dy = scy - this.alternativa3d::sphere.y;
         dz = scz - this.alternativa3d::sphere.z;
         dxyz = dx * dx + dy * dy + dz * dz;
         if(dxyz > this.alternativa3d::sphere.w)
         {
            this.alternativa3d::sphere.w = dxyz;
         }
         dx = sdx - this.alternativa3d::sphere.x;
         dy = sdy - this.alternativa3d::sphere.y;
         dz = sdz - this.alternativa3d::sphere.z;
         dxyz = dx * dx + dy * dy + dz * dz;
         if(dxyz > this.alternativa3d::sphere.w)
         {
            this.alternativa3d::sphere.w = dxyz;
         }
         this.alternativa3d::sphere.w = Math.sqrt(this.alternativa3d::sphere.w);
      }
      
      private function prepare(source:Vector3D, displacement:Vector3D, object:Object3D, excludedObjects:Dictionary) : void
      {
         var j:int = 0;
         var intersects:Boolean = false;
         var geometry:Geometry = null;
         var transform:Transform3D = null;
         var geometryIndicesLength:int = 0;
         var vBuffer:VertexStream = null;
         var geometryIndices:Vector.<uint> = null;
         var attributesOffset:int = 0;
         var numMappings:int = 0;
         var data:ByteArray = null;
         var vx:Number = NaN;
         var vy:Number = NaN;
         var vz:Number = NaN;
         var a:int = 0;
         var index:int = 0;
         var ax:Number = NaN;
         var ay:Number = NaN;
         var az:Number = NaN;
         var b:int = 0;
         var bx:Number = NaN;
         var by:Number = NaN;
         var bz:Number = NaN;
         var c:int = 0;
         var cx:Number = NaN;
         var cy:Number = NaN;
         var cz:Number = NaN;
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
         var offset:Number = NaN;
         this.radius = this.radiusX;
         if(this.radiusY > this.radius)
         {
            this.radius = this.radiusY;
         }
         if(this.radiusZ > this.radius)
         {
            this.radius = this.radiusZ;
         }
         this.matrix.compose(source.x,source.y,source.z,0,0,0,this.radiusX / this.radius,this.radiusY / this.radius,this.radiusZ / this.radius);
         this.§_-jX§.copy(this.matrix);
         this.§_-jX§.invert();
         this.src.x = 0;
         this.src.y = 0;
         this.src.z = 0;
         this.§_-o5§.x = this.§_-jX§.a * displacement.x + this.§_-jX§.b * displacement.y + this.§_-jX§.c * displacement.z;
         this.§_-o5§.y = this.§_-jX§.e * displacement.x + this.§_-jX§.f * displacement.y + this.§_-jX§.g * displacement.z;
         this.§_-o5§.z = this.§_-jX§.i * displacement.x + this.§_-jX§.j * displacement.y + this.§_-jX§.k * displacement.z;
         this.dest.x = this.src.x + this.§_-o5§.x;
         this.dest.y = this.src.y + this.§_-o5§.y;
         this.dest.z = this.src.z + this.§_-o5§.z;
         var rad:Number = this.radius + this.§_-o5§.length;
         this.§_-SZ§.x = -rad;
         this.§_-SZ§.y = -rad;
         this.§_-SZ§.z = -rad;
         this.§_-1v§.x = rad;
         this.§_-1v§.y = -rad;
         this.§_-1v§.z = -rad;
         this.§_-L9§.x = rad;
         this.§_-L9§.y = rad;
         this.§_-L9§.z = -rad;
         this.§_-8B§.x = -rad;
         this.§_-8B§.y = rad;
         this.§_-8B§.z = -rad;
         if(excludedObjects == null || !excludedObjects[object])
         {
            if(object.alternativa3d::transformChanged)
            {
               object.alternativa3d::composeTransforms();
            }
            object.alternativa3d::globalToLocalTransform.combine(object.alternativa3d::inverseTransform,this.matrix);
            intersects = true;
            if(object.boundBox != null)
            {
               this.alternativa3d::calculateSphere(object.alternativa3d::globalToLocalTransform);
               intersects = object.boundBox.alternativa3d::checkSphere(this.alternativa3d::sphere);
            }
            if(intersects)
            {
               object.alternativa3d::localToGlobalTransform.combine(this.§_-jX§,object.alternativa3d::transform);
               object.alternativa3d::collectGeometry(this,excludedObjects);
            }
            if(object.alternativa3d::childrenList != null)
            {
               object.alternativa3d::collectChildrenGeometry(this,excludedObjects);
            }
         }
         this.numTriangles = 0;
         var indicesLength:int = 0;
         var normalsLength:int = 0;
         var mapOffset:int = 0;
         var verticesLength:int = 0;
         var geometriesLength:int = int(this.alternativa3d::geometries.length);
         for(var i:int = 0; i < geometriesLength; i++)
         {
            geometry = this.alternativa3d::geometries[i];
            transform = this.alternativa3d::_-QK[i];
            geometryIndicesLength = int(geometry.alternativa3d::_indices.length);
            if(!(geometry.alternativa3d::_numVertices == 0 || geometryIndicesLength == 0))
            {
               vBuffer = VertexAttributes.POSITION < geometry.alternativa3d::_-GM.length ? geometry.alternativa3d::_-GM[VertexAttributes.POSITION] : null;
               if(vBuffer != null)
               {
                  attributesOffset = int(geometry.alternativa3d::_attributesOffsets[VertexAttributes.POSITION]);
                  numMappings = int(vBuffer.attributes.length);
                  data = vBuffer.data;
                  for(j = 0; j < geometry.alternativa3d::_numVertices; j++)
                  {
                     data.position = 4 * (numMappings * j + attributesOffset);
                     vx = Number(data.readFloat());
                     vy = Number(data.readFloat());
                     vz = Number(data.readFloat());
                     this.vertices[verticesLength] = transform.a * vx + transform.b * vy + transform.c * vz + transform.d;
                     verticesLength++;
                     this.vertices[verticesLength] = transform.e * vx + transform.f * vy + transform.g * vz + transform.h;
                     verticesLength++;
                     this.vertices[verticesLength] = transform.i * vx + transform.j * vy + transform.k * vz + transform.l;
                     verticesLength++;
                  }
               }
               geometryIndices = geometry.alternativa3d::_indices;
               for(j = 0; j < geometryIndicesLength; )
               {
                  a = geometryIndices[j] + mapOffset;
                  j++;
                  index = a * 3;
                  ax = this.vertices[index];
                  index++;
                  ay = this.vertices[index];
                  index++;
                  az = this.vertices[index];
                  b = geometryIndices[j] + mapOffset;
                  j++;
                  index = b * 3;
                  bx = this.vertices[index];
                  index++;
                  by = this.vertices[index];
                  index++;
                  bz = this.vertices[index];
                  c = geometryIndices[j] + mapOffset;
                  j++;
                  index = c * 3;
                  cx = this.vertices[index];
                  index++;
                  cy = this.vertices[index];
                  index++;
                  cz = this.vertices[index];
                  if(!(ax > rad && bx > rad && cx > rad || ax < -rad && bx < -rad && cx < -rad))
                  {
                     if(!(ay > rad && by > rad && cy > rad || ay < -rad && by < -rad && cy < -rad))
                     {
                        if(!(az > rad && bz > rad && cz > rad || az < -rad && bz < -rad && cz < -rad))
                        {
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
                           if(len >= 0.001)
                           {
                              len = 1 / Math.sqrt(len);
                              normalX *= len;
                              normalY *= len;
                              normalZ *= len;
                              offset = ax * normalX + ay * normalY + az * normalZ;
                              if(!(offset > rad || offset < -rad))
                              {
                                 this.indices[indicesLength] = a;
                                 indicesLength++;
                                 this.indices[indicesLength] = b;
                                 indicesLength++;
                                 this.indices[indicesLength] = c;
                                 indicesLength++;
                                 this.§_-g0§[normalsLength] = normalX;
                                 normalsLength++;
                                 this.§_-g0§[normalsLength] = normalY;
                                 normalsLength++;
                                 this.§_-g0§[normalsLength] = normalZ;
                                 normalsLength++;
                                 this.§_-g0§[normalsLength] = offset;
                                 normalsLength++;
                                 ++this.numTriangles;
                              }
                           }
                        }
                     }
                  }
               }
               mapOffset += geometry.alternativa3d::_numVertices;
            }
         }
         this.alternativa3d::geometries.length = 0;
         this.alternativa3d::_-QK.length = 0;
      }
      
      public function calculateDestination(source:Vector3D, displacement:Vector3D, object:Object3D, excludedObjects:Dictionary = null) : Vector3D
      {
         var limit:int = 0;
         var i:int = 0;
         var offset:Number = NaN;
         if(displacement.length <= this.threshold)
         {
            return source.clone();
         }
         this.prepare(source,displacement,object,excludedObjects);
         if(this.numTriangles > 0)
         {
            limit = 50;
            for(i = 0; i < limit; )
            {
               if(!this.checkCollision())
               {
                  break;
               }
               offset = this.radius + this.threshold + this.§_-pU§.w - this.dest.x * this.§_-pU§.x - this.dest.y * this.§_-pU§.y - this.dest.z * this.§_-pU§.z;
               this.dest.x += this.§_-pU§.x * offset;
               this.dest.y += this.§_-pU§.y * offset;
               this.dest.z += this.§_-pU§.z * offset;
               this.src.x = this.§_-SE§.x + this.§_-pU§.x * (this.radius + this.threshold);
               this.src.y = this.§_-SE§.y + this.§_-pU§.y * (this.radius + this.threshold);
               this.src.z = this.§_-SE§.z + this.§_-pU§.z * (this.radius + this.threshold);
               this.§_-o5§.x = this.dest.x - this.src.x;
               this.§_-o5§.y = this.dest.y - this.src.y;
               this.§_-o5§.z = this.dest.z - this.src.z;
               if(this.§_-o5§.length < this.threshold)
               {
                  break;
               }
               i++;
            }
            return new Vector3D(this.matrix.a * this.dest.x + this.matrix.b * this.dest.y + this.matrix.c * this.dest.z + this.matrix.d,this.matrix.e * this.dest.x + this.matrix.f * this.dest.y + this.matrix.g * this.dest.z + this.matrix.h,this.matrix.i * this.dest.x + this.matrix.j * this.dest.y + this.matrix.k * this.dest.z + this.matrix.l);
         }
         return new Vector3D(source.x + displacement.x,source.y + displacement.y,source.z + displacement.z);
      }
      
      public function getCollision(source:Vector3D, displacement:Vector3D, resCollisionPoint:Vector3D, resCollisionPlane:Vector3D, object:Object3D, excludedObjects:Dictionary = null) : Boolean
      {
         var abx:Number = NaN;
         var aby:Number = NaN;
         var abz:Number = NaN;
         var acx:Number = NaN;
         var acy:Number = NaN;
         var acz:Number = NaN;
         var abx2:Number = NaN;
         var aby2:Number = NaN;
         var abz2:Number = NaN;
         var acx2:Number = NaN;
         var acy2:Number = NaN;
         var acz2:Number = NaN;
         if(displacement.length <= this.threshold)
         {
            return false;
         }
         this.prepare(source,displacement,object,excludedObjects);
         if(this.numTriangles > 0)
         {
            if(this.checkCollision())
            {
               resCollisionPoint.x = this.matrix.a * this.§_-SE§.x + this.matrix.b * this.§_-SE§.y + this.matrix.c * this.§_-SE§.z + this.matrix.d;
               resCollisionPoint.y = this.matrix.e * this.§_-SE§.x + this.matrix.f * this.§_-SE§.y + this.matrix.g * this.§_-SE§.z + this.matrix.h;
               resCollisionPoint.z = this.matrix.i * this.§_-SE§.x + this.matrix.j * this.§_-SE§.y + this.matrix.k * this.§_-SE§.z + this.matrix.l;
               if(this.§_-pU§.x < this.§_-pU§.y)
               {
                  if(this.§_-pU§.x < this.§_-pU§.z)
                  {
                     abx = 0;
                     aby = -this.§_-pU§.z;
                     abz = Number(this.§_-pU§.y);
                  }
                  else
                  {
                     abx = -this.§_-pU§.y;
                     aby = Number(this.§_-pU§.x);
                     abz = 0;
                  }
               }
               else if(this.§_-pU§.y < this.§_-pU§.z)
               {
                  abx = Number(this.§_-pU§.z);
                  aby = 0;
                  abz = -this.§_-pU§.x;
               }
               else
               {
                  abx = -this.§_-pU§.y;
                  aby = Number(this.§_-pU§.x);
                  abz = 0;
               }
               acx = this.§_-pU§.z * aby - this.§_-pU§.y * abz;
               acy = this.§_-pU§.x * abz - this.§_-pU§.z * abx;
               acz = this.§_-pU§.y * abx - this.§_-pU§.x * aby;
               abx2 = this.matrix.a * abx + this.matrix.b * aby + this.matrix.c * abz;
               aby2 = this.matrix.e * abx + this.matrix.f * aby + this.matrix.g * abz;
               abz2 = this.matrix.i * abx + this.matrix.j * aby + this.matrix.k * abz;
               acx2 = this.matrix.a * acx + this.matrix.b * acy + this.matrix.c * acz;
               acy2 = this.matrix.e * acx + this.matrix.f * acy + this.matrix.g * acz;
               acz2 = this.matrix.i * acx + this.matrix.j * acy + this.matrix.k * acz;
               resCollisionPlane.x = abz2 * acy2 - aby2 * acz2;
               resCollisionPlane.y = abx2 * acz2 - abz2 * acx2;
               resCollisionPlane.z = aby2 * acx2 - abx2 * acy2;
               resCollisionPlane.normalize();
               resCollisionPlane.w = resCollisionPoint.x * resCollisionPlane.x + resCollisionPoint.y * resCollisionPlane.y + resCollisionPoint.z * resCollisionPlane.z;
               return true;
            }
            return false;
         }
         return false;
      }
      
      private function checkCollision() : Boolean
      {
         var index:int = 0;
         var ax:Number = NaN;
         var ay:Number = NaN;
         var az:Number = NaN;
         var bx:Number = NaN;
         var by:Number = NaN;
         var bz:Number = NaN;
         var cx:Number = NaN;
         var cy:Number = NaN;
         var cz:Number = NaN;
         var normalX:Number = NaN;
         var normalY:Number = NaN;
         var normalZ:Number = NaN;
         var offset:Number = NaN;
         var distance:Number = NaN;
         var pointX:Number = NaN;
         var pointY:Number = NaN;
         var pointZ:Number = NaN;
         var faceX:Number = NaN;
         var faceY:Number = NaN;
         var faceZ:Number = NaN;
         var min:Number = NaN;
         var inside:Boolean = false;
         var k:int = 0;
         var deltaX:Number = NaN;
         var deltaY:Number = NaN;
         var deltaZ:Number = NaN;
         var _loc33_:Number = NaN;
         var p1x:Number = NaN;
         var p1y:Number = NaN;
         var p1z:Number = NaN;
         var p2x:Number = NaN;
         var p2y:Number = NaN;
         var p2z:Number = NaN;
         var abx:Number = NaN;
         var aby:Number = NaN;
         var abz:Number = NaN;
         var acx:Number = NaN;
         var acy:Number = NaN;
         var acz:Number = NaN;
         var crx:Number = NaN;
         var cry:Number = NaN;
         var crz:Number = NaN;
         var edgeLength:Number = NaN;
         var edgeDistanceSqr:Number = NaN;
         var acLen:Number = NaN;
         var backX:Number = NaN;
         var backY:Number = NaN;
         var backZ:Number = NaN;
         var deltaLength:Number = NaN;
         var projectionLength:Number = NaN;
         var projectionInsideLength:Number = NaN;
         var time:Number = NaN;
         var minTime:Number = 1;
         var displacementLength:Number = Number(this.§_-o5§.length);
         var indicesLength:int = this.numTriangles * 3;
         for(var i:int = 0,var j:int = 0; i < indicesLength; )
         {
            index = this.indices[i] * 3;
            i++;
            ax = this.vertices[index];
            index++;
            ay = this.vertices[index];
            index++;
            az = this.vertices[index];
            index = this.indices[i] * 3;
            i++;
            bx = this.vertices[index];
            index++;
            by = this.vertices[index];
            index++;
            bz = this.vertices[index];
            index = this.indices[i] * 3;
            i++;
            cx = this.vertices[index];
            index++;
            cy = this.vertices[index];
            index++;
            cz = this.vertices[index];
            normalX = this.§_-g0§[j];
            j++;
            normalY = this.§_-g0§[j];
            j++;
            normalZ = this.§_-g0§[j];
            j++;
            offset = this.§_-g0§[j];
            j++;
            distance = this.src.x * normalX + this.src.y * normalY + this.src.z * normalZ - offset;
            if(distance < this.radius)
            {
               pointX = this.src.x - normalX * distance;
               pointY = this.src.y - normalY * distance;
               pointZ = this.src.z - normalZ * distance;
            }
            else
            {
               _loc33_ = (distance - this.radius) / (distance - this.dest.x * normalX - this.dest.y * normalY - this.dest.z * normalZ + offset);
               pointX = this.src.x + this.§_-o5§.x * _loc33_ - normalX * this.radius;
               pointY = this.src.y + this.§_-o5§.y * _loc33_ - normalY * this.radius;
               pointZ = this.src.z + this.§_-o5§.z * _loc33_ - normalZ * this.radius;
            }
            min = 1e+22;
            inside = true;
            for(k = 0; k < 3; )
            {
               if(k == 0)
               {
                  p1x = ax;
                  p1y = ay;
                  p1z = az;
                  p2x = bx;
                  p2y = by;
                  p2z = bz;
               }
               else if(k == 1)
               {
                  p1x = bx;
                  p1y = by;
                  p1z = bz;
                  p2x = cx;
                  p2y = cy;
                  p2z = cz;
               }
               else
               {
                  p1x = cx;
                  p1y = cy;
                  p1z = cz;
                  p2x = ax;
                  p2y = ay;
                  p2z = az;
               }
               abx = p2x - p1x;
               aby = p2y - p1y;
               abz = p2z - p1z;
               acx = pointX - p1x;
               acy = pointY - p1y;
               acz = pointZ - p1z;
               crx = acz * aby - acy * abz;
               cry = acx * abz - acz * abx;
               crz = acy * abx - acx * aby;
               if(crx * normalX + cry * normalY + crz * normalZ < 0)
               {
                  edgeLength = abx * abx + aby * aby + abz * abz;
                  edgeDistanceSqr = (crx * crx + cry * cry + crz * crz) / edgeLength;
                  if(edgeDistanceSqr < min)
                  {
                     edgeLength = Number(Math.sqrt(edgeLength));
                     abx /= edgeLength;
                     aby /= edgeLength;
                     abz /= edgeLength;
                     _loc33_ = abx * acx + aby * acy + abz * acz;
                     if(_loc33_ < 0)
                     {
                        acLen = acx * acx + acy * acy + acz * acz;
                        if(acLen < min)
                        {
                           min = acLen;
                           faceX = p1x;
                           faceY = p1y;
                           faceZ = p1z;
                        }
                     }
                     else if(_loc33_ > edgeLength)
                     {
                        acx = pointX - p2x;
                        acy = pointY - p2y;
                        acz = pointZ - p2z;
                        acLen = acx * acx + acy * acy + acz * acz;
                        if(acLen < min)
                        {
                           min = acLen;
                           faceX = p2x;
                           faceY = p2y;
                           faceZ = p2z;
                        }
                     }
                     else
                     {
                        min = edgeDistanceSqr;
                        faceX = p1x + abx * _loc33_;
                        faceY = p1y + aby * _loc33_;
                        faceZ = p1z + abz * _loc33_;
                     }
                  }
                  inside = false;
               }
               k++;
            }
            if(inside)
            {
               faceX = pointX;
               faceY = pointY;
               faceZ = pointZ;
            }
            deltaX = this.src.x - faceX;
            deltaY = this.src.y - faceY;
            deltaZ = this.src.z - faceZ;
            if(deltaX * this.§_-o5§.x + deltaY * this.§_-o5§.y + deltaZ * this.§_-o5§.z <= 0)
            {
               backX = -this.§_-o5§.x / displacementLength;
               backY = -this.§_-o5§.y / displacementLength;
               backZ = -this.§_-o5§.z / displacementLength;
               deltaLength = deltaX * deltaX + deltaY * deltaY + deltaZ * deltaZ;
               projectionLength = deltaX * backX + deltaY * backY + deltaZ * backZ;
               projectionInsideLength = this.radius * this.radius - deltaLength + projectionLength * projectionLength;
               if(projectionInsideLength > 0)
               {
                  time = (projectionLength - Math.sqrt(projectionInsideLength)) / displacementLength;
                  if(time < minTime)
                  {
                     minTime = time;
                     this.§_-SE§.x = faceX;
                     this.§_-SE§.y = faceY;
                     this.§_-SE§.z = faceZ;
                     if(inside)
                     {
                        this.§_-pU§.x = normalX;
                        this.§_-pU§.y = normalY;
                        this.§_-pU§.z = normalZ;
                        this.§_-pU§.w = offset;
                     }
                     else
                     {
                        deltaLength = Number(Math.sqrt(deltaLength));
                        this.§_-pU§.x = deltaX / deltaLength;
                        this.§_-pU§.y = deltaY / deltaLength;
                        this.§_-pU§.z = deltaZ / deltaLength;
                        this.§_-pU§.w = this.§_-SE§.x * this.§_-pU§.x + this.§_-SE§.y * this.§_-pU§.y + this.§_-SE§.z * this.§_-pU§.z;
                     }
                  }
               }
            }
         }
         return minTime < 1;
      }
   }
}

