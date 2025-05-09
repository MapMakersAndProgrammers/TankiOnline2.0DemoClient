package package_3
{
   import alternativa.engine3d.alternativa3d;
   import avmplus.getQualifiedClassName;
   import flash.display.BitmapData;
   import flash.display3D.Context3DBlendFactor;
   import flash.display3D.Context3DProgramType;
   import flash.display3D.VertexBuffer3D;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import package_19.name_134;
   import package_21.name_136;
   import package_21.name_84;
   import package_21.name_86;
   import package_33.name_117;
   import package_33.name_121;
   import package_33.name_123;
   import package_33.name_126;
   import package_33.name_129;
   import package_33.name_130;
   import package_33.name_135;
   import package_34.name_116;
   import package_34.name_119;
   import package_34.name_128;
   
   use namespace alternativa3d;
   
   public class name_475 extends class_5
   {
      alternativa3d static var fogTexture:name_86;
      
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
      
      alternativa3d static const _passReflectionProcedure:name_116 = new name_116(["#v1=vNormal","#v0=vPosition","mov v0, i0","mov v1, i1"],"passReflectionProcedure");
      
      alternativa3d static const _applyReflectionProcedure:name_116 = new name_116(["#v1=vNormal","#v0=vPosition","#s0=sCubeMap","#c0=cCamera","sub t0, v0, c0","dp3 t1.x, v1, t0","add t1.x, t1.x, t1.x","mul t1, v1, t1.x","sub t1, t0, t1","nrm t1.xyz, t1.xyz","tex o0, t1, s0 <cube,clamp,linear,nomip>"],"applyReflectionProcedure");
      
      alternativa3d static const _applyReflectionNormalMapProcedure:name_116 = new name_116(["#s0=sCubeMap","#c0=cCamera","#v0=vPosition","sub t0, v0, c0","dp3 t1.x, i0.xyz, t0","add t1.x, t1.x, t1.x","mul t1, i0.xyz, t1.x","sub t1, t0, t1","nrm t1.xyz, t1.xyz","tex o0, t1, s0 <cube,clamp,linear,nomip>"],"applyReflectionNormalMapProcedure");
      
      alternativa3d static const _blendReflection:name_116 = new name_116(["#c0=cAlpha","mul t1, i0, c0.y","mul t0.xyz, i1, c0.z","add t0.xyz, t1, t0","mov t0.w, i0.w","mov o0, t0"],"blendReflection");
      
      alternativa3d static const _blendReflectionMap:name_116 = new name_116(["#c0=cCamera","#c1=cAlpha","#s0=sReflection","#v0=vUV","tex t0, v0, s0 <2d,repeat,linear,miplinear>","mul t0, t0, c1.z","mul t1.xyz, i1, t0","sub t0, c0.www, t0","mul t2, i0, t0","add t0.xyz, t1, t2","mov t0.w, i0.w","mov o0, t0"],"blendReflectionMap");
      
      private static const _passTBNRightProcedure:name_116 = method_328(true);
      
      private static const _passTBNLeftProcedure:name_116 = method_328(false);
      
      private static const _getNormalTangentProcedure:name_116 = new name_116(["#v0=vTangent","#v1=vBinormal","#v2=vNormal","#v3=vUV","#c0=cCamera","#s0=sBump","tex t0, v3, s0 <2d,repeat,linear,miplinear>","add t0, t0, t0","sub t0.xyz, t0.xyz, c0.www","nrm t1.xyz, v0.xyz","dp3 o0.x, t0.xyz, t1.xyz","nrm t1.xyz, v1.xyz","dp3 o0.y, t0.xyz, t1.xyz","nrm t1.xyz, v2.xyz","dp3 o0.z, t0.xyz, t1.xyz","nrm o0.xyz, o0.xyz"],"getNormalTangentProcedure");
      
      private static const _getNormalObjectProcedure:name_116 = new name_116(["#v3=vUV","#c0=cCamera","#s0=sBump","tex t0, v3, s0 <2d,repeat,linear,miplinear>","add t0, t0, t0","sub t0.xyz, t0.xyz, c0.www","nrm o0.xyz, t0.xyz"],"getNormalObjectProcedure");
      
      private static const passSimpleFogConstProcedure:name_116 = new name_116(["#v0=vZDistance","#c0=cFogSpace","dp4 t0.z, i0, c0","mov v0, t0.zzzz","sub v0.y, i0.w, t0.z"],"passSimpleFogConst");
      
      private static const outputWithSimpleFogProcedure:name_116 = new name_116(["#v0=vZDistance","#c0=cFogColor","#c1=cFogRange","min t0.xy, v0.xy, c1.xy","max t0.xy, t0.xy, c1.zw","mul i0.xyz, i0.xyz, t0.y","mul t0.xyz, c0.xyz, t0.x","add i0.xyz, i0.xyz, t0.xyz","mov o0, i0"],"outputWithSimpleFog");
      
      private static const postPassAdvancedFogConstProcedure:name_116 = new name_116(["#v0=vZDistance","#c0=cFogSpace","dp4 t0.z, i0, c0","mov v0, t0.zzzz","sub v0.y, i0.w, t0.z","mov v0.zw, i1.xwxw","mov o0, i1"],"postPassAdvancedFogConst");
      
      private static const outputWithAdvancedFogProcedure:name_116 = new name_116(["#v0=vZDistance","#c0=cFogConsts","#c1=cFogRange","#s0=sFogTexture","min t0.xy, v0.xy, c1.xy","max t0.xy, t0.xy, c1.zw","mul i0.xyz, i0.xyz, t0.y","mov t1.xyzw, c0.yyzw","div t0.z, v0.z, v0.w","mul t0.z, t0.z, c0.x","add t1.x, t1.x, t0.z","tex t1, t1, s0 <2d, repeat, linear, miplinear>","mul t0.xyz, t1.xyz, t0.x","add i0.xyz, i0.xyz, t0.xyz","mov o0, i0"],"outputWithAdvancedFog");
      
      private static const _applyLightMapProcedure:name_116 = new name_116(["#v0=vUV1","#s0=sLightMap","tex t0, v0, s0 <2d,repeat,linear,mipnone>","add t0, t0, t0","mul i0.xyz, i0.xyz, t0.xyz","mov o0, i0"],"applyLightMapProcedure");
      
      private static const _passLightMapUVProcedure:name_116 = new name_116(["#a0=aUV1","#v0=vUV1","mov v0, a0"],"passLightMapUVProcedure");
      
      private var var_53:int = 0;
      
      public var normalMap:name_86;
      
      public var environmentMap:name_86;
      
      public var reflection:Number = 1;
      
      public var reflectionMap:name_86;
      
      public var lightMap:name_86;
      
      public var lightMapChannel:uint = 1;
      
      public function name_475(diffuseMap:name_86 = null, environmentMap:name_86 = null, normalMap:name_86 = null, reflectionMap:name_86 = null, lightMap:name_86 = null, opacityMap:name_86 = null, alpha:Number = 1)
      {
         super(diffuseMap,opacityMap,alpha);
         this.environmentMap = environmentMap;
         this.normalMap = normalMap;
         this.reflectionMap = reflectionMap;
         this.lightMap = lightMap;
      }
      
      private static function method_328(right:Boolean) : name_116
      {
         var crsInSpace:String = right ? "crs t1.xyz, i0, i1" : "crs t1.xyz, i1, i0";
         return new name_116(["#v0=vTangent","#v1=vBinormal","#v2=vNormal",crsInSpace,"mul t1.xyz, t1.xyz, i0.w","mov v0.x, i0.x","mov v0.y, t1.x","mov v0.z, i1.x","mov v0.w, i1.w","mov v1.x, i0.y","mov v1.y, t1.y","mov v1.z, i1.y","mov v1.w, i1.w","mov v2.x, i0.z","mov v2.y, t1.z","mov v2.z, i1.z","mov v2.w, i1.w"],"passTBNProcedure");
      }
      
      public function get method_329() : int
      {
         return this.var_53;
      }
      
      public function set method_329(value:int) : void
      {
         if(value != name_566.TANGENT_RIGHT_HANDED && value != name_566.TANGENT_LEFT_HANDED && value != name_566.OBJECT)
         {
            throw new ArgumentError("Value must be a constant from the NormalMapSpace class");
         }
         this.var_53 = value;
      }
      
      override alternativa3d function fillResources(resources:Dictionary, resourceType:Class) : void
      {
         super.alternativa3d::fillResources(resources,resourceType);
         if(this.environmentMap != null && Boolean(name_29.alternativa3d::name_133(getDefinitionByName(getQualifiedClassName(this.environmentMap)) as Class,resourceType)))
         {
            resources[this.environmentMap] = true;
         }
         if(this.normalMap != null && Boolean(name_29.alternativa3d::name_133(getDefinitionByName(getQualifiedClassName(this.normalMap)) as Class,resourceType)))
         {
            resources[this.normalMap] = true;
         }
         if(this.reflectionMap != null && Boolean(name_29.alternativa3d::name_133(getDefinitionByName(getQualifiedClassName(this.reflectionMap)) as Class,resourceType)))
         {
            resources[this.reflectionMap] = true;
         }
         if(this.lightMap != null && Boolean(name_29.alternativa3d::name_133(getDefinitionByName(getQualifiedClassName(this.lightMap)) as Class,resourceType)))
         {
            resources[this.lightMap] = true;
         }
      }
      
      private function method_22(targetObject:name_130) : EnvironmentMaterialShaderProgram
      {
         var procedure:name_116 = null;
         var outputProcedure:name_116 = null;
         var nrmProcedure:name_116 = null;
         var vertexLinker:name_119 = new name_119(Context3DProgramType.VERTEX);
         var fragmentLinker:name_119 = new name_119(Context3DProgramType.FRAGMENT);
         var positionVar:String = "aPosition";
         var normalVar:String = "aNormal";
         var tangentVar:String = "aTangent";
         vertexLinker.name_125(positionVar,name_128.ATTRIBUTE);
         vertexLinker.name_125(normalVar,name_128.ATTRIBUTE);
         if(targetObject.alternativa3d::transformProcedure != null)
         {
            positionVar = alternativa3d::name_131(targetObject.alternativa3d::transformProcedure,vertexLinker);
         }
         if(targetObject.alternativa3d::deltaTransformProcedure != null)
         {
            vertexLinker.name_125("tTransformedNormal");
            procedure = targetObject.alternativa3d::deltaTransformProcedure.name_569();
            vertexLinker.name_120(procedure);
            vertexLinker.name_122(procedure,normalVar);
            vertexLinker.name_127(procedure,"tTransformedNormal");
            normalVar = "tTransformedNormal";
            if((this.var_53 == name_566.TANGENT_RIGHT_HANDED || this.var_53 == name_566.TANGENT_LEFT_HANDED) && this.normalMap != null)
            {
               vertexLinker.name_125(tangentVar,name_128.ATTRIBUTE);
               vertexLinker.name_125("tTransformedTangent");
               procedure = targetObject.alternativa3d::deltaTransformProcedure.name_569();
               vertexLinker.name_120(procedure);
               vertexLinker.name_122(procedure,tangentVar);
               vertexLinker.name_127(procedure,"tTransformedTangent");
               tangentVar = "tTransformedTangent";
            }
         }
         else if((this.var_53 == name_566.TANGENT_RIGHT_HANDED || this.var_53 == name_566.TANGENT_LEFT_HANDED) && this.normalMap != null)
         {
            vertexLinker.name_125(tangentVar,name_128.ATTRIBUTE);
         }
         vertexLinker.name_120(_passLightMapUVProcedure);
         vertexLinker.name_120(alternativa3d::_passReflectionProcedure);
         vertexLinker.name_122(alternativa3d::_passReflectionProcedure,positionVar,normalVar);
         vertexLinker.name_120(alternativa3d::_projectProcedure);
         vertexLinker.name_122(alternativa3d::_projectProcedure,positionVar);
         vertexLinker.name_120(alternativa3d::_passUVProcedure);
         if(this.normalMap != null)
         {
            fragmentLinker.name_125("tNormal");
            if(this.var_53 == name_566.TANGENT_RIGHT_HANDED || this.var_53 == name_566.TANGENT_LEFT_HANDED)
            {
               nrmProcedure = this.var_53 == name_566.TANGENT_RIGHT_HANDED ? _passTBNRightProcedure : _passTBNLeftProcedure;
               vertexLinker.name_120(nrmProcedure);
               vertexLinker.name_122(nrmProcedure,tangentVar,normalVar);
               fragmentLinker.name_120(_getNormalTangentProcedure);
               fragmentLinker.name_127(_getNormalTangentProcedure,"tNormal");
            }
            else
            {
               fragmentLinker.name_120(_getNormalObjectProcedure);
               fragmentLinker.name_127(_getNormalObjectProcedure,"tNormal");
            }
         }
         vertexLinker.name_568();
         fragmentLinker.name_125("tColor");
         if(var_21)
         {
            fragmentLinker.name_120(alternativa3d::_samplerSetProcedureDiffuseAlpha);
            fragmentLinker.name_127(alternativa3d::_samplerSetProcedureDiffuseAlpha,"tColor");
         }
         else if(opacityMap != null)
         {
            fragmentLinker.name_120(alternativa3d::_samplerSetProcedureOpacity);
            fragmentLinker.name_127(alternativa3d::_samplerSetProcedureOpacity,"tColor");
         }
         else
         {
            fragmentLinker.name_120(alternativa3d::_samplerSetProcedure);
            fragmentLinker.name_127(alternativa3d::_samplerSetProcedure,"tColor");
         }
         fragmentLinker.name_125("tReflection");
         if(this.normalMap != null)
         {
            fragmentLinker.name_120(alternativa3d::_applyReflectionNormalMapProcedure);
            fragmentLinker.name_122(alternativa3d::_applyReflectionNormalMapProcedure,"tNormal");
            fragmentLinker.name_127(alternativa3d::_applyReflectionNormalMapProcedure,"tReflection");
         }
         else
         {
            fragmentLinker.name_120(alternativa3d::_applyReflectionProcedure);
            fragmentLinker.name_127(alternativa3d::_applyReflectionProcedure,"tReflection");
         }
         fragmentLinker.name_120(_applyLightMapProcedure);
         fragmentLinker.name_122(_applyLightMapProcedure,"tColor");
         fragmentLinker.name_127(_applyLightMapProcedure,"tColor");
         if(this.reflectionMap != null)
         {
            fragmentLinker.name_120(alternativa3d::_blendReflectionMap);
            fragmentLinker.name_122(alternativa3d::_blendReflectionMap,"tColor","tReflection");
            outputProcedure = alternativa3d::_blendReflectionMap;
         }
         else
         {
            fragmentLinker.name_120(alternativa3d::_blendReflection);
            fragmentLinker.name_122(alternativa3d::_blendReflection,"tColor","tReflection");
            outputProcedure = alternativa3d::_blendReflection;
         }
         if(alternativa3d::fogMode == alternativa3d::SIMPLE || alternativa3d::fogMode == alternativa3d::ADVANCED)
         {
            fragmentLinker.name_125("outColor");
            fragmentLinker.name_127(outputProcedure,"outColor");
         }
         if(alternativa3d::fogMode == alternativa3d::SIMPLE)
         {
            vertexLinker.name_120(passSimpleFogConstProcedure);
            vertexLinker.name_122(passSimpleFogConstProcedure,positionVar);
            fragmentLinker.name_120(outputWithSimpleFogProcedure);
            fragmentLinker.name_122(outputWithSimpleFogProcedure,"outColor");
         }
         else if(alternativa3d::fogMode == alternativa3d::ADVANCED)
         {
            vertexLinker.name_125("tProjected");
            vertexLinker.name_127(alternativa3d::_projectProcedure,"tProjected");
            vertexLinker.name_120(postPassAdvancedFogConstProcedure);
            vertexLinker.name_122(postPassAdvancedFogConstProcedure,positionVar,"tProjected");
            fragmentLinker.name_120(outputWithAdvancedFogProcedure);
            fragmentLinker.name_122(outputWithAdvancedFogProcedure,"outColor");
         }
         fragmentLinker.name_568();
         fragmentLinker.name_140(vertexLinker);
         return new EnvironmentMaterialShaderProgram(vertexLinker,fragmentLinker);
      }
      
      override alternativa3d function collectDraws(camera:name_135, surface:name_134, geometry:name_136, lights:Vector.<name_121>, lightsLength:int, objectRenderPriority:int = -1) : void
      {
         var program:class_6 = null;
         var i:int = 0;
         var lm:name_129 = null;
         var dist:Number = NaN;
         var cLocal:name_129 = null;
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
         if(!var_21 && opacityMap != null && opacityMap.alternativa3d::_texture == null)
         {
            return;
         }
         var object:name_130 = surface.alternativa3d::object;
         var positionBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(name_117.POSITION);
         var uvBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(name_117.TEXCOORDS[0]);
         var normalsBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(name_117.NORMAL);
         var tangentsBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(name_117.TANGENT4);
         if(positionBuffer == null || uvBuffer == null)
         {
            return;
         }
         var key:String = alternativa3d::fogMode.toString() + this.var_53.toString() + (this.normalMap != null ? "N" : "n") + (opacityMap != null ? "O" : "o") + (!!var_21 ? "D" : "d");
         var programs:Dictionary = _programs[object.alternativa3d::transformProcedure];
         if(programs == null)
         {
            programs = new Dictionary(false);
            _programs[object.alternativa3d::transformProcedure] = programs;
            program = this.method_22(object);
            program.upload(camera.alternativa3d::context3D);
            programs[key] = program;
         }
         else
         {
            program = programs[key];
            if(program == null)
            {
               program = this.method_22(object);
               program.upload(camera.alternativa3d::context3D);
               programs[key] = program;
            }
         }
         var drawUnit:name_123 = camera.alternativa3d::renderer.alternativa3d::name_138(object,program.program,geometry.alternativa3d::name_78,surface.indexBegin,surface.numTriangles,program);
         drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sLightMap"),this.lightMap.alternativa3d::_texture);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aPosition"),positionBuffer,geometry.alternativa3d::_attributesOffsets[name_117.POSITION],name_117.alternativa3d::FORMATS[name_117.POSITION]);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aUV"),uvBuffer,geometry.alternativa3d::_attributesOffsets[name_117.TEXCOORDS[0]],name_117.alternativa3d::FORMATS[name_117.TEXCOORDS[0]]);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aUV1"),uvBuffer,geometry.alternativa3d::_attributesOffsets[name_117.TEXCOORDS[this.lightMapChannel]],name_117.alternativa3d::FORMATS[name_117.TEXCOORDS[this.lightMapChannel]]);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aNormal"),normalsBuffer,geometry.alternativa3d::_attributesOffsets[name_117.NORMAL],name_117.alternativa3d::FORMATS[name_117.NORMAL]);
         object.alternativa3d::setTransformConstants(drawUnit,surface,program.vertexShader,camera);
         drawUnit.alternativa3d::name_141(camera,program.vertexShader.getVariableIndex("cProjMatrix"),object.alternativa3d::localToCameraTransform);
         var camTransform:name_129 = object.alternativa3d::cameraToLocalTransform;
         drawUnit.alternativa3d::name_124(program.fragmentShader.getVariableIndex("cCamera"),camTransform.d,camTransform.h,camTransform.l);
         var envProgram:EnvironmentMaterialShaderProgram = program as EnvironmentMaterialShaderProgram;
         if(this.normalMap != null)
         {
            drawUnit.alternativa3d::setTextureAt(envProgram.sBump,this.normalMap.alternativa3d::_texture);
            if(this.var_53 == name_566.TANGENT_RIGHT_HANDED || this.var_53 == name_566.TANGENT_LEFT_HANDED)
            {
               drawUnit.alternativa3d::setVertexBufferAt(envProgram.aTangent,tangentsBuffer,geometry.alternativa3d::_attributesOffsets[name_117.TANGENT4],name_117.alternativa3d::FORMATS[name_117.TANGENT4]);
            }
         }
         if(this.reflectionMap != null)
         {
            drawUnit.alternativa3d::setTextureAt(envProgram.sReflection,this.reflectionMap.alternativa3d::_texture);
         }
         drawUnit.alternativa3d::setTextureAt(envProgram.sTexture,diffuseMap.alternativa3d::_texture);
         drawUnit.alternativa3d::setTextureAt(envProgram.sCubeMap,this.environmentMap.alternativa3d::_texture);
         var cameraToLocalTransform:name_129 = object.alternativa3d::cameraToLocalTransform;
         drawUnit.alternativa3d::name_124(envProgram.cCamera,cameraToLocalTransform.d,cameraToLocalTransform.h,cameraToLocalTransform.l);
         drawUnit.alternativa3d::name_124(envProgram.cAlpha,0,1 - this.reflection,this.reflection,alpha);
         drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sTexture"),diffuseMap.alternativa3d::_texture);
         if(!var_21 && opacityMap != null)
         {
            drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sOpacity"),opacityMap.alternativa3d::_texture);
         }
         if(alternativa3d::fogMode == alternativa3d::SIMPLE || alternativa3d::fogMode == alternativa3d::ADVANCED)
         {
            lm = object.alternativa3d::localToCameraTransform;
            dist = alternativa3d::fogFar - alternativa3d::fogNear;
            drawUnit.alternativa3d::name_143(program.vertexShader.getVariableIndex("cFogSpace"),lm.i / dist,lm.j / dist,lm.k / dist,(lm.l - alternativa3d::fogNear) / dist);
            drawUnit.alternativa3d::name_124(program.fragmentShader.getVariableIndex("cFogRange"),alternativa3d::fogMaxDensity,1,0,1 - alternativa3d::fogMaxDensity);
         }
         if(alternativa3d::fogMode == alternativa3d::SIMPLE)
         {
            drawUnit.alternativa3d::name_124(program.fragmentShader.getVariableIndex("cFogColor"),alternativa3d::fogColorR,alternativa3d::fogColorG,alternativa3d::fogColorB);
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
               alternativa3d::fogTexture = new name_84(bmd);
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
            drawUnit.alternativa3d::name_124(program.fragmentShader.getVariableIndex("cFogConsts"),0.5 * uScale,0.5 - uRight,0);
            drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sFogTexture"),alternativa3d::fogTexture.alternativa3d::_texture);
         }
         if(Boolean(var_21) || opacityMap != null || alpha < 1)
         {
            drawUnit.alternativa3d::blendSource = Context3DBlendFactor.SOURCE_ALPHA;
            drawUnit.alternativa3d::blendDestination = Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA;
            camera.alternativa3d::renderer.alternativa3d::name_132(drawUnit,objectRenderPriority >= 0 ? objectRenderPriority : int(name_126.TRANSPARENT_SORT));
         }
         else
         {
            camera.alternativa3d::renderer.alternativa3d::name_132(drawUnit,objectRenderPriority >= 0 ? objectRenderPriority : int(name_126.OPAQUE));
         }
      }
   }
}

