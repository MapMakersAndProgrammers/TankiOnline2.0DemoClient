package package_3
{
   import alternativa.engine3d.alternativa3d;
   import flash.display.BitmapData;
   import flash.display3D.Context3DBlendFactor;
   import flash.display3D.Context3DProgramType;
   import flash.display3D.VertexBuffer3D;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import package_19.name_117;
   import package_21.name_116;
   import package_21.name_124;
   import package_21.name_126;
   import package_21.name_128;
   import package_21.name_135;
   import package_21.name_139;
   import package_21.name_78;
   import package_23.name_103;
   import package_23.name_208;
   import package_24.DirectionalLight;
   import package_24.OmniLight;
   import package_28.name_119;
   import package_28.name_129;
   import package_28.name_93;
   import package_30.name_114;
   import package_30.name_115;
   import package_30.name_121;
   import package_4.class_4;
   import package_4.class_5;
   import package_4.name_127;
   import package_4.name_28;
   
   use namespace alternativa3d;
   
   public class TankMaterial2 extends class_5
   {
      private static var fogTexture:name_129;
      
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
      
      private static const passSimpleFogConstProcedure:name_114 = new name_114(["#v0=vZDistance","#c0=cFogSpace","dp4 t0.z, i0, c0","mov v0, t0.zzzz","sub v0.y, i0.w, t0.z"],"passSimpleFogConst");
      
      private static const outputWithSimpleFogProcedure:name_114 = new name_114(["#v0=vZDistance","#c0=cFogColor","#c1=cFogRange","min t0.xy, v0.xy, c1.xy","max t0.xy, t0.xy, c1.zw","mul t1.xyz, c0.xyz, t0.x","mov t1.w, t0.y","mov o0, t1"],"outputWithSimpleFog");
      
      private static const postPassAdvancedFogConstProcedure:name_114 = new name_114(["#v0=vZDistance","#c0=cFogSpace","dp4 t0.z, i0, c0","mov v0, t0.zzzz","sub v0.y, i0.w, t0.z","mov v0.zw, i1.xwxw","mov o0, i1"],"postPassAdvancedFogConst");
      
      private static const outputWithAdvancedFogProcedure:name_114 = new name_114(["#v0=vZDistance","#c0=cFogConsts","#c1=cFogRange","#s0=sFogTexture","min t0.xy, v0.xy, c1.xy","max t0.xy, t0.xy, c1.zw","mov t1.xyzw, c0.yyzw","div t0.z, v0.z, v0.w","mul t0.z, t0.z, c0.x","add t1.x, t1.x, t0.z","tex t1, t1, s0 <2d, repeat, linear, miplinear>","mul t1.xyz, t1.xyz, t0.x","mov t1.w, t0.y","mov o0, t1"],"outputWithAdvancedFog");
      
      private static const objectsProgramsSets:Dictionary = new Dictionary();
      
      private static const lightContainer:Vector.<name_116> = new Vector.<name_116>(1,true);
      
      private static const actualLigths:Vector.<name_116> = new Vector.<name_116>();
      
      private static const passUVProcedure:name_114 = new name_114(["#a0=aUV","#v0=vUV","mov v0, a0"],"passUVProcedure");
      
      private static const diffuseProcedure:name_114 = name_114.name_140(["#v0=vUV","#c0=cTiling","#s0=sColormap","#s1=sDiffuse","#s2=sSurface","mul t0, v0, c0","tex t1, t0, s0 <2d, repeat, linear, miplinear>","tex t0, v0, s1 <2d, clamp, linear, miplinear>","add t2, t0, t0","mul t2, t2, t1","tex t1, v0, s2 <2d, clamp, linear, miplinear>","mul t2, t2, t1.x","add t2, t2, t0","mul t0, t0, t1.x","sub o0, t2, t0"],"diffuse");
      
      private static const setColorProcedure:name_114 = new name_114(["mov o0, i0"],"setColorProcedure");
      
      private static const outputWithLightProcedure:name_114 = new name_114(["mul t0.xyz, i0.xyz, i1.xyz","mov t0.w, i1.w","mov o0, t0"],"outputWithLightProcedure");
      
      private static const outputProcedure:name_114 = new name_114(["mov o0, i0"],"outputProcedure");
      
      private static const passVaryingsProcedure:name_114 = new name_114(["#c0=cCamera","#v0=vPosition","#v1=vViewVector","mov v0, i0","sub t0, c0, i0","mov v1.xyz, t0.xyz","mov v1.w, c0.w"],"passVaryingsProcedure");
      
      private static const getNormalAndViewProcedure:name_114 = new name_114(["#v0=vUV","#v1=vViewVector","#c0=cSurface","#s0=sBump","tex t0, v0, s0 <2d,clamp,linear,miplinear>","add t0, t0, t0","sub t0.xyz, t0.xyz, c0.www","neg t0.y, t0.y","nrm o0.xyz, t0.xyz","nrm o1.xyz, v1"],"getNormalAndViewProcedure");
      
      private static const getSpecularOptionsProcedure:name_114 = new name_114(["#v0=vUV","#c0=cSurface","#s0=sSurface","tex t0, v0, s0 <2d, clamp, linear, miplinear>","mul i0.w, c0.y, t0.z","mul i1.w, c0.z, t0.y"],"getSpecularOptionsProcedure");
      
      public var diffuse:name_129;
      
      public var colorMap:name_129;
      
      public var surfaceMap:name_129;
      
      public var var_26:Number = 1;
      
      public var var_24:Number = 1;
      
      public var normalMap:name_129;
      
      public var glossiness:Number = 100;
      
      public var var_25:Number = 1;
      
      private const outputWithSpecularProcedure:name_114 = new name_114(["mul t0.xyz, i0.xyz, i1.xyz","add t0.xyz, t0.xyz, i2.xyz","mov t0.w, i1.w","mov o0, t0"],"outputWithSpecularProcedure");
      
      public function TankMaterial2(colorMap:name_129 = null, diffuse:name_129 = null, normalMap:name_129 = null, surfaceMap:name_129 = null)
      {
         super();
         this.colorMap = colorMap;
         this.diffuse = diffuse;
         this.normalMap = normalMap;
         this.surfaceMap = surfaceMap;
      }
      
      public static function method_33(texture:name_129) : void
      {
         fogTexture = texture;
      }
      
      private static function directionalProcedure(light:name_116, add:Boolean) : name_114
      {
         return new name_114(["#c0=c" + light.alternativa3d::name_138 + "Direction","#c1=c" + light.alternativa3d::name_138 + "Color","add t0.xyz, i1.xyz, c0.xyz","nrm t0.xyz, t0.xyz","dp3 t0.w, t0.xyz, i0.xyz","pow t0.w, t0.w, i0.w","mul t0.w, t0.w, i1.w","dp3 t0.x, i0.xyz, c0.xyz","sat t0.x, t0.x",add ? "mul t0.xyz, c1.xyz, t0.x" : "mul o0.xyz, c1.xyz, t0.x",add ? "add o0.xyz, o0.xyz, t0.xyz" : "mov o0.w, c0.w",add ? "mul t0.xyz, c1.xyz, t0.w" : "mul o1.xyz, c1.xyz, t0.w",add ? "add o1.xyz, o1.xyz, t0.xyz" : "mov o1.w, c0.w"],"directionalProcedure");
      }
      
      private static function omniProcedure(light:name_116, add:Boolean) : name_114
      {
         return new name_114(["#c0=c" + light.alternativa3d::name_138 + "Position","#c1=c" + light.alternativa3d::name_138 + "Color","#c2=c" + light.alternativa3d::name_138 + "Radius","#v0=vPosition","sub t0, c0, v0","dp3 t0.w, t0.xyz, t0.xyz","nrm t0.xyz, t0.xyz","add t1.xyz, i1.xyz, t0.xyz","mov t1.w, c0.w","nrm t1.xyz, t1.xyz","dp3 t1.w, t1.xyz, i0.xyz","pow t1.w, t1.w, i0.w","mul t1.w, t1.w, i1.w","sqt t1.x, t0.w","dp3 t0.w, t0.xyz, i0.xyz","sub t0.x, t1.x, c2.z","div t0.y, t0.x, c2.y","sub t0.x, c2.x, t0.y","sat t0.xw, t0.xw","mul t0.xyz, c1.xyz, t0.xxx",add ? "mul t1.xyz, t0.xyz, t0.w" : "mul o0.xyz, t0.xyz, t0.w",add ? "add o0.xyz, o0.xyz, t1.xyz" : "mov o0.w, c0.w",add ? "mul t1.xyz, t0.xyz, t1.w" : "mul o1.xyz, t0.xyz, t1.w",add ? "add o1.xyz, o1.xyz, t1.xyz" : "mov o1.w, c0.w"],"omniProcedure");
      }
      
      override alternativa3d function fillResources(resources:Dictionary, resourceType:Class) : void
      {
         super.alternativa3d::fillResources(resources,resourceType);
         if(this.diffuse != null && Boolean(name_28.alternativa3d::name_131(getDefinitionByName(getQualifiedClassName(this.diffuse)) as Class,resourceType)))
         {
            resources[this.diffuse] = true;
         }
         if(this.colorMap != null && Boolean(name_28.alternativa3d::name_131(getDefinitionByName(getQualifiedClassName(this.colorMap)) as Class,resourceType)))
         {
            resources[this.colorMap] = true;
         }
         if(this.normalMap != null && Boolean(name_28.alternativa3d::name_131(getDefinitionByName(getQualifiedClassName(this.normalMap)) as Class,resourceType)))
         {
            resources[this.normalMap] = true;
         }
         if(this.surfaceMap != null && Boolean(name_28.alternativa3d::name_131(getDefinitionByName(getQualifiedClassName(this.surfaceMap)) as Class,resourceType)))
         {
            resources[this.surfaceMap] = true;
         }
      }
      
      override alternativa3d function collectDraws(camera:name_124, surface:name_117, geometry:name_119, lights:Vector.<name_116>, lightsLength:int, objectRenderPriority:int = -1) : void
      {
         var i:int = 0;
         var light:name_116 = null;
         var shadowedLight:DirectionalLight = null;
         var drawUnit:name_135 = null;
         var shadowOrAmbientProgram:ShadowOrAmbientProgram = null;
         var lightingProgram:LightingProgram = null;
         var numShadows:int = 0;
         var shadow:name_103 = null;
         var lightsPrograms:Dictionary = null;
         var fogProgram:FogProgram = null;
         if(this.diffuse == null || this.colorMap == null || this.normalMap == null || this.surfaceMap == null || this.diffuse.alternativa3d::_texture == null || this.colorMap.alternativa3d::_texture == null || this.normalMap.alternativa3d::_texture == null || this.surfaceMap.alternativa3d::_texture == null)
         {
            return;
         }
         var object:name_78 = surface.alternativa3d::object;
         var positionBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(name_126.POSITION);
         var uvBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(name_126.TEXCOORDS[0]);
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
               lightsKey += light.alternativa3d::name_138;
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
               shadowOrAmbientProgram = this.method_125(object,shadowedLight.shadow,true);
               shadowOrAmbientProgram.upload(camera.alternativa3d::context3D);
               programs[0] = shadowOrAmbientProgram;
            }
            drawUnit = this.method_126(shadowOrAmbientProgram,shadowedLight.shadow,true,camera,object,surface,geometry);
         }
         else
         {
            shadowOrAmbientProgram = programs[1];
            if(shadowOrAmbientProgram == null)
            {
               shadowOrAmbientProgram = this.method_125(object,null,true);
               shadowOrAmbientProgram.upload(camera.alternativa3d::context3D);
               programs[1] = shadowOrAmbientProgram;
            }
            drawUnit = this.method_126(shadowOrAmbientProgram,null,true,camera,object,surface,geometry);
         }
         drawUnit.alternativa3d::blendSource = Context3DBlendFactor.ONE;
         drawUnit.alternativa3d::blendDestination = Context3DBlendFactor.ZERO;
         camera.alternativa3d::renderer.alternativa3d::name_130(drawUnit,name_128.TANK_OPAQUE);
         if(shadowedLight != null)
         {
            numShadows = object.alternativa3d::shadowRenderers != null ? int(object.alternativa3d::shadowRenderers.length) : 0;
            for(i = 0; i < numShadows; )
            {
               shadow = object.alternativa3d::shadowRenderers[i];
               if(shadow is name_208)
               {
                  shadowOrAmbientProgram = programs[2];
                  if(shadowOrAmbientProgram == null)
                  {
                     shadowOrAmbientProgram = this.method_125(object,shadow,false);
                     shadowOrAmbientProgram.upload(camera.alternativa3d::context3D);
                     programs[2] = shadowOrAmbientProgram;
                  }
                  drawUnit = this.method_126(shadowOrAmbientProgram,shadow,false,camera,object,surface,geometry);
                  drawUnit.alternativa3d::blendSource = Context3DBlendFactor.ZERO;
                  drawUnit.alternativa3d::blendDestination = Context3DBlendFactor.SOURCE_COLOR;
                  camera.alternativa3d::renderer.alternativa3d::name_130(drawUnit,name_128.SHADOWS);
               }
               i++;
            }
            lightingProgram = programs[3];
            if(lightingProgram == null)
            {
               lightContainer[0] = shadowedLight;
               lightingProgram = this.method_127(object,lightContainer,1);
               lightingProgram.upload(camera.alternativa3d::context3D);
               programs[3] = lightingProgram;
            }
            drawUnit = this.method_128(lightingProgram,lightContainer,1,camera,object,surface,geometry);
            drawUnit.alternativa3d::blendSource = Context3DBlendFactor.DESTINATION_ALPHA;
            drawUnit.alternativa3d::blendDestination = Context3DBlendFactor.ONE;
            camera.alternativa3d::renderer.alternativa3d::name_130(drawUnit,name_128.SHADOWED_LIGHTS);
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
               lightingProgram = this.method_127(object,actualLigths,actualLightsLength);
               lightingProgram.upload(camera.alternativa3d::context3D);
               lightsPrograms[lightsKey] = lightingProgram;
            }
            drawUnit = this.method_128(lightingProgram,actualLigths,actualLightsLength,camera,object,surface,geometry);
            drawUnit.alternativa3d::blendSource = Context3DBlendFactor.ONE;
            drawUnit.alternativa3d::blendDestination = Context3DBlendFactor.ONE;
            camera.alternativa3d::renderer.alternativa3d::name_130(drawUnit,name_128.LIGHTS);
         }
         if(fogMode == SIMPLE || fogMode == ADVANCED)
         {
            fogProgram = programs[int(fogMode + 4)];
            if(fogProgram == null)
            {
               fogProgram = this.method_129(object);
               fogProgram.upload(camera.alternativa3d::context3D);
               programs[int(fogMode + 4)] = fogProgram;
            }
            drawUnit = this.method_130(fogProgram,camera,object,surface,geometry);
            drawUnit.alternativa3d::blendSource = Context3DBlendFactor.ONE;
            drawUnit.alternativa3d::blendDestination = Context3DBlendFactor.SOURCE_ALPHA;
            camera.alternativa3d::renderer.alternativa3d::name_130(drawUnit,name_128.FOG);
         }
         actualLigths.length = 0;
      }
      
      private function method_125(object:name_78, shadow:name_103, ambient:Boolean) : ShadowOrAmbientProgram
      {
         var shadowProc:name_114 = null;
         var vertexLinker:name_121 = new name_121(Context3DProgramType.VERTEX);
         var fragmentLinker:name_121 = new name_121(Context3DProgramType.FRAGMENT);
         var positionVar:String = "aPosition";
         vertexLinker.name_120(positionVar,name_115.ATTRIBUTE);
         if(object.alternativa3d::transformProcedure != null)
         {
            positionVar = alternativa3d::method_74(object.alternativa3d::transformProcedure,vertexLinker);
         }
         vertexLinker.name_123(alternativa3d::_projectProcedure);
         vertexLinker.name_118(alternativa3d::_projectProcedure,positionVar);
         if(ambient)
         {
            vertexLinker.name_123(passUVProcedure);
         }
         var colorConst:String = ambient ? "cAmbient" : "cShadow";
         fragmentLinker.name_120(colorConst,name_115.CONSTANT);
         fragmentLinker.name_120("tLight");
         fragmentLinker.name_123(setColorProcedure);
         fragmentLinker.name_118(setColorProcedure,colorConst);
         fragmentLinker.name_125(setColorProcedure,"tLight");
         if(shadow != null)
         {
            vertexLinker.name_123(shadow.getVShader());
            shadowProc = shadow.getFIntensityShader();
            fragmentLinker.name_123(shadowProc);
            fragmentLinker.name_125(shadowProc,"tLight");
         }
         if(ambient)
         {
            fragmentLinker.name_120("tColor");
            fragmentLinker.name_123(diffuseProcedure);
            fragmentLinker.name_125(diffuseProcedure,"tColor");
            fragmentLinker.name_123(outputWithLightProcedure);
            fragmentLinker.name_118(outputWithLightProcedure,"tColor","tLight");
         }
         else
         {
            fragmentLinker.name_123(outputProcedure);
            fragmentLinker.name_118(outputProcedure,"tLight");
         }
         fragmentLinker.name_133(vertexLinker);
         return new ShadowOrAmbientProgram(vertexLinker,fragmentLinker);
      }
      
      private function method_126(program:ShadowOrAmbientProgram, shadow:name_103, ambient:Boolean, camera:name_124, object:name_78, surface:name_117, geometry:name_119) : name_135
      {
         var positionBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(name_126.POSITION);
         var uvBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(name_126.TEXCOORDS[0]);
         var drawUnit:name_135 = camera.alternativa3d::renderer.alternativa3d::name_137(object,program.program,geometry.alternativa3d::name_132,surface.indexBegin,surface.numTriangles,program);
         drawUnit.alternativa3d::setVertexBufferAt(program.aPosition,positionBuffer,geometry.alternativa3d::_attributesOffsets[name_126.POSITION],name_126.alternativa3d::FORMATS[name_126.POSITION]);
         if(ambient)
         {
            drawUnit.alternativa3d::setVertexBufferAt(program.aUV,uvBuffer,geometry.alternativa3d::_attributesOffsets[name_126.TEXCOORDS[0]],name_126.alternativa3d::FORMATS[name_126.TEXCOORDS[0]]);
         }
         object.alternativa3d::setTransformConstants(drawUnit,surface,program.vertexShader,camera);
         drawUnit.alternativa3d::name_136(camera,program.cProjMatrix,object.alternativa3d::localToCameraTransform);
         if(ambient)
         {
            drawUnit.alternativa3d::name_134(program.cAmbient,camera.alternativa3d::ambient[0],camera.alternativa3d::ambient[1],camera.alternativa3d::ambient[2],1);
            drawUnit.alternativa3d::name_134(program.cTiling,this.var_26,this.var_24,0,0);
            drawUnit.alternativa3d::setTextureAt(program.sDiffuse,this.diffuse.alternativa3d::_texture);
            drawUnit.alternativa3d::setTextureAt(program.sColormap,this.colorMap.alternativa3d::_texture);
            drawUnit.alternativa3d::setTextureAt(program.sSurface,this.surfaceMap.alternativa3d::_texture);
         }
         else
         {
            drawUnit.alternativa3d::name_134(program.cShadow,1,1,1,1);
         }
         if(shadow != null)
         {
            shadow.applyShader(drawUnit,program,object,camera);
         }
         return drawUnit;
      }
      
      private function method_127(object:name_78, lights:Vector.<name_116>, lightsLength:int) : LightingProgram
      {
         var procedure:name_114 = null;
         var light:name_116 = null;
         var vertexLinker:name_121 = new name_121(Context3DProgramType.VERTEX);
         var fragmentLinker:name_121 = new name_121(Context3DProgramType.FRAGMENT);
         var positionVar:String = "aPosition";
         vertexLinker.name_120(positionVar,name_115.ATTRIBUTE);
         if(object.alternativa3d::transformProcedure != null)
         {
            positionVar = alternativa3d::method_74(object.alternativa3d::transformProcedure,vertexLinker);
         }
         vertexLinker.name_123(alternativa3d::_projectProcedure);
         vertexLinker.name_118(alternativa3d::_projectProcedure,positionVar);
         vertexLinker.name_123(passUVProcedure);
         vertexLinker.name_123(passVaryingsProcedure);
         vertexLinker.name_118(passVaryingsProcedure,positionVar);
         fragmentLinker.name_120("tNormal");
         fragmentLinker.name_120("tView");
         fragmentLinker.name_123(getNormalAndViewProcedure);
         fragmentLinker.name_125(getNormalAndViewProcedure,"tNormal","tView");
         fragmentLinker.name_123(getSpecularOptionsProcedure);
         fragmentLinker.name_118(getSpecularOptionsProcedure,"tNormal","tView");
         fragmentLinker.name_120("tLight");
         fragmentLinker.name_120("tHLight");
         var first:Boolean = true;
         for(var i:int = 0; i < lightsLength; )
         {
            light = lights[i];
            if(light is DirectionalLight)
            {
               procedure = directionalProcedure(light,!first);
               fragmentLinker.name_123(procedure);
               fragmentLinker.name_118(procedure,"tNormal","tView");
               fragmentLinker.name_125(procedure,"tLight","tHLight");
               if(first)
               {
                  first = false;
               }
            }
            else if(light is OmniLight)
            {
               procedure = omniProcedure(light,!first);
               fragmentLinker.name_123(procedure);
               fragmentLinker.name_118(procedure,"tNormal","tView");
               fragmentLinker.name_125(procedure,"tLight","tHLight");
               if(first)
               {
                  first = false;
               }
            }
            i++;
         }
         fragmentLinker.name_120("outColor");
         fragmentLinker.name_123(diffuseProcedure);
         fragmentLinker.name_125(diffuseProcedure,"outColor");
         fragmentLinker.name_123(this.outputWithSpecularProcedure);
         fragmentLinker.name_118(this.outputWithSpecularProcedure,"outColor","tLight","tHLight");
         fragmentLinker.name_133(vertexLinker);
         return new LightingProgram(vertexLinker,fragmentLinker);
      }
      
      private function method_128(program:LightingProgram, lights:Vector.<name_116>, lightsLength:int, camera:name_124, object:name_78, surface:name_117, geometry:name_119) : name_135
      {
         var rScale:Number = NaN;
         var transform:name_139 = null;
         var light:name_116 = null;
         var len:Number = NaN;
         var omni:OmniLight = null;
         var positionBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(name_126.POSITION);
         var uvBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(name_126.TEXCOORDS[0]);
         var drawUnit:name_135 = camera.alternativa3d::renderer.alternativa3d::name_137(object,program.program,geometry.alternativa3d::name_132,surface.indexBegin,surface.numTriangles,program);
         drawUnit.alternativa3d::setVertexBufferAt(program.aPosition,positionBuffer,geometry.alternativa3d::_attributesOffsets[name_126.POSITION],name_126.alternativa3d::FORMATS[name_126.POSITION]);
         drawUnit.alternativa3d::setVertexBufferAt(program.aUV,uvBuffer,geometry.alternativa3d::_attributesOffsets[name_126.TEXCOORDS[0]],name_126.alternativa3d::FORMATS[name_126.TEXCOORDS[0]]);
         object.alternativa3d::setTransformConstants(drawUnit,surface,program.vertexShader,camera);
         drawUnit.alternativa3d::name_136(camera,program.cProjMatrix,object.alternativa3d::localToCameraTransform);
         drawUnit.alternativa3d::name_144(program.cCamera,object.alternativa3d::cameraToLocalTransform.d,object.alternativa3d::cameraToLocalTransform.h,object.alternativa3d::cameraToLocalTransform.l,1);
         for(var i:int = 0; i < lightsLength; )
         {
            light = lights[i];
            if(light is DirectionalLight)
            {
               transform = light.alternativa3d::name_141;
               len = Number(Math.sqrt(transform.c * transform.c + transform.g * transform.g + transform.k * transform.k));
               drawUnit.alternativa3d::name_134(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::name_138 + "Direction"),-transform.c / len,-transform.g / len,-transform.k / len,1);
               drawUnit.alternativa3d::name_134(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::name_138 + "Color"),light.alternativa3d::red,light.alternativa3d::green,light.alternativa3d::blue);
            }
            else if(light is OmniLight)
            {
               omni = OmniLight(light);
               transform = light.alternativa3d::name_141;
               rScale = Number(Math.sqrt(transform.a * transform.a + transform.e * transform.e + transform.i * transform.i));
               rScale += Math.sqrt(transform.b * transform.b + transform.f * transform.f + transform.j * transform.j);
               rScale += Math.sqrt(transform.c * transform.c + transform.g * transform.g + transform.k * transform.k);
               rScale /= 3;
               drawUnit.alternativa3d::name_134(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::name_138 + "Position"),transform.d,transform.h,transform.l);
               drawUnit.alternativa3d::name_134(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::name_138 + "Radius"),1,omni.attenuationEnd * rScale - omni.attenuationBegin * rScale,omni.attenuationBegin * rScale);
               drawUnit.alternativa3d::name_134(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::name_138 + "Color"),light.alternativa3d::red,light.alternativa3d::green,light.alternativa3d::blue);
            }
            i++;
         }
         drawUnit.alternativa3d::name_134(program.cSurface,0,this.glossiness,this.var_25,1);
         drawUnit.alternativa3d::name_134(program.cTiling,this.var_26,this.var_24,0,0);
         drawUnit.alternativa3d::setTextureAt(program.sDiffuse,this.diffuse.alternativa3d::_texture);
         drawUnit.alternativa3d::setTextureAt(program.sColormap,this.colorMap.alternativa3d::_texture);
         drawUnit.alternativa3d::setTextureAt(program.sSurface,this.surfaceMap.alternativa3d::_texture);
         drawUnit.alternativa3d::setTextureAt(program.sBump,this.normalMap.alternativa3d::_texture);
         return drawUnit;
      }
      
      private function method_129(object:name_78) : FogProgram
      {
         var vertexLinker:name_121 = new name_121(Context3DProgramType.VERTEX);
         var fragmentLinker:name_121 = new name_121(Context3DProgramType.FRAGMENT);
         var positionVar:String = "aPosition";
         vertexLinker.name_120(positionVar,name_115.ATTRIBUTE);
         if(object.alternativa3d::transformProcedure != null)
         {
            positionVar = alternativa3d::method_74(object.alternativa3d::transformProcedure,vertexLinker);
         }
         vertexLinker.name_123(alternativa3d::_projectProcedure);
         vertexLinker.name_118(alternativa3d::_projectProcedure,positionVar);
         if(fogMode == SIMPLE)
         {
            vertexLinker.name_123(passSimpleFogConstProcedure);
            vertexLinker.name_118(passSimpleFogConstProcedure,positionVar);
            fragmentLinker.name_123(outputWithSimpleFogProcedure);
         }
         else
         {
            vertexLinker.name_120("projected");
            vertexLinker.name_125(alternativa3d::_projectProcedure,"projected");
            vertexLinker.name_123(postPassAdvancedFogConstProcedure);
            vertexLinker.name_118(postPassAdvancedFogConstProcedure,positionVar,"projected");
            fragmentLinker.name_123(outputWithAdvancedFogProcedure);
         }
         fragmentLinker.name_133(vertexLinker);
         return new FogProgram(vertexLinker,fragmentLinker);
      }
      
      private function method_130(program:FogProgram, camera:name_124, object:name_78, surface:name_117, geometry:name_119) : name_135
      {
         var lm:name_139 = null;
         var dist:Number = NaN;
         var cLocal:name_139 = null;
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
         var positionBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(name_126.POSITION);
         var drawUnit:name_135 = camera.alternativa3d::renderer.alternativa3d::name_137(object,program.program,geometry.alternativa3d::name_132,surface.indexBegin,surface.numTriangles,program);
         drawUnit.alternativa3d::setVertexBufferAt(program.aPosition,positionBuffer,geometry.alternativa3d::_attributesOffsets[name_126.POSITION],name_126.alternativa3d::FORMATS[name_126.POSITION]);
         object.alternativa3d::setTransformConstants(drawUnit,surface,program.vertexShader,camera);
         drawUnit.alternativa3d::name_136(camera,program.cProjMatrix,object.alternativa3d::localToCameraTransform);
         if(fogMode == SIMPLE || fogMode == ADVANCED)
         {
            lm = object.alternativa3d::localToCameraTransform;
            dist = fogFar - fogNear;
            drawUnit.alternativa3d::name_144(program.cFogSpace,lm.i / dist,lm.j / dist,lm.k / dist,(lm.l - fogNear) / dist);
            drawUnit.alternativa3d::name_134(program.cFogRange,fogMaxDensity,1,0,1 - fogMaxDensity);
         }
         if(fogMode == SIMPLE)
         {
            drawUnit.alternativa3d::name_134(program.cFogColor,fogColorR,fogColorG,fogColorB);
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
               fogTexture = new name_93(bmd);
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
            drawUnit.alternativa3d::name_134(program.cFogConsts,0.5 * uScale,0.5 - uRight,0);
            drawUnit.alternativa3d::setTextureAt(program.sFogTexture,fogTexture.alternativa3d::_texture);
         }
         return drawUnit;
      }
      
      override public function clone() : class_4
      {
         var cloned:TankMaterial2 = new TankMaterial2(this.colorMap,this.diffuse,this.normalMap,this.surfaceMap);
         cloned.var_25 = this.var_25;
         cloned.glossiness = this.glossiness;
         return cloned;
      }
   }
}

