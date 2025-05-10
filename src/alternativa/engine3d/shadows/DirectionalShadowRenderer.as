package alternativa.engine3d.shadows
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.BoundBox;
   import alternativa.engine3d.core.Camera3D;
   import alternativa.engine3d.core.DrawUnit;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.Transform3D;
   import alternativa.engine3d.core.VertexAttributes;
   import alternativa.engine3d.lights.DirectionalLight;
   import alternativa.engine3d.materials.ShaderProgram;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.materials.compiler.Linker;
   import alternativa.engine3d.materials.compiler.Procedure;
   import alternativa.engine3d.materials.compiler.VariableType;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.engine3d.objects.Surface;
   import alternativa.engine3d.primitives.Box;
   import alternativa.engine3d.resources.ExternalTextureResource;
   import alternativa.engine3d.resources.TextureResource;
   import flash.display3D.Context3D;
   import flash.display3D.Context3DProgramType;
   import flash.display3D.Context3DTextureFormat;
   import flash.display3D.Context3DTriangleFace;
   import flash.display3D.Program3D;
   import flash.display3D.textures.Texture;
   import flash.geom.Matrix3D;
   import flash.geom.Vector3D;
   
   use namespace alternativa3d;
   
   public class DirectionalShadowRenderer extends ShadowRenderer
   {
      private static var directionalShadowMapProgram:Program3D;
      
      private static const constants:Vector.<Number> = Vector.<Number>([255,255 * 0.96,100,1]);
      
      private static var matrix:Matrix3D = new Matrix3D();
      
      private static var transformToMatrixRawData:Vector.<Number> = new Vector.<Number>(16);
      
      private static var drawProjection:Matrix3D = new Matrix3D();
      
      private static const objectToShadowMap:Matrix3D = new Matrix3D();
      
      private static const localToGlobal:Transform3D = new Transform3D();
      
      private static const vector:Vector.<Number> = new Vector.<Number>(16,false);
      
      public var offset:Vector3D = new Vector3D();
      
      public var §_-qg§:Object3D;
      
      private var context:Context3D;
      
      private var shadowMap:Texture;
      
      private var §_-FQ§:Number;
      
      private var light:DirectionalLight;
      
      alternativa3d var §_-UK§:Matrix3D = new Matrix3D();
      
      private var debugObject:Mesh;
      
      public var §_-Vg§:TextureMaterial = new TextureMaterial();
      
      private var §_-Ez§:TextureResource = new ExternalTextureResource("null");
      
      private var §_-M§:Number = 0;
      
      private var pcfOffsets:Vector.<Number>;
      
      private var §_-1a§:Boolean = false;
      
      private var §_-bD§:Matrix3D = new Matrix3D();
      
      private var uvMatrix:Matrix3D = new Matrix3D();
      
      private var center:Vector3D = new Vector3D();
      
      private var rawData:Vector.<Number> = new Vector.<Number>(16);
      
      public function DirectionalShadowRenderer(context:Context3D, size:int, worldSize:Number, pcfSize:Number = 0)
      {
         super();
         this.context = context;
         this.§_-FQ§ = worldSize;
         this.§_-M§ = pcfSize / worldSize / 255;
         if(this.§_-M§ > 0)
         {
            this.pcfOffsets = Vector.<Number>([-this.§_-M§,-this.§_-M§,0,1 / 4,-this.§_-M§,this.§_-M§,0,1,this.§_-M§,-this.§_-M§,0,1,this.§_-M§,this.§_-M§,0,1]);
         }
         this.shadowMap = context.createTexture(size,size,Context3DTextureFormat.BGRA,true);
         this.§_-Ez§.alternativa3d::_texture = this.shadowMap;
         this.§_-Vg§.diffuseMap = this.§_-Ez§;
         this.§_-Vg§.alpha = 0.9;
         this.§_-Vg§.§_-L4§ = true;
         this.debugObject = new Box(worldSize,worldSize,1,1,1,1,false,this.§_-Vg§);
         this.debugObject.geometry.upload(context);
      }
      
      alternativa3d static function copyMatrixFromTransform(matrix:Matrix3D, transform:Transform3D) : void
      {
         transformToMatrixRawData[0] = transform.a;
         transformToMatrixRawData[1] = transform.e;
         transformToMatrixRawData[2] = transform.i;
         transformToMatrixRawData[3] = 0;
         transformToMatrixRawData[4] = transform.b;
         transformToMatrixRawData[5] = transform.f;
         transformToMatrixRawData[6] = transform.j;
         transformToMatrixRawData[7] = 0;
         transformToMatrixRawData[8] = transform.c;
         transformToMatrixRawData[9] = transform.g;
         transformToMatrixRawData[10] = transform.k;
         transformToMatrixRawData[11] = 0;
         transformToMatrixRawData[12] = transform.d;
         transformToMatrixRawData[13] = transform.h;
         transformToMatrixRawData[14] = transform.l;
         transformToMatrixRawData[15] = 1;
         matrix.copyRawDataFrom(transformToMatrixRawData);
      }
      
      alternativa3d static function drawObjectToShadowMap(context:Context3D, object:Object3D, light:DirectionalLight, projection:Matrix3D) : void
      {
         if(object is Mesh)
         {
            drawMeshToShadowMap(context,Mesh(object),projection);
         }
         for(var child:Object3D = object.alternativa3d::childrenList; child != null; )
         {
            if(child.visible && child.useShadow)
            {
               if(child.alternativa3d::transformChanged)
               {
                  child.alternativa3d::composeTransforms();
               }
               child.alternativa3d::localToCameraTransform.combine(object.alternativa3d::localToCameraTransform,child.alternativa3d::transform);
               alternativa3d::drawObjectToShadowMap(context,child,light,projection);
            }
            child = child.alternativa3d::next;
         }
      }
      
      private static function drawMeshToShadowMap(context:Context3D, mesh:Mesh, projection:Matrix3D) : void
      {
         var surface:Surface = null;
         if(mesh.geometry == null || mesh.geometry.numTriangles == 0 || !mesh.geometry.isUploaded)
         {
            return;
         }
         alternativa3d::copyMatrixFromTransform(drawProjection,mesh.alternativa3d::localToCameraTransform);
         drawProjection.append(projection);
         if(directionalShadowMapProgram == null)
         {
            directionalShadowMapProgram = initMeshToShadowMapProgram(context);
         }
         context.setProgram(directionalShadowMapProgram);
         context.setVertexBufferAt(0,mesh.geometry.alternativa3d::getVertexBuffer(VertexAttributes.POSITION),mesh.geometry.alternativa3d::_attributesOffsets[VertexAttributes.POSITION],VertexAttributes.alternativa3d::FORMATS[VertexAttributes.POSITION]);
         context.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX,0,drawProjection,true);
         context.setProgramConstantsFromVector(Context3DProgramType.VERTEX,4,Vector.<Number>([255,0,0,1]));
         context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,0,Vector.<Number>([1 / 255,0,0,1]));
         context.setCulling(Context3DTriangleFace.BACK);
         for(var i:int = 0; i < mesh.alternativa3d::_-Oy; i++)
         {
            surface = mesh.alternativa3d::_-eW[i];
            if(!(surface.material == null || !surface.material.alternativa3d::canDrawInShadowMap))
            {
               context.drawTriangles(mesh.geometry.alternativa3d::_-EM,surface.indexBegin,surface.numTriangles);
            }
         }
         context.setVertexBufferAt(0,null);
      }
      
      private static function initMeshToShadowMapProgram(context3d:Context3D) : Program3D
      {
         var vLinker:Linker = new Linker(Context3DProgramType.VERTEX);
         var fLinker:Linker = new Linker(Context3DProgramType.FRAGMENT);
         var proc:Procedure = Procedure.compileFromArray(["#a0=a0","#c4=c4","#v0=v0","m44 t0, a0, c0","mul v0, t0, c4.x","mov o0, t0"]);
         proc.assignVariableName(VariableType.CONSTANT,0,"c0",4);
         vLinker.addProcedure(proc);
         fLinker.addProcedure(Procedure.compileFromArray(["#v0=v0","#c0=c0","mov t0.xy, v0.zz","frc t0.y, v0.z","sub t0.x, v0.z, t0.y","mul t0.x, t0.x, c0.x","mov t0.z, c0.z","mov t0.w, c0.w","mov o0, t0"]));
         var program:Program3D = context3d.createProgram();
         program.upload(vLinker.getByteCode(),fLinker.getByteCode());
         return program;
      }
      
      private static function initVShader(index:int) : Procedure
      {
         var shader:Procedure = Procedure.compileFromArray(["m44 v0, a0, c0"]);
         shader.assignVariableName(VariableType.ATTRIBUTE,0,"aPosition");
         shader.assignVariableName(VariableType.CONSTANT,0,index + "cTOSHADOW",4);
         shader.assignVariableName(VariableType.VARYING,0,index + "vSHADOWSAMPLE");
         return shader;
      }
      
      private static function initFShader(mult:Boolean, usePCF:Boolean, index:int, grayScale:Boolean = false) : Procedure
      {
         var i:int = 0;
         var line:int = 0;
         var shaderArr:Array = [];
         var numPass:uint = usePCF ? 4 : 1;
         for(i = 0; i < numPass; i++)
         {
            var _loc10_:* = line++;
            shaderArr[_loc10_] = "mov t0.w, v0.z";
            var _loc11_:* = line++;
            shaderArr[_loc11_] = "mul t0.w, t0.w, c4.y";
            if(usePCF)
            {
               var _loc12_:* = line++;
               shaderArr[_loc12_] = "mul t1, c" + (i + 6).toString() + ", t0.w";
               var _loc13_:* = line++;
               shaderArr[_loc13_] = "add t1, v0, t1";
               var _loc14_:* = line++;
               shaderArr[_loc14_] = "tex t1, t1, s0 <2d,clamp,near,nomip>";
            }
            else
            {
               _loc12_ = line++;
               shaderArr[_loc12_] = "tex t1, v0, s0 <2d,clamp,near,nomip>";
            }
            _loc12_ = line++;
            shaderArr[_loc12_] = "mul t1.w, t1.x, c4.x";
            _loc13_ = line++;
            shaderArr[_loc13_] = "add t1.w, t1.w, t1.y";
            _loc14_ = line++;
            shaderArr[_loc14_] = "sub t2.z, t1.w, t0.w";
            var _loc15_:* = line++;
            shaderArr[_loc15_] = "mul t2.z, t2.z, c4.z";
            var _loc16_:* = line++;
            shaderArr[_loc16_] = "sat t2.z, t2.z";
            if(grayScale)
            {
               var _loc17_:* = line++;
               shaderArr[_loc17_] = "add t2, t2.zzzz, t1.zzzz";
            }
            else
            {
               _loc17_ = line++;
               shaderArr[_loc17_] = "add t2.z, t2.z, t1.z";
               var _loc18_:* = line++;
               shaderArr[_loc18_] = "add t2, t2.zzzz, c5";
            }
            _loc17_ = line++;
            shaderArr[_loc17_] = "sat t2, t2";
            if(usePCF)
            {
               if(i == 0)
               {
                  _loc18_ = line++;
                  shaderArr[_loc18_] = "mov t3, t2";
               }
               else
               {
                  _loc18_ = line++;
                  shaderArr[_loc18_] = "add t3, t3, t2";
               }
            }
         }
         if(usePCF)
         {
            _loc10_ = line++;
            shaderArr[_loc10_] = "mul t2, t3, c6.w";
         }
         if(grayScale)
         {
            _loc10_ = line++;
            shaderArr[_loc10_] = "mov o0.w, t2.x";
         }
         else if(mult)
         {
            _loc10_ = line++;
            shaderArr[_loc10_] = "mul t0.xyz, i0.xyz, t2.xyz";
            _loc11_ = line++;
            shaderArr[_loc11_] = "mov t0.w, i0.w";
            _loc12_ = line++;
            shaderArr[_loc12_] = "mov o0, t0";
         }
         else
         {
            _loc10_ = line++;
            shaderArr[_loc10_] = "mov o0, t2";
         }
         var shader:Procedure = Procedure.compileFromArray(shaderArr,"DirectionalShadowMap");
         shader.assignVariableName(VariableType.VARYING,0,index + "vSHADOWSAMPLE");
         shader.assignVariableName(VariableType.CONSTANT,4,index + "cConstants",1);
         shader.assignVariableName(VariableType.CONSTANT,5,index + "cShadowColor",1);
         if(usePCF)
         {
            for(i = 0; i < numPass; i++)
            {
               shader.assignVariableName(VariableType.CONSTANT,i + 6,"cDPCF" + i.toString(),1);
            }
         }
         shader.assignVariableName(VariableType.SAMPLER,0,index + "sSHADOWMAP");
         return shader;
      }
      
      public function get worldSize() : Number
      {
         return this.§_-FQ§;
      }
      
      public function set worldSize(value:Number) : void
      {
         this.§_-FQ§ = value;
         var newDebug:Mesh = new Box(this.§_-FQ§,this.§_-FQ§,1,1,1,1,false,this.§_-Vg§);
         newDebug.geometry.upload(this.context);
         if(this.debugObject.alternativa3d::_parent != null)
         {
            this.debugObject.alternativa3d::_parent.addChild(newDebug);
            this.debugObject.alternativa3d::_parent.removeChild(this.debugObject);
         }
         this.debugObject = newDebug;
      }
      
      public function setLight(value:DirectionalLight) : void
      {
         this.light = value;
         if(this.§_-1a§)
         {
            this.light.addChild(this.debugObject);
         }
      }
      
      override public function get debug() : Boolean
      {
         return this.§_-1a§;
      }
      
      override public function set debug(value:Boolean) : void
      {
         this.§_-1a§ = value;
         if(this.§_-1a§)
         {
            if(this.light != null)
            {
               this.light.addChild(this.debugObject);
            }
         }
         else if(this.debugObject.alternativa3d::_parent != null)
         {
            this.debugObject.alternativa3d::_parent.removeChild(this.debugObject);
         }
      }
      
      override alternativa3d function cullReciever(boundBox:BoundBox, object:Object3D) : Boolean
      {
         alternativa3d::copyMatrixFromTransform(matrix,object.alternativa3d::localToGlobalTransform);
         matrix.append(this.alternativa3d::_-UK);
         return alternativa3d::cullObjectImplementation(boundBox,matrix);
      }
      
      override public function update() : void
      {
         var root:Object3D = null;
         active = true;
         this.§_-qg§.alternativa3d::localToCameraTransform.compose(this.§_-qg§.alternativa3d::_x,this.§_-qg§.alternativa3d::_y,this.§_-qg§.alternativa3d::_z,this.§_-qg§.alternativa3d::_rotationX,this.§_-qg§.alternativa3d::_rotationY,this.§_-qg§.alternativa3d::_rotationZ,this.§_-qg§.alternativa3d::_scaleX,this.§_-qg§.alternativa3d::_scaleY,this.§_-qg§.alternativa3d::_scaleZ);
         for(root = this.§_-qg§; root.alternativa3d::_parent != null; )
         {
            root = root.alternativa3d::_parent;
            root.alternativa3d::localToGlobalTransform.compose(root.alternativa3d::_x,root.alternativa3d::_y,root.alternativa3d::_z,root.alternativa3d::_rotationX,root.alternativa3d::_rotationY,root.alternativa3d::_rotationZ,root.alternativa3d::_scaleX,root.alternativa3d::_scaleY,root.alternativa3d::_scaleZ);
            this.§_-qg§.alternativa3d::localToCameraTransform.append(root.alternativa3d::localToGlobalTransform);
         }
         this.light.alternativa3d::localToGlobalTransform.compose(this.light.alternativa3d::_x,this.light.alternativa3d::_y,this.light.alternativa3d::_z,this.light.alternativa3d::_rotationX,this.light.alternativa3d::_rotationY,this.light.alternativa3d::_rotationZ,this.light.alternativa3d::_scaleX,this.light.alternativa3d::_scaleY,this.light.alternativa3d::_scaleZ);
         for(root = this.light; root.alternativa3d::_parent != null; )
         {
            root = root.alternativa3d::_parent;
            root.alternativa3d::localToGlobalTransform.compose(root.alternativa3d::_x,root.alternativa3d::_y,root.alternativa3d::_z,root.alternativa3d::_rotationX,root.alternativa3d::_rotationY,root.alternativa3d::_rotationZ,root.alternativa3d::_scaleX,root.alternativa3d::_scaleY,root.alternativa3d::_scaleZ);
            this.light.alternativa3d::localToGlobalTransform.append(root.alternativa3d::localToGlobalTransform);
         }
         this.light.alternativa3d::globalToLocalTransform.copy(this.light.alternativa3d::localToGlobalTransform);
         this.light.alternativa3d::globalToLocalTransform.invert();
         this.§_-qg§.alternativa3d::localToCameraTransform.append(this.light.alternativa3d::globalToLocalTransform);
         var t:Transform3D = this.§_-qg§.alternativa3d::localToCameraTransform;
         this.center.x = t.a * this.offset.x + t.b * this.offset.y + t.c * this.offset.z + t.d;
         this.center.y = t.e * this.offset.x + t.f * this.offset.y + t.g * this.offset.z + t.h;
         this.center.z = t.i * this.offset.x + t.j * this.offset.y + t.k * this.offset.z + t.l;
         this.calculateShadowMapProjection(this.§_-bD§,this.uvMatrix,this.center,this.§_-FQ§,this.§_-FQ§,this.§_-FQ§);
         alternativa3d::copyMatrixFromTransform(this.alternativa3d::_-UK,this.light.alternativa3d::globalToLocalTransform);
         this.alternativa3d::_-UK.append(this.uvMatrix);
         this.debugObject.x = this.center.x;
         this.debugObject.y = this.center.y;
         this.debugObject.z = this.center.z - this.§_-FQ§ / 2;
         this.§_-Vg§.diffuseMap = null;
         this.context.setRenderToTexture(this.shadowMap,true,0,0);
         this.context.clear(1,1,1,1);
         cleanContext(this.context);
         alternativa3d::drawObjectToShadowMap(this.context,this.§_-qg§,this.light,this.§_-bD§);
         this.context.setRenderToBackBuffer();
         cleanContext(this.context);
         this.§_-Vg§.diffuseMap = this.§_-Ez§;
      }
      
      private function calculateShadowMapProjection(matrix:Matrix3D, uvMatrix:Matrix3D, offset:Vector3D, width:Number, height:Number, length:Number) : void
      {
         var halfW:Number = width / 2;
         var halfH:Number = height / 2;
         var halfL:Number = length / 2;
         var frustumMinX:Number = offset.x - halfW;
         var frustumMaxX:Number = offset.x + halfW;
         var frustumMinY:Number = offset.y - halfH;
         var frustumMaxY:Number = offset.y + halfH;
         var frustumMinZ:Number = offset.z - halfL;
         var frustumMaxZ:Number = offset.z + halfL;
         this.rawData[0] = 2 / (frustumMaxX - frustumMinX);
         this.rawData[5] = 2 / (frustumMaxY - frustumMinY);
         this.rawData[10] = 1 / (frustumMaxZ - frustumMinZ);
         this.rawData[12] = -0.5 * (frustumMaxX + frustumMinX) * this.rawData[0];
         this.rawData[13] = -0.5 * (frustumMaxY + frustumMinY) * this.rawData[5];
         this.rawData[14] = -frustumMinZ / (frustumMaxZ - frustumMinZ);
         this.rawData[15] = 1;
         matrix.rawData = this.rawData;
         this.rawData[0] = 1 / (frustumMaxX - frustumMinX);
         this.rawData[5] = -1 / (frustumMaxY - frustumMinY);
         this.rawData[12] = 0.5 - 0.5 * (frustumMaxX + frustumMinX) * this.rawData[0];
         this.rawData[13] = 0.5 - 0.5 * (frustumMaxY + frustumMinY) * this.rawData[5];
         uvMatrix.rawData = this.rawData;
      }
      
      override public function getVShader(index:int = 0) : Procedure
      {
         return initVShader(index);
      }
      
      override public function getFShader(index:int = 0) : Procedure
      {
         return initFShader(false,this.§_-M§ > 0,index);
      }
      
      override public function getFIntensityShader() : Procedure
      {
         return initFShader(false,this.§_-M§ > 0,0,true);
      }
      
      override public function applyShader(drawUnit:DrawUnit, program:ShaderProgram, object:Object3D, camera:Camera3D, index:int = 0) : void
      {
         localToGlobal.combine(camera.alternativa3d::localToGlobalTransform,object.alternativa3d::localToCameraTransform);
         alternativa3d::copyMatrixFromTransform(objectToShadowMap,localToGlobal);
         objectToShadowMap.append(this.alternativa3d::_-UK);
         objectToShadowMap.copyRawDataTo(vector,0,true);
         drawUnit.alternativa3d::setVertexConstantsFromVector(program.vertexShader.getVariableIndex(index + "cTOSHADOW"),vector,4);
         drawUnit.alternativa3d::setFragmentConstantsFromVector(program.fragmentShader.getVariableIndex(index + "cConstants"),constants,1);
         if(program.fragmentShader.containsVariable(index + "cShadowColor"))
         {
            drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.fragmentShader.getVariableIndex(index + "cShadowColor"),camera.alternativa3d::ambient[0] / 2,camera.alternativa3d::ambient[1] / 2,camera.alternativa3d::ambient[2] / 2,1);
         }
         if(this.§_-M§ > 0)
         {
            drawUnit.alternativa3d::setFragmentConstantsFromVector(program.fragmentShader.getVariableIndex("cDPCF0"),this.pcfOffsets,this.pcfOffsets.length / 4);
         }
         drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex(index + "sSHADOWMAP"),this.shadowMap);
      }
   }
}

