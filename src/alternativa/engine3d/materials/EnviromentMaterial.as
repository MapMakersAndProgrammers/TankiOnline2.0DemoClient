package alternativa.engine3d.materials
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.Camera3D;
   import alternativa.engine3d.core.DrawUnit;
   import alternativa.engine3d.core.Light3D;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.RenderPriority;
   import alternativa.engine3d.core.Transform3D;
   import alternativa.engine3d.core.VertexAttributes;
   import alternativa.engine3d.materials.compiler.Linker;
   import alternativa.engine3d.materials.compiler.Procedure;
   import alternativa.engine3d.materials.compiler.VariableType;
   import alternativa.engine3d.objects.Surface;
   import alternativa.engine3d.resources.BitmapTextureResource;
   import alternativa.engine3d.resources.Geometry;
   import alternativa.engine3d.resources.TextureResource;
   import avmplus.getQualifiedClassName;
   import flash.display.BitmapData;
   import flash.display3D.Context3DBlendFactor;
   import flash.display3D.Context3DProgramType;
   import flash.display3D.VertexBuffer3D;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   
   use namespace alternativa3d;
   
   public class EnviromentMaterial extends TextureMaterial
   {
      alternativa3d static var fogTexture:TextureResource;
      
      private static var _programs:Dictionary = new Dictionary();
      
      alternativa3d static const DISABLED:int = 0;
      
      alternativa3d static const SIMPLE:int = 1;
      
      alternativa3d static const ADVANCED:int = 2;
      
      alternativa3d static var fogMode:int = alternativa3d::DISABLED;
      
      alternativa3d static var fogNear:Number = 1000;
      
      alternativa3d static var fogFar:Number = 5000;
      
      alternativa3d static var fogMaxDensity:Number = 1;
      
      alternativa3d static var fogColorR:Number = 200 / 255;
      
      alternativa3d static var fogColorG:Number = 162 / 255;
      
      alternativa3d static var fogColorB:Number = 200 / 255;
      
      alternativa3d static const _passReflectionProcedure:Procedure = new Procedure(["#v1=vNormal","#v0=vPosition","mov v0, i0","mov v1, i1"],"passReflectionProcedure");
      
      alternativa3d static const _applyReflectionProcedure:Procedure = new Procedure(["#v1=vNormal","#v0=vPosition","#s0=sCubeMap","#c0=cCamera","sub t0, v0, c0","dp3 t1.x, v1, t0","add t1.x, t1.x, t1.x","mul t1, v1, t1.x","sub t1, t0, t1","nrm t1.xyz, t1.xyz","tex o0, t1, s0 <cube,clamp,linear,nomip>"],"applyReflectionProcedure");
      
      alternativa3d static const _applyReflectionNormalMapProcedure:Procedure = new Procedure(["#s0=sCubeMap","#c0=cCamera","#v0=vPosition","sub t0, v0, c0","dp3 t1.x, i0.xyz, t0","add t1.x, t1.x, t1.x","mul t1, i0.xyz, t1.x","sub t1, t0, t1","nrm t1.xyz, t1.xyz","tex o0, t1, s0 <cube,clamp,linear,nomip>"],"applyReflectionNormalMapProcedure");
      
      alternativa3d static const _blendReflection:Procedure = new Procedure(["#c0=cAlpha","mul t1, i0, c0.y","mul t0.xyz, i1, c0.z","add t0.xyz, t1, t0","mov t0.w, i0.w","mov o0, t0"],"blendReflection");
      
      alternativa3d static const _blendReflectionMap:Procedure = new Procedure(["#c0=cCamera","#c1=cAlpha","#s0=sReflection","#v0=vUV","tex t0, v0, s0 <2d,repeat,linear,miplinear>","mul t0, t0, c1.z","mul t1.xyz, i1, t0","sub t0, c0.www, t0","mul t2, i0, t0","add t0.xyz, t1, t2","mov t0.w, i0.w","mov o0, t0"],"blendReflectionMap");
      
      private static const _passTBNRightProcedure:Procedure = getPassTBNProcedure(true);
      
      private static const _passTBNLeftProcedure:Procedure = getPassTBNProcedure(false);
      
      private static const _getNormalTangentProcedure:Procedure = new Procedure(["#v0=vTangent","#v1=vBinormal","#v2=vNormal","#v3=vUV","#c0=cCamera","#s0=sBump","tex t0, v3, s0 <2d,repeat,linear,miplinear>","add t0, t0, t0","sub t0.xyz, t0.xyz, c0.www","nrm t1.xyz, v0.xyz","dp3 o0.x, t0.xyz, t1.xyz","nrm t1.xyz, v1.xyz","dp3 o0.y, t0.xyz, t1.xyz","nrm t1.xyz, v2.xyz","dp3 o0.z, t0.xyz, t1.xyz","nrm o0.xyz, o0.xyz"],"getNormalTangentProcedure");
      
      private static const _getNormalObjectProcedure:Procedure = new Procedure(["#v3=vUV","#c0=cCamera","#s0=sBump","tex t0, v3, s0 <2d,repeat,linear,miplinear>","add t0, t0, t0","sub t0.xyz, t0.xyz, c0.www","nrm o0.xyz, t0.xyz"],"getNormalObjectProcedure");
      
      private static const passSimpleFogConstProcedure:Procedure = new Procedure(["#v0=vZDistance","#c0=cFogSpace","dp4 t0.z, i0, c0","mov v0, t0.zzzz","sub v0.y, i0.w, t0.z"],"passSimpleFogConst");
      
      private static const outputWithSimpleFogProcedure:Procedure = new Procedure(["#v0=vZDistance","#c0=cFogColor","#c1=cFogRange","min t0.xy, v0.xy, c1.xy","max t0.xy, t0.xy, c1.zw","mul i0.xyz, i0.xyz, t0.y","mul t0.xyz, c0.xyz, t0.x","add i0.xyz, i0.xyz, t0.xyz","mov o0, i0"],"outputWithSimpleFog");
      
      private static const postPassAdvancedFogConstProcedure:Procedure = new Procedure(["#v0=vZDistance","#c0=cFogSpace","dp4 t0.z, i0, c0","mov v0, t0.zzzz","sub v0.y, i0.w, t0.z","mov v0.zw, i1.xwxw","mov o0, i1"],"postPassAdvancedFogConst");
      
      private static const outputWithAdvancedFogProcedure:Procedure = new Procedure(["#v0=vZDistance","#c0=cFogConsts","#c1=cFogRange","#s0=sFogTexture","min t0.xy, v0.xy, c1.xy","max t0.xy, t0.xy, c1.zw","mul i0.xyz, i0.xyz, t0.y","mov t1.xyzw, c0.yyzw","div t0.z, v0.z, v0.w","mul t0.z, t0.z, c0.x","add t1.x, t1.x, t0.z","tex t1, t1, s0 <2d, repeat, linear, miplinear>","mul t0.xyz, t1.xyz, t0.x","add i0.xyz, i0.xyz, t0.xyz","mov o0, i0"],"outputWithAdvancedFog");
      
      private static const _applyLightMapProcedure:Procedure = new Procedure(["#v0=vUV1","#s0=sLightMap","tex t0, v0, s0 <2d,repeat,linear,mipnone>","add t0, t0, t0","mul i0.xyz, i0.xyz, t0.xyz","mov o0, i0"],"applyLightMapProcedure");
      
      private static const _passLightMapUVProcedure:Procedure = new Procedure(["#a0=aUV1","#v0=vUV1","mov v0, a0"],"passLightMapUVProcedure");
      
      private var name_NH:int = 0;
      
      public var normalMap:TextureResource;
      
      public var environmentMap:TextureResource;
      
      public var reflection:Number = 1;
      
      public var reflectionMap:TextureResource;
      
      public var lightMap:TextureResource;
      
      public var lightMapChannel:uint = 1;
      
      public function EnviromentMaterial(diffuseMap:TextureResource = null, environmentMap:TextureResource = null, normalMap:TextureResource = null, reflectionMap:TextureResource = null, lightMap:TextureResource = null, opacityMap:TextureResource = null, alpha:Number = 1)
      {
         super(diffuseMap,opacityMap,alpha);
         this.environmentMap = environmentMap;
         this.normalMap = normalMap;
         this.reflectionMap = reflectionMap;
         this.lightMap = lightMap;
      }
      
      private static function getPassTBNProcedure(right:Boolean) : Procedure
      {
         var crsInSpace:String = right ? "crs t1.xyz, i0, i1" : "crs t1.xyz, i1, i0";
         return new Procedure(["#v0=vTangent","#v1=vBinormal","#v2=vNormal",crsInSpace,"mul t1.xyz, t1.xyz, i0.w","mov v0.x, i0.x","mov v0.y, t1.x","mov v0.z, i1.x","mov v0.w, i1.w","mov v1.x, i0.y","mov v1.y, t1.y","mov v1.z, i1.y","mov v1.w, i1.w","mov v2.x, i0.z","mov v2.y, t1.z","mov v2.z, i1.z","mov v2.w, i1.w"],"passTBNProcedure");
      }
      
      public function get normalMapSpace() : int
      {
         return this.name_NH;
      }
      
      public function set normalMapSpace(value:int) : void
      {
         if(value != NormalMapSpace.TANGENT_RIGHT_HANDED && value != NormalMapSpace.TANGENT_LEFT_HANDED && value != NormalMapSpace.OBJECT)
         {
            throw new ArgumentError("Value must be a constant from the NormalMapSpace class");
         }
         this.name_NH = value;
      }
      
      override alternativa3d function fillResources(resources:Dictionary, resourceType:Class) : void
      {
         super.alternativa3d::fillResources(resources,resourceType);
         if(this.environmentMap != null && Boolean(A3DUtils.alternativa3d::checkParent(getDefinitionByName(getQualifiedClassName(this.environmentMap)) as Class,resourceType)))
         {
            resources[this.environmentMap] = true;
         }
         if(this.normalMap != null && Boolean(A3DUtils.alternativa3d::checkParent(getDefinitionByName(getQualifiedClassName(this.normalMap)) as Class,resourceType)))
         {
            resources[this.normalMap] = true;
         }
         if(this.reflectionMap != null && Boolean(A3DUtils.alternativa3d::checkParent(getDefinitionByName(getQualifiedClassName(this.reflectionMap)) as Class,resourceType)))
         {
            resources[this.reflectionMap] = true;
         }
         if(this.lightMap != null && Boolean(A3DUtils.alternativa3d::checkParent(getDefinitionByName(getQualifiedClassName(this.lightMap)) as Class,resourceType)))
         {
            resources[this.lightMap] = true;
         }
      }
      
      private function final(targetObject:Object3D) : EnvironmentMaterialShaderProgram
      {
         var procedure:Procedure = null;
         var outputProcedure:Procedure = null;
         var nrmProcedure:Procedure = null;
         var vertexLinker:Linker = new Linker(Context3DProgramType.VERTEX);
         var fragmentLinker:Linker = new Linker(Context3DProgramType.FRAGMENT);
         var positionVar:String = "aPosition";
         var normalVar:String = "aNormal";
         var tangentVar:String = "aTangent";
         vertexLinker.declareVariable(positionVar,VariableType.ATTRIBUTE);
         vertexLinker.declareVariable(normalVar,VariableType.ATTRIBUTE);
         if(targetObject.alternativa3d::transformProcedure != null)
         {
            positionVar = alternativa3d::appendPositionTransformProcedure(targetObject.alternativa3d::transformProcedure,vertexLinker);
         }
         if(targetObject.alternativa3d::deltaTransformProcedure != null)
         {
            vertexLinker.declareVariable("tTransformedNormal");
            procedure = targetObject.alternativa3d::deltaTransformProcedure.newInstance();
            vertexLinker.addProcedure(procedure);
            vertexLinker.setInputParams(procedure,normalVar);
            vertexLinker.setOutputParams(procedure,"tTransformedNormal");
            normalVar = "tTransformedNormal";
            if((this.name_NH == NormalMapSpace.TANGENT_RIGHT_HANDED || this.name_NH == NormalMapSpace.TANGENT_LEFT_HANDED) && this.normalMap != null)
            {
               vertexLinker.declareVariable(tangentVar,VariableType.ATTRIBUTE);
               vertexLinker.declareVariable("tTransformedTangent");
               procedure = targetObject.alternativa3d::deltaTransformProcedure.newInstance();
               vertexLinker.addProcedure(procedure);
               vertexLinker.setInputParams(procedure,tangentVar);
               vertexLinker.setOutputParams(procedure,"tTransformedTangent");
               tangentVar = "tTransformedTangent";
            }
         }
         else if((this.name_NH == NormalMapSpace.TANGENT_RIGHT_HANDED || this.name_NH == NormalMapSpace.TANGENT_LEFT_HANDED) && this.normalMap != null)
         {
            vertexLinker.declareVariable(tangentVar,VariableType.ATTRIBUTE);
         }
         vertexLinker.addProcedure(_passLightMapUVProcedure);
         vertexLinker.addProcedure(alternativa3d::_passReflectionProcedure);
         vertexLinker.setInputParams(alternativa3d::_passReflectionProcedure,positionVar,normalVar);
         vertexLinker.addProcedure(alternativa3d::_projectProcedure);
         vertexLinker.setInputParams(alternativa3d::_projectProcedure,positionVar);
         vertexLinker.addProcedure(alternativa3d::_passUVProcedure);
         if(this.normalMap != null)
         {
            fragmentLinker.declareVariable("tNormal");
            if(this.name_NH == NormalMapSpace.TANGENT_RIGHT_HANDED || this.name_NH == NormalMapSpace.TANGENT_LEFT_HANDED)
            {
               nrmProcedure = this.name_NH == NormalMapSpace.TANGENT_RIGHT_HANDED ? _passTBNRightProcedure : _passTBNLeftProcedure;
               vertexLinker.addProcedure(nrmProcedure);
               vertexLinker.setInputParams(nrmProcedure,tangentVar,normalVar);
               fragmentLinker.addProcedure(_getNormalTangentProcedure);
               fragmentLinker.setOutputParams(_getNormalTangentProcedure,"tNormal");
            }
            else
            {
               fragmentLinker.addProcedure(_getNormalObjectProcedure);
               fragmentLinker.setOutputParams(_getNormalObjectProcedure,"tNormal");
            }
         }
         vertexLinker.link();
         fragmentLinker.declareVariable("tColor");
         if(name_L4)
         {
            fragmentLinker.addProcedure(alternativa3d::_samplerSetProcedureDiffuseAlpha);
            fragmentLinker.setOutputParams(alternativa3d::_samplerSetProcedureDiffuseAlpha,"tColor");
         }
         else if(opacityMap != null)
         {
            fragmentLinker.addProcedure(alternativa3d::_samplerSetProcedureOpacity);
            fragmentLinker.setOutputParams(alternativa3d::_samplerSetProcedureOpacity,"tColor");
         }
         else
         {
            fragmentLinker.addProcedure(alternativa3d::_samplerSetProcedure);
            fragmentLinker.setOutputParams(alternativa3d::_samplerSetProcedure,"tColor");
         }
         fragmentLinker.declareVariable("tReflection");
         if(this.normalMap != null)
         {
            fragmentLinker.addProcedure(alternativa3d::_applyReflectionNormalMapProcedure);
            fragmentLinker.setInputParams(alternativa3d::_applyReflectionNormalMapProcedure,"tNormal");
            fragmentLinker.setOutputParams(alternativa3d::_applyReflectionNormalMapProcedure,"tReflection");
         }
         else
         {
            fragmentLinker.addProcedure(alternativa3d::_applyReflectionProcedure);
            fragmentLinker.setOutputParams(alternativa3d::_applyReflectionProcedure,"tReflection");
         }
         fragmentLinker.addProcedure(_applyLightMapProcedure);
         fragmentLinker.setInputParams(_applyLightMapProcedure,"tColor");
         fragmentLinker.setOutputParams(_applyLightMapProcedure,"tColor");
         if(this.reflectionMap != null)
         {
            fragmentLinker.addProcedure(alternativa3d::_blendReflectionMap);
            fragmentLinker.setInputParams(alternativa3d::_blendReflectionMap,"tColor","tReflection");
            outputProcedure = alternativa3d::_blendReflectionMap;
         }
         else
         {
            fragmentLinker.addProcedure(alternativa3d::_blendReflection);
            fragmentLinker.setInputParams(alternativa3d::_blendReflection,"tColor","tReflection");
            outputProcedure = alternativa3d::_blendReflection;
         }
         if(alternativa3d::fogMode == alternativa3d::SIMPLE || alternativa3d::fogMode == alternativa3d::ADVANCED)
         {
            fragmentLinker.declareVariable("outColor");
            fragmentLinker.setOutputParams(outputProcedure,"outColor");
         }
         if(alternativa3d::fogMode == alternativa3d::SIMPLE)
         {
            vertexLinker.addProcedure(passSimpleFogConstProcedure);
            vertexLinker.setInputParams(passSimpleFogConstProcedure,positionVar);
            fragmentLinker.addProcedure(outputWithSimpleFogProcedure);
            fragmentLinker.setInputParams(outputWithSimpleFogProcedure,"outColor");
         }
         else if(alternativa3d::fogMode == alternativa3d::ADVANCED)
         {
            vertexLinker.declareVariable("tProjected");
            vertexLinker.setOutputParams(alternativa3d::_projectProcedure,"tProjected");
            vertexLinker.addProcedure(postPassAdvancedFogConstProcedure);
            vertexLinker.setInputParams(postPassAdvancedFogConstProcedure,positionVar,"tProjected");
            fragmentLinker.addProcedure(outputWithAdvancedFogProcedure);
            fragmentLinker.setInputParams(outputWithAdvancedFogProcedure,"outColor");
         }
         fragmentLinker.link();
         fragmentLinker.setOppositeLinker(vertexLinker);
         return new EnvironmentMaterialShaderProgram(vertexLinker,fragmentLinker);
      }
      
      override alternativa3d function collectDraws(camera:Camera3D, surface:Surface, geometry:Geometry, lights:Vector.<Light3D>, lightsLength:int, objectRenderPriority:int = -1) : void
      {
         var program:ShaderProgram = null;
         var i:int = 0;
         var lm:Transform3D = null;
         var dist:Number = NaN;
         var cLocal:Transform3D = null;
         var halfW:Number = NaN;
         var leftX:Number = NaN;
         var leftY:Number = NaN;
         var rightX:Number = NaN;
         var rightY:Number = NaN;
         var angle:Number = NaN;
         var dx:Number = NaN;
         var dy:Number = NaN;
         var lens:Number = NaN;
         var uScale:Number = NaN;
         var uRight:Number = NaN;
         var bmd:BitmapData = null;
         if(diffuseMap == null || this.environmentMap == null || diffuseMap.alternativa3d::_texture == null || this.environmentMap.alternativa3d::_texture == null)
         {
            return;
         }
         if(!name_L4 && opacityMap != null && opacityMap.alternativa3d::_texture == null)
         {
            return;
         }
         var object:Object3D = surface.alternativa3d::object;
         var positionBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(VertexAttributes.POSITION);
         var uvBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(VertexAttributes.TEXCOORDS[0]);
         var normalsBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(VertexAttributes.NORMAL);
         var tangentsBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(VertexAttributes.TANGENT4);
         if(positionBuffer == null || uvBuffer == null)
         {
            return;
         }
         var key:String = alternativa3d::fogMode.toString() + this.name_NH.toString() + (this.normalMap != null ? "N" : "n") + (opacityMap != null ? "O" : "o") + (name_L4 ? "D" : "d");
         var programs:Dictionary = _programs[object.alternativa3d::transformProcedure];
         if(programs == null)
         {
            programs = new Dictionary(false);
            _programs[object.alternativa3d::transformProcedure] = programs;
            program = this.final(object);
            program.upload(camera.alternativa3d::context3D);
            programs[key] = program;
         }
         else
         {
            program = programs[key];
            if(program == null)
            {
               program = this.final(object);
               program.upload(camera.alternativa3d::context3D);
               programs[key] = program;
            }
         }
         var drawUnit:DrawUnit = camera.alternativa3d::renderer.alternativa3d::createDrawUnit(object,program.program,geometry.name_EM,surface.indexBegin,surface.numTriangles,program);
         drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sLightMap"),this.lightMap.alternativa3d::_texture);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aPosition"),positionBuffer,geometry.alternativa3d::_attributesOffsets[VertexAttributes.POSITION],VertexAttributes.alternativa3d::FORMATS[VertexAttributes.POSITION]);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aUV"),uvBuffer,geometry.alternativa3d::_attributesOffsets[VertexAttributes.TEXCOORDS[0]],VertexAttributes.alternativa3d::FORMATS[VertexAttributes.TEXCOORDS[0]]);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aUV1"),uvBuffer,geometry.alternativa3d::_attributesOffsets[VertexAttributes.TEXCOORDS[this.lightMapChannel]],VertexAttributes.alternativa3d::FORMATS[VertexAttributes.TEXCOORDS[this.lightMapChannel]]);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aNormal"),normalsBuffer,geometry.alternativa3d::_attributesOffsets[VertexAttributes.NORMAL],VertexAttributes.alternativa3d::FORMATS[VertexAttributes.NORMAL]);
         object.alternativa3d::setTransformConstants(drawUnit,surface,program.vertexShader,camera);
         drawUnit.alternativa3d::setProjectionConstants(camera,program.vertexShader.getVariableIndex("cProjMatrix"),object.alternativa3d::localToCameraTransform);
         var camTransform:Transform3D = object.alternativa3d::cameraToLocalTransform;
         drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.fragmentShader.getVariableIndex("cCamera"),camTransform.d,camTransform.h,camTransform.l);
         var envProgram:EnvironmentMaterialShaderProgram = program as EnvironmentMaterialShaderProgram;
         if(this.normalMap != null)
         {
            drawUnit.alternativa3d::setTextureAt(envProgram.sBump,this.normalMap.alternativa3d::_texture);
            if(this.name_NH == NormalMapSpace.TANGENT_RIGHT_HANDED || this.name_NH == NormalMapSpace.TANGENT_LEFT_HANDED)
            {
               drawUnit.alternativa3d::setVertexBufferAt(envProgram.aTangent,tangentsBuffer,geometry.alternativa3d::_attributesOffsets[VertexAttributes.TANGENT4],VertexAttributes.alternativa3d::FORMATS[VertexAttributes.TANGENT4]);
            }
         }
         if(this.reflectionMap != null)
         {
            drawUnit.alternativa3d::setTextureAt(envProgram.sReflection,this.reflectionMap.alternativa3d::_texture);
         }
         drawUnit.alternativa3d::setTextureAt(envProgram.sTexture,diffuseMap.alternativa3d::_texture);
         drawUnit.alternativa3d::setTextureAt(envProgram.sCubeMap,this.environmentMap.alternativa3d::_texture);
         var cameraToLocalTransform:Transform3D = object.alternativa3d::cameraToLocalTransform;
         drawUnit.alternativa3d::setFragmentConstantsFromNumbers(envProgram.cCamera,cameraToLocalTransform.d,cameraToLocalTransform.h,cameraToLocalTransform.l);
         drawUnit.alternativa3d::setFragmentConstantsFromNumbers(envProgram.cAlpha,0,1 - this.reflection,this.reflection,alpha);
         drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sTexture"),diffuseMap.alternativa3d::_texture);
         if(!name_L4 && opacityMap != null)
         {
            drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sOpacity"),opacityMap.alternativa3d::_texture);
         }
         if(alternativa3d::fogMode == alternativa3d::SIMPLE || alternativa3d::fogMode == alternativa3d::ADVANCED)
         {
            lm = object.alternativa3d::localToCameraTransform;
            dist = alternativa3d::fogFar - alternativa3d::fogNear;
            drawUnit.alternativa3d::setVertexConstantsFromNumbers(program.vertexShader.getVariableIndex("cFogSpace"),lm.i / dist,lm.j / dist,lm.k / dist,(lm.l - alternativa3d::fogNear) / dist);
            drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.fragmentShader.getVariableIndex("cFogRange"),alternativa3d::fogMaxDensity,1,0,1 - alternativa3d::fogMaxDensity);
         }
         if(alternativa3d::fogMode == alternativa3d::SIMPLE)
         {
            drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.fragmentShader.getVariableIndex("cFogColor"),alternativa3d::fogColorR,alternativa3d::fogColorG,alternativa3d::fogColorB);
         }
         if(alternativa3d::fogMode == alternativa3d::ADVANCED)
         {
            if(alternativa3d::fogTexture == null)
            {
               bmd = new BitmapData(32,1,false,16711680);
               for(i = 0; i < 32; i++)
               {
                  bmd.setPixel(i,0,i / 32 * 255 << 16);
               }
               alternativa3d::fogTexture = new BitmapTextureResource(bmd);
               alternativa3d::fogTexture.upload(camera.alternativa3d::context3D);
            }
            cLocal = camera.alternativa3d::localToGlobalTransform;
            halfW = camera.view.width / 2;
            leftX = -halfW * cLocal.a + camera.alternativa3d::focalLength * cLocal.c;
            leftY = -halfW * cLocal.e + camera.alternativa3d::focalLength * cLocal.g;
            rightX = halfW * cLocal.a + camera.alternativa3d::focalLength * cLocal.c;
            rightY = halfW * cLocal.e + camera.alternativa3d::focalLength * cLocal.g;
            angle = Math.atan2(leftY,leftX) - Math.PI / 2;
            if(angle < 0)
            {
               angle += Math.PI * 2;
            }
            dx = rightX - leftX;
            dy = rightY - leftY;
            lens = Number(Math.sqrt(dx * dx + dy * dy));
            leftX /= lens;
            leftY /= lens;
            rightX /= lens;
            rightY /= lens;
            uScale = Math.acos(leftX * rightX + leftY * rightY) / Math.PI / 2;
            uRight = angle / Math.PI / 2;
            drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.fragmentShader.getVariableIndex("cFogConsts"),0.5 * uScale,0.5 - uRight,0);
            drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sFogTexture"),alternativa3d::fogTexture.alternativa3d::_texture);
         }
         if(name_L4 || opacityMap != null || alpha < 1)
         {
            drawUnit.alternativa3d::blendSource = Context3DBlendFactor.SOURCE_ALPHA;
            drawUnit.alternativa3d::blendDestination = Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA;
            camera.alternativa3d::renderer.alternativa3d::addDrawUnit(drawUnit,objectRenderPriority >= 0 ? objectRenderPriority : RenderPriority.TRANSPARENT_SORT);
         }
         else
         {
            camera.alternativa3d::renderer.alternativa3d::addDrawUnit(drawUnit,objectRenderPriority >= 0 ? objectRenderPriority : RenderPriority.OPAQUE);
         }
      }
   }
}