import package_30.name_121;
import package_4.name_127;

class ShadowOrAmbientProgram extends name_127
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
   
   public function ShadowOrAmbientProgram(vertex:name_121, fragment:name_121)
   {
      super(vertex,fragment);
      this.aPosition = vertex.name_207("aPosition");
      this.aUV = vertex.name_207("aUV");
      this.cProjMatrix = vertex.name_207("cProjMatrix");
      this.cAmbient = fragment.name_207("cAmbient");
      this.cTiling = fragment.name_207("cTiling");
      this.sDiffuse = fragment.name_207("sDiffuse");
      this.sColormap = fragment.name_207("sColormap");
      this.sSurface = fragment.name_207("sSurface");
      this.cShadow = fragment.name_207("cShadow");
   }
}

class LightingProgram extends name_127
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
   
   public function LightingProgram(vertex:name_121, fragment:name_121)
   {
      super(vertex,fragment);
      this.aPosition = vertex.name_207("aPosition");
      this.aUV = vertex.name_207("aUV");
      this.cProjMatrix = vertex.name_207("cProjMatrix");
      this.cCamera = vertex.name_207("cCamera");
      this.cSurface = fragment.name_207("cSurface");
      this.cTiling = fragment.name_207("cTiling");
      this.sDiffuse = fragment.name_207("sDiffuse");
      this.sColormap = fragment.name_207("sColormap");
      this.sSurface = fragment.name_207("sSurface");
      this.sBump = fragment.name_207("sBump");
   }
}

class FogProgram extends name_127
{
   public var aPosition:int;
   
   public var cProjMatrix:int;
   
   public var cFogSpace:int;
   
   public var cFogRange:int;
   
   public var cFogColor:int;
   
   public var cFogConsts:int;
   
   public var sFogTexture:int;
   
   public function FogProgram(vertex:name_121, fragment:name_121)
   {
      super(vertex,fragment);
      this.aPosition = vertex.name_207("aPosition");
      this.cProjMatrix = vertex.name_207("cProjMatrix");
      this.cFogSpace = vertex.name_207("cFogSpace");
      this.cFogRange = fragment.name_207("cFogRange");
      this.cFogColor = fragment.name_207("cFogColor");
      this.cFogConsts = fragment.name_207("cFogConsts");
      this.sFogTexture = fragment.name_207("sFogTexture");
   }
}
