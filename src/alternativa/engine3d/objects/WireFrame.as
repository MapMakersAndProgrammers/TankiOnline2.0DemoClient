package alternativa.engine3d.objects
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.BoundBox;
   import alternativa.engine3d.core.Camera3D;
   import alternativa.engine3d.core.Light3D;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.Transform3D;
   import alternativa.engine3d.core.VertexAttributes;
   import alternativa.engine3d.materials.A3DUtils;
   import alternativa.engine3d.materials.ShaderProgram;
   import alternativa.engine3d.materials.compiler.Linker;
   import alternativa.engine3d.materials.compiler.Procedure;
   import alternativa.engine3d.materials.compiler.VariableType;
   import alternativa.engine3d.resources.Geometry;
   import alternativa.engine3d.resources.WireGeometry;
   import flash.display3D.Context3DProgramType;
   import flash.geom.Vector3D;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   use namespace alternativa3d;
   
   public class WireFrame extends Object3D
   {
      alternativa3d static const shaderProgram:ShaderProgram = initProgram();
      
      public var thickness:Number = 1;
      
      alternativa3d var var_625:Vector.<Number> = new Vector.<Number>(4,true);
      
      alternativa3d var geometry:WireGeometry;
      
      public function WireFrame(color:uint = 0, alpha:Number = 1, thickness:Number = 0.5)
      {
         super();
         this.color = color;
         this.alpha = alpha;
         this.thickness = thickness;
         this.alternativa3d::geometry = new WireGeometry();
      }
      
      private static function initProgram() : ShaderProgram
      {
         var vertexShader:Linker = new Linker(Context3DProgramType.VERTEX);
         var transform:Procedure = new Procedure();
         transform.compileFromArray(["mov t0, a0","mov t0.w, c0.y","m34 t0.xyz, t0, c2","m34 t1.xyz, a1, c2","sub t2, t1.xyz, t0.xyz","slt t5.x, t0.z, c1.z","sub t5.y, c0.y, t5.x","add t4.x, t0.z, c0.z","sub t4.y, t0.z, t1.z","add t4.y, t4.y, c0.w","div t4.z, t4.x, t4.y","mul t4.xyz, t4.zzz, t2.xyz","add t3.xyz, t0.xyz, t4.xyz","mul t0, t0, t5.y","mul t3.xyz, t3.xyz, t5.x","add t0, t0, t3.xyz","sub t2, t1.xyz, t0.xyz","crs t3.xyz, t2, t0","nrm t3.xyz, t3.xyz","mul t3.xyz, t3.xyz, a0.w","mul t3.xyz, t3.xyz, c1.w","mul t4.x, t0.z, c1.x","mul t3.xyz, t3.xyz, t4.xxx","add t0.xyz, t0.xyz, t3.xyz","m44 o0, t0, c5"]);
         transform.assignVariableName(VariableType.ATTRIBUTE,0,"pos1");
         transform.assignVariableName(VariableType.ATTRIBUTE,1,"pos2");
         transform.assignVariableName(VariableType.CONSTANT,0,"ZERO");
         transform.assignVariableName(VariableType.CONSTANT,1,"consts");
         transform.assignVariableName(VariableType.CONSTANT,2,"worldView",3);
         transform.assignVariableName(VariableType.CONSTANT,5,"proj",4);
         vertexShader.addProcedure(transform);
         vertexShader.link();
         var fragmentShader:Linker = new Linker(Context3DProgramType.FRAGMENT);
         var fp:Procedure = new Procedure();
         fp.compileFromArray(["mov o0, c0"]);
         fp.assignVariableName(VariableType.CONSTANT,0,"color");
         fragmentShader.addProcedure(fp);
         fragmentShader.link();
         return new ShaderProgram(vertexShader,fragmentShader);
      }
      
      public static function createLinesList(points:Vector.<Vector3D>, color:uint = 0, alpha:Number = 1, thickness:Number = 1) : WireFrame
      {
         var p0:Vector3D = null;
         var p1:Vector3D = null;
         var result:WireFrame = new WireFrame(color,alpha,thickness);
         var geometry:WireGeometry = result.alternativa3d::geometry;
         for(var i:uint = 0,var count:uint = points.length - 1; i < count; i += 2)
         {
            p0 = points[i];
            p1 = points[i + 1];
            geometry.alternativa3d::addLine(p0.x,p0.y,p0.z,p1.x,p1.y,p1.z);
         }
         result.calculateBoundBox();
         return result;
      }
      
      public static function createLineStrip(points:Vector.<Vector3D>, color:uint = 0, alpha:Number = 1, thickness:Number = 1) : WireFrame
      {
         var p0:Vector3D = null;
         var p1:Vector3D = null;
         var result:WireFrame = new WireFrame(color,alpha,thickness);
         var geometry:WireGeometry = result.alternativa3d::geometry;
         for(var i:uint = 0,var count:uint = points.length - 1; i < count; i++)
         {
            p0 = points[i];
            p1 = points[i + 1];
            geometry.alternativa3d::addLine(p0.x,p0.y,p0.z,p1.x,p1.y,p1.z);
         }
         result.calculateBoundBox();
         return result;
      }
      
      public static function createEdges(mesh:Mesh, color:uint = 0, alpha:Number = 1, thickness:Number = 1) : WireFrame
      {
         var index:uint = 0;
         var v1x:Number = NaN;
         var v1y:Number = NaN;
         var v1z:Number = NaN;
         var v2x:Number = NaN;
         var v2y:Number = NaN;
         var v2z:Number = NaN;
         var v3x:Number = NaN;
         var v3y:Number = NaN;
         var v3z:Number = NaN;
         var result:WireFrame = new WireFrame(color,alpha,thickness);
         var geometry:Geometry = mesh.geometry;
         var resultGeometry:WireGeometry = result.alternativa3d::geometry;
         var edges:Dictionary = new Dictionary();
         var indices:Vector.<uint> = geometry.indices;
         var vertices:Vector.<Number> = geometry.getAttributeValues(VertexAttributes.POSITION);
         for(var i:int = 0,var count:int = int(indices.length); i < count; )
         {
            index = indices[i] * 3;
            v1x = vertices[index];
            index++;
            v1y = vertices[index];
            index++;
            v1z = vertices[index];
            index = indices[int(i + 1)] * 3;
            v2x = vertices[index];
            index++;
            v2y = vertices[index];
            index++;
            v2z = vertices[index];
            index = indices[int(i + 2)] * 3;
            v3x = vertices[index];
            index++;
            v3y = vertices[index];
            index++;
            v3z = vertices[index];
            if(checkEdge(edges,v1x,v1y,v1z,v2x,v2y,v2z))
            {
               resultGeometry.alternativa3d::addLine(v1x,v1y,v1z,v2x,v2y,v2z);
            }
            if(checkEdge(edges,v2x,v2y,v2z,v3x,v3y,v3z))
            {
               resultGeometry.alternativa3d::addLine(v2x,v2y,v2z,v3x,v3y,v3z);
            }
            if(checkEdge(edges,v1x,v1y,v1z,v3x,v3y,v3z))
            {
               resultGeometry.alternativa3d::addLine(v1x,v1y,v1z,v3x,v3y,v3z);
            }
            i += 3;
         }
         result.calculateBoundBox();
         result.alternativa3d::_x = mesh.alternativa3d::_x;
         result.alternativa3d::_y = mesh.alternativa3d::_y;
         result.alternativa3d::_z = mesh.alternativa3d::_z;
         result.alternativa3d::_rotationX = mesh.alternativa3d::_rotationX;
         result.alternativa3d::_rotationY = mesh.alternativa3d::_rotationY;
         result.alternativa3d::_rotationZ = mesh.alternativa3d::_rotationZ;
         result.alternativa3d::_scaleX = mesh.alternativa3d::_scaleX;
         result.alternativa3d::_scaleY = mesh.alternativa3d::_scaleY;
         result.alternativa3d::_scaleZ = mesh.alternativa3d::_scaleZ;
         return result;
      }
      
      private static function checkEdge(edges:Dictionary, v1x:Number, v1y:Number, v1z:Number, v2x:Number, v2y:Number, v2z:Number) : Boolean
      {
         var str:String = null;
         if(v1x * v1x + v1y * v1y + v1z * v1z < v2x * v2x + v2y * v2y + v2z * v2z)
         {
            str = v1x.toString() + v1y.toString() + v1z.toString() + v2x.toString() + v2y.toString() + v2z.toString();
         }
         else
         {
            str = v2x.toString() + v2y.toString() + v2z.toString() + v1x.toString() + v1y.toString() + v1z.toString();
         }
         if(Boolean(edges[str]))
         {
            return false;
         }
         edges[str] = true;
         return true;
      }
      
      public function get alpha() : Number
      {
         return this.alternativa3d::var_625[3];
      }
      
      public function set alpha(value:Number) : void
      {
         this.alternativa3d::var_625[3] = value;
      }
      
      public function get color() : uint
      {
         return this.alternativa3d::var_625[0] * 255 << 16 | this.alternativa3d::var_625[1] * 255 << 8 | this.alternativa3d::var_625[2] * 255;
      }
      
      public function set color(value:uint) : void
      {
         this.alternativa3d::var_625[0] = (value >> 16 & 0xFF) / 255;
         this.alternativa3d::var_625[1] = (value >> 8 & 0xFF) / 255;
         this.alternativa3d::var_625[2] = (value & 0xFF) / 255;
      }
      
      override alternativa3d function updateBoundBox(boundBox:BoundBox, hierarchy:Boolean, transform:Transform3D = null) : void
      {
         super.alternativa3d::updateBoundBox(boundBox,hierarchy,transform);
         if(this.alternativa3d::geometry != null)
         {
            this.alternativa3d::geometry.alternativa3d::updateBoundBox(boundBox,transform);
         }
      }
      
      override alternativa3d function collectDraws(camera:Camera3D, lights:Vector.<Light3D>, lightsLength:int) : void
      {
         this.alternativa3d::geometry.alternativa3d::getDrawUnits(camera,this.alternativa3d::var_625,this.thickness,this,alternativa3d::shaderProgram);
      }
      
      override alternativa3d function fillResources(resources:Dictionary, hierarchy:Boolean = false, resourceType:Class = null) : void
      {
         super.alternativa3d::fillResources(resources,hierarchy,resourceType);
         if(A3DUtils.alternativa3d::checkParent(getDefinitionByName(getQualifiedClassName(this.alternativa3d::geometry)) as Class,resourceType))
         {
            resources[this.alternativa3d::geometry] = true;
         }
      }
   }
}

