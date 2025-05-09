package package_1
{
   import alternativa.engine3d.alternativa3d;
   import flash.display.BitmapData;
   import flash.display3D.Context3DBlendFactor;
   import flash.display3D.Context3DProgramType;
   import flash.display3D.VertexBuffer3D;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import package_19.name_134;
   import package_21.name_136;
   import package_21.name_84;
   import package_21.name_86;
   import package_3.class_5;
   import package_3.class_6;
   import package_3.name_139;
   import package_3.name_29;
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
   import package_35.DirectionalLight;
   import package_35.OmniLight;
   import package_36.name_137;
   import package_36.name_142;
   
   use namespace alternativa3d;
   
   public class TankMaterial2 extends class_5
   {
      private static var fogTexture:name_86;
      
      public static const DISABLED:int = 0;
      
      public static const SIMPLE:int = 1;
      
      public static const ADVANCED:int = 2;
      
      public static var fogMode:int = DISABLED;
      
      public static var fogNear:Number = 1000;
      
      public static var fogFar:Number = 5000;
      
      public static var fogMaxDensity:Number = 1;
      
      public static var fogColorR:Number = 200 / 255;
      
      public static var fogColorG:Number = 162 / 255;
      
      public static var fogColorB:Number = 200 / 255;
      
      private static const passSimpleFogConstProcedure:name_116 = new name_116(["#v0=vZDistance","#c0=cFogSpace","dp4 t0.z, i0, c0","mov v0, t0.zzzz","sub v0.y, i0.w, t0.z"],"passSimpleFogConst");
      
      private static const outputWithSimpleFogProcedure:name_116 = new name_116(["#v0=vZDistance","#c0=cFogColor","#c1=cFogRange","min t0.xy, v0.xy, c1.xy","max t0.xy, t0.xy, c1.zw","mul t1.xyz, c0.xyz, t0.x","mov t1.w, t0.y","mov o0, t1"],"outputWithSimpleFog");
      
      private static const postPassAdvancedFogConstProcedure:name_116 = new name_116(["#v0=vZDistance","#c0=cFogSpace","dp4 t0.z, i0, c0","mov v0, t0.zzzz","sub v0.y, i0.w, t0.z","mov v0.zw, i1.xwxw","mov o0, i1"],"postPassAdvancedFogConst");
      
      private static const outputWithAdvancedFogProcedure:name_116 = new name_116(["#v0=vZDistance","#c0=cFogConsts","#c1=cFogRange","#s0=sFogTexture","min t0.xy, v0.xy, c1.xy","max t0.xy, t0.xy, c1.zw","mov t1.xyzw, c0.yyzw","div t0.z, v0.z, v0.w","mul t0.z, t0.z, c0.x","add t1.x, t1.x, t0.z","tex t1, t1, s0 <2d, repeat, linear, miplinear>","mul t1.xyz, t1.xyz, t0.x","mov t1.w, t0.y","mov o0, t1"],"outputWithAdvancedFog");
      
      private static const objectsProgramsSets:Dictionary = new Dictionary();
      
      private static const lightContainer:Vector.<name_121> = new Vector.<name_121>(1,true);
      
      private static const actualLigths:Vector.<name_121> = new Vector.<name_121>();
      
      private static const passUVProcedure:name_116 = new name_116(["#a0=aUV","#v0=vUV","mov v0, a0"],"passUVProcedure");
      
      private static const diffuseProcedure:name_116 = name_116.name_144(["#v0=vUV","#c0=cTiling","#s0=sColormap","#s1=sDiffuse","#s2=sSurface","mul t0, v0, c0","tex t1, t0, s0 <2d, repeat, linear, miplinear>","tex t0, v0, s1 <2d, clamp, linear, miplinear>","add t2, t0, t0","mul t2, t2, t1","tex t1, v0, s2 <2d, clamp, linear, miplinear>","mul t2, t2, t1.x","add t2, t2, t0","mul t0, t0, t1.x","sub o0, t2, t0"],"diffuse");
      
      private static const setColorProcedure:name_116 = new name_116(["mov o0, i0"],"setColorProcedure");
      
      private static const outputWithLightProcedure:name_116 = new name_116(["mul t0.xyz, i0.xyz, i1.xyz","mov t0.w, i1.w","mov o0, t0"],"outputWithLightProcedure");
      
      private static const outputProcedure:name_116 = new name_116(["mov o0, i0"],"outputProcedure");
      
      private static const passVaryingsProcedure:name_116 = new name_116(["#c0=cCamera","#v0=vPosition","#v1=vViewVector","mov v0, i0","sub t0, c0, i0","mov v1.xyz, t0.xyz","mov v1.w, c0.w"],"passVaryingsProcedure");
      
      private static const getNormalAndViewProcedure:name_116 = new name_116(["#v0=vUV","#v1=vViewVector","#c0=cSurface","#s0=sBump","tex t0, v0, s0 <2d,clamp,linear,miplinear>","add t0, t0, t0","sub t0.xyz, t0.xyz, c0.www","neg t0.y, t0.y","nrm o0.xyz, t0.xyz","nrm o1.xyz, v1"],"getNormalAndViewProcedure");
      
      private static const getSpecularOptionsProcedure:name_116 = new name_116(["#v0=vUV","#c0=cSurface","#s0=sSurface","tex t0, v0, s0 <2d, clamp, linear, miplinear>","mul i0.w, c0.y, t0.z","mul i1.w, c0.z, t0.y"],"getSpecularOptionsProcedure");
      
      public var diffuse:name_86;
      
      public var colorMap:name_86;
      
      public var surfaceMap:name_86;
      
      public var var_25:Number = 1;
      
      public var var_24:Number = 1;
      
      public var normalMap:name_86;
      
      public var glossiness:Number = 100;
      
      public var var_26:Number = 1;
      
      private const outputWithSpecularProcedure:name_116 = new name_116(["mul t0.xyz, i0.xyz, i1.xyz","add t0.xyz, t0.xyz, i2.xyz","mov t0.w, i1.w","mov o0, t0"],"outputWithSpecularProcedure");
      
      public function TankMaterial2(colorMap:name_86 = null, diffuse:name_86 = null, normalMap:name_86 = null, surfaceMap:name_86 = null)
      {
         super();
         this.colorMap = colorMap;
         this.diffuse = diffuse;
         this.normalMap = normalMap;
         this.surfaceMap = surfaceMap;
      }
      
      public static function method_52(texture:name_86) : void
      {
         fogTexture = texture;
      }
      
      private static function directionalProcedure(light:name_121, add:Boolean) : name_116
      {
         return new name_116(["#c0=c" + light.alternativa3d::name_79 + "Direction","#c1=c" + light.alternativa3d::name_79 + "Color","add t0.xyz, i1.xyz, c0.xyz","nrm t0.xyz, t0.xyz","dp3 t0.w, t0.xyz, i0.xyz","pow t0.w, t0.w, i0.w","mul t0.w, t0.w, i1.w","dp3 t0.x, i0.xyz, c0.xyz","sat t0.x, t0.x",add ? "mul t0.xyz, c1.xyz, t0.x" : "mul o0.xyz, c1.xyz, t0.x",add ? "add o0.xyz, o0.xyz, t0.xyz" : "mov o0.w, c0.w",add ? "mul t0.xyz, c1.xyz, t0.w" : "mul o1.xyz, c1.xyz, t0.w",add ? "add o1.xyz, o1.xyz, t0.xyz" : "mov o1.w, c0.w"],"directionalProcedure");
      }
      
      private static function omniProcedure(light:name_121, add:Boolean) : name_116
      {
         return new name_116(["#c0=c" + light.alternativa3d::name_79 + "Position","#c1=c" + light.alternativa3d::name_79 + "Color","#c2=c" + light.alternativa3d::name_79 + "Radius","#v0=vPosition","sub t0, c0, v0","dp3 t0.w, t0.xyz, t0.xyz","nrm t0.xyz, t0.xyz","add t1.xyz, i1.xyz, t0.xyz","mov t1.w, c0.w","nrm t1.xyz, t1.xyz","dp3 t1.w, t1.xyz, i0.xyz","pow t1.w, t1.w, i0.w","mul t1.w, t1.w, i1.w","sqt t1.x, t0.w","dp3 t0.w, t0.xyz, i0.xyz","sub t0.x, t1.x, c2.z","div t0.y, t0.x, c2.y","sub t0.x, c2.x, t0.y","sat t0.xw, t0.xw","mul t0.xyz, c1.xyz, t0.xxx",add ? "mul t1.xyz, t0.xyz, t0.w" : "mul o0.xyz, t0.xyz, t0.w",add ? "add o0.xyz, o0.xyz, t1.xyz" : "mov o0.w, c0.w",add ? "mul t1.xyz, t0.xyz, t1.w" : "mul o1.xyz, t0.xyz, t1.w",add ? "add o1.xyz, o1.xyz, t1.xyz" : "mov o1.w, c0.w"],"omniProcedure");
      }
      
      override alternativa3d function fillResources(resources:Dictionary, resourceType:Class) : void
      {
         super.alternativa3d::fillResources(resources,resourceType);
         if(this.diffuse != null && Boolean(name_29.alternativa3d::name_133(getDefinitionByName(getQualifiedClassName(this.diffuse)) as Class,resourceType)))
         {
            resources[this.diffuse] = true;
         }
         if(this.colorMap != null && Boolean(name_29.alternativa3d::name_133(getDefinitionByName(getQualifiedClassName(this.colorMap)) as Class,resourceType)))
         {
            resources[this.colorMap] = true;
         }
         if(this.normalMap != null && Boolean(name_29.alternativa3d::name_133(getDefinitionByName(getQualifiedClassName(this.normalMap)) as Class,resourceType)))
         {
            resources[this.normalMap] = true;
         }
         if(this.surfaceMap != null && Boolean(name_29.alternativa3d::name_133(getDefinitionByName(getQualifiedClassName(this.surfaceMap)) as Class,resourceType)))
         {
            resources[this.surfaceMap] = true;
         }
      }
      
      override alternativa3d function collectDraws(camera:name_135, surface:name_134, geometry:name_136, lights:Vector.<name_121>, lightsLength:int, objectRenderPriority:int = -1) : void
      {
         var i:int = 0;
         var light:name_121 = null;
         var shadowedLight:DirectionalLight = null;
         var drawUnit:name_123 = null;
         var shadowOrAmbientProgram:ShadowOrAmbientProgram = null;
         var lightingProgram:LightingProgram = null;
         var numShadows:int = 0;
         var shadow:name_137 = null;
         var lightsPrograms:Dictionary = null;
         var fogProgram:FogProgram = null;
         if(this.diffuse == null || this.colorMap == null || this.normalMap == null || this.surfaceMap == null || this.diffuse.alternativa3d::_texture == null || this.colorMap.alternativa3d::_texture == null || this.normalMap.alternativa3d::_texture == null || this.surfaceMap.alternativa3d::_texture == null)
         {
            return;
         }
         var object:name_130 = surface.alternativa3d::object;
         var positionBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(name_117.POSITION);
         var uvBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(name_117.TEXCOORDS[0]);
         if(positionBuffer == null || uvBuffer == null)
         {
            return;
         }
         var lightsKey:String = "";
         var actualLightsLength:int = 0;
         for(i = 0; i < lightsLength; )
         {
            light = lights[i];
            if(light is DirectionalLight && shadowedLight == null && DirectionalLight(light).shadow != null)
            {
               shadowedLight = DirectionalLight(light);
            }
            else if(actualLightsLength < 8 && (light is OmniLight || light is DirectionalLight))
            {
               actualLigths[actualLightsLength] = light;
               lightsKey += light.alternativa3d::name_79;
               actualLightsLength++;
            }
            i++;
         }
         var programs:Array = objectsProgramsSets[object.alternativa3d::transformProcedure];
         if(programs == null)
         {
            programs = [];
            objectsProgramsSets[object.alternativa3d::transformProcedure] = programs;
         }
         if(shadowedLight != null)
         {
            shadowOrAmbientProgram = programs[0];
            if(shadowOrAmbientProgram == null)
            {
               shadowOrAmbientProgram = this.method_46(object,shadowedLight.shadow,true);
               shadowOrAmbientProgram.upload(camera.alternativa3d::context3D);
               programs[0] = shadowOrAmbientProgram;
            }
            drawUnit = this.method_47(shadowOrAmbientProgram,shadowedLight.shadow,true,camera,object,surface,geometry);
         }
         else
         {
            shadowOrAmbientProgram = programs[1];
            if(shadowOrAmbientProgram == null)
            {
               shadowOrAmbientProgram = this.method_46(object,null,true);
               shadowOrAmbientProgram.upload(camera.alternativa3d::context3D);
               programs[1] = shadowOrAmbientProgram;
            }
            drawUnit = this.method_47(shadowOrAmbientProgram,null,true,camera,object,surface,geometry);
         }
         drawUnit.alternativa3d::blendSource = Context3DBlendFactor.ONE;
         drawUnit.alternativa3d::blendDestination = Context3DBlendFactor.ZERO;
         camera.alternativa3d::renderer.alternativa3d::name_132(drawUnit,name_126.TANK_OPAQUE);
         if(shadowedLight != null)
         {
            numShadows = object.alternativa3d::shadowRenderers != null ? int(object.alternativa3d::shadowRenderers.length) : 0;
            for(i = 0; i < numShadows; )
            {
               shadow = object.alternativa3d::shadowRenderers[i];
               if(shadow is name_142)
               {
                  shadowOrAmbientProgram = programs[2];
                  if(shadowOrAmbientProgram == null)
                  {
                     shadowOrAmbientProgram = this.method_46(object,shadow,false);
                     shadowOrAmbientProgram.upload(camera.alternativa3d::context3D);
                     programs[2] = shadowOrAmbientProgram;
                  }
                  drawUnit = this.method_47(shadowOrAmbientProgram,shadow,false,camera,object,surface,geometry);
                  drawUnit.alternativa3d::blendSource = Context3DBlendFactor.ZERO;
                  drawUnit.alternativa3d::blendDestination = Context3DBlendFactor.SOURCE_COLOR;
                  camera.alternativa3d::renderer.alternativa3d::name_132(drawUnit,name_126.SHADOWS);
               }
               i++;
            }
            lightingProgram = programs[3];
            if(lightingProgram == null)
            {
               lightContainer[0] = shadowedLight;
               lightingProgram = this.method_48(object,lightContainer,1);
               lightingProgram.upload(camera.alternativa3d::context3D);
               programs[3] = lightingProgram;
            }
            drawUnit = this.method_49(lightingProgram,lightContainer,1,camera,object,surface,geometry);
            drawUnit.alternativa3d::blendSource = Context3DBlendFactor.DESTINATION_ALPHA;
            drawUnit.alternativa3d::blendDestination = Context3DBlendFactor.ONE;
            camera.alternativa3d::renderer.alternativa3d::name_132(drawUnit,name_126.SHADOWED_LIGHTS);
         }
         if(actualLightsLength > 0)
         {
            lightsPrograms = programs[4];
            if(lightsPrograms == null)
            {
               lightsPrograms = new Dictionary(false);
               programs[4] = lightsPrograms;
            }
            lightingProgram = lightsPrograms[lightsKey];
            if(lightingProgram == null)
            {
               lightingProgram = this.method_48(object,actualLigths,actualLightsLength);
               lightingProgram.upload(camera.alternativa3d::context3D);
               lightsPrograms[lightsKey] = lightingProgram;
            }
            drawUnit = this.method_49(lightingProgram,actualLigths,actualLightsLength,camera,object,surface,geometry);
            drawUnit.alternativa3d::blendSource = Context3DBlendFactor.ONE;
            drawUnit.alternativa3d::blendDestination = Context3DBlendFactor.ONE;
            camera.alternativa3d::renderer.alternativa3d::name_132(drawUnit,name_126.LIGHTS);
         }
         if(fogMode == SIMPLE || fogMode == ADVANCED)
         {
            fogProgram = programs[int(fogMode + 4)];
            if(fogProgram == null)
            {
               fogProgram = this.method_50(object);
               fogProgram.upload(camera.alternativa3d::context3D);
               programs[int(fogMode + 4)] = fogProgram;
            }
            drawUnit = this.method_51(fogProgram,camera,object,surface,geometry);
            drawUnit.alternativa3d::blendSource = Context3DBlendFactor.ONE;
            drawUnit.alternativa3d::blendDestination = Context3DBlendFactor.SOURCE_ALPHA;
            camera.alternativa3d::renderer.alternativa3d::name_132(drawUnit,name_126.FOG);
         }
         actualLigths.length = 0;
      }
      
      private function method_46(object:name_130, shadow:name_137, ambient:Boolean) : ShadowOrAmbientProgram
      {
         var shadowProc:name_116 = null;
         var vertexLinker:name_119 = new name_119(Context3DProgramType.VERTEX);
         var fragmentLinker:name_119 = new name_119(Context3DProgramType.FRAGMENT);
         var positionVar:String = "aPosition";
         vertexLinker.name_125(positionVar,name_128.ATTRIBUTE);
         if(object.alternativa3d::transformProcedure != null)
         {
            positionVar = alternativa3d::name_131(object.alternativa3d::transformProcedure,vertexLinker);
         }
         vertexLinker.name_120(alternativa3d::_projectProcedure);
         vertexLinker.name_122(alternativa3d::_projectProcedure,positionVar);
         if(ambient)
         {
            vertexLinker.name_120(passUVProcedure);
         }
         var colorConst:String = ambient ? "cAmbient" : "cShadow";
         fragmentLinker.name_125(colorConst,name_128.CONSTANT);
         fragmentLinker.name_125("tLight");
         fragmentLinker.name_120(setColorProcedure);
         fragmentLinker.name_122(setColorProcedure,colorConst);
         fragmentLinker.name_127(setColorProcedure,"tLight");
         if(shadow != null)
         {
            vertexLinker.name_120(shadow.getVShader());
            shadowProc = shadow.getFIntensityShader();
            fragmentLinker.name_120(shadowProc);
            fragmentLinker.name_127(shadowProc,"tLight");
         }
         if(ambient)
         {
            fragmentLinker.name_125("tColor");
            fragmentLinker.name_120(diffuseProcedure);
            fragmentLinker.name_127(diffuseProcedure,"tColor");
            fragmentLinker.name_120(outputWithLightProcedure);
            fragmentLinker.name_122(outputWithLightProcedure,"tColor","tLight");
         }
         else
         {
            fragmentLinker.name_120(outputProcedure);
            fragmentLinker.name_122(outputProcedure,"tLight");
         }
         fragmentLinker.name_140(vertexLinker);
         return new ShadowOrAmbientProgram(vertexLinker,fragmentLinker);
      }
      
      private function method_47(program:ShadowOrAmbientProgram, shadow:name_137, ambient:Boolean, camera:name_135, object:name_130, surface:name_134, geometry:name_136) : name_123
      {
         var positionBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(name_117.POSITION);
         var uvBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(name_117.TEXCOORDS[0]);
         var drawUnit:name_123 = camera.alternativa3d::renderer.alternativa3d::name_138(object,program.program,geometry.alternativa3d::name_78,surface.indexBegin,surface.numTriangles,program);
         drawUnit.alternativa3d::setVertexBufferAt(program.aPosition,positionBuffer,geometry.alternativa3d::_attributesOffsets[name_117.POSITION],name_117.alternativa3d::FORMATS[name_117.POSITION]);
         if(ambient)
         {
            drawUnit.alternativa3d::setVertexBufferAt(program.aUV,uvBuffer,geometry.alternativa3d::_attributesOffsets[name_117.TEXCOORDS[0]],name_117.alternativa3d::FORMATS[name_117.TEXCOORDS[0]]);
         }
         object.alternativa3d::setTransformConstants(drawUnit,surface,program.vertexShader,camera);
         drawUnit.alternativa3d::name_141(camera,program.cProjMatrix,object.alternativa3d::localToCameraTransform);
         if(ambient)
         {
            drawUnit.alternativa3d::name_124(program.cAmbient,camera.alternativa3d::ambient[0],camera.alternativa3d::ambient[1],camera.alternativa3d::ambient[2],1);
            drawUnit.alternativa3d::name_124(program.cTiling,this.var_25,this.var_24,0,0);
            drawUnit.alternativa3d::setTextureAt(program.sDiffuse,this.diffuse.alternativa3d::_texture);
            drawUnit.alternativa3d::setTextureAt(program.sColormap,this.colorMap.alternativa3d::_texture);
            drawUnit.alternativa3d::setTextureAt(program.sSurface,this.surfaceMap.alternativa3d::_texture);
         }
         else
         {
            drawUnit.alternativa3d::name_124(program.cShadow,1,1,1,1);
         }
         if(shadow != null)
         {
            shadow.applyShader(drawUnit,program,object,camera);
         }
         return drawUnit;
      }
      
      private function method_48(object:name_130, lights:Vector.<name_121>, lightsLength:int) : LightingProgram
      {
         var procedure:name_116 = null;
         var light:name_121 = null;
         var vertexLinker:name_119 = new name_119(Context3DProgramType.VERTEX);
         var fragmentLinker:name_119 = new name_119(Context3DProgramType.FRAGMENT);
         var positionVar:String = "aPosition";
         vertexLinker.name_125(positionVar,name_128.ATTRIBUTE);
         if(object.alternativa3d::transformProcedure != null)
         {
            positionVar = alternativa3d::name_131(object.alternativa3d::transformProcedure,vertexLinker);
         }
         vertexLinker.name_120(alternativa3d::_projectProcedure);
         vertexLinker.name_122(alternativa3d::_projectProcedure,positionVar);
         vertexLinker.name_120(passUVProcedure);
         vertexLinker.name_120(passVaryingsProcedure);
         vertexLinker.name_122(passVaryingsProcedure,positionVar);
         fragmentLinker.name_125("tNormal");
         fragmentLinker.name_125("tView");
         fragmentLinker.name_120(getNormalAndViewProcedure);
         fragmentLinker.name_127(getNormalAndViewProcedure,"tNormal","tView");
         fragmentLinker.name_120(getSpecularOptionsProcedure);
         fragmentLinker.name_122(getSpecularOptionsProcedure,"tNormal","tView");
         fragmentLinker.name_125("tLight");
         fragmentLinker.name_125("tHLight");
         var first:Boolean = true;
         for(var i:int = 0; i < lightsLength; )
         {
            light = lights[i];
            if(light is DirectionalLight)
            {
               procedure = directionalProcedure(light,!first);
               fragmentLinker.name_120(procedure);
               fragmentLinker.name_122(procedure,"tNormal","tView");
               fragmentLinker.name_127(procedure,"tLight","tHLight");
               if(first)
               {
                  first = false;
               }
            }
            else if(light is OmniLight)
            {
               procedure = omniProcedure(light,!first);
               fragmentLinker.name_120(procedure);
               fragmentLinker.name_122(procedure,"tNormal","tView");
               fragmentLinker.name_127(procedure,"tLight","tHLight");
               if(first)
               {
                  first = false;
               }
            }
            i++;
         }
         fragmentLinker.name_125("outColor");
         fragmentLinker.name_120(diffuseProcedure);
         fragmentLinker.name_127(diffuseProcedure,"outColor");
         fragmentLinker.name_120(this.outputWithSpecularProcedure);
         fragmentLinker.name_122(this.outputWithSpecularProcedure,"outColor","tLight","tHLight");
         fragmentLinker.name_140(vertexLinker);
         return new LightingProgram(vertexLinker,fragmentLinker);
      }
      
      private function method_49(program:LightingProgram, lights:Vector.<name_121>, lightsLength:int, camera:name_135, object:name_130, surface:name_134, geometry:name_136) : name_123
      {
         var rScale:Number = NaN;
         var transform:name_129 = null;
         var light:name_121 = null;
         var len:Number = NaN;
         var omni:OmniLight = null;
         var positionBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(name_117.POSITION);
         var uvBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(name_117.TEXCOORDS[0]);
         var drawUnit:name_123 = camera.alternativa3d::renderer.alternativa3d::name_138(object,program.program,geometry.alternativa3d::name_78,surface.indexBegin,surface.numTriangles,program);
         drawUnit.alternativa3d::setVertexBufferAt(program.aPosition,positionBuffer,geometry.alternativa3d::_attributesOffsets[name_117.POSITION],name_117.alternativa3d::FORMATS[name_117.POSITION]);
         drawUnit.alternativa3d::setVertexBufferAt(program.aUV,uvBuffer,geometry.alternativa3d::_attributesOffsets[name_117.TEXCOORDS[0]],name_117.alternativa3d::FORMATS[name_117.TEXCOORDS[0]]);
         object.alternativa3d::setTransformConstants(drawUnit,surface,program.vertexShader,camera);
         drawUnit.alternativa3d::name_141(camera,program.cProjMatrix,object.alternativa3d::localToCameraTransform);
         drawUnit.alternativa3d::name_143(program.cCamera,object.alternativa3d::cameraToLocalTransform.d,object.alternativa3d::cameraToLocalTransform.h,object.alternativa3d::cameraToLocalTransform.l,1);
         for(var i:int = 0; i < lightsLength; )
         {
            light = lights[i];
            if(light is DirectionalLight)
            {
               transform = light.alternativa3d::name_80;
               len = Number(Math.sqrt(transform.c * transform.c + transform.g * transform.g + transform.k * transform.k));
               drawUnit.alternativa3d::name_124(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::name_79 + "Direction"),-transform.c / len,-transform.g / len,-transform.k / len,1);
               drawUnit.alternativa3d::name_124(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::name_79 + "Color"),light.alternativa3d::red,light.alternativa3d::green,light.alternativa3d::blue);
            }
            else if(light is OmniLight)
            {
               omni = OmniLight(light);
               transform = light.alternativa3d::name_80;
               rScale = Number(Math.sqrt(transform.a * transform.a + transform.e * transform.e + transform.i * transform.i));
               rScale += Math.sqrt(transform.b * transform.b + transform.f * transform.f + transform.j * transform.j);
               rScale += Math.sqrt(transform.c * transform.c + transform.g * transform.g + transform.k * transform.k);
               rScale /= 3;
               drawUnit.alternativa3d::name_124(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::name_79 + "Position"),transform.d,transform.h,transform.l);
               drawUnit.alternativa3d::name_124(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::name_79 + "Radius"),1,omni.attenuationEnd * rScale - omni.attenuationBegin * rScale,omni.attenuationBegin * rScale);
               drawUnit.alternativa3d::name_124(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::name_79 + "Color"),light.alternativa3d::red,light.alternativa3d::green,light.alternativa3d::blue);
            }
            i++;
         }
         drawUnit.alternativa3d::name_124(program.cSurface,0,this.glossiness,this.var_26,1);
         drawUnit.alternativa3d::name_124(program.cTiling,this.var_25,this.var_24,0,0);
         drawUnit.alternativa3d::setTextureAt(program.sDiffuse,this.diffuse.alternativa3d::_texture);
         drawUnit.alternativa3d::setTextureAt(program.sColormap,this.colorMap.alternativa3d::_texture);
         drawUnit.alternativa3d::setTextureAt(program.sSurface,this.surfaceMap.alternativa3d::_texture);
         drawUnit.alternativa3d::setTextureAt(program.sBump,this.normalMap.alternativa3d::_texture);
         return drawUnit;
      }
      
      private function method_50(object:name_130) : FogProgram
      {
         var vertexLinker:name_119 = new name_119(Context3DProgramType.VERTEX);
         var fragmentLinker:name_119 = new name_119(Context3DProgramType.FRAGMENT);
         var positionVar:String = "aPosition";
         vertexLinker.name_125(positionVar,name_128.ATTRIBUTE);
         if(object.alternativa3d::transformProcedure != null)
         {
            positionVar = alternativa3d::name_131(object.alternativa3d::transformProcedure,vertexLinker);
         }
         vertexLinker.name_120(alternativa3d::_projectProcedure);
         vertexLinker.name_122(alternativa3d::_projectProcedure,positionVar);
         if(fogMode == SIMPLE)
         {
            vertexLinker.name_120(passSimpleFogConstProcedure);
            vertexLinker.name_122(passSimpleFogConstProcedure,positionVar);
            fragmentLinker.name_120(outputWithSimpleFogProcedure);
         }
         else
         {
            vertexLinker.name_125("projected");
            vertexLinker.name_127(alternativa3d::_projectProcedure,"projected");
            vertexLinker.name_120(postPassAdvancedFogConstProcedure);
            vertexLinker.name_122(postPassAdvancedFogConstProcedure,positionVar,"projected");
            fragmentLinker.name_120(outputWithAdvancedFogProcedure);
         }
         fragmentLinker.name_140(vertexLinker);
         return new FogProgram(vertexLinker,fragmentLinker);
      }
      
      private function method_51(program:FogProgram, camera:name_135, object:name_130, surface:name_134, geometry:name_136) : name_123
      {
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
         var i:int = 0;
         var positionBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(name_117.POSITION);
         var drawUnit:name_123 = camera.alternativa3d::renderer.alternativa3d::name_138(object,program.program,geometry.alternativa3d::name_78,surface.indexBegin,surface.numTriangles,program);
         drawUnit.alternativa3d::setVertexBufferAt(program.aPosition,positionBuffer,geometry.alternativa3d::_attributesOffsets[name_117.POSITION],name_117.alternativa3d::FORMATS[name_117.POSITION]);
         object.alternativa3d::setTransformConstants(drawUnit,surface,program.vertexShader,camera);
         drawUnit.alternativa3d::name_141(camera,program.cProjMatrix,object.alternativa3d::localToCameraTransform);
         if(fogMode == SIMPLE || fogMode == ADVANCED)
         {
            lm = object.alternativa3d::localToCameraTransform;
            dist = fogFar - fogNear;
            drawUnit.alternativa3d::name_143(program.cFogSpace,lm.i / dist,lm.j / dist,lm.k / dist,(lm.l - fogNear) / dist);
            drawUnit.alternativa3d::name_124(program.cFogRange,fogMaxDensity,1,0,1 - fogMaxDensity);
         }
         if(fogMode == SIMPLE)
         {
            drawUnit.alternativa3d::name_124(program.cFogColor,fogColorR,fogColorG,fogColorB);
         }
         if(fogMode == ADVANCED)
         {
            if(fogTexture == null)
            {
               bmd = new BitmapData(32,1,false,16711680);
               for(i = 0; i < 32; i++)
               {
                  bmd.setPixel(i,0,i / 32 * 255 << 16);
               }
               fogTexture = new name_84(bmd);
               fogTexture.upload(camera.alternativa3d::context3D);
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
            drawUnit.alternativa3d::name_124(program.cFogConsts,0.5 * uScale,0.5 - uRight,0);
            drawUnit.alternativa3d::setTextureAt(program.sFogTexture,fogTexture.alternativa3d::_texture);
         }
         return drawUnit;
      }
      
      override public function clone() : name_139
      {
         var cloned:TankMaterial2 = new TankMaterial2(this.colorMap,this.diffuse,this.normalMap,this.surfaceMap);
         cloned.var_26 = this.var_26;
         cloned.glossiness = this.glossiness;
         return cloned;
      }
   }
}

