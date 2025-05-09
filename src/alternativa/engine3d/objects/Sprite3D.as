package alternativa.engine3d.objects
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.BoundBox;
   import alternativa.engine3d.core.Camera3D;
   import alternativa.engine3d.core.Debug;
   import alternativa.engine3d.core.DrawUnit;
   import alternativa.engine3d.core.Light3D;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.RenderPriority;
   import alternativa.engine3d.core.Transform3D;
   import alternativa.engine3d.core.VertexAttributes;
   import alternativa.engine3d.materials.Material;
   import alternativa.engine3d.materials.compiler.Linker;
   import alternativa.engine3d.materials.compiler.Procedure;
   import alternativa.engine3d.resources.Geometry;
   import flash.display3D.Context3D;
   import flash.utils.Dictionary;
   
   use namespace alternativa3d;
   
   public class Sprite3D extends Object3D
   {
      private static const geometries:Dictionary = new Dictionary();
      
      private static var transformProcedureStatic:Procedure = new Procedure(["sub t0.z, i0.x, c3.x","sub t0.w, i0.y, c3.y","mul t0.z, t0.z, c3.z","mul t0.w, t0.w, c3.w","mov t1.z, c4.w","sin t1.x, t1.z","cos t1.y, t1.z","mul t1.z, t0.z, t1.y","mul t1.w, t0.w, t1.x","sub t0.x, t1.z, t1.w","mul t1.z, t0.z, t1.x","mul t1.w, t0.w, t1.y","add t0.y, t1.z, t1.w","add t0.x, t0.x, c4.x","add t0.y, t0.y, c4.y","add t0.z, i0.z, c4.z","mov t0.w, i0.w","dp4 o0.x, t0, c0","dp4 o0.y, t0, c1","dp4 o0.z, t0, c2","mov o0.w, t0.w","#c0=trans1","#c1=trans2","#c2=trans3","#c3=size","#c4=coords"]);
      
      private static var deltaTransformProcedureStatic:Procedure = new Procedure(["mov t1.z, c4.w","sin t1.x, t1.z","cos t1.y, t1.z","mul t1.z, i0.x, t1.y","mul t1.w, i0.y, t1.x","sub t0.x, t1.z, t1.w","mul t1.z, i0.x, t1.x","mul t1.w, i0.y, t1.y","add t0.y, t1.z, t1.w","mov t0.z, i0.z","mov t0.w, i0.w","dp3 o0.x, t0, c0","dp3 o0.y, t0, c1","dp3 o0.z, t0, c2","#c0=trans1","#c1=trans2","#c2=trans3","#c3=size","#c4=coords"]);
      
      public var originX:Number = 0.5;
      
      public var originY:Number = 0.5;
      
      public var rotation:Number = 0;
      
      public var width:Number;
      
      public var height:Number;
      
      public var perspectiveScale:Boolean = true;
      
      public var alwaysOnTop:Boolean = false;
      
      alternativa3d var surface:Surface;
      
      public function Sprite3D(width:Number, height:Number, material:Material = null)
      {
         super();
         this.width = width;
         this.height = height;
         this.alternativa3d::surface = new Surface();
         this.alternativa3d::surface.alternativa3d::object = this;
         this.material = material;
         this.alternativa3d::surface.indexBegin = 0;
         this.alternativa3d::surface.numTriangles = 2;
         alternativa3d::transformProcedure = transformProcedureStatic;
         alternativa3d::deltaTransformProcedure = deltaTransformProcedureStatic;
      }
      
      public function get material() : Material
      {
         return this.alternativa3d::surface.material;
      }
      
      public function set material(value:Material) : void
      {
         this.alternativa3d::surface.material = value;
      }
      
      override alternativa3d function fillResources(resources:Dictionary, hierarchy:Boolean = false, resourceType:Class = null) : void
      {
         if(this.alternativa3d::surface.material != null)
         {
            this.alternativa3d::surface.material.alternativa3d::fillResources(resources,resourceType);
         }
         super.alternativa3d::fillResources(resources,hierarchy,resourceType);
      }
      
      override alternativa3d function collectDraws(camera:Camera3D, lights:Vector.<Light3D>, lightsLength:int) : void
      {
         var debug:int = 0;
         var geometry:Geometry = this.alternativa3d::getGeometry(camera.alternativa3d::context3D);
         if(this.alternativa3d::surface.material != null)
         {
            this.alternativa3d::surface.material.alternativa3d::collectDraws(camera,this.alternativa3d::surface,geometry,lights,lightsLength,this.alwaysOnTop ? RenderPriority.NEXT_LAYER : -1);
         }
         if(alternativa3d::listening)
         {
            camera.view.alternativa3d::addSurfaceToMouseEvents(this.alternativa3d::surface,geometry,alternativa3d::transformProcedure);
         }
         if(camera.debug)
         {
            debug = int(camera.alternativa3d::checkInDebug(this));
            if(Boolean(debug & Debug.BOUNDS) && boundBox != null)
            {
               Debug.alternativa3d::drawBoundBox(camera,boundBox,alternativa3d::localToCameraTransform);
            }
         }
      }
      
      override alternativa3d function setTransformConstants(drawUnit:DrawUnit, surface:Surface, vertexShader:Linker, camera:Camera3D) : void
      {
         var scale:Number = Number(Math.sqrt(alternativa3d::localToCameraTransform.a * alternativa3d::localToCameraTransform.a + alternativa3d::localToCameraTransform.e * alternativa3d::localToCameraTransform.e + alternativa3d::localToCameraTransform.i * alternativa3d::localToCameraTransform.i));
         scale += Math.sqrt(alternativa3d::localToCameraTransform.b * alternativa3d::localToCameraTransform.b + alternativa3d::localToCameraTransform.f * alternativa3d::localToCameraTransform.f + alternativa3d::localToCameraTransform.j * alternativa3d::localToCameraTransform.j);
         scale += Math.sqrt(alternativa3d::localToCameraTransform.c * alternativa3d::localToCameraTransform.c + alternativa3d::localToCameraTransform.g * alternativa3d::localToCameraTransform.g + alternativa3d::localToCameraTransform.k * alternativa3d::localToCameraTransform.k);
         scale /= 3;
         if(!this.perspectiveScale && !camera.orthographic)
         {
            scale *= alternativa3d::localToCameraTransform.l / camera.alternativa3d::focalLength;
         }
         drawUnit.alternativa3d::setVertexConstantsFromTransform(0,alternativa3d::cameraToLocalTransform);
         drawUnit.alternativa3d::setVertexConstantsFromNumbers(3,this.originX,this.originY,this.width * scale,this.height * scale);
         drawUnit.alternativa3d::setVertexConstantsFromNumbers(4,alternativa3d::localToCameraTransform.d,alternativa3d::localToCameraTransform.h,alternativa3d::localToCameraTransform.l,this.rotation);
      }
      
      alternativa3d function getGeometry(context:Context3D) : Geometry
      {
         var attributes:Array = null;
         var geometry:Geometry = geometries[context];
         if(geometry == null)
         {
            geometry = new Geometry(4);
            attributes = new Array();
            attributes[0] = VertexAttributes.POSITION;
            attributes[1] = VertexAttributes.POSITION;
            attributes[2] = VertexAttributes.POSITION;
            attributes[3] = VertexAttributes.NORMAL;
            attributes[4] = VertexAttributes.NORMAL;
            attributes[5] = VertexAttributes.NORMAL;
            attributes[6] = VertexAttributes.TEXCOORDS[0];
            attributes[7] = VertexAttributes.TEXCOORDS[0];
            attributes[8] = VertexAttributes.TEXCOORDS[1];
            attributes[9] = VertexAttributes.TEXCOORDS[1];
            attributes[10] = VertexAttributes.TEXCOORDS[2];
            attributes[11] = VertexAttributes.TEXCOORDS[2];
            attributes[12] = VertexAttributes.TEXCOORDS[3];
            attributes[13] = VertexAttributes.TEXCOORDS[3];
            attributes[14] = VertexAttributes.TEXCOORDS[4];
            attributes[15] = VertexAttributes.TEXCOORDS[4];
            attributes[16] = VertexAttributes.TEXCOORDS[5];
            attributes[17] = VertexAttributes.TEXCOORDS[5];
            attributes[18] = VertexAttributes.TEXCOORDS[6];
            attributes[19] = VertexAttributes.TEXCOORDS[6];
            attributes[20] = VertexAttributes.TEXCOORDS[7];
            attributes[21] = VertexAttributes.TEXCOORDS[7];
            attributes[22] = VertexAttributes.TANGENT4;
            attributes[23] = VertexAttributes.TANGENT4;
            attributes[24] = VertexAttributes.TANGENT4;
            attributes[25] = VertexAttributes.TANGENT4;
            geometry.addVertexStream(attributes);
            geometry.setAttributeValues(VertexAttributes.POSITION,Vector.<Number>([0,0,0,0,1,0,1,1,0,1,0,0]));
            geometry.setAttributeValues(VertexAttributes.NORMAL,Vector.<Number>([0,0,-1,0,0,-1,0,0,-1,0,0,-1]));
            geometry.setAttributeValues(VertexAttributes.TEXCOORDS[0],Vector.<Number>([0,0,0,1,1,1,1,0]));
            geometry.setAttributeValues(VertexAttributes.TEXCOORDS[1],Vector.<Number>([0,0,0,1,1,1,1,0]));
            geometry.setAttributeValues(VertexAttributes.TEXCOORDS[2],Vector.<Number>([0,0,0,1,1,1,1,0]));
            geometry.setAttributeValues(VertexAttributes.TEXCOORDS[3],Vector.<Number>([0,0,0,1,1,1,1,0]));
            geometry.setAttributeValues(VertexAttributes.TEXCOORDS[4],Vector.<Number>([0,0,0,1,1,1,1,0]));
            geometry.setAttributeValues(VertexAttributes.TEXCOORDS[5],Vector.<Number>([0,0,0,1,1,1,1,0]));
            geometry.setAttributeValues(VertexAttributes.TEXCOORDS[6],Vector.<Number>([0,0,0,1,1,1,1,0]));
            geometry.setAttributeValues(VertexAttributes.TEXCOORDS[7],Vector.<Number>([0,0,0,1,1,1,1,0]));
            geometry.indices = Vector.<uint>([0,1,3,2,3,1]);
            geometry.upload(context);
            geometries[context] = geometry;
         }
         return geometry;
      }
      
      override public function clone() : Object3D
      {
         var res:Sprite3D = new Sprite3D(this.width,this.height);
         res.clonePropertiesFrom(this);
         return res;
      }
      
      override protected function clonePropertiesFrom(source:Object3D) : void
      {
         super.clonePropertiesFrom(source);
         var src:Sprite3D = source as Sprite3D;
         this.width = src.width;
         this.height = src.height;
         this.material = src.material;
         this.originX = src.originX;
         this.originY = src.originY;
         this.rotation = src.rotation;
         this.perspectiveScale = src.perspectiveScale;
         this.alwaysOnTop = src.alwaysOnTop;
      }
      
      override alternativa3d function updateBoundBox(boundBox:BoundBox, hierarchy:Boolean, transform:Transform3D = null) : void
      {
         var ax:Number = NaN;
         var ay:Number = NaN;
         var az:Number = NaN;
         var size:Number = NaN;
         var ww:Number = this.width;
         var hh:Number = this.height;
         var w:Number = (this.originX >= 0.5 ? this.originX : 1 - this.originX) * ww;
         var h:Number = (this.originY >= 0.5 ? this.originY : 1 - this.originY) * hh;
         var radius:Number = Number(Math.sqrt(w * w + h * h));
         var cx:Number = 0;
         var cy:Number = 0;
         var cz:Number = 0;
         if(transform != null)
         {
            ax = transform.a;
            ay = transform.e;
            az = transform.i;
            size = Number(Math.sqrt(ax * ax + ay * ay + az * az));
            ax = transform.b;
            ay = transform.f;
            az = transform.j;
            size += Math.sqrt(ax * ax + ay * ay + az * az);
            ax = transform.c;
            ay = transform.g;
            az = transform.k;
            size += Math.sqrt(ax * ax + ay * ay + az * az);
            radius *= size / 3;
            cx = transform.d;
            cy = transform.h;
            cz = transform.l;
         }
         if(cx - radius < boundBox.minX)
         {
            boundBox.minX = cx - radius;
         }
         if(cx + radius > boundBox.maxX)
         {
            boundBox.maxX = cx + radius;
         }
         if(cy - radius < boundBox.minY)
         {
            boundBox.minY = cy - radius;
         }
         if(cy + radius > boundBox.maxY)
         {
            boundBox.maxY = cy + radius;
         }
         if(cz - radius < boundBox.minZ)
         {
            boundBox.minZ = cz - radius;
         }
         if(cz + radius > boundBox.maxZ)
         {
            boundBox.maxZ = cz + radius;
         }
      }
   }
}

