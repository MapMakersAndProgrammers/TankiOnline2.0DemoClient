package package_19
{
   import alternativa.engine3d.alternativa3d;
   import flash.display3D.Context3DProgramType;
   import flash.geom.Vector3D;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import package_21.name_116;
   import package_21.name_124;
   import package_21.name_126;
   import package_21.name_139;
   import package_21.name_386;
   import package_21.name_78;
   import package_28.name_119;
   import package_28.name_694;
   import package_30.name_114;
   import package_30.name_115;
   import package_30.name_121;
   import package_4.name_127;
   import package_4.name_28;
   
   use namespace alternativa3d;
   
   public class name_509 extends name_78
   {
      alternativa3d static const shaderProgram:name_127 = method_709();
      
      public var thickness:Number = 1;
      
      alternativa3d var var_625:Vector.<Number> = new Vector.<Number>(4,true);
      
      alternativa3d var geometry:name_694;
      
      public function name_509(color:uint = 0, alpha:Number = 1, thickness:Number = 0.5)
      {
         super();
         this.color = color;
         this.alpha = alpha;
         this.thickness = thickness;
         this.alternativa3d::geometry = new name_694();
      }
      
      private static function method_709() : name_127
      {
         var vertexShader:name_121 = new name_121(Context3DProgramType.VERTEX);
         var transform:name_114 = new name_114();
         transform.name_140(["mov t0, a0","mov t0.w, c0.y","m34 t0.xyz, t0, c2","m34 t1.xyz, a1, c2","sub t2, t1.xyz, t0.xyz","slt t5.x, t0.z, c1.z","sub t5.y, c0.y, t5.x","add t4.x, t0.z, c0.z","sub t4.y, t0.z, t1.z","add t4.y, t4.y, c0.w","div t4.z, t4.x, t4.y","mul t4.xyz, t4.zzz, t2.xyz","add t3.xyz, t0.xyz, t4.xyz","mul t0, t0, t5.y","mul t3.xyz, t3.xyz, t5.x","add t0, t0, t3.xyz","sub t2, t1.xyz, t0.xyz","crs t3.xyz, t2, t0","nrm t3.xyz, t3.xyz","mul t3.xyz, t3.xyz, a0.w","mul t3.xyz, t3.xyz, c1.w","mul t4.x, t0.z, c1.x","mul t3.xyz, t3.xyz, t4.xxx","add t0.xyz, t0.xyz, t3.xyz","m44 o0, t0, c5"]);
         transform.name_122(name_115.ATTRIBUTE,0,"pos1");
         transform.name_122(name_115.ATTRIBUTE,1,"pos2");
         transform.name_122(name_115.CONSTANT,0,"ZERO");
         transform.name_122(name_115.CONSTANT,1,"consts");
         transform.name_122(name_115.CONSTANT,2,"worldView",3);
         transform.name_122(name_115.CONSTANT,5,"proj",4);
         vertexShader.name_123(transform);
         vertexShader.name_142();
         var fragmentShader:name_121 = new name_121(Context3DProgramType.FRAGMENT);
         var fp:name_114 = new name_114();
         fp.name_140(["mov o0, c0"]);
         fp.name_122(name_115.CONSTANT,0,"color");
         fragmentShader.name_123(fp);
         fragmentShader.name_142();
         return new name_127(vertexShader,fragmentShader);
      }
      
      public static function method_710(points:Vector.<Vector3D>, color:uint = 0, alpha:Number = 1, thickness:Number = 1) : name_509
      {
         var p0:Vector3D = null;
         var p1:Vector3D = null;
         var result:name_509 = new name_509(color,alpha,thickness);
         var geometry:name_694 = result.alternativa3d::geometry;
         for(var i:uint = 0,var count:uint = points.length - 1; i < count; i += 2)
         {
            p0 = points[i];
            p1 = points[i + 1];
            geometry.alternativa3d::method_558(p0.x,p0.y,p0.z,p1.x,p1.y,p1.z);
         }
         result.calculateBoundBox();
         return result;
      }
      
      public static function method_711(points:Vector.<Vector3D>, color:uint = 0, alpha:Number = 1, thickness:Number = 1) : name_509
      {
         var p0:Vector3D = null;
         var p1:Vector3D = null;
         var result:name_509 = new name_509(color,alpha,thickness);
         var geometry:name_694 = result.alternativa3d::geometry;
         for(var i:uint = 0,var count:uint = points.length - 1; i < count; i++)
         {
            p0 = points[i];
            p1 = points[i + 1];
            geometry.alternativa3d::method_558(p0.x,p0.y,p0.z,p1.x,p1.y,p1.z);
         }
         result.calculateBoundBox();
         return result;
      }
      
      public static function name_511(mesh:name_380, color:uint = 0, alpha:Number = 1, thickness:Number = 1) : name_509
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
         var result:name_509 = new name_509(color,alpha,thickness);
         var geometry:name_119 = mesh.geometry;
         var resultGeometry:name_694 = result.alternativa3d::geometry;
         var edges:Dictionary = new Dictionary();
         var indices:Vector.<uint> = geometry.indices;
         var vertices:Vector.<Number> = geometry.method_275(name_126.POSITION);
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
            if(method_708(edges,v1x,v1y,v1z,v2x,v2y,v2z))
            {
               resultGeometry.alternativa3d::method_558(v1x,v1y,v1z,v2x,v2y,v2z);
            }
            if(method_708(edges,v2x,v2y,v2z,v3x,v3y,v3z))
            {
               resultGeometry.alternativa3d::method_558(v2x,v2y,v2z,v3x,v3y,v3z);
            }
            if(method_708(edges,v1x,v1y,v1z,v3x,v3y,v3z))
            {
               resultGeometry.alternativa3d::method_558(v1x,v1y,v1z,v3x,v3y,v3z);
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
      
      private static function method_708(edges:Dictionary, v1x:Number, v1y:Number, v1z:Number, v2x:Number, v2y:Number, v2z:Number) : Boolean
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
      
      override alternativa3d function updateBoundBox(boundBox:name_386, hierarchy:Boolean, transform:name_139 = null) : void
      {
         super.alternativa3d::updateBoundBox(boundBox,hierarchy,transform);
         if(this.alternativa3d::geometry != null)
         {
            this.alternativa3d::geometry.alternativa3d::updateBoundBox(boundBox,transform);
         }
      }
      
      override alternativa3d function collectDraws(camera:name_124, lights:Vector.<name_116>, lightsLength:int) : void
      {
         this.alternativa3d::geometry.alternativa3d::name_695(camera,this.alternativa3d::var_625,this.thickness,this,alternativa3d::shaderProgram);
      }
      
      override alternativa3d function fillResources(resources:Dictionary, hierarchy:Boolean = false, resourceType:Class = null) : void
      {
         super.alternativa3d::fillResources(resources,hierarchy,resourceType);
         if(name_28.alternativa3d::name_131(getDefinitionByName(getQualifiedClassName(this.alternativa3d::geometry)) as Class,resourceType))
         {
            resources[this.alternativa3d::geometry] = true;
         }
      }
   }
}