import package_3.class_6;
import package_34.name_119;

class ShadowOrAmbientProgram extends class_6
{
   public var aPosition:int;
   
   public var aUV:int;
   
   public var cProjMatrix:int;
   
   public var cAmbient:int;
   
   public var cTiling:int;
   
   public var sDiffuse:int;
   
   public var sColormap:int;
   
   public var sSurface:int;
   
   public var cShadow:int;
   
   public function ShadowOrAmbientProgram(vertex:name_119, fragment:name_119)
   {
      super(vertex,fragment);
      this.aPosition = vertex.name_118("aPosition");
      this.aUV = vertex.name_118("aUV");
      this.cProjMatrix = vertex.name_118("cProjMatrix");
      this.cAmbient = fragment.name_118("cAmbient");
      this.cTiling = fragment.name_118("cTiling");
      this.sDiffuse = fragment.name_118("sDiffuse");
      this.sColormap = fragment.name_118("sColormap");
      this.sSurface = fragment.name_118("sSurface");
      this.cShadow = fragment.name_118("cShadow");
   }
}

class LightingProgram extends class_6
{
   public var aPosition:int;
   
   public var aUV:int;
   
   public var cProjMatrix:int;
   
   public var cCamera:int;
   
   public var cSurface:int;
   
   public var cTiling:int;
   