import alternativa.engine3d.materials.compiler.Linker;
import alternativa.engine3d.materials.ShaderProgram;

class EnvironmentMaterialShaderProgram extends ShaderProgram
{
   public var aTangent:int = -1;
   
   public var aNormal:int = -1;
   
   public var aPosition:int = -1;
   
   public var aUV:int = -1;
   
   public var cCamera:int = -1;
   
   public var cAlpha:int = -1;
   
   public var cProjMatrix:int = -1;
   
   public var sBump:int = -1;
   
   public var sTexture:int = -1;
   
   public var sOpacity:int = -1;
   
   public var sCubeMap:int = -1;
   
   public var sReflection:int = -1;
   
   public function EnvironmentMaterialShaderProgram(vertexShader:Linker, fragmentShader:Linker)
   {
      super(vertexShader,fragmentShader);
      this.aPosition = vertexShader.getVariableIndex("aPosition");
      this.aNormal = vertexShader.getVariableIndex("aNormal");
      this.aUV = vertexShader.getVariableIndex("aUV");
      if(fragmentShader.containsVariable("sBump"))
      {
         this.sBump = fragmentShader.getVariableIndex("sBump");
      }
      if(vertexShader.containsVariable("aTangent"))
      {
         this.aTangent = vertexShader.getVariableIndex("aTangent");
      }
      if(fragmentShader.containsVariable("sReflection"))
      {
         this.sReflection = fragmentShader.getVariableIndex("sReflection");
      }
      this.cProjMatrix = vertexShader.getVariableIndex("cProjMatrix");
      this.sTexture = fragmentShader.getVariableIndex("sTexture");
      this.sCubeMap = fragmentShader.getVariableIndex("sCubeMap");
      this.cCamera = fragmentShader.getVariableIndex("cCamera");
      this.cAlpha = fragmentShader.getVariableIndex("cAlpha");
      if(fragmentShader.containsVariable("sOpacity"))
      {
         this.sOpacity = fragmentShader.getVariableIndex("sOpacity");
      }
   }
}
