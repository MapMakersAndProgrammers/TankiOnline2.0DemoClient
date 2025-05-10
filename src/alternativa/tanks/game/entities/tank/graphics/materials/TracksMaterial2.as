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
   import alternativa.engine3d.materials.A3DUtils;
   import alternativa.engine3d.materials.Material;
   import alternativa.engine3d.materials.ShaderProgram;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.materials.compiler.Linker;
   import alternativa.engine3d.materials.compiler.Procedure;
   import alternativa.engine3d.materials.compiler.VariableType;
   import alternativa.engine3d.objects.Surface;
   import alternativa.engine3d.resources.BitmapTextureResource;
   import alternativa.engine3d.resources.Geometry;
   import alternativa.engine3d.resources.TextureResource;
   import alternativa.engine3d.shadows.DirectionalShadowRenderer;
   import alternativa.engine3d.shadows.ShadowRenderer;
   import flash.display.BitmapData;
   import flash.display3D.Context3DBlendFactor;
   import flash.display3D.Context3DProgramType;
   import flash.display3D.VertexBuffer3D;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   use namespace alternativa3d;
   
   public class TracksMaterial2 extends TextureMaterial
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
      
      private static const passSimpleFogConstProcedure:Procedure = new Procedure(["#v0=vZDistance","#c0=cFogSpace","dp4 t0.z, i0, c0","mov v0, t0.zzzz","sub v0.y, i0.w, t0.z"],"passSimpleFogConst");
      
      private static const outputWithSimpleFogProcedure:Procedure = new Procedure(["#v0=vZDistance","#c0=cFogColor","#c1=cFogRange","min t0.xy, v0.xy, c1.xy","max t0.xy, t0.xy, c1.zw","mul t1.xyz, c0.xyz, t0.x","mov t1.w, t0.y","mov o0, t1"],"outputWithSimpleFog");
      
      private static const postPassAdvancedFogConstProcedure:Procedure = new Procedure(["#v0=vZDistance","#c0=cFogSpace","dp4 t0.z, i0, c0","mov v0, t0.zzzz","sub v0.y, i0.w, t0.z","mov v0.zw, i1.xwxw","mov o0, i1"],"postPassAdvancedFogConst");
      
      private static const outputWithAdvancedFogProcedure:Procedure = new Procedure(["#v0=vZDistance","#c0=cFogConsts","#c1=cFogRange","#s0=sFogTexture","min t0.xy, v0.xy, c1.xy","max t0.xy, t0.xy, c1.zw","mov t1.xyzw, c0.yyzw","div t0.z, v0.z, v0.w","mul t0.z, t0.z, c0.x","add t1.x, t1.x, t0.z","tex t1, t1, s0 <2d, repeat, linear, miplinear>","mul t1.xyz, t1.xyz, t0.x","mov t1.w, t0.y","mov o0, t1"],"outputWithAdvancedFog");
      
      private static const objectsProgramsSets:Dictionary = new Dictionary();
      
      private static const lightContainer:Vector.<Light3D> = new Vector.<Light3D>(1,true);
      
      private static const actualLigths:Vector.<Light3D> = new Vector.<Light3D>();
      
      private static const passUVProcedure:Procedure = Procedure.compileFromArray(["#a0=aUV","#v0=vUV","#c0=cUVOffsets","add v0, a0, c0"]);
      
      private static const diffuseProcedure:Procedure = Procedure.compileFromArray(["#v0=vUV","#s0=sDiffuse","tex t0, v0, s0 <2d, repeat, linear, miplinear>","mov o0, t0"],"diffuse");
      
      private static const setColorProcedure:Procedure = new Procedure(["mov o0, i0"],"setColorProcedure");
      
      private static const outputWithLightProcedure:Procedure = new Procedure(["mul t0.xyz, i0.xyz, i1.xyz","mov t0.w, i1.w","mov o0, t0"],"outputWithLightProcedure");
      
      private static const outputProcedure:Procedure = new Procedure(["mov o0, i0"],"outputProcedure");
      
      private static const passVaryingsProcedure:Procedure = new Procedure(["#c0=cCamera","#v0=vPosition","#v1=vViewVector","mov v0, i0","sub t0, c0, i0","mov v1.xyz, t0.xyz","mov v1.w, c0.w"],"passVaryingsProcedure");
      
      private static const passTBNRightProcedure:Procedure = getPassTBNProcedure(true);
      
      private static const passTBNLeftProcedure:Procedure = getPassTBNProcedure(false);
      
      private static const getNormalAndViewProcedure:Procedure = new Procedure(["#v0=vTangent","#v1=vBinormal","#v2=vNormal","#v3=vUV","#v4=vViewVector","#c0=cSurface","#s0=sBump","tex t0, v3, s0 <2d,repeat,linear,miplinear>","add t0, t0, t0","sub t0.xyz, t0.xyz, c0.www","nrm t1.xyz, v0.xyz","dp3 o0.x, t0.xyz, t1.xyz","nrm t1.xyz, v1.xyz","dp3 o0.y, t0.xyz, t1.xyz","nrm t1.xyz, v2.xyz","dp3 o0.z, t0.xyz, t1.xyz","nrm o0.xyz, o0.xyz","nrm o1.xyz, v4"],"getNormalAndViewProcedure");
      
      private static const getSpecularOptionsConstProcedure:Procedure = new Procedure(["#c0=cSurface","mov i0.w, c0.y","mov i1.w, c0.z"],"getSpecularOptionsConstProcedure");
      
      public var uOffset:Number = 0;
      
      public var vOffset:Number = 0;
      
      public var normalMap:TextureResource;
      
      public var glossiness:Number = 100;
      
      public var §_-kj§:Number = 1;
      
      private const outputWithSpecularProcedure:Procedure = new Procedure(["mul t0.xyz, i0.xyz, i1.xyz","add t0.xyz, t0.xyz, i2.xyz","mov t0.w, i1.w","mov o0, t0"],"outputWithSpecularProcedure");
      
      public function TracksMaterial2(diffuse:TextureResource = null, normalMap:TextureResource = null)
      {
         super();
         this.diffuseMap = diffuse;
         this.normalMap = normalMap;
      }
      
      public static function setFogTexture(texture:TextureResource) : void
      {
         fogTexture = texture;
      }
      
      private static function getPassTBNProcedure(right:Boolean) : Procedure
      {
         var crsInSpace:String = right ? "crs t1.xyz, i0, i1" : "crs t1.xyz, i1, i0";
         return new Procedure(["#v0=vTangent","#v1=vBinormal","#v2=vNormal",crsInSpace,"mul t1.xyz, t1.xyz, i0.w","mov v0.x, i0.x","mov v0.y, t1.x","mov v0.z, i1.x","mov v0.w, i1.w","mov v1.x, i0.y","mov v1.y, t1.y","mov v1.z, i1.y","mov v1.w, i1.w","mov v2.x, i0.z","mov v2.y, t1.z","mov v2.z, i1.z","mov v2.w, i1.w"],"passTBNProcedure");
      }
      
      private static function directionalProcedure(light:Light3D, add:Boolean) : Procedure
      {
         return new Procedure(["#c0=c" + light.alternativa3d::_-oG + "Direction","#c1=c" + light.alternativa3d::_-oG + "Color","add t0.xyz, i1.xyz, c0.xyz","nrm t0.xyz, t0.xyz","dp3 t0.w, t0.xyz, i0.xyz","pow t0.w, t0.w, i0.w","mul t0.w, t0.w, i1.w","dp3 t0.x, i0.xyz, c0.xyz","sat t0.x, t0.x",add ? "mul t0.xyz, c1.xyz, t0.x" : "mul o0.xyz, c1.xyz, t0.x",add ? "add o0.xyz, o0.xyz, t0.xyz" : "mov o0.w, c0.w",add ? "mul t0.xyz, c1.xyz, t0.w" : "mul o1.xyz, c1.xyz, t0.w",add ? "add o1.xyz, o1.xyz, t0.xyz" : "mov o1.w, c0.w"],"directionalProcedure");
      }
      
      private static function omniProcedure(light:Light3D, add:Boolean) : Procedure
      {
         return new Procedure(["#c0=c" + light.alternativa3d::_-oG + "Position","#c1=c" + light.alternativa3d::_-oG + "Color","#c2=c" + light.alternativa3d::_-oG + "Radius","#v0=vPosition","sub t0, c0, v0","dp3 t0.w, t0.xyz, t0.xyz","nrm t0.xyz, t0.xyz","add t1.xyz, i1.xyz, t0.xyz","mov t1.w, c0.w","nrm t1.xyz, t1.xyz","dp3 t1.w, t1.xyz, i0.xyz","pow t1.w, t1.w, i0.w","mul t1.w, t1.w, i1.w","sqt t1.x, t0.w","dp3 t0.w, t0.xyz, i0.xyz","sub t0.x, t1.x, c2.z","div t0.y, t0.x, c2.y","sub t0.x, c2.x, t0.y","sat t0.xw, t0.xw","mul t0.xyz, c1.xyz, t0.xxx",add ? "mul t1.xyz, t0.xyz, t0.w" : "mul o0.xyz, t0.xyz, t0.w",add ? "add o0.xyz, o0.xyz, t1.xyz" : "mov o0.w, c0.w",add ? "mul t1.xyz, t0.xyz, t1.w" : "mul o1.xyz, t0.xyz, t1.w",add ? "add o1.xyz, o1.xyz, t1.xyz" : "mov o1.w, c0.w"],"omniProcedure");
      }
      
      override alternativa3d function fillResources(resources:Dictionary, resourceType:Class) : void
      {
         super.alternativa3d::fillResources(resources,resourceType);
         if(diffuseMap != null && Boolean(A3DUtils.alternativa3d::checkParent(getDefinitionByName(getQualifiedClassName(diffuseMap)) as Class,resourceType)))
         {
            resources[diffuseMap] = true;
         }
         if(this.normalMap != null && Boolean(A3DUtils.alternativa3d::checkParent(getDefinitionByName(getQualifiedClassName(this.normalMap)) as Class,resourceType)))
         {
            resources[this.normalMap] = true;
         }
      }
      
      override alternativa3d function collectDraws(camera:Camera3D, surface:Surface, geometry:Geometry, lights:Vector.<Light3D>, lightsLength:int, objectRenderPriority:int = -1) : void
      {
         var i:int = 0;
         var light:Light3D = null;
         var shadowedLight:DirectionalLight = null;
         var drawUnit:DrawUnit = null;
         var program:ShaderProgram = null;
         var numShadows:int = 0;
         var shadow:ShadowRenderer = null;
         var lightsPrograms:Dictionary = null;
         if(diffuseMap == null || this.normalMap == null || diffuseMap.alternativa3d::_texture == null || this.normalMap.alternativa3d::_texture == null)
         {
            return;
         }
         var object:Object3D = surface.alternativa3d::object;
         var positionBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(VertexAttributes.POSITION);
         var uvBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(VertexAttributes.TEXCOORDS[0]);
         var tangentBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(VertexAttributes.TANGENT4);
         var normalBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(VertexAttributes.NORMAL);
         if(positionBuffer == null || uvBuffer == null || tangentBuffer == null || normalBuffer == null)
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
            program = programs[0];
            if(program == null)
            {
               program = this.setupShadowOrAmbient(object,shadowedLight.shadow,true);
               program.upload(camera.alternativa3d::context3D);
               programs[0] = program;
            }
            drawUnit = this.getShadowOrAmbientDrawUnit(program,shadowedLight.shadow,true,camera,object,surface,geometry);
         }
         else
         {
            program = programs[1];
            if(program == null)
            {
               program = this.setupShadowOrAmbient(object,null,true);
               program.upload(camera.alternativa3d::context3D);
               programs[1] = program;
            }
            drawUnit = this.getShadowOrAmbientDrawUnit(program,null,true,camera,object,surface,geometry);
         }
         drawUnit.alternativa3d::blendSource = Context3DBlendFactor.ONE;
         drawUnit.alternativa3d::blendDestination = Context3DBlendFactor.ZERO;
         camera.alternativa3d::renderer.alternativa3d::addDrawUnit(drawUnit,RenderPriority.TANK_OPAQUE);
         if(shadowedLight != null)
         {
            numShadows = object.alternativa3d::shadowRenderers != null ? int(object.alternativa3d::shadowRenderers.length) : 0;
            for(i = 0; i < numShadows; )
            {
               shadow = object.alternativa3d::shadowRenderers[i];
               if(shadow is DirectionalShadowRenderer)
               {
                  program = programs[2];
                  if(program == null)
                  {
                     program = this.setupShadowOrAmbient(object,shadow,false);
                     program.upload(camera.alternativa3d::context3D);
                     programs[2] = program;
                  }
                  drawUnit = this.getShadowOrAmbientDrawUnit(program,shadow,false,camera,object,surface,geometry);
                  drawUnit.alternativa3d::blendSource = Context3DBlendFactor.ZERO;
                  drawUnit.alternativa3d::blendDestination = Context3DBlendFactor.SOURCE_COLOR;
                  camera.alternativa3d::renderer.alternativa3d::addDrawUnit(drawUnit,RenderPriority.SHADOWS);
               }
               i++;
            }
            program = programs[3];
            if(program == null)
            {
               lightContainer[0] = shadowedLight;
               program = this.setupLighting(object,lightContainer,1);
               program.upload(camera.alternativa3d::context3D);
               programs[3] = program;
            }
            drawUnit = this.getLightingDrawUnit(program,lightContainer,1,camera,object,surface,geometry);
            drawUnit.alternativa3d::blendSource = Context3DBlendFactor.DESTINATION_ALPHA;
            drawUnit.alternativa3d::blendDestination = Context3DBlendFactor.ONE;
            camera.alternativa3d::renderer.alternativa3d::addDrawUnit(drawUnit,RenderPriority.SHADOWED_LIGHTS);
         }
         if(actualLightsLength > 0)
         {
            lightsPrograms = programs[4];
            if(lightsPrograms == null)
            {
               lightsPrograms = new Dictionary(false);
               programs[4] = lightsPrograms;
            }
            program = lightsPrograms[lightsKey];
            if(program == null)
            {
               program = this.setupLighting(object,actualLigths,actualLightsLength);
               program.upload(camera.alternativa3d::context3D);
               lightsPrograms[lightsKey] = program;
            }
            drawUnit = this.getLightingDrawUnit(program,actualLigths,actualLightsLength,camera,object,surface,geometry);
            drawUnit.alternativa3d::blendSource = Context3DBlendFactor.ONE;
            drawUnit.alternativa3d::blendDestination = Context3DBlendFactor.ONE;
            camera.alternativa3d::renderer.alternativa3d::addDrawUnit(drawUnit,RenderPriority.LIGHTS);
         }
         if(fogMode == SIMPLE || fogMode == ADVANCED)
         {
            program = programs[int(fogMode + 4)];
            if(program == null)
            {
               program = this.setupFog(object);
               program.upload(camera.alternativa3d::context3D);
               programs[int(fogMode + 4)] = program;
            }
            drawUnit = this.getFogDrawUnit(program,camera,object,surface,geometry);
            drawUnit.alternativa3d::blendSource = Context3DBlendFactor.ONE;
            drawUnit.alternativa3d::blendDestination = Context3DBlendFactor.SOURCE_ALPHA;
            camera.alternativa3d::renderer.alternativa3d::addDrawUnit(drawUnit,RenderPriority.FOG);
         }
         actualLigths.length = 0;
      }
      
      private function setupShadowOrAmbient(object:Object3D, shadow:ShadowRenderer, ambient:Boolean) : ShaderProgram
      {
         var shadowProc:Procedure = null;
         var vertexLinker:Linker = new Linker(Context3DProgramType.VERTEX);
         var fragmentLinker:Linker = new Linker(Context3DProgramType.FRAGMENT);
         var positionVar:String = "aPosition";
         vertexLinker.declareVariable(positionVar,VariableType.ATTRIBUTE);
         if(object.alternativa3d::transformProcedure != null)
         {
            positionVar = alternativa3d::appendPositionTransformProcedure(object.alternativa3d::transformProcedure,vertexLinker);
         }
         vertexLinker.addProcedure(alternativa3d::_projectProcedure);
         vertexLinker.setInputParams(alternativa3d::_projectProcedure,positionVar);
         if(ambient)
         {
            vertexLinker.addProcedure(passUVProcedure);
         }
         var colorConst:String = ambient ? "cAmbient" : "cShadow";
         fragmentLinker.declareVariable(colorConst,VariableType.CONSTANT);
         fragmentLinker.declareVariable("tLight");
         fragmentLinker.addProcedure(setColorProcedure);
         fragmentLinker.setInputParams(setColorProcedure,colorConst);
         fragmentLinker.setOutputParams(setColorProcedure,"tLight");
         if(shadow != null)
         {
            vertexLinker.addProcedure(shadow.getVShader());
            shadowProc = shadow.getFIntensityShader();
            fragmentLinker.addProcedure(shadowProc);
            fragmentLinker.setOutputParams(shadowProc,"tLight");
         }
         if(ambient)
         {
            fragmentLinker.declareVariable("tColor");
            fragmentLinker.addProcedure(diffuseProcedure);
            fragmentLinker.setOutputParams(diffuseProcedure,"tColor");
            fragmentLinker.addProcedure(outputWithLightProcedure);
            fragmentLinker.setInputParams(outputWithLightProcedure,"tColor","tLight");
         }
         else
         {
            fragmentLinker.addProcedure(outputProcedure);
            fragmentLinker.setInputParams(outputProcedure,"tLight");
         }
         fragmentLinker.setOppositeLinker(vertexLinker);
         return new ShaderProgram(vertexLinker,fragmentLinker);
      }
      
      private function getShadowOrAmbientDrawUnit(program:ShaderProgram, shadow:ShadowRenderer, ambient:Boolean, camera:Camera3D, object:Object3D, surface:Surface, geometry:Geometry) : DrawUnit
      {
         var positionBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(VertexAttributes.POSITION);
         var uvBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(VertexAttributes.TEXCOORDS[0]);
         var drawUnit:DrawUnit = camera.alternativa3d::renderer.alternativa3d::createDrawUnit(object,program.program,geometry.alternativa3d::_-EM,surface.indexBegin,surface.numTriangles,program);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aPosition"),positionBuffer,geometry.alternativa3d::_attributesOffsets[VertexAttributes.POSITION],VertexAttributes.alternativa3d::FORMATS[VertexAttributes.POSITION]);
         if(ambient)
         {
            drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aUV"),uvBuffer,geometry.alternativa3d::_attributesOffsets[VertexAttributes.TEXCOORDS[0]],VertexAttributes.alternativa3d::FORMATS[VertexAttributes.TEXCOORDS[0]]);
         }
         object.alternativa3d::setTransformConstants(drawUnit,surface,program.vertexShader,camera);
         drawUnit.alternativa3d::setProjectionConstants(camera,program.vertexShader.getVariableIndex("cProjMatrix"),object.alternativa3d::localToCameraTransform);
         if(ambient)
         {
            drawUnit.alternativa3d::setVertexConstantsFromNumbers(program.vertexShader.getVariableIndex("cUVOffsets"),-this.uOffset,this.vOffset,0,0);
            drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.fragmentShader.getVariableIndex("cAmbient"),camera.alternativa3d::ambient[0],camera.alternativa3d::ambient[1],camera.alternativa3d::ambient[2],1);
            drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sDiffuse"),diffuseMap.alternativa3d::_texture);
         }
         else
         {
            drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.fragmentShader.getVariableIndex("cShadow"),1,1,1,1);
         }
         if(shadow != null)
         {
            shadow.applyShader(drawUnit,program,object,camera);
         }
         return drawUnit;
      }
      
      private function setupLighting(object:Object3D, lights:Vector.<Light3D>, lightsLength:int) : ShaderProgram
      {
         var procedure:Procedure = null;
         var light:Light3D = null;
         var vertexLinker:Linker = new Linker(Context3DProgramType.VERTEX);
         var fragmentLinker:Linker = new Linker(Context3DProgramType.FRAGMENT);
         var positionVar:String = "aPosition";
         vertexLinker.declareVariable(positionVar,VariableType.ATTRIBUTE);
         if(object.alternativa3d::transformProcedure != null)
         {
            positionVar = alternativa3d::appendPositionTransformProcedure(object.alternativa3d::transformProcedure,vertexLinker);
         }
         vertexLinker.addProcedure(alternativa3d::_projectProcedure);
         vertexLinker.setInputParams(alternativa3d::_projectProcedure,positionVar);
         vertexLinker.addProcedure(passUVProcedure);
         vertexLinker.addProcedure(passVaryingsProcedure);
         vertexLinker.setInputParams(passVaryingsProcedure,positionVar);
         vertexLinker.declareVariable("aTangent",VariableType.ATTRIBUTE);
         vertexLinker.declareVariable("aNormal",VariableType.ATTRIBUTE);
         vertexLinker.addProcedure(passTBNRightProcedure);
         vertexLinker.setInputParams(passTBNRightProcedure,"aTangent","aNormal");
         fragmentLinker.declareVariable("tNormal");
         fragmentLinker.declareVariable("tView");
         fragmentLinker.addProcedure(getNormalAndViewProcedure);
         fragmentLinker.setOutputParams(getNormalAndViewProcedure,"tNormal","tView");
         fragmentLinker.addProcedure(getSpecularOptionsConstProcedure);
         fragmentLinker.setInputParams(getSpecularOptionsConstProcedure,"tNormal","tView");
         fragmentLinker.declareVariable("tLight");
         fragmentLinker.declareVariable("tHLight");
         var first:Boolean = true;
         for(var i:int = 0; i < lightsLength; )
         {
            light = lights[i];
            if(light is DirectionalLight)
            {
               procedure = directionalProcedure(light,!first);
               fragmentLinker.addProcedure(procedure);
               fragmentLinker.setInputParams(procedure,"tNormal","tView");
               fragmentLinker.setOutputParams(procedure,"tLight","tHLight");
               if(first)
               {
                  first = false;
               }
            }
            else if(light is OmniLight)
            {
               procedure = omniProcedure(light,!first);
               fragmentLinker.addProcedure(procedure);
               fragmentLinker.setInputParams(procedure,"tNormal","tView");
               fragmentLinker.setOutputParams(procedure,"tLight","tHLight");
               if(first)
               {
                  first = false;
               }
            }
            i++;
         }
         fragmentLinker.declareVariable("outColor");
         fragmentLinker.addProcedure(diffuseProcedure);
         fragmentLinker.setOutputParams(diffuseProcedure,"outColor");
         fragmentLinker.addProcedure(this.outputWithSpecularProcedure);
         fragmentLinker.setInputParams(this.outputWithSpecularProcedure,"outColor","tLight","tHLight");
         fragmentLinker.setOppositeLinker(vertexLinker);
         return new ShaderProgram(vertexLinker,fragmentLinker);
      }
      
      private function getLightingDrawUnit(program:ShaderProgram, lights:Vector.<Light3D>, lightsLength:int, camera:Camera3D, object:Object3D, surface:Surface, geometry:Geometry) : DrawUnit
      {
         var rScale:Number = NaN;
         var transform:Transform3D = null;
         var light:Light3D = null;
         var len:Number = NaN;
         var omni:OmniLight = null;
         var positionBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(VertexAttributes.POSITION);
         var uvBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(VertexAttributes.TEXCOORDS[0]);
         var tangentBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(VertexAttributes.TANGENT4);
         var normalBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(VertexAttributes.NORMAL);
         var drawUnit:DrawUnit = camera.alternativa3d::renderer.alternativa3d::createDrawUnit(object,program.program,geometry.alternativa3d::_-EM,surface.indexBegin,surface.numTriangles,program);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aPosition"),positionBuffer,geometry.alternativa3d::_attributesOffsets[VertexAttributes.POSITION],VertexAttributes.alternativa3d::FORMATS[VertexAttributes.POSITION]);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aUV"),uvBuffer,geometry.alternativa3d::_attributesOffsets[VertexAttributes.TEXCOORDS[0]],VertexAttributes.alternativa3d::FORMATS[VertexAttributes.TEXCOORDS[0]]);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aTangent"),tangentBuffer,geometry.alternativa3d::_attributesOffsets[VertexAttributes.TANGENT4],VertexAttributes.alternativa3d::FORMATS[VertexAttributes.TANGENT4]);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aNormal"),normalBuffer,geometry.alternativa3d::_attributesOffsets[VertexAttributes.NORMAL],VertexAttributes.alternativa3d::FORMATS[VertexAttributes.NORMAL]);
         object.alternativa3d::setTransformConstants(drawUnit,surface,program.vertexShader,camera);
         drawUnit.alternativa3d::setProjectionConstants(camera,program.vertexShader.getVariableIndex("cProjMatrix"),object.alternativa3d::localToCameraTransform);
         drawUnit.alternativa3d::setVertexConstantsFromNumbers(program.vertexShader.getVariableIndex("cCamera"),object.alternativa3d::cameraToLocalTransform.d,object.alternativa3d::cameraToLocalTransform.h,object.alternativa3d::cameraToLocalTransform.l,1);
         drawUnit.alternativa3d::setVertexConstantsFromNumbers(program.vertexShader.getVariableIndex("cUVOffsets"),-this.uOffset,this.vOffset,0,0);
         for(var i:int = 0; i < lightsLength; )
         {
            light = lights[i];
            if(light is DirectionalLight)
            {
               transform = light.alternativa3d::_-cl;
               len = Number(Math.sqrt(transform.c * transform.c + transform.g * transform.g + transform.k * transform.k));
               drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::_-oG + "Direction"),-transform.c / len,-transform.g / len,-transform.k / len,1);
               drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::_-oG + "Color"),light.alternativa3d::red,light.alternativa3d::green,light.alternativa3d::blue);
            }
            else if(light is OmniLight)
            {
               omni = OmniLight(light);
               transform = light.alternativa3d::_-cl;
               rScale = Number(Math.sqrt(transform.a * transform.a + transform.e * transform.e + transform.i * transform.i));
               rScale += Math.sqrt(transform.b * transform.b + transform.f * transform.f + transform.j * transform.j);
               rScale += Math.sqrt(transform.c * transform.c + transform.g * transform.g + transform.k * transform.k);
               rScale /= 3;
               drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::_-oG + "Position"),transform.d,transform.h,transform.l);
               drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::_-oG + "Radius"),1,omni.attenuationEnd * rScale - omni.attenuationBegin * rScale,omni.attenuationBegin * rScale);
               drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.fragmentShader.getVariableIndex("c" + light.alternativa3d::_-oG + "Color"),light.alternativa3d::red,light.alternativa3d::green,light.alternativa3d::blue);
            }
            i++;
         }
         drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.fragmentShader.getVariableIndex("cSurface"),0,this.glossiness,this.§_-kj§,1);
         drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sDiffuse"),diffuseMap.alternativa3d::_texture);
         drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sBump"),this.normalMap.alternativa3d::_texture);
         return drawUnit;
      }
      
      private function setupFog(object:Object3D) : ShaderProgram
      {
         var vertexLinker:Linker = new Linker(Context3DProgramType.VERTEX);
         var fragmentLinker:Linker = new Linker(Context3DProgramType.FRAGMENT);
         var positionVar:String = "aPosition";
         vertexLinker.declareVariable(positionVar,VariableType.ATTRIBUTE);
         if(object.alternativa3d::transformProcedure != null)
         {
            positionVar = alternativa3d::appendPositionTransformProcedure(object.alternativa3d::transformProcedure,vertexLinker);
         }
         vertexLinker.addProcedure(alternativa3d::_projectProcedure);
         vertexLinker.setInputParams(alternativa3d::_projectProcedure,positionVar);
         if(fogMode == SIMPLE)
         {
            vertexLinker.addProcedure(passSimpleFogConstProcedure);
            vertexLinker.setInputParams(passSimpleFogConstProcedure,positionVar);
            fragmentLinker.addProcedure(outputWithSimpleFogProcedure);
         }
         else
         {
            vertexLinker.declareVariable("projected");
            vertexLinker.setOutputParams(alternativa3d::_projectProcedure,"projected");
            vertexLinker.addProcedure(postPassAdvancedFogConstProcedure);
            vertexLinker.setInputParams(postPassAdvancedFogConstProcedure,positionVar,"projected");
            fragmentLinker.addProcedure(outputWithAdvancedFogProcedure);
         }
         fragmentLinker.setOppositeLinker(vertexLinker);
         return new ShaderProgram(vertexLinker,fragmentLinker);
      }
      
      private function getFogDrawUnit(program:ShaderProgram, camera:Camera3D, object:Object3D, surface:Surface, geometry:Geometry) : DrawUnit
      {
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
         var i:int = 0;
         var positionBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(VertexAttributes.POSITION);
         var drawUnit:DrawUnit = camera.alternativa3d::renderer.alternativa3d::createDrawUnit(object,program.program,geometry.alternativa3d::_-EM,surface.indexBegin,surface.numTriangles,program);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aPosition"),positionBuffer,geometry.alternativa3d::_attributesOffsets[VertexAttributes.POSITION],VertexAttributes.alternativa3d::FORMATS[VertexAttributes.POSITION]);
         object.alternativa3d::setTransformConstants(drawUnit,surface,program.vertexShader,camera);
         drawUnit.alternativa3d::setProjectionConstants(camera,program.vertexShader.getVariableIndex("cProjMatrix"),object.alternativa3d::localToCameraTransform);
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
         return drawUnit;
      }
      
      override public function clone() : Material
      {
         var cloned:TracksMaterial2 = new TracksMaterial2(diffuseMap,this.normalMap);
         cloned.§_-kj§ = this.§_-kj§;
         cloned.glossiness = this.glossiness;
         return cloned;
      }
   }
}

