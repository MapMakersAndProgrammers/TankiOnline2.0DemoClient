package §_-Vh§
{
   import §_-1z§.§_-b1§;
   import §_-1z§.§_-gA§;
   import §_-1z§.§_-pi§;
   import §_-8D§.§_-Jo§;
   import §_-8D§.§_-OX§;
   import §_-8D§.§_-QF§;
   import §_-8D§.§_-WR§;
   import §_-8D§.§_-be§;
   import §_-8D§.§_-d6§;
   import §_-8D§.§_-jw§;
   import §_-Ex§.§_-a2§;
   import §_-M8§.§_-5§;
   import §_-M8§.§_-Xk§;
   import §_-M8§.§_-hR§;
   import alternativa.engine3d.alternativa3d;
   import avmplus.getQualifiedClassName;
   import flash.display.BitmapData;
   import flash.display3D.Context3DBlendFactor;
   import flash.display3D.Context3DProgramType;
   import flash.display3D.VertexBuffer3D;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   
   use namespace alternativa3d;
   
   public class §_-18§ extends §_-pZ§
   {
      alternativa3d static var fogTexture:§_-pi§;
      
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
      
      alternativa3d static const _passReflectionProcedure:§_-Xk§ = new §_-Xk§(["#v1=vNormal","#v0=vPosition","mov v0, i0","mov v1, i1"],"passReflectionProcedure");
      
      alternativa3d static const _applyReflectionProcedure:§_-Xk§ = new §_-Xk§(["#v1=vNormal","#v0=vPosition","#s0=sCubeMap","#c0=cCamera","sub t0, v0, c0","dp3 t1.x, v1, t0","add t1.x, t1.x, t1.x","mul t1, v1, t1.x","sub t1, t0, t1","nrm t1.xyz, t1.xyz","tex o0, t1, s0 <cube,clamp,linear,nomip>"],"applyReflectionProcedure");
      
      alternativa3d static const _applyReflectionNormalMapProcedure:§_-Xk§ = new §_-Xk§(["#s0=sCubeMap","#c0=cCamera","#v0=vPosition","sub t0, v0, c0","dp3 t1.x, i0.xyz, t0","add t1.x, t1.x, t1.x","mul t1, i0.xyz, t1.x","sub t1, t0, t1","nrm t1.xyz, t1.xyz","tex o0, t1, s0 <cube,clamp,linear,nomip>"],"applyReflectionNormalMapProcedure");
      
      alternativa3d static const _blendReflection:§_-Xk§ = new §_-Xk§(["#c0=cAlpha","mul t1, i0, c0.y","mul t0.xyz, i1, c0.z","add t0.xyz, t1, t0","mov t0.w, i0.w","mov o0, t0"],"blendReflection");
      
      alternativa3d static const _blendReflectionMap:§_-Xk§ = new §_-Xk§(["#c0=cCamera","#c1=cAlpha","#s0=sReflection","#v0=vUV","tex t0, v0, s0 <2d,repeat,linear,miplinear>","mul t0, t0, c1.z","mul t1.xyz, i1, t0","sub t0, c0.www, t0","mul t2, i0, t0","add t0.xyz, t1, t2","mov t0.w, i0.w","mov o0, t0"],"blendReflectionMap");
      
      private static const _passTBNRightProcedure:§_-Xk§ = §_-eg§(true);
      
      private static const _passTBNLeftProcedure:§_-Xk§ = §_-eg§(false);
      
      private static const _getNormalTangentProcedure:§_-Xk§ = new §_-Xk§(["#v0=vTangent","#v1=vBinormal","#v2=vNormal","#v3=vUV","#c0=cCamera","#s0=sBump","tex t0, v3, s0 <2d,repeat,linear,miplinear>","add t0, t0, t0","sub t0.xyz, t0.xyz, c0.www","nrm t1.xyz, v0.xyz","dp3 o0.x, t0.xyz, t1.xyz","nrm t1.xyz, v1.xyz","dp3 o0.y, t0.xyz, t1.xyz","nrm t1.xyz, v2.xyz","dp3 o0.z, t0.xyz, t1.xyz","nrm o0.xyz, o0.xyz"],"getNormalTangentProcedure");
      
      private static const _getNormalObjectProcedure:§_-Xk§ = new §_-Xk§(["#v3=vUV","#c0=cCamera","#s0=sBump","tex t0, v3, s0 <2d,repeat,linear,miplinear>","add t0, t0, t0","sub t0.xyz, t0.xyz, c0.www","nrm o0.xyz, t0.xyz"],"getNormalObjectProcedure");
      
      private static const passSimpleFogConstProcedure:§_-Xk§ = new §_-Xk§(["#v0=vZDistance","#c0=cFogSpace","dp4 t0.z, i0, c0","mov v0, t0.zzzz","sub v0.y, i0.w, t0.z"],"passSimpleFogConst");
      
      private static const outputWithSimpleFogProcedure:§_-Xk§ = new §_-Xk§(["#v0=vZDistance","#c0=cFogColor","#c1=cFogRange","min t0.xy, v0.xy, c1.xy","max t0.xy, t0.xy, c1.zw","mul i0.xyz, i0.xyz, t0.y","mul t0.xyz, c0.xyz, t0.x","add i0.xyz, i0.xyz, t0.xyz","mov o0, i0"],"outputWithSimpleFog");
      
      private static const postPassAdvancedFogConstProcedure:§_-Xk§ = new §_-Xk§(["#v0=vZDistance","#c0=cFogSpace","dp4 t0.z, i0, c0","mov v0, t0.zzzz","sub v0.y, i0.w, t0.z","mov v0.zw, i1.xwxw","mov o0, i1"],"postPassAdvancedFogConst");
      
      private static const outputWithAdvancedFogProcedure:§_-Xk§ = new §_-Xk§(["#v0=vZDistance","#c0=cFogConsts","#c1=cFogRange","#s0=sFogTexture","min t0.xy, v0.xy, c1.xy","max t0.xy, t0.xy, c1.zw","mul i0.xyz, i0.xyz, t0.y","mov t1.xyzw, c0.yyzw","div t0.z, v0.z, v0.w","mul t0.z, t0.z, c0.x","add t1.x, t1.x, t0.z","tex t1, t1, s0 <2d, repeat, linear, miplinear>","mul t0.xyz, t1.xyz, t0.x","add i0.xyz, i0.xyz, t0.xyz","mov o0, i0"],"outputWithAdvancedFog");
      
      private static const _applyLightMapProcedure:§_-Xk§ = new §_-Xk§(["#v0=vUV1","#s0=sLightMap","tex t0, v0, s0 <2d,repeat,linear,mipnone>","add t0, t0, t0","mul i0.xyz, i0.xyz, t0.xyz","mov o0, i0"],"applyLightMapProcedure");
      
      private static const _passLightMapUVProcedure:§_-Xk§ = new §_-Xk§(["#a0=aUV1","#v0=vUV1","mov v0, a0"],"passLightMapUVProcedure");
      
      private var §_-NH§:int = 0;
      
      public var normalMap:§_-pi§;
      
      public var environmentMap:§_-pi§;
      
      public var reflection:Number = 1;
      
      public var reflectionMap:§_-pi§;
      
      public var lightMap:§_-pi§;
      
      public var lightMapChannel:uint = 1;
      
      public function §_-18§(diffuseMap:§_-pi§ = null, environmentMap:§_-pi§ = null, normalMap:§_-pi§ = null, reflectionMap:§_-pi§ = null, lightMap:§_-pi§ = null, opacityMap:§_-pi§ = null, alpha:Number = 1)
      {
         super(diffuseMap,opacityMap,alpha);
         this.environmentMap = environmentMap;
         this.normalMap = normalMap;
         this.reflectionMap = reflectionMap;
         this.lightMap = lightMap;
      }
      
      private static function §_-eg§(right:Boolean) : §_-Xk§
      {
         var crsInSpace:String = right ? "crs t1.xyz, i0, i1" : "crs t1.xyz, i1, i0";
         return new §_-Xk§(["#v0=vTangent","#v1=vBinormal","#v2=vNormal",crsInSpace,"mul t1.xyz, t1.xyz, i0.w","mov v0.x, i0.x","mov v0.y, t1.x","mov v0.z, i1.x","mov v0.w, i1.w","mov v1.x, i0.y","mov v1.y, t1.y","mov v1.z, i1.y","mov v1.w, i1.w","mov v2.x, i0.z","mov v2.y, t1.z","mov v2.z, i1.z","mov v2.w, i1.w"],"passTBNProcedure");
      }
      
      public function get §_-Q8§() : int
      {
         return this.§_-NH§;
      }
      
      public function set §_-Q8§(value:int) : void
      {
         if(value != §_-12§.TANGENT_RIGHT_HANDED && value != §_-12§.TANGENT_LEFT_HANDED && value != §_-12§.OBJECT)
         {
            throw new ArgumentError("Value must be a constant from the NormalMapSpace class");
         }
         this.§_-NH§ = value;
      }
      
      override alternativa3d function fillResources(resources:Dictionary, resourceType:Class) : void
      {
         super.alternativa3d::fillResources(resources,resourceType);
         if(this.environmentMap != null && Boolean(§_-Pt§.alternativa3d::_-EU(getDefinitionByName(getQualifiedClassName(this.environmentMap)) as Class,resourceType)))
         {
            resources[this.environmentMap] = true;
         }
         if(this.normalMap != null && Boolean(§_-Pt§.alternativa3d::_-EU(getDefinitionByName(getQualifiedClassName(this.normalMap)) as Class,resourceType)))
         {
            resources[this.normalMap] = true;
         }
         if(this.reflectionMap != null && Boolean(§_-Pt§.alternativa3d::_-EU(getDefinitionByName(getQualifiedClassName(this.reflectionMap)) as Class,resourceType)))
         {
            resources[this.reflectionMap] = true;
         }
         if(this.lightMap != null && Boolean(§_-Pt§.alternativa3d::_-EU(getDefinitionByName(getQualifiedClassName(this.lightMap)) as Class,resourceType)))
         {
            resources[this.lightMap] = true;
         }
      }
      
      private function final(targetObject:§_-OX§) : EnvironmentMaterialShaderProgram
      {
         var procedure:§_-Xk§ = null;
         var outputProcedure:§_-Xk§ = null;
         var nrmProcedure:§_-Xk§ = null;
         var vertexLinker:§_-hR§ = new §_-hR§(Context3DProgramType.VERTEX);
         var fragmentLinker:§_-hR§ = new §_-hR§(Context3DProgramType.FRAGMENT);
         var positionVar:String = "aPosition";
         var normalVar:String = "aNormal";
         var tangentVar:String = "aTangent";
         vertexLinker.§_-LU§(positionVar,§_-5§.ATTRIBUTE);
         vertexLinker.§_-LU§(normalVar,§_-5§.ATTRIBUTE);
         if(targetObject.alternativa3d::transformProcedure != null)
         {
            positionVar = alternativa3d::_-di(targetObject.alternativa3d::transformProcedure,vertexLinker);
         }
         if(targetObject.alternativa3d::deltaTransformProcedure != null)
         {
            vertexLinker.§_-LU§("tTransformedNormal");
            procedure = targetObject.alternativa3d::deltaTransformProcedure.§_-mY§();
            vertexLinker.§_-on§(procedure);
            vertexLinker.§_-FS§(procedure,normalVar);
            vertexLinker.§_-qd§(procedure,"tTransformedNormal");
            normalVar = "tTransformedNormal";
            if((this.§_-NH§ == §_-12§.TANGENT_RIGHT_HANDED || this.§_-NH§ == §_-12§.TANGENT_LEFT_HANDED) && this.normalMap != null)
            {
               vertexLinker.§_-LU§(tangentVar,§_-5§.ATTRIBUTE);
               vertexLinker.§_-LU§("tTransformedTangent");
               procedure = targetObject.alternativa3d::deltaTransformProcedure.§_-mY§();
               vertexLinker.§_-on§(procedure);
               vertexLinker.§_-FS§(procedure,tangentVar);
               vertexLinker.§_-qd§(procedure,"tTransformedTangent");
               tangentVar = "tTransformedTangent";
            }
         }
         else if((this.§_-NH§ == §_-12§.TANGENT_RIGHT_HANDED || this.§_-NH§ == §_-12§.TANGENT_LEFT_HANDED) && this.normalMap != null)
         {
            vertexLinker.§_-LU§(tangentVar,§_-5§.ATTRIBUTE);
         }
         vertexLinker.§_-on§(_passLightMapUVProcedure);
         vertexLinker.§_-on§(alternativa3d::_passReflectionProcedure);
         vertexLinker.§_-FS§(alternativa3d::_passReflectionProcedure,positionVar,normalVar);
         vertexLinker.§_-on§(alternativa3d::_projectProcedure);
         vertexLinker.§_-FS§(alternativa3d::_projectProcedure,positionVar);
         vertexLinker.§_-on§(alternativa3d::_passUVProcedure);
         if(this.normalMap != null)
         {
            fragmentLinker.§_-LU§("tNormal");
            if(this.§_-NH§ == §_-12§.TANGENT_RIGHT_HANDED || this.§_-NH§ == §_-12§.TANGENT_LEFT_HANDED)
            {
               nrmProcedure = this.§_-NH§ == §_-12§.TANGENT_RIGHT_HANDED ? _passTBNRightProcedure : _passTBNLeftProcedure;
               vertexLinker.§_-on§(nrmProcedure);
               vertexLinker.§_-FS§(nrmProcedure,tangentVar,normalVar);
               fragmentLinker.§_-on§(_getNormalTangentProcedure);
               fragmentLinker.§_-qd§(_getNormalTangentProcedure,"tNormal");
            }
            else
            {
               fragmentLinker.§_-on§(_getNormalObjectProcedure);
               fragmentLinker.§_-qd§(_getNormalObjectProcedure,"tNormal");
            }
         }
         vertexLinker.§_-XI§();
         fragmentLinker.§_-LU§("tColor");
         if(§_-L4§)
         {
            fragmentLinker.§_-on§(alternativa3d::_samplerSetProcedureDiffuseAlpha);
            fragmentLinker.§_-qd§(alternativa3d::_samplerSetProcedureDiffuseAlpha,"tColor");
         }
         else if(opacityMap != null)
         {
            fragmentLinker.§_-on§(alternativa3d::_samplerSetProcedureOpacity);
            fragmentLinker.§_-qd§(alternativa3d::_samplerSetProcedureOpacity,"tColor");
         }
         else
         {
            fragmentLinker.§_-on§(alternativa3d::_samplerSetProcedure);
            fragmentLinker.§_-qd§(alternativa3d::_samplerSetProcedure,"tColor");
         }
         fragmentLinker.§_-LU§("tReflection");
         if(this.normalMap != null)
         {
            fragmentLinker.§_-on§(alternativa3d::_applyReflectionNormalMapProcedure);
            fragmentLinker.§_-FS§(alternativa3d::_applyReflectionNormalMapProcedure,"tNormal");
            fragmentLinker.§_-qd§(alternativa3d::_applyReflectionNormalMapProcedure,"tReflection");
         }
         else
         {
            fragmentLinker.§_-on§(alternativa3d::_applyReflectionProcedure);
            fragmentLinker.§_-qd§(alternativa3d::_applyReflectionProcedure,"tReflection");
         }
         fragmentLinker.§_-on§(_applyLightMapProcedure);
         fragmentLinker.§_-FS§(_applyLightMapProcedure,"tColor");
         fragmentLinker.§_-qd§(_applyLightMapProcedure,"tColor");
         if(this.reflectionMap != null)
         {
            fragmentLinker.§_-on§(alternativa3d::_blendReflectionMap);
            fragmentLinker.§_-FS§(alternativa3d::_blendReflectionMap,"tColor","tReflection");
            outputProcedure = alternativa3d::_blendReflectionMap;
         }
         else
         {
            fragmentLinker.§_-on§(alternativa3d::_blendReflection);
            fragmentLinker.§_-FS§(alternativa3d::_blendReflection,"tColor","tReflection");
            outputProcedure = alternativa3d::_blendReflection;
         }
         if(alternativa3d::fogMode == alternativa3d::SIMPLE || alternativa3d::fogMode == alternativa3d::ADVANCED)
         {
            fragmentLinker.§_-LU§("outColor");
            fragmentLinker.§_-qd§(outputProcedure,"outColor");
         }
         if(alternativa3d::fogMode == alternativa3d::SIMPLE)
         {
            vertexLinker.§_-on§(passSimpleFogConstProcedure);
            vertexLinker.§_-FS§(passSimpleFogConstProcedure,positionVar);
            fragmentLinker.§_-on§(outputWithSimpleFogProcedure);
            fragmentLinker.§_-FS§(outputWithSimpleFogProcedure,"outColor");
         }
         else if(alternativa3d::fogMode == alternativa3d::ADVANCED)
         {
            vertexLinker.§_-LU§("tProjected");
            vertexLinker.§_-qd§(alternativa3d::_projectProcedure,"tProjected");
            vertexLinker.§_-on§(postPassAdvancedFogConstProcedure);
            vertexLinker.§_-FS§(postPassAdvancedFogConstProcedure,positionVar,"tProjected");
            fragmentLinker.§_-on§(outputWithAdvancedFogProcedure);
            fragmentLinker.§_-FS§(outputWithAdvancedFogProcedure,"outColor");
         }
         fragmentLinker.§_-XI§();
         fragmentLinker.§_-NA§(vertexLinker);
         return new EnvironmentMaterialShaderProgram(vertexLinker,fragmentLinker);
      }
      
      override alternativa3d function collectDraws(camera:§_-be§, surface:§_-a2§, geometry:§_-gA§, lights:Vector.<§_-Jo§>, lightsLength:int, objectRenderPriority:int = -1) : void
      {
         var program:§_-RB§ = null;
         var i:int = 0;
         var lm:§_-jw§ = null;
         var dist:Number = NaN;
         var cLocal:§_-jw§ = null;
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
         if(!§_-L4§ && opacityMap != null && opacityMap.alternativa3d::_texture == null)
         {
            return;
         }
         var object:§_-OX§ = surface.alternativa3d::object;
         var positionBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(§_-d6§.POSITION);
         var uvBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(§_-d6§.TEXCOORDS[0]);
         var normalsBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(§_-d6§.NORMAL);
         var tangentsBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(§_-d6§.TANGENT4);
         if(positionBuffer == null || uvBuffer == null)
         {
            return;
         }
         var key:String = alternativa3d::fogMode.toString() + this.§_-NH§.toString() + (this.normalMap != null ? "N" : "n") + (opacityMap != null ? "O" : "o") + (!!§_-L4§ ? "D" : "d");
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
         var drawUnit:§_-QF§ = camera.alternativa3d::renderer.alternativa3d::_-2s(object,program.program,geometry.alternativa3d::_-EM,surface.indexBegin,surface.numTriangles,program);
         drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sLightMap"),this.lightMap.alternativa3d::_texture);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aPosition"),positionBuffer,geometry.alternativa3d::_attributesOffsets[§_-d6§.POSITION],§_-d6§.alternativa3d::FORMATS[§_-d6§.POSITION]);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aUV"),uvBuffer,geometry.alternativa3d::_attributesOffsets[§_-d6§.TEXCOORDS[0]],§_-d6§.alternativa3d::FORMATS[§_-d6§.TEXCOORDS[0]]);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aUV1"),uvBuffer,geometry.alternativa3d::_attributesOffsets[§_-d6§.TEXCOORDS[this.lightMapChannel]],§_-d6§.alternativa3d::FORMATS[§_-d6§.TEXCOORDS[this.lightMapChannel]]);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aNormal"),normalsBuffer,geometry.alternativa3d::_attributesOffsets[§_-d6§.NORMAL],§_-d6§.alternativa3d::FORMATS[§_-d6§.NORMAL]);
         object.alternativa3d::setTransformConstants(drawUnit,surface,program.vertexShader,camera);
         drawUnit.alternativa3d::_-mQ(camera,program.vertexShader.getVariableIndex("cProjMatrix"),object.alternativa3d::localToCameraTransform);
         var camTransform:§_-jw§ = object.alternativa3d::cameraToLocalTransform;
         drawUnit.alternativa3d::_-Ry(program.fragmentShader.getVariableIndex("cCamera"),camTransform.d,camTransform.h,camTransform.l);
         var envProgram:EnvironmentMaterialShaderProgram = program as EnvironmentMaterialShaderProgram;
         if(this.normalMap != null)
         {
            drawUnit.alternativa3d::setTextureAt(envProgram.sBump,this.normalMap.alternativa3d::_texture);
            if(this.§_-NH§ == §_-12§.TANGENT_RIGHT_HANDED || this.§_-NH§ == §_-12§.TANGENT_LEFT_HANDED)
            {
               drawUnit.alternativa3d::setVertexBufferAt(envProgram.aTangent,tangentsBuffer,geometry.alternativa3d::_attributesOffsets[§_-d6§.TANGENT4],§_-d6§.alternativa3d::FORMATS[§_-d6§.TANGENT4]);
            }
         }
         if(this.reflectionMap != null)
         {
            drawUnit.alternativa3d::setTextureAt(envProgram.sReflection,this.reflectionMap.alternativa3d::_texture);
         }
         drawUnit.alternativa3d::setTextureAt(envProgram.sTexture,diffuseMap.alternativa3d::_texture);
         drawUnit.alternativa3d::setTextureAt(envProgram.sCubeMap,this.environmentMap.alternativa3d::_texture);
         var cameraToLocalTransform:§_-jw§ = object.alternativa3d::cameraToLocalTransform;
         drawUnit.alternativa3d::_-Ry(envProgram.cCamera,cameraToLocalTransform.d,cameraToLocalTransform.h,cameraToLocalTransform.l);
         drawUnit.alternativa3d::_-Ry(envProgram.cAlpha,0,1 - this.reflection,this.reflection,alpha);
         drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sTexture"),diffuseMap.alternativa3d::_texture);
         if(!§_-L4§ && opacityMap != null)
         {
            drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sOpacity"),opacityMap.alternativa3d::_texture);
         }
         if(alternativa3d::fogMode == alternativa3d::SIMPLE || alternativa3d::fogMode == alternativa3d::ADVANCED)
         {
            lm = object.alternativa3d::localToCameraTransform;
            dist = alternativa3d::fogFar - alternativa3d::fogNear;
            drawUnit.alternativa3d:: if(program.vertexShader.getVariableIndex("cFogSpace"),lm.i / dist,lm.j / dist,lm.k / dist,(lm.l - alternativa3d::fogNear) / dist);
            drawUnit.alternativa3d::_-Ry(program.fragmentShader.getVariableIndex("cFogRange"),alternativa3d::fogMaxDensity,1,0,1 - alternativa3d::fogMaxDensity);
         }
         if(alternativa3d::fogMode == alternativa3d::SIMPLE)
         {
            drawUnit.alternativa3d::_-Ry(program.fragmentShader.getVariableIndex("cFogColor"),alternativa3d::fogColorR,alternativa3d::fogColorG,alternativa3d::fogColorB);
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
               alternativa3d::fogTexture = new §_-b1§(bmd);
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
            drawUnit.alternativa3d::_-Ry(program.fragmentShader.getVariableIndex("cFogConsts"),0.5 * uScale,0.5 - uRight,0);
            drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sFogTexture"),alternativa3d::fogTexture.alternativa3d::_texture);
         }
         if(Boolean(§_-L4§) || opacityMap != null || alpha < 1)
         {
            drawUnit.alternativa3d::blendSource = Context3DBlendFactor.SOURCE_ALPHA;
            drawUnit.alternativa3d::blendDestination = Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA;
            camera.alternativa3d::renderer.alternativa3d::_-SH(drawUnit,objectRenderPriority >= 0 ? objectRenderPriority : int(§_-WR§.TRANSPARENT_SORT));
         }
         else
         {
            camera.alternativa3d::renderer.alternativa3d::_-SH(drawUnit,objectRenderPriority >= 0 ? objectRenderPriority : int(§_-WR§.OPAQUE));
         }
      }
   }
}

