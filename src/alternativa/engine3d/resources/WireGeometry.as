package alternativa.engine3d.resources
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.BoundBox;
   import alternativa.engine3d.core.Camera3D;
   import alternativa.engine3d.core.DrawUnit;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.RenderPriority;
   import alternativa.engine3d.core.Resource;
   import alternativa.engine3d.core.Transform3D;
   import alternativa.engine3d.materials.ShaderProgram;
   import flash.display3D.Context3D;
   import flash.display3D.Context3DBlendFactor;
   import flash.display3D.Context3DVertexBufferFormat;
   import flash.display3D.IndexBuffer3D;
   import flash.display3D.VertexBuffer3D;
   
   use namespace alternativa3d;
   
   public class WireGeometry extends Resource
   {
      private const name_VA:uint = 65500;
      
      private const name_Pp:Number = 2 * Math.tan(Math.PI / 6);
      
      private const name_SS:uint = 7;
      
      alternativa3d var vertexBuffers:Vector.<VertexBuffer3D>;
      
      alternativa3d var indexBuffers:Vector.<IndexBuffer3D>;
      
      private var name_Rz:Vector.<int>;
      
      private var vertices:Vector.<Vector.<Number>>;
      
      private var indices:Vector.<Vector.<uint>>;
      
      private var name_ix:int = 0;
      
      private var name_dP:uint = 0;
      
      public function WireGeometry()
      {
         super();
         this.alternativa3d::vertexBuffers = new Vector.<VertexBuffer3D>(1);
         this.alternativa3d::indexBuffers = new Vector.<IndexBuffer3D>(1);
         this.clear();
      }
      
      override public function upload(context3D:Context3D) : void
      {
         var verts:Vector.<Number> = null;
         var inds:Vector.<uint> = null;
         var vBuffer:VertexBuffer3D = null;
         var iBuffer:IndexBuffer3D = null;
         for(var i:int = 0; i <= this.name_ix; )
         {
            if(this.alternativa3d::vertexBuffers[i] != null)
            {
               this.alternativa3d::vertexBuffers[i].dispose();
            }
            if(this.alternativa3d::indexBuffers[i] != null)
            {
               this.alternativa3d::indexBuffers[i].dispose();
            }
            if(this.name_Rz[i] > 0)
            {
               verts = this.vertices[i];
               inds = this.indices[i];
               vBuffer = this.alternativa3d::vertexBuffers[i] = context3D.createVertexBuffer(verts.length / this.name_SS,this.name_SS);
               vBuffer.uploadFromVector(verts,0,verts.length / this.name_SS);
               iBuffer = this.alternativa3d::indexBuffers[i] = context3D.createIndexBuffer(inds.length);
               iBuffer.uploadFromVector(inds,0,inds.length);
            }
            i++;
         }
      }
      
      override public function dispose() : void
      {
         for(var i:int = 0; i <= this.name_ix; )
         {
            if(this.alternativa3d::vertexBuffers[i] != null)
            {
               this.alternativa3d::vertexBuffers[i].dispose();
               this.alternativa3d::vertexBuffers[i] = null;
            }
            if(this.alternativa3d::indexBuffers[i] != null)
            {
               this.alternativa3d::indexBuffers[i].dispose();
               this.alternativa3d::indexBuffers[i] = null;
            }
            i++;
         }
      }
      
      override public function get isUploaded() : Boolean
      {
         for(var i:int = 0; i <= this.name_ix; )
         {
            if(this.alternativa3d::vertexBuffers[i] == null)
            {
               return false;
            }
            if(this.alternativa3d::indexBuffers[i] == null)
            {
               return false;
            }
            i++;
         }
         return true;
      }
      
      public function clear() : void
      {
         this.dispose();
         this.vertices = new Vector.<Vector.<Number>>();
         this.indices = new Vector.<Vector.<uint>>();
         this.vertices[0] = new Vector.<Number>();
         this.indices[0] = new Vector.<uint>();
         this.name_Rz = new Vector.<int>(1);
         this.name_dP = 0;
      }
      
      alternativa3d function updateBoundBox(boundBox:BoundBox, transform:Transform3D = null) : void
      {
         var j:int = 0;
         var vcount:int = 0;
         var verts:Vector.<Number> = null;
         var vx:Number = NaN;
         var vy:Number = NaN;
         var vz:Number = NaN;
         var x:Number = NaN;
         var y:Number = NaN;
         var z:Number = NaN;
         for(var i:int = 0, count:int = int(this.vertices.length); i < count; i++)
         {
            for(j = 0,vcount = int(this.vertices[i].length); j < vcount; )
            {
               verts = this.vertices[i];
               vx = verts[j];
               vy = verts[int(j + 1)];
               vz = verts[int(j + 2)];
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
               j += this.name_SS;
            }
         }
      }
      
      alternativa3d function getDrawUnits(camera:Camera3D, color:Vector.<Number>, thickness:Number, object:Object3D, shader:ShaderProgram) : void
      {
         var iBuffer:IndexBuffer3D = null;
         var vBuffer:VertexBuffer3D = null;
         var drawUnit:DrawUnit = null;
         if(shader.program == null)
         {
            shader.upload(camera.alternativa3d::context3D);
         }
         for(var i:int = 0; i <= this.name_ix; )
         {
            iBuffer = this.alternativa3d::indexBuffers[i];
            vBuffer = this.alternativa3d::vertexBuffers[i];
            if(iBuffer != null && vBuffer != null)
            {
               drawUnit = camera.alternativa3d::renderer.alternativa3d::createDrawUnit(object,shader.program,iBuffer,0,this.name_Rz[i],shader);
               drawUnit.alternativa3d::setVertexBufferAt(0,vBuffer,0,Context3DVertexBufferFormat.FLOAT_4);
               drawUnit.alternativa3d::setVertexBufferAt(1,vBuffer,4,Context3DVertexBufferFormat.FLOAT_3);
               drawUnit.alternativa3d::setVertexConstantsFromNumbers(0,0,1,-1,0.000001);
               drawUnit.alternativa3d::setVertexConstantsFromNumbers(1,-this.name_Pp / camera.view.alternativa3d::_height,0,camera.nearClipping,thickness);
               drawUnit.alternativa3d::setVertexConstantsFromTransform(2,object.alternativa3d::localToCameraTransform);
               drawUnit.alternativa3d::setProjectionConstants(camera,5);
               drawUnit.alternativa3d::setFragmentConstantsFromNumbers(0,color[0],color[1],color[2],color[3]);
               if(color[3] < 1)
               {
                  drawUnit.alternativa3d::blendSource = Context3DBlendFactor.SOURCE_ALPHA;
                  drawUnit.alternativa3d::blendDestination = Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA;
                  camera.alternativa3d::renderer.alternativa3d::addDrawUnit(drawUnit,RenderPriority.TRANSPARENT_SORT);
               }
               else
               {
                  camera.alternativa3d::renderer.alternativa3d::addDrawUnit(drawUnit,RenderPriority.OPAQUE);
               }
            }
            i++;
         }
      }
      
      alternativa3d function addLine(v1x:Number, v1y:Number, v1z:Number, v2x:Number, v2y:Number, v2z:Number) : void
      {
         var currentVertices:Vector.<Number> = this.vertices[this.name_ix];
         var currentIndices:Vector.<uint> = this.indices[this.name_ix];
         var verticesCount:uint = currentVertices.length / this.name_SS;
         if(verticesCount > this.name_VA - 4)
         {
            this.name_dP = 0;
            ++this.name_ix;
            this.name_Rz[this.name_ix] = 0;
            currentVertices = this.vertices[this.name_ix] = new Vector.<Number>();
            currentIndices = this.indices[this.name_ix] = new Vector.<uint>();
            this.alternativa3d::vertexBuffers.length = this.name_ix + 1;
            this.alternativa3d::indexBuffers.length = this.name_ix + 1;
         }
         else
         {
            this.name_Rz[this.name_ix] += 2;
         }
         currentVertices.push(v1x,v1y,v1z,0.5,v2x,v2y,v2z,v2x,v2y,v2z,-0.5,v1x,v1y,v1z,v1x,v1y,v1z,-0.5,v2x,v2y,v2z,v2x,v2y,v2z,0.5,v1x,v1y,v1z);
         currentIndices.push(this.name_dP,this.name_dP + 1,this.name_dP + 2,this.name_dP + 3,this.name_dP + 2,this.name_dP + 1);
         this.name_dP += 4;
      }
   }
}