import package_34.name_119;

class EnvironmentMaterialShaderProgram extends class_6
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
   
   public function EnvironmentMaterialShaderProgram(vertexShader:name_119, fragmentShader:name_119)
   {
      super(vertexShader,fragmentShader);
      this.aPosition = vertexShader.getVariableIndex("aPosition");
      this.aNormal = vertexShader.getVariableIndex("aNormal");
      this.aUV = vertexShader.getVariableIndex("aUV");
      if(fragmentShader.name_567("sBump"))
      {
         this.sBump = fragmentShader.getVariableIndex("sBump");
      }
      if(vertexShader.name_567("aTangent"))
      {
         this.aTangent = vertexShader.getVariableIndex("aTangent");
      }
      if(fragmentShader.name_567("sReflection"))
      {
         this.sReflection = fragmentShader.getVariableIndex("sReflection");
      }
      this.cProjMatrix = vertexShader.getVariableIndex("cProjMatrix");
      this.sTexture = fragmentShader.getVariableIndex("sTexture");
      this.sCubeMap = fragmentShader.getVariableIndex("sCubeMap");
      this.cCamera = fragmentShader.getVariableIndex("cCamera");
      this.cAlpha = fragmentShader.getVariableIndex("cAlpha");
      if(fragmentShader.name_567("sOpacity"))
      {
         this.sOpacity = fragmentShader.getVariableIndex("sOpacity");
      }
   }
}