import §_-M8§.§_-hR§;

class EnvironmentMaterialShaderProgram extends §_-RB§
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
   
   public function EnvironmentMaterialShaderProgram(vertexShader:§_-hR§, fragmentShader:§_-hR§)
   {
      super(vertexShader,fragmentShader);
      this.aPosition = vertexShader.getVariableIndex("aPosition");
      this.aNormal = vertexShader.getVariableIndex("aNormal");
      this.aUV = vertexShader.getVariableIndex("aUV");
      if(fragmentShader.§_-oj§("sBump"))
      {
         this.sBump = fragmentShader.getVariableIndex("sBump");
      }
      if(vertexShader.§_-oj§("aTangent"))
      {
         this.aTangent = vertexShader.getVariableIndex("aTangent");
      }
      if(fragmentShader.§_-oj§("sReflection"))
      {
         this.sReflection = fragmentShader.getVariableIndex("sReflection");
      }
      this.cProjMatrix = vertexShader.getVariableIndex("cProjMatrix");
      this.sTexture = fragmentShader.getVariableIndex("sTexture");
      this.sCubeMap = fragmentShader.getVariableIndex("sCubeMap");
      this.cCamera = fragmentShader.getVariableIndex("cCamera");
      this.cAlpha = fragmentShader.getVariableIndex("cAlpha");
      if(fragmentShader.§_-oj§("sOpacity"))
      {
         this.sOpacity = fragmentShader.getVariableIndex("sOpacity");
      }
   }
}
