package package_19
{
   import alternativa.engine3d.alternativa3d;
   import flash.display3D.Context3D;
   import flash.utils.Dictionary;
   import package_21.name_116;
   import package_21.name_124;
   import package_21.name_126;
   import package_21.name_128;
   import package_21.name_135;
   import package_21.name_139;
   import package_21.name_386;
   import package_21.name_397;
   import package_21.name_78;
   import package_28.name_119;
   import package_30.name_114;
   import package_30.name_121;
   import package_4.class_4;
   
   use namespace alternativa3d;
   
   public class name_494 extends name_78
   {
      private static const geometries:Dictionary = new Dictionary();
      
      private static var transformProcedureStatic:name_114 = new name_114(["sub t0.z, i0.x, c3.x","sub t0.w, i0.y, c3.y","mul t0.z, t0.z, c3.z","mul t0.w, t0.w, c3.w","mov t1.z, c4.w","sin t1.x, t1.z","cos t1.y, t1.z","mul t1.z, t0.z, t1.y","mul t1.w, t0.w, t1.x","sub t0.x, t1.z, t1.w","mul t1.z, t0.z, t1.x","mul t1.w, t0.w, t1.y","add t0.y, t1.z, t1.w","add t0.x, t0.x, c4.x","add t0.y, t0.y, c4.y","add t0.z, i0.z, c4.z","mov t0.w, i0.w","dp4 o0.x, t0, c0","dp4 o0.y, t0, c1","dp4 o0.z, t0, c2","mov o0.w, t0.w","#c0=trans1","#c1=trans2","#c2=trans3","#c3=size","#c4=coords"]);
      
      private static var deltaTransformProcedureStatic:name_114 = new name_114(["mov t1.z, c4.w","sin t1.x, t1.z","cos t1.y, t1.z","mul t1.z, i0.x, t1.y","mul t1.w, i0.y, t1.x","sub t0.x, t1.z, t1.w","mul t1.z, i0.x, t1.x","mul t1.w, i0.y, t1.y","add t0.y, t1.z, t1.w","mov t0.z, i0.z","mov t0.w, i0.w","dp3 o0.x, t0, c0","dp3 o0.y, t0, c1","dp3 o0.z, t0, c2","#c0=trans1","#c1=trans2","#c2=trans3","#c3=size","#c4=coords"]);
      
      public var originX:Number = 0.5;
      
      public var originY:Number = 0.5;
      
      public var rotation:Number = 0;
      
      public var width:Number;
      
      public var height:Number;
      
      public var perspectiveScale:Boolean = true;
      
      public var alwaysOnTop:Boolean = false;
      
      alternativa3d var surface:name_117;
      
      public function name_494(width:Number, height:Number, material:class_4 = null)
      {
         super();
         this.width = width;
         this.height = height;
         this.alternativa3d::surface = new name_117();
         this.alternativa3d::surface.alternativa3d::object = this;
         this.material = material;
         this.alternativa3d::surface.indexBegin = 0;
         this.alternativa3d::surface.numTriangles = 2;
         alternativa3d::transformProcedure = transformProcedureStatic;
         alternativa3d::deltaTransformProcedure = deltaTransformProcedureStatic;
      }
      
      public function get material() : class_4
      {
         return this.alternativa3d::surface.material;
      }
      
      public function set material(value:class_4) : void
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
      
      override alternativa3d function collectDraws(camera:name_124, lights:Vector.<name_116>, lightsLength:int) : void
      {
         var debug:int = 0;
         var geometry:name_119 = this.alternativa3d::method_704(camera.alternativa3d::context3D);
         if(this.alternativa3d::surface.material != null)
         {
            this.alternativa3d::surface.material.alternativa3d::collectDraws(camera,this.alternativa3d::surface,geometry,lights,lightsLength,this.alwaysOnTop ? name_128.NEXT_LAYER : -1);
         }
         if(alternativa3d::listening)
         {
            camera.view.alternativa3d::name_398(this.alternativa3d::surface,geometry,alternativa3d::transformProcedure);
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
         var scale:Number = Number(Math.sqrt(alternativa3d::localToCameraTransform.a * alternativa3d::localToCameraTransform.a + alternativa3d::localToCameraTransform.e * alternativa3d::localToCameraTransform.e + alternativa3d::localToCameraTransform.i * alternativa3d::localToCameraTransform.i));
         scale += Math.sqrt(alternativa3d::localToCameraTransform.b * alternativa3d::localToCameraTransform.b + alternativa3d::localToCameraTransform.f * alternativa3d::localToCameraTransform.f + alternativa3d::localToCameraTransform.j * alternativa3d::localToCameraTransform.j);
         scale += Math.sqrt(alternativa3d::localToCameraTransform.c * alternativa3d::localToCameraTransform.c + alternativa3d::localToCameraTransform.g * alternativa3d::localToCameraTransform.g + alternativa3d::localToCameraTransform.k * alternativa3d::localToCameraTransform.k);
         scale /= 3;
         if(!this.perspectiveScale && !camera.orthographic)
         {
            scale *= alternativa3d::localToCameraTransform.l / camera.alternativa3d::focalLength;
         }
         drawUnit.alternativa3d::name_412(0,alternativa3d::cameraToLocalTransform);
         drawUnit.alternativa3d::name_144(3,this.originX,this.originY,this.width * scale,this.height * scale);
         drawUnit.alternativa3d::name_144(4,alternativa3d::localToCameraTransform.d,alternativa3d::localToCameraTransform.h,alternativa3d::localToCameraTransform.l,this.rotation);
      }
      
      alternativa3d function method_704(context:Context3D) : name_119
      {
         var attributes:Array = null;
         var geometry:name_119 = geometries[context];
         if(geometry == null)
         {
            geometry = new name_119(4);
            attributes = new Array();
            attributes[0] = name_126.POSITION;
            attributes[1] = name_126.POSITION;
            attributes[2] = name_126.POSITION;
            attributes[3] = name_126.NORMAL;
            attributes[4] = name_126.NORMAL;
            attributes[5] = name_126.NORMAL;
            attributes[6] = name_126.TEXCOORDS[0];
            attributes[7] = name_126.TEXCOORDS[0];
            attributes[8] = name_126.TEXCOORDS[1];
            attributes[9] = name_126.TEXCOORDS[1];
            attributes[10] = name_126.TEXCOORDS[2];
            attributes[11] = name_126.TEXCOORDS[2];
            attributes[12] = name_126.TEXCOORDS[3];
            attributes[13] = name_126.TEXCOORDS[3];
            attributes[14] = name_126.TEXCOORDS[4];
            attributes[15] = name_126.TEXCOORDS[4];
            attributes[16] = name_126.TEXCOORDS[5];
            attributes[17] = name_126.TEXCOORDS[5];
            attributes[18] = name_126.TEXCOORDS[6];
            attributes[19] = name_126.TEXCOORDS[6];
            attributes[20] = name_126.TEXCOORDS[7];
            attributes[21] = name_126.TEXCOORDS[7];
            attributes[22] = name_126.TANGENT4;
            attributes[23] = name_126.TANGENT4;
            attributes[24] = name_126.TANGENT4;
            attributes[25] = name_126.TANGENT4;
            geometry.addVertexStream(attributes);
            geometry.setAttributeValues(name_126.POSITION,Vector.<Number>([0,0,0,0,1,0,1,1,0,1,0,0]));
            geometry.setAttributeValues(name_126.NORMAL,Vector.<Number>([0,0,-1,0,0,-1,0,0,-1,0,0,-1]));
            geometry.setAttributeValues(name_126.TEXCOORDS[0],Vector.<Number>([0,0,0,1,1,1,1,0]));
            geometry.setAttributeValues(name_126.TEXCOORDS[1],Vector.<Number>([0,0,0,1,1,1,1,0]));
            geometry.setAttributeValues(name_126.TEXCOORDS[2],Vector.<Number>([0,0,0,1,1,1,1,0]));
            geometry.setAttributeValues(name_126.TEXCOORDS[3],Vector.<Number>([0,0,0,1,1,1,1,0]));
            geometry.setAttributeValues(name_126.TEXCOORDS[4],Vector.<Number>([0,0,0,1,1,1,1,0]));
            geometry.setAttributeValues(name_126.TEXCOORDS[5],Vector.<Number>([0,0,0,1,1,1,1,0]));
            geometry.setAttributeValues(name_126.TEXCOORDS[6],Vector.<Number>([0,0,0,1,1,1,1,0]));
            geometry.setAttributeValues(name_126.TEXCOORDS[7],Vector.<Number>([0,0,0,1,1,1,1,0]));
            geometry.indices = Vector.<uint>([0,1,3,2,3,1]);
            geometry.upload(context);
            geometries[context] = geometry;
         }
         return geometry;
      }
      
      override public function clone() : name_78
      {
         var res:name_494 = new name_494(this.width,this.height);
         res.clonePropertiesFrom(this);
         return res;
      }
      
      override protected function clonePropertiesFrom(source:name_78) : void
      {
         super.clonePropertiesFrom(source);
         var src:name_494 = source as name_494;
         this.width = src.width;
         this.height = src.height;
         this.material = src.material;
         this.originX = src.originX;
         this.originY = src.originY;
         this.rotation = src.rotation;
         this.perspectiveScale = src.perspectiveScale;
         this.alwaysOnTop = src.alwaysOnTop;
      }
      
      override alternativa3d function updateBoundBox(boundBox:name_386, hierarchy:Boolean, transform:name_139 = null) : void
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

