package §_-Yj§
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
   import §_-R1§.DirectionalLight;
   import §_-R1§.OmniLight;
   import §_-Vh§.§_-Pt§;
   import §_-Vh§.§_-RB§;
   import §_-Vh§.§_-b9§;
   import §_-Vh§.§_-pZ§;
   import §_-Z2§.§_-ZC§;
   import §_-Z2§.§_-cD§;
   import alternativa.engine3d.alternativa3d;
   import flash.display.BitmapData;
   import flash.display3D.Context3DBlendFactor;
   import flash.display3D.Context3DProgramType;
   import flash.display3D.VertexBuffer3D;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   use namespace alternativa3d;
   
   public class TankMaterial2 extends §_-pZ§
   {
      private static var fogTexture:§_-pi§;
      
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
      
      private static const passSimpleFogConstProcedure:§_-Xk§ = new §_-Xk§(["#v0=vZDistance","#c0=cFogSpace","dp4 t0.z, i0, c0","mov v0, t0.zzzz","sub v0.y, i0.w, t0.z"],"passSimpleFogConst");
      
      private static const outputWithSimpleFogProcedure:§_-Xk§ = new §_-Xk§(["#v0=vZDistance","#c0=cFogColor","#c1=cFogRange","min t0.xy, v0.xy, c1.xy","max t0.xy, t0.xy, c1.zw","mul t1.xyz, c0.xyz, t0.x","mov t1.w, t0.y","mov o0, t1"],"outputWithSimpleFog");
      
      private static const postPassAdvancedFogConstProcedure:§_-Xk§ = new §_-Xk§(["#v0=vZDistance","#c0=cFogSpace","dp4 t0.z, i0, c0","mov v0, t0.zzzz","sub v0.y, i0.w, t0.z","mov v0.zw, i1.xwxw","mov o0, i1"],"postPassAdvancedFogConst");
      
      private static const outputWithAdvancedFogProcedure:§_-Xk§ = new §_-Xk§(["#v0=vZDistance","#c0=cFogConsts","#c1=cFogRange","#s0=sFogTexture","min t0.xy, v0.xy, c1.xy","max t0.xy, t0.xy, c1.zw","mov t1.xyzw, c0.yyzw","div t0.z, v0.z, v0.w","mul t0.z, t0.z, c0.x","add t1.x, t1.x, t0.z","tex t1, t1, s0 <2d, repeat, linear, miplinear>","mul t1.xyz, t1.xyz, t0.x","mov t1.w, t0.y","mov o0, t1"],"outputWithAdvancedFog");
      
      private static const objectsProgramsSets:Dictionary = new Dictionary();
      
      private static const lightContainer:Vector.<§_-Jo§> = new Vector.<§_-Jo§>(1,true);
      
      private static const actualLigths:Vector.<§_-Jo§> = new Vector.<§_-Jo§>();
      
      private static const passUVProcedure:§_-Xk§ = new §_-Xk§(["#a0=aUV","#v0=vUV","mov v0, a0"],"passUVProcedure");
      
      private static const diffuseProcedure:§_-Xk§ = §_-Xk§.§_-En§(["#v0=vUV","#c0=cTiling","#s0=sColormap","#s1=sDiffuse","#s2=sSurface","mul t0, v0, c0","tex t1, t0, s0 <2d, repeat, linear, miplinear>","tex t0, v0, s1 <2d, clamp, linear, miplinear>","add t2, t0, t0","mul t2, t2, t1","tex t1, v0, s2 <2d, clamp, linear, miplinear>","mul t2, t2, t1.x","add t2, t2, t0","mul t0, t0, t1.x","sub o0, t2, t0"],"diffuse");
      
      private static const setColorProcedure:§_-Xk§ = new §_-Xk§(["mov o0, i0"],"setColorProcedure");
      
      private static const outputWithLightProcedure:§_-Xk§ = new §_-Xk§(["mul t0.xyz, i0.xyz, i1.xyz","mov t0.w, i1.w","mov o0, t0"],"outputWithLightProcedure");
      
      private static const outputProcedure:§_-Xk§ = new §_-Xk§(["mov o0, i0"],"outputProcedure");
      
      private static const passVaryingsProcedure:§_-Xk§ = new §_-Xk§(["#c0=cCamera","#v0=vPosition","#v1=vViewVector","mov v0, i0","sub t0, c0, i0","mov v1.xyz, t0.xyz","mov v1.w, c0.w"],"passVaryingsProcedure");
      
      private static const getNormalAndViewProcedure:§_-Xk§ = new §_-Xk§(["#v0=vUV","#v1=vViewVector","#c0=cSurface","#s0=sBump","tex t0, v0, s0 <2d,clamp,linear,miplinear>","add t0, t0, t0","sub t0.xyz, t0.xyz, c0.www","neg t0.y, t0.y","nrm o0.xyz, t0.xyz","nrm o1.xyz, v1"],"getNormalAndViewProcedure");
      
      private static const getSpecularOptionsProcedure:§_-Xk§ = new §_-Xk§(["#v0=vUV","#c0=cSurface","#s0=sSurface","tex t0, v0, s0 <2d, clamp, linear, miplinear>","mul i0.w, c0.y, t0.z","mul i1.w, c0.z, t0.y"],"getSpecularOptionsProcedure");
      
      public var diffuse:§_-pi§;
      
      public var colorMap:§_-pi§;
      
      public var surfaceMap:§_-pi§;
      
      public var §_-jM§:Number = 1;
      
      public var §_-Sf§:Number = 1;
      
      public var normalMap:§_-pi§;
      
      public var glossiness:Number = 100;
      
      public var §_-kj§:Number = 1;
      
      private const outputWithSpecularProcedure:§_-Xk§ = new §_-Xk§(["mul t0.xyz, i0.xyz, i1.xyz","add t0.xyz, t0.xyz, i2.xyz","mov t0.w, i1.w","mov o0, t0"],"outputWithSpecularProcedure");
      
      public function TankMaterial2(colorMap:§_-pi§ = null, diffuse:§_-pi§ = null, normalMap:§_-pi§ = null, surfaceMap:§_-pi§ = null)
      {
         super();
         this.colorMap = colorMap;
         this.diffuse = diffuse;
         this.normalMap = normalMap;
         this.surfaceMap = surfaceMap;
      }
      
      public static function §_-RX§(texture:§_-pi§) : void
      {
         fogTexture = texture;
      }
      
      private static function directionalProcedure(light:§_-Jo§, add:Boolean) : §_-Xk§
      {
         return new §_-Xk§(["#c0=c" + light.alternativa3d::_-oG + "Direction","#c1=c" + light.alternativa3d::_-oG + "Color","add t0.xyz, i1.xyz, c0.xyz","nrm t0.xyz, t0.xyz","dp3 t0.w, t0.xyz, i0.xyz","pow t0.w, t0.w, i0.w","mul t0.w, t0.w, i1.w","dp3 t0.x, i0.xyz, c0.xyz","sat t0.x, t0.x",add ? "mul t0.xyz, c1.xyz, t0.x" : "mul o0.xyz, c1.xyz, t0.x",add ? "add o0.xyz, o0.xyz, t0.xyz" : "mov o0.w, c0.w",add ? "mul t0.xyz, c1.xyz, t0.w" : "mul o1.xyz, c1.xyz, t0.w",add ? "add o1.xyz, o1.xyz, t0.xyz" : "mov o1.w, c0.w"],"directionalProcedure");
      }
      
      private static function omniProcedure(light:§_-Jo§, add:Boolean) : §_-Xk§
      {
         return new §_-Xk§(["#c0=c" + light.alternativa3d::_-oG + "Position","#c1=c" + light.alternativa3d::_-oG + "Color","#c2=c" + light.alternativa3d::_-oG + "Radius","#v0=vPosition","sub t0, c0, v0","dp3 t0.w, t0.xyz, t0.xyz","nrm t0.xyz, t0.xyz","add t1.xyz, i1.xyz, t0.xyz","mov t1.w, c0.w","nrm t1.xyz, t1.xyz","dp3 t1.w, t1.xyz, i0.xyz","pow t1.w, t1.w, i0.w","mul t1.w, t1.w, i1.w","sqt t1.x, t0.w","dp3 t0.w, t0.xyz, i0.xyz","sub t0.x, t1.x, c2.z","div t0.y, t0.x, c2.y","sub t0.x, c2.x, t0.y","sat t0.xw, t0.xw","mul t0.xyz, c1.xyz, t0.xxx",add ? "mul t1.xyz, t0.xyz, t0.w" : "mul o0.xyz, t0.xyz, t0.w",add ? "add o0.xyz, o0.xyz, t1.xyz" : "mov o0.w, c0.w",add ? "mul t1.xyz, t0.xyz, t1.w" : "mul o1.xyz, t0.xyz, t1.w",add ? "add o1.xyz, o1.xyz, t1.xyz" : "mov o1.w, c0.w"],"omniProcedure");
      }
      
      override alternativa3d function fillResources(resources:Dictionary, resourceType:Class) : void
      {
         super.alternativa3d::fillResources(resources,resourceType);
         if(this.diffuse != null && Boolean(§_-Pt§.alternativa3d::_-EU(getDefinitionByName(getQualifiedClassName(this.diffuse)) as Class,resourceType)))
         {
            resources[this.diffuse] = true;
         }
         if(this.colorMap != null && Boolean(§_-Pt§.alternativa3d::_-EU(getDefinitionByName(getQualifiedClassName(this.colorMap)) as Class,resourceType)))
         {
            resources[this.colorMap] = true;
         }
         if(this.normalMap != null && Boolean(§_-Pt§.alternativa3d::_-EU(getDefinitionByName(getQualifiedClassName(this.normalMap)) as Class,resourceType)))
         {
            resources[this.normalMap] = true;
         }
         if(this.surfaceMap != null && Boolean(§_-Pt§.alternativa3d::_-EU(getDefinitionByName(getQualifiedClassName(this.surfaceMap)) as Class,resourceType)))
         {
            resources[this.surfaceMap] = true;
         }
      }
      
      override alternativa3d function collectDraws(camera:§_-be§, surface:§_-a2§, geometry:§_-gA§, lights:Vector.<§_-Jo§>, lightsLength:int, objectRenderPriority:int = -1) : void
      {
         var i:int = 0;
         var light:§_-Jo§ = null;
         var shadowedLight:DirectionalLight = null;
         var drawUnit:§_-QF§ = null;
         var shadowOrAmbientProgram:ShadowOrAmbientProgram = null;
         var lightingProgram:LightingProgram = null;
         var numShadows:int = 0;
         var shadow:§_-ZC§ = null;
         var lightsPrograms:Dictionary = null;
         var fogProgram:FogProgram = null;
         if(this.diffuse == null || this.colorMap == null || this.normalMap == null || this.surfaceMap == null || this.diffuse.alternativa3d::_texture == null || this.colorMap.alternativa3d::_texture == null || this.normalMap.alternativa3d::_texture == null || this.surfaceMap.alternativa3d::_texture == null)
         {
            return;
         }
         var object:§_-OX§ = surface.alternativa3d::object;
         var positionBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(§_-d6§.POSITION);
         var uvBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(§_-d6§.TEXCOORDS[0]);
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
               lightsKey += light.alternativa3d::_-oG;
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
               shadowOrAmbientProgram = this.§_-3O§(object,shadowedLight.shadow,true);
               shadowOrAmbientProgram.upload(camera.alternativa3d::context3D);
               programs[0] = shadowOrAmbientProgram;
            }
            drawUnit = this.§_-Mi§(shadowOrAmbientProgram,shadowedLight.shadow,true,camera,object,surface,geometry);
         }
         else
         {
            shadowOrAmbientProgram = programs[1];
            if(shadowOrAmbientProgram == null)
            {
               shadowOrAmbientProgram = this.§_-3O§(object,null,true);
               shadowOrAmbientProgram.upload(camera.alternativa3d::context3D);
               programs[1] = shadowOrAmbientProgram;
            }
            drawUnit = this.§_-Mi§(shadowOrAmbientProgram,null,true,camera,object,surface,geometry);
         }
         drawUnit.alternativa3d::blendSource = Context3DBlendFactor.ONE;
         drawUnit.alternativa3d::blendDestination = Context3DBlendFactor.ZERO;
         camera.alternativa3d::renderer.alternativa3d::_-SH(drawUnit,§_-WR§.TANK_OPAQUE);
         if(shadowedLight != null)
         {
            numShadows = object.alternativa3d::shadowRenderers != null ? int(object.alternativa3d::shadowRenderers.length) : 0;
            for(i = 0; i < numShadows; )
            {
               shadow = object.alternativa3d::shadowRenderers[i];
               if(shadow is §_-cD§)
               {
                  shadowOrAmbientProgram = programs[2];
                  if(shadowOrAmbientProgram == null)
                  {
                     shadowOrAmbientProgram = this.§_-3O§(object,shadow,false);
                     shadowOrAmbientProgram.upload(camera.alternativa3d::context3D);
                     programs[2] = shadowOrAmbientProgram;
                  }
                  drawUnit = this.§_-Mi§(shadowOrAmbientProgram,shadow,false,camera,object,surface,geometry);
                  drawUnit.alternativa3d::blendSource = Context3DBlendFactor.ZERO;
                  drawUnit.alternativa3d::blendDestination = Context3DBlendFactor.SOURCE_COLOR;
                  camera.alternativa3d::renderer.alternativa3d::_-SH(drawUnit,§_-WR§.SHADOWS);
               }
               i++;
            }
            lightingProgram = programs[3];
            if(lightingProgram == null)
            {
               lightContainer[0] = shadowedLight;
               lightingProgram = this.§_-F§(object,lightContainer,1);
               lightingProgram.upload(camera.alternativa3d::context3D);
               programs[3] = lightingProgram;
            }
            drawUnit = this.§_-MK§(lightingProgram,lightContainer,1,camera,object,surface,geometry);
            drawUnit.alternativa3d::blendSource = Context3DBlendFactor.DESTINATION_ALPHA;
            drawUnit.alternativa3d::blendDestination = Context3DBlendFactor.ONE;
            camera.alternativa3d::renderer.alternativa3d::_-SH(drawUnit,§_-WR§.SHADOWED_LIGHTS);
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
               lightingProgram = this.§_-F§(object,actualLigths,actualLightsLength);
               lightingProgram.upload(camera.alternativa3d::context3D);
               lightsPrograms[lightsKey] = lightingProgram;
            }
            drawUnit = this.§_-MK§(lightingProgram,actualLigths,actualLightsLength,camera,object,surface,geometry);
            drawUnit.alternativa3d::blendSource = Context3DBlendFactor.ONE;
            drawUnit.alternativa3d::blendDestination = Context3DBlendFactor.ONE;
            camera.alternativa3d::renderer.alternativa3d::_-SH(drawUnit,§_-WR§.LIGHTS);
         }
         if(fogMode == SIMPLE || fogMode == ADVANCED)
         {
            fogProgram = programs[int(fogMode + 4)];
            if(fogProgram == null)
            {
               fogProgram = this.§_-Ck§(object);
               fogProgram.upload(camera.alternativa3d::context3D);
               programs[int(fogMode + 4)] = fogProgram;
            }
            drawUnit = this.§_-P8§(fogProgram,camera,object,surface,geometry);
            drawUnit.alternativa3d::blendSource = Context3DBlendFactor.ONE;
            drawUnit.alternativa3d::blendDestination = Context3DBlendFactor.SOURCE_ALPHA;
            camera.alternativa3d::renderer.alternativa3d::_-SH(drawUnit,§_-WR§.FOG);
         }
         actualLigths.length = 0;
      }
      
      private function §_-3O§(object:§_-OX§, shadow:§_-ZC§, ambient:Boolean) : ShadowOrAmbientProgram
      {
         var shadowProc:§_-Xk§ = null;
         var vertexLinker:§_-hR§ = new §_-hR§(Context3DProgramType.VERTEX);
         var fragmentLinker:§_-hR§ = new §_-hR§(Context3DProgramType.FRAGMENT);
         var positionVar:String = "aPosition";
         vertexLinker.§_-LU§(positionVar,§_-5§.ATTRIBUTE);
         if(object.alternativa3d::transformProcedure != null)
         {
            positionVar = alternativa3d::_-di(object.alternativa3d::transformProcedure,vertexLinker);
         }
         vertexLinker.§_-on§(alternativa3d::_projectProcedure);
         vertexLinker.§_-FS§(alternativa3d::_projectProcedure,positionVar);
         if(ambient)
         {
            vertexLinker.§_-on§(passUVProcedure);
         }
         var colorConst:String = ambient ? "cAmbient" : "cShadow";
         fragmentLinker.§_-LU§(colorConst,§_-5§.CONSTANT);
         fragmentLinker.§_-LU§("tLight");
         fragmentLinker.§_-on§(setColorProcedure);
         fragmentLinker.§_-FS§(setColorProcedure,colorConst);
         fragmentLinker.§_-qd§(setColorProcedure,"tLight");
         if(shadow != null)
         {
            vertexLinker.§_-on§(shadow.getVShader());
            shadowProc = shadow.getFIntensityShader();
            fragmentLinker.§_-on§(shadowProc);
            fragmentLinker.§_-qd§(shadowProc,"tLight");
         }
         if(ambient)
         {
            fragmentLinker.§_-LU§("tColor");
            fragmentLinker.§_-on§(diffuseProcedure);
            fragmentLinker.§_-qd§(diffuseProcedure,"tColor");
            fragmentLinker.§_-on§(outputWithLightProcedure);
            fragmentLinker.§_-FS§(outputWithLightProcedure,"tColor","tLight");
         }
         else
         {
            fragmentLinker.§_-on§(outputProcedure);
            fragmentLinker.§_-FS§(outputProcedure,"tLight");
         }
         fragmentLinker.§_-NA§(vertexLinker);
         return new ShadowOrAmbientProgram(vertexLinker,fragmentLinker);
      }
      
      private function §_-Mi§(program:ShadowOrAmbientProgram, shadow:§_-ZC§, ambient:Boolean, camera:§_-be§, object:§_-OX§, surface:§_-a2§, geometry:§_-gA§) : §_-QF§
      {
         var positionBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(§_-d6§.POSITION);
         var uvBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(§_-d6§.TEXCOORDS[0]);
         var drawUnit:§_-QF§ = camera.alternativa3d::renderer.alternativa3d::_-2s(object,program.program,geometry.alternativa3d::_-EM,surface.indexBegin,surface.numTriangles,program);
         drawUnit.alternativa3d::setVertexBufferAt(program.aPosition,positionBuffer,geometry.alternativa3d::_attributesOffsets[§_-d6§.POSITION],§_-d6§.alternativa3d::FORMATS[§_-d6§.POSITION]);
         if(ambient)
         {
            drawUnit.alternativa3d::setVertexBufferAt(program.aUV,uvBuffer,geometry.alternativa3d::_attributesOffsets[§_-d6§.TEXCOORDS[0]],§_-d6§.alternativa3d::FORMATS[§_-d6§.TEXCOORDS[0]]);
         }
         object.alternativa3d::setTransformConstants(drawUnit,surface,program.vertexShader,camera);
         drawUnit.alternativa3d::_-mQ(camera,program.cProjMatrix,object.alternativa3d::localToCameraTransform);
         if(ambient)
         {
            drawUnit.alternativa3d::_-Ry(program.cAmbient,camera.alternativa3d::ambient[0],camera.alternativa3d::ambient[1],camera.alternativa3d::ambient[2],1);
            drawUnit.alternativa3d::_-Ry(program.cTiling,this.§_-jM§,this.§_-Sf§,0,0);
            drawUnit.alternativa3d::setTextureAt(program.sDiffuse,this.diffuse.alternativa3d::_texture);
            drawUnit.alternativa3d::setTextureAt(program.sColormap,this.colorMap.alternativa3d::_texture);
            drawUnit.alternativa3d::setTextureAt(program.sSurface,this.surfaceMap.alternativa3d::_texture);
         }
         else
         {
            drawUnit.alternativa3d::_-Ry(program.cShadow,1,1,1,1);
         }
         if(shadow != null)
         {
            shadow.applyShader(drawUnit,program,object,camera);
         }
         return drawUnit;
      }
      
      private function §_-F§(object:§_-OX§, lights:Vector.<§_-Jo§>, lightsLength:int) : LightingProgram
      {
         var procedure:§_-Xk§ = null;
         var light:§_-Jo§ = null;
         var vertexLinker:§_-hR§ = new §_-hR§(Context3DProgramType.VERTEX);
         var fragmentLinker:§_-hR§ = new §_-hR§(Context3DProgramType.FRAGMENT);
         var positionVar:String = "aPosition";
         vertexLinker.§_-LU§(positionVar,§_-5§.ATTRIBUTE);
         if(object.alternativa3d::transformProcedure != null)
         {
            positionVar = alternativa3d::_-di(object.alternativa3d::transformProcedure,vertexLinker);
         }
         vertexLinker.§_-on§(alternativa3d::_projectProcedure);
         vertexLinker.§_-FS§(alternativa3d::_projectProcedure,positionVar);
         vertexLinker.§_-on§(passUVProcedure);
         vertexLinker.§_-on§(passVaryingsProcedure);
         vertexLinker.§_-FS§(passVaryingsProcedure,positionVar);
         fragmentLinker.§_-LU§("tNormal");
         fragmentLinker.§_-LU§("tView");
         fragmentLinker.§_-on§(getNormalAndViewProcedure);
         fragmentLinker.§_-qd§(getNormalAndViewProcedure,"tNormal","tView");
         fragmentLinker.§_-on§(getSpecularOptionsProcedure);
         fragmentLinker.§_-FS§(getSpecularOptionsProcedure,"tNormal","tView");
         fragmentLinker.§_-LU§("tLight");
         fragmentLinker.§_-LU§("tHLight");
         var first:Boolean = true;
         for(var i:int = 0; i < lightsLength; )
         {
            light = lights[i];
            if(light is DirectionalLight)
            {
               procedure = directionalProcedure(light,!first);
               fragmentLinker.§_-on§(procedure);
               fragmentLinker.§_-FS§(procedure,"tNormal","tView");
               fragmentLinker.§_-qd§(procedure,"tLight","tHLight");
               if(first)
               {
                  first = false;
               }
            }
            else if(light is OmniLight)
            {
               procedure = omniProcedure(light,!first);
               fragmentLinker.§_-on§(procedure);
               fragmentLinker.§_-FS§(procedure,"tNormal","tView");
               fragmentLinker.§_-qd§(procedure,"tLight","tHLight");
               if(first)
               {
                  first = false;
               }
            }
            i++;
         }
         fragmentLinker.§_-LU§("outColor");
         fragmentLinker.§_-on§(diffuseProcedure);
         fragmentLinker.§_-qd§(diffuseProcedure,"outColor");
         fragmentLinker.§_-on§(this.outputWithSpecularProcedure);
         fragmentLinker.§_-FS§(this.outputWithSpecularProcedure,"outColor","tLight","tHLight");
         fragmentLinker.§_-NA§(vertexLinker);
         return new LightingProgram(vertexLinker,fragmentLinker);
      }
      
      private function §_-MK§(program:LightingProgram, lights:Vector.<§_-Jo§>, lightsLength:int, camera:§_-be§, object:§_-OX§, surface:§_-a2§, geometry:§_-gA§) : §_-QF§
      {
         var rScale:Number = NaN;
         var transform:§_-jw§ = null;
         var light:§_-Jo§ = null;
         var len:Number = NaN;
         var omni:OmniLight = null;
         var positionBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(§_-d6§.POSITION);
         var uvBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(§_-d6§.TEXCOORDS[0]);
         var drawUnit:§_-QF§ = camera.alternativa3d::renderer.alternativa3d::_-2s(object,program.program,geometry.alternativa3d::_-EM,surface.indexBegin,surface.numTriangles,program);
         drawUnit.alternativa3d::setVertexBufferAt(program.aPosition,positionBuffer,geometry.alternativa3d::_attributesOffsets[§_-d6§.POSITION],§_-d6§.alternativa3d::FORMATS[§_-d6§.POSITION]);
         drawUnit.alternativa3d::setVertexBufferAt(program.aUV,uvBuffer,geometry.alternativa3d::_attributesOffsets[§_-d6§.TEXCOORDS[0]],§_-d6§.alternativa3d::FORMATS[§_-d6§.TEXCOORDS[0]]);
         object.alternativa3d::setTransformConstants(drawUnit,surface,program.vertexShader,camera);
         drawUnit.alternativa3d::_-mQ(camera,program.cProjMatrix,object.alternativa3d::localToCameraTransform);
         drawUnit.alternativa3d:: if(program.cCamera,object.alternativa3d::cameraToLocalTransform.d,object.alternativa3d::cameraToLocalTransform.h,object.alternativa3d::cameraToLocalTransform.l,1);
         for(var i:int = 0; i < lightsLength; )
         {
            light = lights[i];
            if(light is DirectionalLight)
            {
               transform = light.alternativa3d::_-cl;
               len = Number(Math.sqrt(transform.c * transform.c + transform.g * transform.g + transform.k * transform.k));
               drawUnit.alternativa3d::_-Ry(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::_-oG + "Direction"),-transform.c / len,-transform.g / len,-transform.k / len,1);
               drawUnit.alternativa3d::_-Ry(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::_-oG + "Color"),light.alternativa3d::red,light.alternativa3d::green,light.alternativa3d::blue);
            }
            else if(light is OmniLight)
            {
               omni = OmniLight(light);
               transform = light.alternativa3d::_-cl;
               rScale = Number(Math.sqrt(transform.a * transform.a + transform.e * transform.e + transform.i * transform.i));
               rScale += Math.sqrt(transform.b * transform.b + transform.f * transform.f + transform.j * transform.j);
               rScale += Math.sqrt(transform.c * transform.c + transform.g * transform.g + transform.k * transform.k);
               rScale /= 3;
               drawUnit.alternativa3d::_-Ry(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::_-oG + "Position"),transform.d,transform.h,transform.l);
               drawUnit.alternativa3d::_-Ry(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::_-oG + "Radius"),1,omni.attenuationEnd * rScale - omni.attenuationBegin * rScale,omni.attenuationBegin * rScale);
               drawUnit.alternativa3d::_-Ry(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::_-oG + "Color"),light.alternativa3d::red,light.alternativa3d::green,light.alternativa3d::blue);
            }
            i++;
         }
         drawUnit.alternativa3d::_-Ry(program.cSurface,0,this.glossiness,this.§_-kj§,1);
         drawUnit.alternativa3d::_-Ry(program.cTiling,this.§_-jM§,this.§_-Sf§,0,0);
         drawUnit.alternativa3d::setTextureAt(program.sDiffuse,this.diffuse.alternativa3d::_texture);
         drawUnit.alternativa3d::setTextureAt(program.sColormap,this.colorMap.alternativa3d::_texture);
         drawUnit.alternativa3d::setTextureAt(program.sSurface,this.surfaceMap.alternativa3d::_texture);
         drawUnit.alternativa3d::setTextureAt(program.sBump,this.normalMap.alternativa3d::_texture);
         return drawUnit;
      }
      
      private function §_-Ck§(object:§_-OX§) : FogProgram
      {
         var vertexLinker:§_-hR§ = new §_-hR§(Context3DProgramType.VERTEX);
         var fragmentLinker:§_-hR§ = new §_-hR§(Context3DProgramType.FRAGMENT);
         var positionVar:String = "aPosition";
         vertexLinker.§_-LU§(positionVar,§_-5§.ATTRIBUTE);
         if(object.alternativa3d::transformProcedure != null)
         {
            positionVar = alternativa3d::_-di(object.alternativa3d::transformProcedure,vertexLinker);
         }
         vertexLinker.§_-on§(alternativa3d::_projectProcedure);
         vertexLinker.§_-FS§(alternativa3d::_projectProcedure,positionVar);
         if(fogMode == SIMPLE)
         {
            vertexLinker.§_-on§(passSimpleFogConstProcedure);
            vertexLinker.§_-FS§(passSimpleFogConstProcedure,positionVar);
            fragmentLinker.§_-on§(outputWithSimpleFogProcedure);
         }
         else
         {
            vertexLinker.§_-LU§("projected");
            vertexLinker.§_-qd§(alternativa3d::_projectProcedure,"projected");
            vertexLinker.§_-on§(postPassAdvancedFogConstProcedure);
            vertexLinker.§_-FS§(postPassAdvancedFogConstProcedure,positionVar,"projected");
            fragmentLinker.§_-on§(outputWithAdvancedFogProcedure);
         }
         fragmentLinker.§_-NA§(vertexLinker);
         return new FogProgram(vertexLinker,fragmentLinker);
      }
      
      private function §_-P8§(program:FogProgram, camera:§_-be§, object:§_-OX§, surface:§_-a2§, geometry:§_-gA§) : §_-QF§
      {
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
         var i:int = 0;
         var positionBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(§_-d6§.POSITION);
         var drawUnit:§_-QF§ = camera.alternativa3d::renderer.alternativa3d::_-2s(object,program.program,geometry.alternativa3d::_-EM,surface.indexBegin,surface.numTriangles,program);
         drawUnit.alternativa3d::setVertexBufferAt(program.aPosition,positionBuffer,geometry.alternativa3d::_attributesOffsets[§_-d6§.POSITION],§_-d6§.alternativa3d::FORMATS[§_-d6§.POSITION]);
         object.alternativa3d::setTransformConstants(drawUnit,surface,program.vertexShader,camera);
         drawUnit.alternativa3d::_-mQ(camera,program.cProjMatrix,object.alternativa3d::localToCameraTransform);
         if(fogMode == SIMPLE || fogMode == ADVANCED)
         {
            lm = object.alternativa3d::localToCameraTransform;
            dist = fogFar - fogNear;
            drawUnit.alternativa3d:: if(program.cFogSpace,lm.i / dist,lm.j / dist,lm.k / dist,(lm.l - fogNear) / dist);
            drawUnit.alternativa3d::_-Ry(program.cFogRange,fogMaxDensity,1,0,1 - fogMaxDensity);
         }
         if(fogMode == SIMPLE)
         {
            drawUnit.alternativa3d::_-Ry(program.cFogColor,fogColorR,fogColorG,fogColorB);
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
               fogTexture = new §_-b1§(bmd);
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
            drawUnit.alternativa3d::_-Ry(program.cFogConsts,0.5 * uScale,0.5 - uRight,0);
            drawUnit.alternativa3d::setTextureAt(program.sFogTexture,fogTexture.alternativa3d::_texture);
         }
         return drawUnit;
      }
      
      override public function clone() : §_-b9§
      {
         var cloned:TankMaterial2 = new TankMaterial2(this.colorMap,this.diffuse,this.normalMap,this.surfaceMap);
         cloned.§_-kj§ = this.§_-kj§;
         cloned.glossiness = this.glossiness;
         return cloned;
      }
   }
}

