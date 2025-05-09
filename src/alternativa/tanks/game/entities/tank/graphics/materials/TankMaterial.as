package alternativa.tanks.game.entities.tank.graphics.materials
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.Camera3D;
   import alternativa.engine3d.core.DrawUnit;
   import alternativa.engine3d.core.Light3D;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.RenderPriority;
   import alternativa.engine3d.core.Transform3D;
   import alternativa.engine3d.core.VertexAttributes;
   import alternativa.engine3d.lights.DirectionalLight;
   import alternativa.engine3d.lights.OmniLight;
   import alternativa.engine3d.lights.SpotLight;
   import alternativa.engine3d.materials.A3DUtils;
   import alternativa.engine3d.materials.ShaderProgram;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.materials.compiler.Linker;
   import alternativa.engine3d.materials.compiler.Procedure;
   import alternativa.engine3d.materials.compiler.VariableType;
   import alternativa.engine3d.objects.Surface;
   import alternativa.engine3d.resources.BitmapTextureResource;
   import alternativa.engine3d.resources.Geometry;
   import alternativa.engine3d.resources.TextureResource;
   import flash.display.BitmapData;
   import flash.display3D.Context3DBlendFactor;
   import flash.display3D.Context3DProgramType;
   import flash.display3D.VertexBuffer3D;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   use namespace alternativa3d;
   
   public class TankMaterial extends TextureMaterial
   {
      private static var fogTexture:TextureResource;
      
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
      
      private static const _programs:Dictionary = new Dictionary();
      
      private static const _lightFragmentProcedures:Dictionary = new Dictionary();
      
      private static const _diffuseProcedure:Procedure = Procedure.compileFromArray(["#v0=vUV","#c0=cTiling","#s0=sColormap","#s1=sDiffuse","#s2=sSurface","mul t0, v0, c0","tex t1, t0, s0 <2d, repeat, linear, miplinear>","tex t0, v0, s1 <2d, clamp, linear, miplinear>","add t2, t0, t0","mul t2, t2, t1","tex t1, v0, s2 <2d, clamp, linear, miplinear>","mul t2, t2, t1.x","add t2, t2, t0","mul t0, t0, t1.x","sub o0, t2, t0"],"diffuse");
      
      private static const _passVaryingsProcedure:Procedure = new Procedure(["#v0=vPosition","#v1=vViewVector","#c0=cCameraPosition","mov v0, i0","sub t0, c0, i0","mov v1.xyz, t0.xyz","mov v1.w, c0.w"],"passVaryings");
      
      private static const _passTBNProcedure:Procedure = new Procedure(["#v0=vTangent","#v1=vBinormal","#v2=vNormal","crs t1.xyz, i0, i1","mul t1.xyz, t1.xyz, i0.w","mov t0, i0","mov t2, i1","mov t4.w, t0.y","mov t0.y, t1.x","mov t1.x, t4.w","mov t4.w, t0.z","mov t0.z, t2.x","mov t2.x, t4.w","mov t4.w, t1.z","mov t1.z, t2.y","mov t2.y, t4.w","mov t0.w, i1.w","mov t1.w, i1.w","mov t2.w, i1.w","mov v2, t2","mov v0, t0","mov v1, t1"],"passsTBN");
      
      private static const _ambientLightProcedure:Procedure = new Procedure(["#c0=cSurface","mov o0, i0","mov o1, c0.xxxx"],"ambientLight");
      
      private static const _getNormalAndViewTangentProcedure:Procedure = new Procedure(["#v0=vTangent","#v1=vBinormal","#v2=vNormal","#v3=vUV","#v4=vViewVector","#c0=cAmbientColor","#s0=sBump","tex t0, v3, s0 <2d,clamp,linear,miplinear>","add t0, t0, t0","sub t0.xyz, t0.xyz, c0.www","nrm t1.xyz, v0.xyz","dp3 o0.x, t0.xyz, t1.xyz","nrm t1.xyz, v1.xyz","dp3 o0.y, t0.xyz, t1.xyz","nrm t1.xyz, v2.xyz","dp3 o0.z, t0.xyz, t1.xyz","nrm o0.xyz, o0.xyz","nrm o1.xyz, v4"],"getNormalAndViewTangent");
      
      private static const _getNormalAndViewObjectProcedure:Procedure = new Procedure(["#v3=vUV","#v4=vViewVector","#c0=cAmbientColor","#s0=sBump","tex t0, v3, s0 <2d,clamp,linear,miplinear>","add t0, t0, t0","sub t0.xyz, t0.xyz, c0.www","neg t0.y, t0.y","nrm o0.xyz, t0.xyz","nrm o1.xyz, v4"],"getNormalAndViewObject");
      
      private static const _setOpacityProcedure:Procedure = new Procedure(["#v0=vUV","#s0=sOpacity","tex t0, v0, s0 <2d, clamp,linear,miplinear>","mov o0.w, t0.x"],"setOpactity");
      
      private static const _applySpecularProcedure:Procedure = new Procedure(["#v0=vUV","#s0=sSurface","tex t0, v0, s0 <2d, clamp,linear,miplinear>","mul o0.xyz, o0.xyz, t0.y"],"applySpecular");
      
      private static const _setGlossinessFromTextureProcedure:Procedure = new Procedure(["#v0=vUV","#c0=cSurface","#s0=sSurface","tex t0, v0, s0 <2d, clamp, linear, miplinear>","mul o0.w, c0.y, t0.z"],"setGlossinessFromTexture");
      
      private static const _setGlossinessFromConstantProcedure:Procedure = new Procedure(["#c0=cSurface","mov o0.w, c0.y"],"setGlossinessFromConstant");
      
      private static const _mulLightingProcedure:Procedure = new Procedure(["#c0=cSurface","mul t0.xyz, i0.xyz, i2.xyz","mul t1.xyz, i1.xyz, c0.z","add t0.xyz, t0.xyz, t1.xyz","mov t0.w, c0.w","mov o0, t0"],"mulLighting");
      
      private static const _mulLightingProcedureWithDiffuseAlpha:Procedure = new Procedure(["#s0=sTexture","#v0=vUV","#c0=cSurface","mul t0.xyz, i0.xyz, i2.xyz","mul t1.xyz, i1.xyz, c0.z","add t0.xyz, t0.xyz, t1.xyz","tex t2, v0, s0 <2d, clamp,linear,miplinear>","mov t0.w, t2.x","mul t0.w, t0.w, c0.w","mov o0, t0"],"mulLightingWithDiffuseAlpha");
      
      private static const passSimpleFogConstProcedure:Procedure = new Procedure(["#v0=vZDistance","#c0=cFogSpace","dp4 t0.z, i0, c0","mov v0, t0.zzzz","sub v0.y, i0.w, t0.z"],"passSimpleFogConst");
      
      private static const outputWithSimpleFogProcedure:Procedure = new Procedure(["#v0=vZDistance","#c0=cFogColor","#c1=cFogRange","min t0.xy, v0.xy, c1.xy","max t0.xy, t0.xy, c1.zw","mul i0.xyz, i0.xyz, t0.y","mul t0.xyz, c0.xyz, t0.x","add i0.xyz, i0.xyz, t0.xyz","mov o0, i0"],"outputWithSimpleFog");
      
      private static const postPassAdvancedFogConstProcedure:Procedure = new Procedure(["#v0=vZDistance","#c0=cFogSpace","dp4 t0.z, i0, c0","mov v0, t0.zzzz","sub v0.y, i0.w, t0.z","mov v0.zw, i1.xwxw","mov o0, i1"],"postPassAdvancedFogConst");
      
      private static const outputWithAdvancedFogProcedure:Procedure = new Procedure(["#v0=vZDistance","#c0=cFogConsts","#c1=cFogRange","#s0=sFogTexture","min t0.xy, v0.xy, c1.xy","max t0.xy, t0.xy, c1.zw","mul i0.xyz, i0.xyz, t0.y","mov t1.xyzw, c0.yyzw","div t0.z, v0.z, v0.w","mul t0.z, t0.z, c0.x","add t1.x, t1.x, t0.z","tex t1, t1, s0 <2d, repeat, linear, miplinear>","mul t0.xyz, t1.xyz, t0.x","add i0.xyz, i0.xyz, t0.xyz","mov o0, i0"],"outputWithAdvancedFog");
      
      public var colorMap:TextureResource;
      
      public var surfaceMap:TextureResource;
      
      public var var_25:Number = 1;
      
      public var var_24:Number = 1;
      
      public var var_23:Number = 1;
      
      public var normalMap:TextureResource;
      
      public var glossiness:Number = 100;
      
      public var var_26:Number = 1;
      
      alternativa3d var var_22:Boolean = false;
      
      public function TankMaterial(colorMap:TextureResource = null, diffuseMap:TextureResource = null, normalMap:TextureResource = null, surfaceMap:TextureResource = null)
      {
         super(diffuseMap);
         this.colorMap = colorMap;
         this.normalMap = normalMap;
         this.surfaceMap = surfaceMap;
      }
      
      public static function setFogTexture(texture:TextureResource) : void
      {
         fogTexture = texture;
      }
      
      alternativa3d function getPassUVProcedure() : Procedure
      {
         return alternativa3d::_passUVProcedure;
      }
      
      alternativa3d function setPassUVProcedureConstants(destination:DrawUnit, vertexLinker:Linker) : void
      {
      }
      
      private function method_22(targetObject:Object3D, lights:Vector.<Light3D>, directional:DirectionalLight, lightsLength:int) : ShaderProgram
      {
         var i:int = 0;
         var procedure:Procedure = null;
         var shadowProc:Procedure = null;
         var dirMulShadowProcedure:Procedure = null;
         var light:Light3D = null;
         var lightFragmentProcedure:Procedure = null;
         var vertexLinker:Linker = new Linker(Context3DProgramType.VERTEX);
         var fragmentLinker:Linker = new Linker(Context3DProgramType.FRAGMENT);
         fragmentLinker.declareVariable("tTotalLight");
         fragmentLinker.declareVariable("tTotalHighLight");
         fragmentLinker.declareVariable("tNormal");
         fragmentLinker.declareVariable("cAmbientColor",VariableType.CONSTANT);
         fragmentLinker.addProcedure(_ambientLightProcedure);
         fragmentLinker.setInputParams(_ambientLightProcedure,"cAmbientColor");
         fragmentLinker.setOutputParams(_ambientLightProcedure,"tTotalLight","tTotalHighLight");
         fragmentLinker.declareVariable("outColor");
         fragmentLinker.addProcedure(_diffuseProcedure);
         fragmentLinker.setOutputParams(_diffuseProcedure,"outColor");
         var positionVar:String = "aPosition";
         var normalVar:String = "aNormal";
         var tangentVar:String = "aTangent";
         vertexLinker.declareVariable(positionVar,VariableType.ATTRIBUTE);
         vertexLinker.declareVariable(tangentVar,VariableType.ATTRIBUTE);
         vertexLinker.declareVariable(normalVar,VariableType.ATTRIBUTE);
         if(targetObject.alternativa3d::transformProcedure != null)
         {
            positionVar = alternativa3d::appendPositionTransformProcedure(targetObject.alternativa3d::transformProcedure,vertexLinker);
         }
         vertexLinker.addProcedure(alternativa3d::_projectProcedure);
         vertexLinker.setInputParams(alternativa3d::_projectProcedure,positionVar);
         vertexLinker.addProcedure(this.alternativa3d::getPassUVProcedure());
         if(this.surfaceMap != null)
         {
            fragmentLinker.addProcedure(_setGlossinessFromTextureProcedure);
            fragmentLinker.setOutputParams(_setGlossinessFromTextureProcedure,"tTotalHighLight");
         }
         else
         {
            fragmentLinker.addProcedure(_setGlossinessFromConstantProcedure);
            fragmentLinker.setOutputParams(_setGlossinessFromConstantProcedure,"tTotalHighLight");
         }
         if(lightsLength > 0)
         {
            if(targetObject.alternativa3d::deltaTransformProcedure != null)
            {
               vertexLinker.declareVariable("tTransformedNormal");
               procedure = targetObject.alternativa3d::deltaTransformProcedure.newInstance();
               vertexLinker.addProcedure(procedure);
               vertexLinker.setInputParams(procedure,normalVar);
               vertexLinker.setOutputParams(procedure,"tTransformedNormal");
               normalVar = "tTransformedNormal";
               vertexLinker.declareVariable("tTransformedTangent");
               procedure = targetObject.alternativa3d::deltaTransformProcedure.newInstance();
               vertexLinker.addProcedure(procedure);
               vertexLinker.setInputParams(procedure,tangentVar);
               vertexLinker.setOutputParams(procedure,"tTransformedTangent");
               tangentVar = "tTransformedTangent";
            }
            vertexLinker.addProcedure(_passVaryingsProcedure);
            vertexLinker.setInputParams(_passVaryingsProcedure,positionVar);
            fragmentLinker.declareVariable("tViewVector");
            if(this.alternativa3d::var_22)
            {
               vertexLinker.addProcedure(_passTBNProcedure);
               vertexLinker.setInputParams(_passTBNProcedure,tangentVar,normalVar);
               fragmentLinker.addProcedure(_getNormalAndViewTangentProcedure);
               fragmentLinker.setOutputParams(_getNormalAndViewTangentProcedure,"tNormal","tViewVector");
            }
            else
            {
               fragmentLinker.addProcedure(_getNormalAndViewObjectProcedure);
               fragmentLinker.setOutputParams(_getNormalAndViewObjectProcedure,"tNormal","tViewVector");
            }
            if(directional != null)
            {
               vertexLinker.addProcedure(directional.shadow.getVShader());
               shadowProc = directional.shadow.getFShader();
               fragmentLinker.addProcedure(shadowProc);
               fragmentLinker.setOutputParams(shadowProc,"tTotalLight");
               dirMulShadowProcedure = _lightFragmentProcedures[directional.shadow];
               if(dirMulShadowProcedure == null)
               {
                  dirMulShadowProcedure = new Procedure(null,"DirectionalLightWithShadow");
                  this.formDirectionalProcedure(dirMulShadowProcedure,directional,true);
               }
               fragmentLinker.addProcedure(dirMulShadowProcedure);
               fragmentLinker.setInputParams(dirMulShadowProcedure,"tNormal","tViewVector","tTotalLight","cAmbientColor");
               fragmentLinker.setOutputParams(dirMulShadowProcedure,"tTotalLight","tTotalHighLight");
            }
            for(i = 0; i < lightsLength; )
            {
               light = lights[i];
               if(light != directional)
               {
                  lightFragmentProcedure = _lightFragmentProcedures[light];
                  if(lightFragmentProcedure == null)
                  {
                     lightFragmentProcedure = new Procedure();
                     if(light is DirectionalLight)
                     {
                        this.formDirectionalProcedure(lightFragmentProcedure,light,false);
                        lightFragmentProcedure.name = i + "DirectionalLight";
                     }
                     else if(light is OmniLight)
                     {
                        lightFragmentProcedure.compileFromArray(["#c0=c" + light.alternativa3d::name_79 + "Position","#c1=c" + light.alternativa3d::name_79 + "Color","#c2=c" + light.alternativa3d::name_79 + "Radius","#v0=vPosition","sub t0, c0, v0","dp3 t0.w, t0.xyz, t0.xyz","nrm t0.xyz, t0.xyz","add t1.xyz, i1.xyz, t0.xyz","mov t1.w, c0.w","nrm t1.xyz, t1.xyz","dp3 t1.w, t1.xyz, i0.xyz","pow t1.w, t1.w, o1.w","sqt t1.x, t0.w","dp3 t0.w, t0.xyz, i0.xyz","sub t0.x, t1.x, c2.z","div t0.y, t0.x, c2.y","sub t0.x, c2.x, t0.y","sat t0.xw, t0.xw","mul t0.xyz, c1.xyz, t0.xxx","mul t1.xyz, t0.xyz, t1.w","add o1.xyz, o1.xyz, t1.xyz","mul t0.xyz, t0.xyz, t0.www","add o0.xyz, o0.xyz, t0.xyz"]);
                        lightFragmentProcedure.name = i + "OmniLight";
                     }
                     else if(light is SpotLight)
                     {
                        lightFragmentProcedure.compileFromArray(["#c0=c" + light.alternativa3d::name_79 + "Position","#c1=c" + light.alternativa3d::name_79 + "Color","#c2=c" + light.alternativa3d::name_79 + "Radius","#c3=c" + light.alternativa3d::name_79 + "Axis","#v0=vPosition","sub t0, c0, v0","dp3 t0.w, t0, t0","nrm t0.xyz,t0.xyz","add t2.xyz, i1.xyz, t0.xyz","nrm t2.xyz, t2.xyz","dp3 t2.x, t2.xyz, i0.xyz","pow t2.x, t2.x, o1.w","dp3 t1.x, t0.xyz, c3.xyz","dp3 t0.x,t0,i0","sqt t0.w,t0.w","sub t0.w, t0.w, c2.y","div t0.y, t0.w, c2.x","sub t0.w, c0.w, t0.y","sub t0.y, t1.x, c2.w","div t0.y, t0.y, c2.z","sat t0.xyw,t0.xyw","mul t1.xyz,c1.xyz,t0.yyy","mul t1.xyz,t1.xyz,t0.www","mul t2.xyz, t2.x, t1.xyz","add o1.xyz, o1.xyz, t2.xyz","mul t1.xyz, t1.xyz, t0.xxx","add o0.xyz, o0.xyz, t1.xyz"]);
                        lightFragmentProcedure.name = i + "SpotLight";
                     }
                  }
                  fragmentLinker.addProcedure(lightFragmentProcedure);
                  fragmentLinker.setInputParams(lightFragmentProcedure,"tNormal","tViewVector");
                  fragmentLinker.setOutputParams(lightFragmentProcedure,"tTotalLight","tTotalHighLight");
               }
               i++;
            }
         }
         if(opacityMap != null)
         {
            fragmentLinker.addProcedure(_setOpacityProcedure);
            fragmentLinker.setOutputParams(_setOpacityProcedure,"outColor");
         }
         if(this.surfaceMap != null)
         {
            fragmentLinker.addProcedure(_applySpecularProcedure);
            fragmentLinker.setOutputParams(_applySpecularProcedure,"tTotalHighLight");
         }
         if(var_21)
         {
            fragmentLinker.addProcedure(_mulLightingProcedureWithDiffuseAlpha);
            fragmentLinker.setInputParams(_mulLightingProcedureWithDiffuseAlpha,"tTotalLight","tTotalHighLight","outColor");
         }
         else
         {
            fragmentLinker.addProcedure(_mulLightingProcedure);
            fragmentLinker.setInputParams(_mulLightingProcedure,"tTotalLight","tTotalHighLight","outColor");
         }
         if(fogMode == SIMPLE)
         {
            vertexLinker.addProcedure(passSimpleFogConstProcedure);
            vertexLinker.setInputParams(passSimpleFogConstProcedure,positionVar);
            fragmentLinker.setOutputParams(_mulLightingProcedure,"outColor");
            fragmentLinker.addProcedure(outputWithSimpleFogProcedure);
            fragmentLinker.setInputParams(outputWithSimpleFogProcedure,"outColor");
         }
         else if(fogMode == ADVANCED)
         {
            vertexLinker.declareVariable("tProjected");
            vertexLinker.setOutputParams(alternativa3d::_projectProcedure,"tProjected");
            vertexLinker.addProcedure(postPassAdvancedFogConstProcedure);
            vertexLinker.setInputParams(postPassAdvancedFogConstProcedure,positionVar,"tProjected");
            fragmentLinker.setOutputParams(_mulLightingProcedure,"outColor");
            fragmentLinker.addProcedure(outputWithAdvancedFogProcedure);
            fragmentLinker.setInputParams(outputWithAdvancedFogProcedure,"outColor");
         }
         fragmentLinker.setOppositeLinker(vertexLinker);
         vertexLinker.link();
         fragmentLinker.link();
         return new ShaderProgram(vertexLinker,fragmentLinker);
      }
      
      private function formDirectionalProcedure(procedure:Procedure, light:Light3D, useShadow:Boolean) : void
      {
         var source:Array = ["#c0=c" + light.alternativa3d::name_79 + "Direction","#c1=c" + light.alternativa3d::name_79 + "Color","add t0.xyz, i1.xyz, c0.xyz","mov t0.w, c0.w","nrm t0.xyz,t0.xyz","dp3 t0.w, t0.xyz, i0.xyz","pow t0.w, t0.w, o1.w","dp3 t0.x, i0, c0.xyz","sat t0.x, t0.x"];
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
         procedure.compileFromArray(source);
      }
      
      override alternativa3d function fillResources(resources:Dictionary, resourceType:Class) : void
      {
         super.alternativa3d::fillResources(resources,resourceType);
         if(this.colorMap != null && Boolean(A3DUtils.alternativa3d::checkParent(getDefinitionByName(getQualifiedClassName(this.colorMap)) as Class,resourceType)))
         {
            resources[this.colorMap] = true;
         }
         if(this.normalMap != null && Boolean(A3DUtils.alternativa3d::checkParent(getDefinitionByName(getQualifiedClassName(this.normalMap)) as Class,resourceType)))
         {
            resources[this.normalMap] = true;
         }
         if(opacityMap != null && Boolean(A3DUtils.alternativa3d::checkParent(getDefinitionByName(getQualifiedClassName(opacityMap)) as Class,resourceType)))
         {
            resources[opacityMap] = true;
         }
         if(this.surfaceMap != null && Boolean(A3DUtils.alternativa3d::checkParent(getDefinitionByName(getQualifiedClassName(this.surfaceMap)) as Class,resourceType)))
         {
            resources[this.surfaceMap] = true;
         }
      }
      
      override alternativa3d function collectDraws(camera:Camera3D, surface:Surface, geometry:Geometry, lights:Vector.<Light3D>, lightsLength:int, objectRenderPriority:int = -1) : void
      {
         var light:Light3D = null;
         var i:int = 0;
         var directional:DirectionalLight = null;
         var program:ShaderProgram = null;
         var camTransform:Transform3D = null;
         var transform:Transform3D = null;
         var rScale:Number = NaN;
         var len:Number = NaN;
         var omni:OmniLight = null;
         var spot:SpotLight = null;
         var falloff:Number = NaN;
         var hotspot:Number = NaN;
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
         if(diffuseMap == null || this.colorMap == null || this.normalMap == null || diffuseMap.alternativa3d::_texture == null || this.colorMap.alternativa3d::_texture == null || this.normalMap.alternativa3d::_texture == null)
         {
            return;
         }
         if(!var_21 && opacityMap != null && opacityMap.alternativa3d::_texture == null)
         {
            return;
         }
         if(this.surfaceMap != null && this.surfaceMap.alternativa3d::_texture == null)
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
         lightsLength = lightsLength > 5 ? 5 : lightsLength;
         var key:String = fogMode.toString() + (this.alternativa3d::var_22 ? "T" : "t") + (opacityMap != null ? "O" : "o") + (this.surfaceMap != null ? "S" : "s") + (var_21 ? "D" : "d");
         for(i = 0; i < lightsLength; i++)
         {
            light = lights[i];
            if(light is DirectionalLight && directional == null && DirectionalLight(light).shadow != null)
            {
               directional = DirectionalLight(light);
               key += "S";
            }
            key += light.alternativa3d::name_79;
         }
         var dict:Dictionary = _programs[object.alternativa3d::transformProcedure];
         if(dict == null)
         {
            dict = new Dictionary();
            _programs[object.alternativa3d::transformProcedure] = dict;
            program = this.method_22(object,lights,directional,lightsLength);
            program.upload(camera.alternativa3d::context3D);
            dict[key] = program;
         }
         else
         {
            program = dict[key];
            if(program == null)
            {
               program = this.method_22(object,lights,directional,lightsLength);
               program.upload(camera.alternativa3d::context3D);
               dict[key] = program;
            }
         }
         var drawUnit:DrawUnit = camera.alternativa3d::renderer.alternativa3d::createDrawUnit(object,program.program,geometry.alternativa3d::name_78,surface.indexBegin,surface.numTriangles,program);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aPosition"),positionBuffer,geometry.alternativa3d::_attributesOffsets[VertexAttributes.POSITION],VertexAttributes.alternativa3d::FORMATS[VertexAttributes.POSITION]);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aUV"),uvBuffer,geometry.alternativa3d::_attributesOffsets[VertexAttributes.TEXCOORDS[0]],VertexAttributes.alternativa3d::FORMATS[VertexAttributes.TEXCOORDS[0]]);
         object.alternativa3d::setTransformConstants(drawUnit,surface,program.vertexShader,camera);
         drawUnit.alternativa3d::setProjectionConstants(camera,program.vertexShader.getVariableIndex("cProjMatrix"),object.alternativa3d::localToCameraTransform);
         drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.fragmentShader.getVariableIndex("cAmbientColor"),this.var_23 * camera.alternativa3d::ambient[0],this.var_23 * camera.alternativa3d::ambient[1],this.var_23 * camera.alternativa3d::ambient[2]);
         drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.fragmentShader.getVariableIndex("cSurface"),0,this.glossiness,this.var_26,alpha);
         drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.fragmentShader.getVariableIndex("cTiling"),this.var_25,this.var_24,0,0);
         drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sColormap"),this.colorMap.alternativa3d::_texture);
         drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sDiffuse"),diffuseMap.alternativa3d::_texture);
         if(opacityMap != null)
         {
            drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sOpacity"),opacityMap.alternativa3d::_texture);
         }
         if(this.surfaceMap != null)
         {
            drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sSurface"),this.surfaceMap.alternativa3d::_texture);
         }
         if(lightsLength > 0)
         {
            if(this.alternativa3d::var_22)
            {
               drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aNormal"),normalsBuffer,geometry.alternativa3d::_attributesOffsets[VertexAttributes.NORMAL],VertexAttributes.alternativa3d::FORMATS[VertexAttributes.NORMAL]);
               drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aTangent"),tangentsBuffer,geometry.alternativa3d::_attributesOffsets[VertexAttributes.TANGENT4],VertexAttributes.alternativa3d::FORMATS[VertexAttributes.TANGENT4]);
            }
            drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sBump"),this.normalMap.alternativa3d::_texture);
            camTransform = object.alternativa3d::cameraToLocalTransform;
            drawUnit.alternativa3d::setVertexConstantsFromNumbers(program.vertexShader.getVariableIndex("cCameraPosition"),camTransform.d,camTransform.h,camTransform.l);
            for(i = 0; i < lightsLength; )
            {
               light = lights[i];
               if(light is DirectionalLight)
               {
                  transform = light.alternativa3d::name_80;
                  len = Number(Math.sqrt(transform.c * transform.c + transform.g * transform.g + transform.k * transform.k));
                  drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::name_79 + "Direction"),-transform.c / len,-transform.g / len,-transform.k / len,1);
                  drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::name_79 + "Color"),light.alternativa3d::red,light.alternativa3d::green,light.alternativa3d::blue);
               }
               else if(light is OmniLight)
               {
                  omni = light as OmniLight;
                  transform = light.alternativa3d::name_80;
                  rScale = Number(Math.sqrt(transform.a * transform.a + transform.e * transform.e + transform.i * transform.i));
                  rScale += Math.sqrt(transform.b * transform.b + transform.f * transform.f + transform.j * transform.j);
                  rScale += Math.sqrt(transform.c * transform.c + transform.g * transform.g + transform.k * transform.k);
                  rScale /= 3;
                  drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::name_79 + "Position"),transform.d,transform.h,transform.l);
                  drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::name_79 + "Radius"),1,omni.attenuationEnd * rScale - omni.attenuationBegin * rScale,omni.attenuationBegin * rScale);
                  drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::name_79 + "Color"),light.alternativa3d::red,light.alternativa3d::green,light.alternativa3d::blue);
               }
               else if(light is SpotLight)
               {
                  spot = light as SpotLight;
                  transform = light.alternativa3d::name_80;
                  rScale = Number(Math.sqrt(transform.a * transform.a + transform.e * transform.e + transform.i * transform.i));
                  rScale += Math.sqrt(transform.b * transform.b + transform.f * transform.f + transform.j * transform.j);
                  rScale += len = Number(Math.sqrt(transform.c * transform.c + transform.g * transform.g + transform.k * transform.k));
                  rScale /= 3;
                  falloff = Number(Math.cos(spot.falloff * 0.5));
                  hotspot = Number(Math.cos(spot.hotspot * 0.5));
                  drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::name_79 + "Position"),transform.d,transform.h,transform.l);
                  drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::name_79 + "Axis"),-transform.c / len,-transform.g / len,-transform.k / len);
                  drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::name_79 + "Radius"),spot.attenuationEnd * rScale - spot.attenuationBegin * rScale,spot.attenuationBegin * rScale,hotspot == falloff ? 0.000001 : hotspot - falloff,falloff);
                  drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::name_79 + "Color"),light.alternativa3d::red,light.alternativa3d::green,light.alternativa3d::blue);
               }
               if(directional != null)
               {
                  directional.shadow.applyShader(drawUnit,program,object,camera);
               }
               i++;
            }
         }
         this.alternativa3d::setPassUVProcedureConstants(drawUnit,program.vertexShader);
         if(fogMode == SIMPLE || fogMode == ADVANCED)
         {
            lm = object.alternativa3d::localToCameraTransform;
            dist = fogFar - fogNear;
            drawUnit.alternativa3d::setVertexConstantsFromNumbers(program.vertexShader.getVariableIndex("cFogSpace"),lm.i / dist,lm.j / dist,lm.k / dist,(lm.l - fogNear) / dist);
            drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.fragmentShader.getVariableIndex("cFogRange"),fogMaxDensity,1,0,1 - fogMaxDensity);
         }
         if(fogMode == SIMPLE)
         {
            drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.fragmentShader.getVariableIndex("cFogColor"),fogColorR,fogColorG,fogColorB);
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
               fogTexture = new BitmapTextureResource(bmd);
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
            drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.fragmentShader.getVariableIndex("cFogConsts"),0.5 * uScale,0.5 - uRight,0);
            drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sFogTexture"),fogTexture.alternativa3d::_texture);
         }
         if(var_21 || opacityMap != null || alpha < 1)
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

