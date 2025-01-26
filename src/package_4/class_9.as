package package_4
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
   import package_24.DirectionalLight;
   import package_24.OmniLight;
   import package_24.SpotLight;
   import package_28.name_119;
   import package_28.name_129;
   import package_28.name_93;
   import package_30.name_114;
   import package_30.name_115;
   import package_30.name_121;
   
   use namespace alternativa3d;
   
   public class class_9 extends class_5
   {
      alternativa3d static var fogTexture:name_129;
      
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
      
      private static const _programs:Dictionary = new Dictionary();
      
      private static const _lightFragmentProcedures:Dictionary = new Dictionary();
      
      private static const _passVaryingsProcedure:name_114 = new name_114(["#v0=vPosition","#v1=vViewVector","#c0=cCameraPosition","mov v0, i0","sub t0, c0, i0","mov v1.xyz, t0.xyz","mov v1.w, c0.w"]);
      
      private static const _passTBNRightProcedure:name_114 = method_123(true);
      
      private static const _passTBNLeftProcedure:name_114 = method_123(false);
      
      private static const _ambientLightProcedure:name_114 = new name_114(["#c0=cSurface","mov o0, i0","mov o1, c0.xxxx"],"ambientLightProcedure");
      
      private static const _setGlossinessFromConstantProcedure:name_114 = new name_114(["#c0=cSurface","mov o0.w, c0.y"],"setGlossinessFromConstantProcedure");
      
      private static const _setGlossinessFromTextureProcedure:name_114 = new name_114(["#v0=vUV","#c0=cSurface","#s0=sGlossiness","tex t0, v0, s0 <2d, repeat, linear, miplinear>","mul o0.w, t0.x, c0.y"],"setGlossinessFromTextureProcedure");
      
      private static const _getNormalAndViewTangentProcedure:name_114 = new name_114(["#v0=vTangent","#v1=vBinormal","#v2=vNormal","#v3=vUV","#v4=vViewVector","#c0=cAmbientColor","#s0=sBump","tex t0, v3, s0 <2d,repeat,linear,miplinear>","add t0, t0, t0","sub t0.xyz, t0.xyz, c0.www","nrm t1.xyz, v0.xyz","dp3 o0.x, t0.xyz, t1.xyz","nrm t1.xyz, v1.xyz","dp3 o0.y, t0.xyz, t1.xyz","nrm t1.xyz, v2.xyz","dp3 o0.z, t0.xyz, t1.xyz","nrm o0.xyz, o0.xyz","nrm o1.xyz, v4"],"getNormalAndViewTangentProcedure");
      
      private static const _getNormalAndViewObjectProcedure:name_114 = new name_114(["#v3=vUV","#v4=vViewVector","#c0=cAmbientColor","#s0=sBump","tex t0, v3, s0 <2d,repeat,linear,miplinear>","add t0, t0, t0","sub t0.xyz, t0.xyz, c0.www","nrm o0.xyz, t0.xyz","nrm o1.xyz, v4"],"getNormalAndViewObjectProcedure");
      
      private static const _applySpecularProcedure:name_114 = new name_114(["#v0=vUV","#s0=sSpecular","tex t0, v0, s0 <2d, repeat,linear,miplinear>","mul o0.xyz, o0.xyz, t0.xyz"],"applySpecularProcedure");
      
      private static const _mulLightingProcedure:name_114 = new name_114(["#s0=sTexture","#v0=vUV","#c0=cSurface","tex t0, v0, s0 <2d, repeat, linear, miplinear>","mul t0.xyz, t0.xyz, i0.xyz","mul t1.xyz, i1.xyz, c0.z","add t0.xyz, t0.xyz, t1.xyz","mov o0, t0"],"mulLightingProcedure");
      
      private static const passSimpleFogConstProcedure:name_114 = new name_114(["#v0=vZDistance","#c0=cFogSpace","dp4 t0.z, i0, c0","mov v0, t0.zzzz","sub v0.y, i0.w, t0.z"],"passSimpleFogConst");
      
      private static const outputWithSimpleFogProcedure:name_114 = new name_114(["#v0=vZDistance","#c0=cFogColor","#c1=cFogRange","min t0.xy, v0.xy, c1.xy","max t0.xy, t0.xy, c1.zw","mul i0.xyz, i0.xyz, t0.y","mul t0.xyz, c0.xyz, t0.x","add i0.xyz, i0.xyz, t0.xyz","mov o0, i0"],"outputWithSimpleFog");
      
      private static const postPassAdvancedFogConstProcedure:name_114 = new name_114(["#v0=vZDistance","#c0=cFogSpace","dp4 t0.z, i0, c0","mov v0, t0.zzzz","sub v0.y, i0.w, t0.z","mov v0.zw, i1.xwxw","mov o0, i1"],"postPassAdvancedFogConst");
      
      private static const outputWithAdvancedFogProcedure:name_114 = new name_114(["#v0=vZDistance","#c0=cFogConsts","#c1=cFogRange","#s0=sFogTexture","min t0.xy, v0.xy, c1.xy","max t0.xy, t0.xy, c1.zw","mul i0.xyz, i0.xyz, t0.y","mov t1.xyzw, c0.yyzw","div t0.z, v0.z, v0.w","mul t0.z, t0.z, c0.x","add t1.x, t1.x, t0.z","tex t1, t1, s0 <2d, repeat, linear, miplinear>","mul t0.xyz, t1.xyz, t0.x","add i0.xyz, i0.xyz, t0.xyz","mov o0, i0"],"outputWithAdvancedFog");
      
      alternativa3d var var_54:Boolean = false;
      
      alternativa3d var outputAlpha:name_114 = new name_114(["#c0=cSurface","mov i0.w, c0.w","mov o0, i0"],"outputAlpha");
      
      alternativa3d var outputDiffuseAlpha:name_114 = new name_114(["#c0=cSurface","mul i0.w, i0.w, c0.w","mov o0, i0"],"outputDiffuseAlpha");
      
      alternativa3d var outputOpacity:name_114 = new name_114(["#c0=cSurface","#s0=sOpacity","#v0=vUV","tex t0, v0, s0 <2d, repeat,linear,miplinear>","mul i0.w, t0.x, c0.w","mov o0, i0"],"outputOpacity");
      
      public var normalMap:name_129;
      
      private var var_53:int = 0;
      
      public var specularMap:name_129;
      
      public var glossinessMap:name_129;
      
      public var glossiness:Number = 100;
      
      public var var_25:Number = 1;
      
      public function class_9(diffuseMap:name_129, normalMap:name_129, specularMap:name_129 = null, glossinessMap:name_129 = null, opacityMap:name_129 = null)
      {
         super(diffuseMap);
         this.normalMap = normalMap;
         this.specularMap = specularMap;
         this.glossinessMap = glossinessMap;
         this.opacityMap = opacityMap;
      }
      
      private static function method_123(right:Boolean) : name_114
      {
         var crsInSpace:String = right ? "crs t1.xyz, i0, i1" : "crs t1.xyz, i1, i0";
         return new name_114(["#v0=vTangent","#v1=vBinormal","#v2=vNormal",crsInSpace,"mul t1.xyz, t1.xyz, i0.w","mov v0.x, i0.x","mov v0.y, t1.x","mov v0.z, i1.x","mov v0.w, i1.w","mov v1.x, i0.y","mov v1.y, t1.y","mov v1.z, i1.y","mov v1.w, i1.w","mov v2.x, i0.z","mov v2.y, t1.z","mov v2.z, i1.z","mov v2.w, i1.w"],"passTBNProcedure");
      }
      
      public function get method_124() : int
      {
         return this.var_53;
      }
      
      public function set method_124(value:int) : void
      {
         if(value != name_204.TANGENT_RIGHT_HANDED && value != name_204.TANGENT_LEFT_HANDED && value != name_204.OBJECT)
         {
            throw new ArgumentError("Value must be a constant from the NormalMapSpace class");
         }
         this.var_53 = value;
      }
      
      alternativa3d function getPassUVProcedure() : name_114
      {
         return alternativa3d::_passUVProcedure;
      }
      
      alternativa3d function setPassUVProcedureConstants(destination:name_135, vertexLinker:name_121) : void
      {
      }
      
      private function method_75(object:name_78, lights:Vector.<name_116>, directional:DirectionalLight, lightsLength:int) : name_127
      {
         var i:int = 0;
         var outputProcedure:name_114 = null;
         var procedure:name_114 = null;
         var nrmProcedure:name_114 = null;
         var shadowProc:name_114 = null;
         var dirMulShadowProcedure:name_114 = null;
         var light:name_116 = null;
         var lightFragmentProcedure:name_114 = null;
         var vertexLinker:name_121 = new name_121(Context3DProgramType.VERTEX);
         var fragmentLinker:name_121 = new name_121(Context3DProgramType.FRAGMENT);
         fragmentLinker.name_120("tTotalLight");
         fragmentLinker.name_120("tTotalHighLight");
         fragmentLinker.name_120("tNormal");
         fragmentLinker.name_120("cAmbientColor",name_115.CONSTANT);
         fragmentLinker.name_123(_ambientLightProcedure);
         fragmentLinker.name_118(_ambientLightProcedure,"cAmbientColor");
         fragmentLinker.name_125(_ambientLightProcedure,"tTotalLight","tTotalHighLight");
         var positionVar:String = "aPosition";
         var normalVar:String = "aNormal";
         var tangentVar:String = "aTangent";
         vertexLinker.name_120(positionVar,name_115.ATTRIBUTE);
         vertexLinker.name_120(tangentVar,name_115.ATTRIBUTE);
         vertexLinker.name_120(normalVar,name_115.ATTRIBUTE);
         if(object.alternativa3d::transformProcedure != null)
         {
            positionVar = alternativa3d::method_74(object.alternativa3d::transformProcedure,vertexLinker);
         }
         vertexLinker.name_123(alternativa3d::_projectProcedure);
         vertexLinker.name_118(alternativa3d::_projectProcedure,positionVar);
         vertexLinker.name_123(this.alternativa3d::getPassUVProcedure());
         if(this.glossinessMap != null)
         {
            fragmentLinker.name_123(_setGlossinessFromTextureProcedure);
            fragmentLinker.name_125(_setGlossinessFromTextureProcedure,"tTotalHighLight");
         }
         else
         {
            fragmentLinker.name_123(_setGlossinessFromConstantProcedure);
            fragmentLinker.name_125(_setGlossinessFromConstantProcedure,"tTotalHighLight");
         }
         if(lightsLength > 0)
         {
            if(object.alternativa3d::deltaTransformProcedure != null)
            {
               vertexLinker.name_120("tTransformedNormal");
               procedure = object.alternativa3d::deltaTransformProcedure.name_143();
               vertexLinker.name_123(procedure);
               vertexLinker.name_118(procedure,normalVar);
               vertexLinker.name_125(procedure,"tTransformedNormal");
               normalVar = "tTransformedNormal";
               vertexLinker.name_120("tTransformedTangent");
               procedure = object.alternativa3d::deltaTransformProcedure.name_143();
               vertexLinker.name_123(procedure);
               vertexLinker.name_118(procedure,tangentVar);
               vertexLinker.name_125(procedure,"tTransformedTangent");
               tangentVar = "tTransformedTangent";
            }
            vertexLinker.name_123(_passVaryingsProcedure);
            vertexLinker.name_118(_passVaryingsProcedure,positionVar);
            fragmentLinker.name_120("tViewVector");
            if(this.var_53 == name_204.TANGENT_RIGHT_HANDED || this.var_53 == name_204.TANGENT_LEFT_HANDED)
            {
               nrmProcedure = this.var_53 == name_204.TANGENT_RIGHT_HANDED ? _passTBNRightProcedure : _passTBNLeftProcedure;
               vertexLinker.name_123(nrmProcedure);
               vertexLinker.name_118(nrmProcedure,tangentVar,normalVar);
               fragmentLinker.name_123(_getNormalAndViewTangentProcedure);
               fragmentLinker.name_125(_getNormalAndViewTangentProcedure,"tNormal","tViewVector");
            }
            else
            {
               fragmentLinker.name_123(_getNormalAndViewObjectProcedure);
               fragmentLinker.name_125(_getNormalAndViewObjectProcedure,"tNormal","tViewVector");
            }
            if(directional != null)
            {
               vertexLinker.name_123(directional.shadow.getVShader());
               shadowProc = directional.shadow.getFShader();
               fragmentLinker.name_123(shadowProc);
               fragmentLinker.name_125(shadowProc,"tTotalLight");
               dirMulShadowProcedure = _lightFragmentProcedures[directional.shadow];
               if(dirMulShadowProcedure == null)
               {
                  dirMulShadowProcedure = new name_114();
                  this.method_76(dirMulShadowProcedure,directional,true);
               }
               fragmentLinker.name_123(dirMulShadowProcedure);
               fragmentLinker.name_118(dirMulShadowProcedure,"tNormal","tViewVector","tTotalLight","cAmbientColor");
               fragmentLinker.name_125(dirMulShadowProcedure,"tTotalLight","tTotalHighLight");
            }
            for(i = 0; i < lightsLength; )
            {
               light = lights[i];
               if(light != directional)
               {
                  lightFragmentProcedure = _lightFragmentProcedures[light];
                  if(lightFragmentProcedure == null)
                  {
                     lightFragmentProcedure = new name_114();
                     lightFragmentProcedure.name = "light" + i.toString();
                     if(light is DirectionalLight)
                     {
                        this.method_76(lightFragmentProcedure,light,false);
                        lightFragmentProcedure.name += "Directional";
                     }
                     else if(light is OmniLight)
                     {
                        lightFragmentProcedure.name_140(["#c0=c" + light.alternativa3d::name_138 + "Position","#c1=c" + light.alternativa3d::name_138 + "Color","#c2=c" + light.alternativa3d::name_138 + "Radius","#v0=vPosition","sub t0, c0, v0","dp3 t0.w, t0.xyz, t0.xyz","nrm t0.xyz, t0.xyz","add t1.xyz, i1.xyz, t0.xyz","mov t1.w, c0.w","nrm t1.xyz, t1.xyz","dp3 t1.w, t1.xyz, i0.xyz","pow t1.w, t1.w, o1.w","sqt t1.x, t0.w","dp3 t0.w, t0.xyz, i0.xyz","sub t0.x, t1.x, c2.z","div t0.y, t0.x, c2.y","sub t0.x, c2.x, t0.y","sat t0.xw, t0.xw","mul t0.xyz, c1.xyz, t0.xxx","mul t1.xyz, t0.xyz, t1.w","add o1.xyz, o1.xyz, t1.xyz","mul t0.xyz, t0.xyz, t0.www","add o0.xyz, o0.xyz, t0.xyz"]);
                        lightFragmentProcedure.name += "Omni";
                     }
                     else if(light is SpotLight)
                     {
                        lightFragmentProcedure.name_140(["#c0=c" + light.alternativa3d::name_138 + "Position","#c1=c" + light.alternativa3d::name_138 + "Color","#c2=c" + light.alternativa3d::name_138 + "Radius","#c3=c" + light.alternativa3d::name_138 + "Axis","#v0=vPosition","sub t0, c0, v0","dp3 t0.w, t0, t0","nrm t0.xyz,t0.xyz","add t2.xyz, i1.xyz, t0.xyz","nrm t2.xyz, t2.xyz","dp3 t2.x, t2.xyz, i0.xyz","pow t2.x, t2.x, o1.w","dp3 t1.x, t0.xyz, c3.xyz","dp3 t0.x, t0, i0.xyz","sqt t0.w, t0.w","sub t0.w, t0.w, c2.y","div t0.y, t0.w, c2.x","sub t0.w, c0.w, t0.y","sub t0.y, t1.x, c2.w","div t0.y, t0.y, c2.z","sat t0.xyw,t0.xyw","mul t1.xyz,c1.xyz,t0.yyy","mul t1.xyz,t1.xyz,t0.www","mul t2.xyz, t2.x, t1.xyz","add o1.xyz, o1.xyz, t2.xyz","mul t1.xyz, t1.xyz, t0.xxx","add o0.xyz, o0.xyz, t1.xyz"]);
                        lightFragmentProcedure.name += "Spot";
                     }
                  }
                  fragmentLinker.name_123(lightFragmentProcedure);
                  fragmentLinker.name_118(lightFragmentProcedure,"tNormal","tViewVector");
                  fragmentLinker.name_125(lightFragmentProcedure,"tTotalLight","tTotalHighLight");
               }
               i++;
            }
         }
         if(this.specularMap != null)
         {
            fragmentLinker.name_123(_applySpecularProcedure);
            fragmentLinker.name_125(_applySpecularProcedure,"tTotalHighLight");
            outputProcedure = _applySpecularProcedure;
         }
         fragmentLinker.name_120("outColor");
         fragmentLinker.name_123(_mulLightingProcedure);
         fragmentLinker.name_118(_mulLightingProcedure,"tTotalLight","tTotalHighLight");
         fragmentLinker.name_125(_mulLightingProcedure,"outColor");
         if(var_21)
         {
            fragmentLinker.name_123(this.alternativa3d::outputDiffuseAlpha);
            fragmentLinker.name_118(this.alternativa3d::outputDiffuseAlpha,"outColor");
            outputProcedure = this.alternativa3d::outputDiffuseAlpha;
         }
         else if(opacityMap != null)
         {
            fragmentLinker.name_123(this.alternativa3d::outputOpacity);
            fragmentLinker.name_118(this.alternativa3d::outputOpacity,"outColor");
            outputProcedure = this.alternativa3d::outputOpacity;
         }
         else
         {
            fragmentLinker.name_123(this.alternativa3d::outputAlpha);
            fragmentLinker.name_118(this.alternativa3d::outputAlpha,"outColor");
            outputProcedure = this.alternativa3d::outputAlpha;
         }
         if(alternativa3d::fogMode == alternativa3d::SIMPLE || alternativa3d::fogMode == alternativa3d::ADVANCED)
         {
            fragmentLinker.name_125(outputProcedure,"outColor");
         }
         if(alternativa3d::fogMode == alternativa3d::SIMPLE)
         {
            vertexLinker.name_123(passSimpleFogConstProcedure);
            vertexLinker.name_118(passSimpleFogConstProcedure,positionVar);
            fragmentLinker.name_123(outputWithSimpleFogProcedure);
            fragmentLinker.name_118(outputWithSimpleFogProcedure,"outColor");
         }
         else if(alternativa3d::fogMode == alternativa3d::ADVANCED)
         {
            vertexLinker.name_120("tProjected");
            vertexLinker.name_125(alternativa3d::_projectProcedure,"tProjected");
            vertexLinker.name_123(postPassAdvancedFogConstProcedure);
            vertexLinker.name_118(postPassAdvancedFogConstProcedure,positionVar,"tProjected");
            fragmentLinker.name_123(outputWithAdvancedFogProcedure);
            fragmentLinker.name_118(outputWithAdvancedFogProcedure,"outColor");
         }
         fragmentLinker.name_133(vertexLinker);
         return new name_127(vertexLinker,fragmentLinker);
      }
      
      private function method_76(procedure:name_114, light:name_116, useShadow:Boolean) : void
      {
         var source:Array = ["#c0=c" + light.alternativa3d::name_138 + "Direction","#c1=c" + light.alternativa3d::name_138 + "Color","add t0.xyz, i1.xyz, c0.xyz","mov t0.w, c0.w","nrm t0.xyz,t0.xyz","dp3 t0.w, t0.xyz, i0.xyz","pow t0.w, t0.w, o1.w","dp3 t0.x, i0.xyz, c0.xyz","sat t0.x, t0.x"];
         if(useShadow)
         {
            source.push("mul t0.x, t0.x, i2.x");
            source.push("mul t0.xyz, c1.xyz, t0.xxx");
            source.push("mov o0.xyz, t0.xyz");
            source.push("add o0.xyz, o0.xyz, i3.xyz");
            source.push("mul t0.w, i2.x, t0.w");
            source.push("mul o1.xyz, c1.xyz, t0.www");
         }
         else
         {
            source.push("mul t0.xyz, c1.xyz, t0.xxxx");
            source.push("add o0, o0, t0.xyz");
            source.push("mul t0.xyz, c1.xyz, t0.w");
            source.push("add o1.xyz, o1.xyz, t0.xyz");
         }
         procedure.name_140(source);
      }
      
      override alternativa3d function fillResources(resources:Dictionary, resourceType:Class) : void
      {
         super.alternativa3d::fillResources(resources,resourceType);
         if(this.normalMap != null && Boolean(name_28.alternativa3d::name_131(getDefinitionByName(getQualifiedClassName(this.normalMap)) as Class,resourceType)))
         {
            resources[this.normalMap] = true;
         }
         if(opacityMap != null && Boolean(name_28.alternativa3d::name_131(getDefinitionByName(getQualifiedClassName(opacityMap)) as Class,resourceType)))
         {
            resources[opacityMap] = true;
         }
         if(this.glossinessMap != null && Boolean(name_28.alternativa3d::name_131(getDefinitionByName(getQualifiedClassName(this.glossinessMap)) as Class,resourceType)))
         {
            resources[this.glossinessMap] = true;
         }
         if(this.specularMap != null && Boolean(name_28.alternativa3d::name_131(getDefinitionByName(getQualifiedClassName(this.specularMap)) as Class,resourceType)))
         {
            resources[this.specularMap] = true;
         }
      }
      
      override alternativa3d function collectDraws(camera:name_124, surface:name_117, geometry:name_119, lights:Vector.<name_116>, lightsLength:int, objectRenderPriority:int = -1) : void
      {
         var program:name_127 = null;
         var i:int = 0;
         var light:name_116 = null;
         var directional:DirectionalLight = null;
         var camTransform:name_139 = null;
         var transform:name_139 = null;
         var rScale:Number = NaN;
         var len:Number = NaN;
         var omni:OmniLight = null;
         var spot:SpotLight = null;
         var falloff:Number = NaN;
         var hotspot:Number = NaN;
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
         if(diffuseMap == null || this.normalMap == null || diffuseMap.alternativa3d::_texture == null || this.normalMap.alternativa3d::_texture == null)
         {
            return;
         }
         if(!var_21 && opacityMap != null && opacityMap.alternativa3d::_texture == null)
         {
            return;
         }
         if(this.glossinessMap != null && this.glossinessMap.alternativa3d::_texture == null)
         {
            return;
         }
         if(this.specularMap != null && this.specularMap.alternativa3d::_texture == null)
         {
            return;
         }
         var object:name_78 = surface.alternativa3d::object;
         var positionBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(name_126.POSITION);
         var uvBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(name_126.TEXCOORDS[0]);
         var normalsBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(name_126.NORMAL);
         var tangentsBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(name_126.TANGENT4);
         if(positionBuffer == null || uvBuffer == null)
         {
            return;
         }
         var key:String = alternativa3d::fogMode.toString() + this.var_53.toString() + (this.glossinessMap != null ? "G" : "g") + (opacityMap != null ? "O" : "o") + (this.specularMap != null ? "S" : "s") + (var_21 ? "D" : "d");
         for(i = 0; i < lightsLength; i++)
         {
            light = lights[i];
            if(light is DirectionalLight && directional == null && DirectionalLight(light).shadow != null)
            {
               directional = DirectionalLight(light);
               key += "S";
            }
            key += light.alternativa3d::name_138;
         }
         var programs:Dictionary = _programs[object.alternativa3d::transformProcedure];
         if(programs == null)
         {
            programs = new Dictionary(false);
            _programs[object.alternativa3d::transformProcedure] = programs;
            program = this.method_75(object,lights,directional,lightsLength);
            program.upload(camera.alternativa3d::context3D);
            programs[key] = program;
         }
         else
         {
            program = programs[key];
            if(program == null)
            {
               program = this.method_75(object,lights,directional,lightsLength);
               program.upload(camera.alternativa3d::context3D);
               programs[key] = program;
            }
         }
         var drawUnit:name_135 = camera.alternativa3d::renderer.alternativa3d::name_137(object,program.program,geometry.alternativa3d::name_132,surface.indexBegin,surface.numTriangles,program);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aPosition"),positionBuffer,geometry.alternativa3d::_attributesOffsets[name_126.POSITION],name_126.alternativa3d::FORMATS[name_126.POSITION]);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aUV"),uvBuffer,geometry.alternativa3d::_attributesOffsets[name_126.TEXCOORDS[0]],name_126.alternativa3d::FORMATS[name_126.TEXCOORDS[0]]);
         object.alternativa3d::setTransformConstants(drawUnit,surface,program.vertexShader,camera);
         drawUnit.alternativa3d::name_136(camera,program.vertexShader.getVariableIndex("cProjMatrix"),object.alternativa3d::localToCameraTransform);
         drawUnit.alternativa3d::name_205(program.fragmentShader.getVariableIndex("cAmbientColor"),camera.alternativa3d::ambient,1);
         drawUnit.alternativa3d::name_134(program.fragmentShader.getVariableIndex("cSurface"),0,this.glossiness,this.var_25,alpha);
         if(lightsLength > 0)
         {
            if(this.var_53 == name_204.TANGENT_RIGHT_HANDED || this.var_53 == name_204.TANGENT_LEFT_HANDED)
            {
               drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aNormal"),normalsBuffer,geometry.alternativa3d::_attributesOffsets[name_126.NORMAL],name_126.alternativa3d::FORMATS[name_126.NORMAL]);
               drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aTangent"),tangentsBuffer,geometry.alternativa3d::_attributesOffsets[name_126.TANGENT4],name_126.alternativa3d::FORMATS[name_126.TANGENT4]);
            }
            drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sBump"),this.normalMap.alternativa3d::_texture);
            camTransform = object.alternativa3d::cameraToLocalTransform;
            drawUnit.alternativa3d::name_144(program.vertexShader.getVariableIndex("cCameraPosition"),camTransform.d,camTransform.h,camTransform.l);
            for(i = 0; i < lightsLength; )
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
                  omni = light as OmniLight;
                  transform = light.alternativa3d::name_141;
                  rScale = Number(Math.sqrt(transform.a * transform.a + transform.e * transform.e + transform.i * transform.i));
                  rScale += Math.sqrt(transform.b * transform.b + transform.f * transform.f + transform.j * transform.j);
                  rScale += Math.sqrt(transform.c * transform.c + transform.g * transform.g + transform.k * transform.k);
                  rScale /= 3;
                  drawUnit.alternativa3d::name_134(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::name_138 + "Position"),transform.d,transform.h,transform.l);
                  drawUnit.alternativa3d::name_134(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::name_138 + "Radius"),1,omni.attenuationEnd * rScale - omni.attenuationBegin * rScale,omni.attenuationBegin * rScale);
                  drawUnit.alternativa3d::name_134(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::name_138 + "Color"),light.alternativa3d::red,light.alternativa3d::green,light.alternativa3d::blue);
               }
               else if(light is SpotLight)
               {
                  spot = light as SpotLight;
                  transform = light.alternativa3d::name_141;
                  rScale = Number(Math.sqrt(transform.a * transform.a + transform.e * transform.e + transform.i * transform.i));
                  rScale += Math.sqrt(transform.b * transform.b + transform.f * transform.f + transform.j * transform.j);
                  rScale += len = Number(Math.sqrt(transform.c * transform.c + transform.g * transform.g + transform.k * transform.k));
                  rScale /= 3;
                  falloff = Number(Math.cos(spot.falloff * 0.5));
                  hotspot = Number(Math.cos(spot.hotspot * 0.5));
                  drawUnit.alternativa3d::name_134(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::name_138 + "Position"),transform.d,transform.h,transform.l);
                  drawUnit.alternativa3d::name_134(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::name_138 + "Axis"),-transform.c / len,-transform.g / len,-transform.k / len);
                  drawUnit.alternativa3d::name_134(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::name_138 + "Radius"),spot.attenuationEnd * rScale - spot.attenuationBegin * rScale,spot.attenuationBegin * rScale,hotspot == falloff ? 0.000001 : hotspot - falloff,falloff);
                  drawUnit.alternativa3d::name_134(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::name_138 + "Color"),light.alternativa3d::red,light.alternativa3d::green,light.alternativa3d::blue);
               }
               if(directional != null)
               {
                  directional.shadow.applyShader(drawUnit,program,object,camera);
               }
               i++;
            }
         }
         drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sTexture"),diffuseMap.alternativa3d::_texture);
         if(!var_21 && opacityMap != null)
         {
            drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sOpacity"),opacityMap.alternativa3d::_texture);
         }
         if(this.glossinessMap != null)
         {
            drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sGlossiness"),this.glossinessMap.alternativa3d::_texture);
         }
         if(this.specularMap != null)
         {
            drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sSpecular"),this.specularMap.alternativa3d::_texture);
         }
         this.alternativa3d::setPassUVProcedureConstants(drawUnit,program.vertexShader);
         if(alternativa3d::fogMode == alternativa3d::SIMPLE || alternativa3d::fogMode == alternativa3d::ADVANCED)
         {
            lm = object.alternativa3d::localToCameraTransform;
            dist = alternativa3d::fogFar - alternativa3d::fogNear;
            drawUnit.alternativa3d::name_144(program.vertexShader.getVariableIndex("cFogSpace"),lm.i / dist,lm.j / dist,lm.k / dist,(lm.l - alternativa3d::fogNear) / dist);
            drawUnit.alternativa3d::name_134(program.fragmentShader.getVariableIndex("cFogRange"),alternativa3d::fogMaxDensity,1,0,1 - alternativa3d::fogMaxDensity);
         }
         if(alternativa3d::fogMode == alternativa3d::SIMPLE)
         {
            drawUnit.alternativa3d::name_134(program.fragmentShader.getVariableIndex("cFogColor"),alternativa3d::fogColorR,alternativa3d::fogColorG,alternativa3d::fogColorB);
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
               alternativa3d::fogTexture = new name_93(bmd);
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
            drawUnit.alternativa3d::name_134(program.fragmentShader.getVariableIndex("cFogConsts"),0.5 * uScale,0.5 - uRight,0);
            drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sFogTexture"),alternativa3d::fogTexture.alternativa3d::_texture);
         }
         if(this.alternativa3d::var_54)
         {
            if(drawUnit.alternativa3d::object == null)
            {
               throw new Error("");
            }
            camera.alternativa3d::renderer.alternativa3d::name_130(drawUnit,objectRenderPriority >= 0 ? objectRenderPriority : name_128.OPAQUE);
         }
         else if(var_21 || opacityMap != null || alpha < 1)
         {
            drawUnit.alternativa3d::blendSource = Context3DBlendFactor.SOURCE_ALPHA;
            drawUnit.alternativa3d::blendDestination = Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA;
            camera.alternativa3d::renderer.alternativa3d::name_130(drawUnit,objectRenderPriority >= 0 ? objectRenderPriority : name_128.TRANSPARENT_SORT);
         }
         else
         {
            camera.alternativa3d::renderer.alternativa3d::name_130(drawUnit,objectRenderPriority >= 0 ? objectRenderPriority : name_128.OPAQUE);
         }
      }
   }
}

