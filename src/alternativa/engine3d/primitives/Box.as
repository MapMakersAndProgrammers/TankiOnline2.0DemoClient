package alternativa.engine3d.primitives
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.BoundBox;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.VertexAttributes;
   import alternativa.engine3d.materials.Material;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.engine3d.resources.Geometry;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   use namespace alternativa3d;
   
   public class Box extends Mesh
   {
      public function Box(width:Number = 100, length:Number = 100, height:Number = 100, widthSegments:uint = 1, lengthSegments:uint = 1, heightSegments:uint = 1, reverse:Boolean = false, material:Material = null)
      {
         var x:int = 0;
         var y:int = 0;
         var z:int = 0;
         var halfHeight:Number = NaN;
         super();
         if(widthSegments <= 0 || lengthSegments <= 0 || heightSegments <= 0)
         {
            return;
         }
         var indices:Vector.<uint> = new Vector.<uint>();
         var wp:int = widthSegments + 1;
         var lp:int = lengthSegments + 1;
         var hp:int = heightSegments + 1;
         var halfWidth:Number = width * 0.5;
         var halfLength:Number = length * 0.5;
         halfHeight = height * 0.5;
         var wd:Number = 1 / widthSegments;
         var ld:Number = 1 / lengthSegments;
         var hd:Number = 1 / heightSegments;
         var ws:Number = width / widthSegments;
         var ls:Number = length / lengthSegments;
         var hs:Number = height / heightSegments;
         var vertices:ByteArray = new ByteArray();
         vertices.endian = Endian.LITTLE_ENDIAN;
         var offset:uint = 0;
         for(x = 0; x < wp; x++)
         {
            for(y = 0; y < lp; y++)
            {
               vertices.writeFloat(x * ws - halfWidth);
               vertices.writeFloat(y * ls - halfLength);
               vertices.writeFloat(-halfHeight);
               vertices.writeFloat((widthSegments - x) * wd);
               vertices.writeFloat((lengthSegments - y) * ld);
               vertices.length = vertices.position = vertices.position + 28;
            }
         }
         offset = uint(vertices.position);
         for(x = 0; x < wp; x++)
         {
            for(y = 0; y < lp; )
            {
               if(x < widthSegments && y < lengthSegments)
               {
                  this.createFace(indices,vertices,(x + 1) * lp + y + 1,(x + 1) * lp + y,x * lp + y,x * lp + y + 1,0,0,-1,halfHeight,0,-1,0,0,reverse);
               }
               y++;
            }
         }
         vertices.position = offset;
         var o:uint = uint(wp * lp);
         for(x = 0; x < wp; x++)
         {
            for(y = 0; y < lp; y++)
            {
               vertices.writeFloat(x * ws - halfWidth);
               vertices.writeFloat(y * ls - halfLength);
               vertices.writeFloat(halfHeight);
               vertices.writeFloat(x * wd);
               vertices.writeFloat((lengthSegments - y) * ld);
               vertices.length = vertices.position = vertices.position + 28;
            }
         }
         offset = uint(vertices.position);
         for(x = 0; x < wp; x++)
         {
            for(y = 0; y < lp; )
            {
               if(x < widthSegments && y < lengthSegments)
               {
                  this.createFace(indices,vertices,o + x * lp + y,o + (x + 1) * lp + y,o + (x + 1) * lp + y + 1,o + x * lp + y + 1,0,0,1,halfHeight,0,-1,0,0,reverse);
               }
               y++;
            }
         }
         vertices.position = offset;
         o += wp * lp;
         for(x = 0; x < wp; x++)
         {
            for(z = 0; z < hp; z++)
            {
               vertices.writeFloat(x * ws - halfWidth);
               vertices.writeFloat(-halfLength);
               vertices.writeFloat(z * hs - halfHeight);
               vertices.writeFloat(x * wd);
               vertices.writeFloat((heightSegments - z) * hd);
               vertices.length = vertices.position = vertices.position + 28;
            }
         }
         offset = uint(vertices.position);
         for(x = 0; x < wp; x++)
         {
            for(z = 0; z < hp; )
            {
               if(x < widthSegments && z < heightSegments)
               {
                  this.createFace(indices,vertices,o + x * hp + z,o + (x + 1) * hp + z,o + (x + 1) * hp + z + 1,o + x * hp + z + 1,0,-1,0,halfLength,0,0,-1,0,reverse);
               }
               z++;
            }
         }
         vertices.position = offset;
         o += wp * hp;
         for(x = 0; x < wp; x++)
         {
            for(z = 0; z < hp; z++)
            {
               vertices.writeFloat(x * ws - halfWidth);
               vertices.writeFloat(halfLength);
               vertices.writeFloat(z * hs - halfHeight);
               vertices.writeFloat((widthSegments - x) * wd);
               vertices.writeFloat((heightSegments - z) * hd);
               vertices.length = vertices.position = vertices.position + 28;
            }
         }
         offset = uint(vertices.position);
         for(x = 0; x < wp; x++)
         {
            for(z = 0; z < hp; )
            {
               if(x < widthSegments && z < heightSegments)
               {
                  this.createFace(indices,vertices,o + x * hp + z,o + x * hp + z + 1,o + (x + 1) * hp + z + 1,o + (x + 1) * hp + z,0,1,0,halfLength,0,0,-1,0,reverse);
               }
               z++;
            }
         }
         vertices.position = offset;
         o += wp * hp;
         for(y = 0; y < lp; y++)
         {
            for(z = 0; z < hp; z++)
            {
               vertices.writeFloat(-halfWidth);
               vertices.writeFloat(y * ls - halfLength);
               vertices.writeFloat(z * hs - halfHeight);
               vertices.writeFloat((lengthSegments - y) * ld);
               vertices.writeFloat((heightSegments - z) * hd);
               vertices.length = vertices.position = vertices.position + 28;
            }
         }
         offset = uint(vertices.position);
         for(y = 0; y < lp; y++)
         {
            for(z = 0; z < hp; )
            {
               if(y < lengthSegments && z < heightSegments)
               {
                  this.createFace(indices,vertices,o + y * hp + z,o + y * hp + z + 1,o + (y + 1) * hp + z + 1,o + (y + 1) * hp + z,-1,0,0,halfWidth,0,0,-1,0,reverse);
               }
               z++;
            }
         }
         vertices.position = offset;
         o += lp * hp;
         for(y = 0; y < lp; y++)
         {
            for(z = 0; z < hp; z++)
            {
               vertices.writeFloat(halfWidth);
               vertices.writeFloat(y * ls - halfLength);
               vertices.writeFloat(z * hs - halfHeight);
               vertices.writeFloat(y * ld);
               vertices.writeFloat((heightSegments - z) * hd);
               vertices.length = vertices.position = vertices.position + 28;
            }
         }
         for(y = 0; y < lp; y++)
         {
            for(z = 0; z < hp; )
            {
               if(y < lengthSegments && z < heightSegments)
               {
                  this.createFace(indices,vertices,o + y * hp + z,o + (y + 1) * hp + z,o + (y + 1) * hp + z + 1,o + y * hp + z + 1,1,0,0,halfWidth,0,0,-1,0,reverse);
               }
               z++;
            }
         }
         geometry = new Geometry();
         geometry.alternativa3d::_indices = indices;
         var attributes:Array = new Array();
         attributes[0] = VertexAttributes.POSITION;
         attributes[1] = VertexAttributes.POSITION;
         attributes[2] = VertexAttributes.POSITION;
         attributes[3] = VertexAttributes.TEXCOORDS[0];
         attributes[4] = VertexAttributes.TEXCOORDS[0];
         attributes[5] = VertexAttributes.NORMAL;
         attributes[6] = VertexAttributes.NORMAL;
         attributes[7] = VertexAttributes.NORMAL;
         attributes[8] = VertexAttributes.TANGENT4;
         attributes[9] = VertexAttributes.TANGENT4;
         attributes[10] = VertexAttributes.TANGENT4;
         attributes[11] = VertexAttributes.TANGENT4;
         geometry.addVertexStream(attributes);
         geometry.alternativa3d::_vertexStreams[0].data = vertices;
         geometry.alternativa3d::_numVertices = vertices.length / 48;
         addSurface(material,0,indices.length / 3);
         boundBox = new BoundBox();
         boundBox.minX = -halfWidth;
         boundBox.minY = -halfLength;
         boundBox.minZ = -halfHeight;
         boundBox.maxX = halfWidth;
         boundBox.maxY = halfLength;
         boundBox.maxZ = halfHeight;
      }
      
      private function createFace(indices:Vector.<uint>, vertices:ByteArray, a:int, b:int, c:int, d:int, nx:Number, ny:Number, nz:Number, no:Number, tx:Number, ty:Number, tz:Number, tw:Number, reverse:Boolean) : void
      {
         var v:int = 0;
         if(reverse)
         {
            nx = -nx;
            ny = -ny;
            nz = -nz;
            no = -no;
            v = a;
            a = d;
            d = v;
            v = b;
            b = c;
            c = v;
         }
         indices.push(a);
         indices.push(b);
         indices.push(c);
         indices.push(a);
         indices.push(c);
         indices.push(d);
         vertices.position = a * 48 + 20;
         vertices.writeFloat(nx);
         vertices.writeFloat(ny);
         vertices.writeFloat(nz);
         vertices.writeFloat(tx);
         vertices.writeFloat(ty);
         vertices.writeFloat(tz);
         vertices.writeFloat(tw);
         vertices.position = b * 48 + 20;
         vertices.writeFloat(nx);
         vertices.writeFloat(ny);
         vertices.writeFloat(nz);
         vertices.writeFloat(tx);
         vertices.writeFloat(ty);
         vertices.writeFloat(tz);
         vertices.writeFloat(tw);
         vertices.position = c * 48 + 20;
         vertices.writeFloat(nx);
         vertices.writeFloat(ny);
         vertices.writeFloat(nz);
         vertices.writeFloat(tx);
         vertices.writeFloat(ty);
         vertices.writeFloat(tz);
         vertices.writeFloat(tw);
         vertices.position = d * 48 + 20;
         vertices.writeFloat(nx);
         vertices.writeFloat(ny);
         vertices.writeFloat(nz);
         vertices.writeFloat(tx);
         vertices.writeFloat(ty);
         vertices.writeFloat(tz);
         vertices.writeFloat(tw);
      }
      
      override public function clone() : Object3D
      {
         var res:Box = new Box(0,0,0,0,0,0);
         res.clonePropertiesFrom(this);
         return res;
      }
   }
}

