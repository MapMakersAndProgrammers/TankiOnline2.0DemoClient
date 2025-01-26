package package_27
{
   import package_109.name_377;
   import package_109.name_378;
   import package_109.name_381;
   import package_19.name_380;
   import package_21.name_126;
   import package_46.Matrix4;
   import package_46.name_194;
   import package_76.name_235;
   
   public class name_642
   {
      public function name_642()
      {
         super();
      }
      
      public static function name_646(mesh:name_380, collisionPrimitives:Vector.<name_235>, collisionGroup:int, collisionMask:int) : void
      {
         mesh.calculateBoundBox();
         var minX:Number = mesh.boundBox.minX * mesh.scaleX;
         var maxX:Number = mesh.boundBox.maxX * mesh.scaleX;
         var minY:Number = mesh.boundBox.minY * mesh.scaleX;
         var maxY:Number = mesh.boundBox.maxY * mesh.scaleX;
         var minZ:Number = mesh.boundBox.minZ * mesh.scaleX;
         var maxZ:Number = mesh.boundBox.maxZ * mesh.scaleX;
         var halfSize:name_194 = new name_194();
         halfSize.x = maxX - minX;
         halfSize.y = maxY - minY;
         halfSize.z = maxZ - minZ;
         halfSize.scale(0.5);
         var collisionBox:name_377 = new name_377(halfSize,collisionGroup,collisionMask);
         collisionBox.transform.setMatrix(mesh.x,mesh.y,mesh.z,mesh.rotationX,mesh.rotationY,mesh.rotationZ);
         var midPoint:name_194 = new name_194(0.5 * (maxX + minX),0.5 * (maxY + minY),0.5 * (maxZ + minZ));
         midPoint.transform4(collisionBox.transform);
         collisionBox.transform.d = midPoint.x;
         collisionBox.transform.h = midPoint.y;
         collisionBox.transform.l = midPoint.z;
         collisionPrimitives.push(collisionBox);
      }
      
      public static function name_645(mesh:name_380, collisionPrimitives:Vector.<name_235>, collisionGroup:int, collisionMask:int) : void
      {
         var i:int = 0;
         var baseIndex:uint = 0;
         var edge:name_194 = null;
         var len:Number = NaN;
         var indices:Vector.<uint> = mesh.geometry.indices;
         var vertexCoordinates:Vector.<Number> = mesh.geometry.method_275(name_126.POSITION);
         var faceVertexIndices:Vector.<uint> = Vector.<uint>([indices[0],indices[1],indices[2]]);
         var edges:Vector.<name_194> = Vector.<name_194>([new name_194(),new name_194(),new name_194()]);
         var lengths:Vector.<Number> = new Vector.<Number>(3);
         var vertices:Vector.<name_194> = new Vector.<name_194>(3);
         for(i = 0; i < 3; i++)
         {
            baseIndex = 3 * faceVertexIndices[i];
            vertices[i] = new name_194(vertexCoordinates[baseIndex],vertexCoordinates[baseIndex + 1],vertexCoordinates[baseIndex + 2]);
         }
         var max:Number = -1;
         var imax:int = 0;
         for(i = 0; i < 3; )
         {
            edge = edges[i];
            edge.method_366(vertices[(i + 1) % 3],vertices[i]);
            len = lengths[i] = edge.length();
            if(len > max)
            {
               max = len;
               imax = i;
            }
            i++;
         }
         var ix:int = (imax + 2) % 3;
         var iy:int = (imax + 1) % 3;
         var xAxis:name_194 = edges[ix];
         var yAxis:name_194 = edges[iy];
         yAxis.reverse();
         var width:Number = lengths[ix];
         var length:Number = lengths[iy];
         var translation:name_194 = vertices[(imax + 2) % 3].clone();
         translation.x += 0.5 * (xAxis.x + yAxis.x);
         translation.y += 0.5 * (xAxis.y + yAxis.y);
         translation.z += 0.5 * (xAxis.z + yAxis.z);
         xAxis.normalize();
         yAxis.normalize();
         var zAxis:name_194 = new name_194().cross2(xAxis,yAxis);
         var collisionRect:name_381 = new name_381(new name_194(width / 2,length / 2,0),collisionGroup,collisionMask);
         var transform:Matrix4 = collisionRect.transform;
         transform.a = xAxis.x;
         transform.e = xAxis.y;
         transform.i = xAxis.z;
         transform.b = yAxis.x;
         transform.f = yAxis.y;
         transform.j = yAxis.z;
         transform.c = zAxis.x;
         transform.g = zAxis.y;
         transform.k = zAxis.z;
         transform.d = translation.x;
         transform.h = translation.y;
         transform.l = translation.z;
         var matrix:Matrix4 = new Matrix4();
         matrix.setMatrix(mesh.x,mesh.y,mesh.z,mesh.rotationX,mesh.rotationY,mesh.rotationZ);
         transform.append(matrix);
         collisionPrimitives.push(collisionRect);
      }
      
      public static function name_644(mesh:name_380, collisionPrimitives:Vector.<name_235>, collisionGroup:int, collisionMask:int) : int
      {
         var numTriangles:int = 0;
         var j:int = 0;
         var vertexBaseIndex:uint = 0;
         var v:name_194 = null;
         var indices:Vector.<uint> = mesh.geometry.indices;
         var vertexCoordinates:Vector.<Number> = mesh.geometry.method_275(name_126.POSITION);
         var vertices:Vector.<name_194> = new Vector.<name_194>(3);
         vertices[0] = new name_194();
         vertices[1] = new name_194();
         vertices[2] = new name_194();
         for(var i:int = 0; i < indices.length; i += 3)
         {
            for(j = 0; j < 3; j++)
            {
               vertexBaseIndex = 3 * indices[i + j];
               v = vertices[j];
               v.x = vertexCoordinates[vertexBaseIndex];
               v.y = vertexCoordinates[vertexBaseIndex + 1];
               v.z = vertexCoordinates[vertexBaseIndex + 2];
               v.scale(mesh.scaleX);
            }
            numTriangles++;
            collisionPrimitives.push(method_813(vertices[0],vertices[1],vertices[2],mesh,collisionGroup,collisionMask));
         }
         return numTriangles;
      }
      
      private static function method_813(v0:name_194, v1:name_194, v2:name_194, parentMesh:name_380, collisionGroup:int, collisionMask:int) : name_378
      {
         var midPoint:name_194 = new name_194();
         midPoint.x = (v0.x + v1.x + v2.x) / 3;
         midPoint.y = (v0.y + v1.y + v2.y) / 3;
         midPoint.z = (v0.z + v1.z + v2.z) / 3;
         var xAxis:name_194 = new name_194();
         xAxis.method_366(v1,v0);
         v1.reset(xAxis.length(),0,0);
         xAxis.normalize();
         var yAxis:name_194 = new name_194();
         yAxis.method_366(v2,v0);
         var x:Number = yAxis.dot(xAxis);
         var y:Number = Number(Math.sqrt(yAxis.method_365() - x * x));
         v2.reset(x,y,0);
         var zAxis:name_194 = new name_194();
         zAxis.cross2(xAxis,yAxis);
         zAxis.normalize();
         yAxis.cross2(zAxis,xAxis);
         yAxis.normalize();
         var transform:Matrix4 = new Matrix4();
         transform.a = xAxis.x;
         transform.e = xAxis.y;
         transform.i = xAxis.z;
         transform.b = yAxis.x;
         transform.f = yAxis.y;
         transform.j = yAxis.z;
         transform.c = zAxis.x;
         transform.g = zAxis.y;
         transform.k = zAxis.z;
         transform.d = midPoint.x;
         transform.h = midPoint.y;
         transform.l = midPoint.z;
         var meshMatrix:Matrix4 = new Matrix4();
         meshMatrix.setMatrix(parentMesh.x,parentMesh.y,parentMesh.z,parentMesh.rotationX,parentMesh.rotationY,parentMesh.rotationZ);
         transform.append(meshMatrix);
         x = (v1.x + v2.x) / 3;
         y = (v1.y + v2.y) / 3;
         v0.reset(-x,-y,0);
         v1.x -= x;
         v1.y -= y;
         v2.x -= x;
         v2.y -= y;
         var collisionTriangle:name_378 = new name_378(v0,v1,v2,collisionGroup,collisionMask);
         collisionTriangle.transform = transform;
         return collisionTriangle;
      }
   }
}