import §_-M8§.§_-hR§;
import §_-Vh§.§_-RB§;

class ShadowOrAmbientProgram extends §_-RB§
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
   
   public function ShadowOrAmbientProgram(vertex:§_-hR§, fragment:§_-hR§)
   {
      super(vertex,fragment);
      this.aPosition = vertex.§_-Dj§("aPosition");
      this.aUV = vertex.§_-Dj§("aUV");
      this.cProjMatrix = vertex.§_-Dj§("cProjMatrix");
      this.cAmbient = fragment.§_-Dj§("cAmbient");
      this.cTiling = fragment.§_-Dj§("cTiling");
      this.sDiffuse = fragment.§_-Dj§("sDiffuse");
      this.sColormap = fragment.§_-Dj§("sColormap");
      this.sSurface = fragment.§_-Dj§("sSurface");
      this.cShadow = fragment.§_-Dj§("cShadow");
   }
}

class LightingProgram extends §_-RB§
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
   
   public function LightingProgram(vertex:§_-hR§, fragment:§_-hR§)
   {
      super(vertex,fragment);
      this.aPosition = vertex.§_-Dj§("aPosition");
      this.aUV = vertex.§_-Dj§("aUV");
      this.cProjMatrix = vertex.§_-Dj§("cProjMatrix");
      this.cCamera = vertex.§_-Dj§("cCamera");
      this.cSurface = fragment.§_-Dj§("cSurface");
      this.cTiling = fragment.§_-Dj§("cTiling");
      this.sDiffuse = fragment.§_-Dj§("sDiffuse");
      this.sColormap = fragment.§_-Dj§("sColormap");
      this.sSurface = fragment.§_-Dj§("sSurface");
      this.sBump = fragment.§_-Dj§("sBump");
   }
}

class FogProgram extends §_-RB§
{
   public var aPosition:int;
   
   public var cProjMatrix:int;
   
   public var cFogSpace:int;
   
   public var cFogRange:int;
   
   public var cFogColor:int;
   
   public var cFogConsts:int;
   
   public var sFogTexture:int;
   
   public function FogProgram(vertex:§_-hR§, fragment:§_-hR§)
   {
      super(vertex,fragment);
      this.aPosition = vertex.§_-Dj§("aPosition");
      this.cProjMatrix = vertex.§_-Dj§("cProjMatrix");
      this.cFogSpace = vertex.§_-Dj§("cFogSpace");
      this.cFogRange = fragment.§_-Dj§("cFogRange");
      this.cFogColor = fragment.§_-Dj§("cFogColor");
      this.cFogConsts = fragment.§_-Dj§("cFogConsts");
      this.sFogTexture = fragment.§_-Dj§("sFogTexture");
   }
}