   public var sDiffuse:int;
   
   public var sColormap:int;
   
   public var sSurface:int;
   
   public var sBump:int;
   
   public function LightingProgram(vertex:name_119, fragment:name_119)
   {
      super(vertex,fragment);
      this.aPosition = vertex.name_118("aPosition");
      this.aUV = vertex.name_118("aUV");
      this.cProjMatrix = vertex.name_118("cProjMatrix");
      this.cCamera = vertex.name_118("cCamera");
      this.cSurface = fragment.name_118("cSurface");
      this.cTiling = fragment.name_118("cTiling");
      this.sDiffuse = fragment.name_118("sDiffuse");
      this.sColormap = fragment.name_118("sColormap");
      this.sSurface = fragment.name_118("sSurface");
      this.sBump = fragment.name_118("sBump");
   }
}

class FogProgram extends class_6
{
   public var aPosition:int;
   
   public var cProjMatrix:int;
   
   public var cFogSpace:int;
   
   public var cFogRange:int;
   
   public var cFogColor:int;
   
   public var cFogConsts:int;
   
   public var sFogTexture:int;
   
   public function FogProgram(vertex:name_119, fragment:name_119)
   {
      super(vertex,fragment);
      this.aPosition = vertex.name_118("aPosition");
      this.cProjMatrix = vertex.name_118("cProjMatrix");
      this.cFogSpace = vertex.name_118("cFogSpace");
      this.cFogRange = fragment.name_118("cFogRange");
      this.cFogColor = fragment.name_118("cFogColor");
      this.cFogConsts = fragment.name_118("cFogConsts");
      this.sFogTexture = fragment.name_118("sFogTexture");
   }
}
