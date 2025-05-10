package alternativa.tanks.game.entities.map
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.Camera3D;
   import alternativa.engine3d.core.DrawUnit;
   import alternativa.engine3d.core.Light3D;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.RenderPriority;
   import alternativa.engine3d.core.Transform3D;
   import alternativa.engine3d.core.VertexAttributes;
   import alternativa.engine3d.materials.A3DUtils;
   import alternativa.engine3d.materials.Material;
   import alternativa.engine3d.materials.compiler.Linker;
   import alternativa.engine3d.materials.compiler.Procedure;
   import alternativa.engine3d.materials.compiler.VariableType;
   import alternativa.engine3d.objects.Surface;
   import alternativa.engine3d.resources.BitmapTextureResource;
   import alternativa.engine3d.resources.Geometry;
   import alternativa.engine3d.resources.TextureResource;
   import alternativa.engine3d.shadows.ShadowRenderer;
   import avmplus.getQualifiedClassName;
   import flash.display.BitmapData;
   import flash.display3D.Context3DBlendFactor;
   import flash.display3D.Context3DProgramType;
   import flash.display3D.VertexBuffer3D;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   
   use namespace alternativa3d;
   
   public class MapMaterial extends Material
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
      
      private static var _programs:Dictionary = new Dictionary();
      
      private static const getLightMapProcedure:Procedure = Procedure.compileFromArray(["#v0=vUV1","#s0=sLightMap","tex o0, v0, s0 <2d,repeat,linear,mipnone>"],"getLightMap");
      
      private static const minShadowProcedure:Procedure = Procedure.compileFromArray(["min o0, o0, i0"],"minShadowProc");
      
      private static const mulShadowProcedure:Procedure = Procedure.compileFromArray(["mul o0, o0, i0"],"mulShadowProc");
      
      private static const applyLightMapProcedure:Procedure = Procedure.compileFromArray(["add i1, i1, i1","mul i0.xyz, i0.xyz, i1.xyz","mov o0, i0"],"applyLightMap");
      
      private static const _passLightMapUVProcedure:Procedure = new Procedure(["#a0=aUV1","#v0=vUV1","mov v0, a0"],"passLightMapUV");
      
      private static const passSimpleFogConstProcedure:Procedure = new Procedure(["#v0=vZDistance","#c0=cFogSpace","dp4 t0.z, i0, c0","mov v0, t0.zzzz","sub v0.y, i0.w, t0.z"],"passSimpleFogConst");
      
      private static const applyLightMapAndSimpleFogProcedure:Procedure = new Procedure(["#v0=vZDistance","#c0=cFogColor","#c1=cFogRange","add i1, i1, i1","mul i0.xyz, i0.xyz, i1.xyz","min t0.xy, v0.xy, c1.xy","max t0.xy, t0.xy, c1.zw","mul i0.xyz, i0.xyz, t0.y","mul t0.xyz, c0.xyz, t0.x","add i0.xyz, i0.xyz, t0.xyz","mov o0, i0"],"applyLightMapAndSimpleFog");
      
      private static const passAdvancedFogConstProcedure:Procedure = new Procedure(["#v0=vZDistance","#c0=cFogSpace","dp4 t0.z, i0, c0","mov v0, t0.zzzz","sub v0.y, i0.w, t0.z","mov v0.zw, i1.xwxw","mov o0, i1"],"projAndPassAdvancedFogConst");
      
      private static const applyLightMapAndAdvancedFogProcedure:Procedure = new Procedure(["#v0=vZDistance","#c0=cFogConsts","#c1=cFogRange","#s0=sFogTexture","add i1, i1, i1","mul i0.xyz, i0.xyz, i1.xyz","min t0.xy, v0.xy, c1.xy","max t0.xy, t0.xy, c1.zw","mul i0.xyz, i0.xyz, t0.y","mov t1.xyzw, c0.yyzw","div t0.z, v0.z, v0.w","mul t0.z, t0.z, c0.x","add t1.x, t1.x, t0.z","tex t1, t1, s0 <2d, repeat, linear, miplinear>","mul t0.xyz, t1.xyz, t0.x","add i0.xyz, i0.xyz, t0.xyz","mov o0, i0"],"applyLightMapAndAdvancedFog");
      
      alternativa3d static const outputOpacity:Procedure = new Procedure(["#v0=vUV","#s0=sTexture","#s1=sOpacity","#c0=cAlpha","tex t0, v0, s0 <2d, linear,repeat, miplinear>","tex t1, v0, s1 <2d, linear,repeat, miplinear>","mov t0.w, t1.x","sub t1.x, t1.x, c0.w","kil t1.x","mov o0, t0"],"samplerSetProcedureOpacity");
      
      private static const passUVProcedure:Procedure = new Procedure(["#v0=vUV","#a0=aUV","mov v0, a0"],"passUVProcedure");
      
      private static const diffuseProcedure:Procedure = new Procedure(["#v0=vUV","#s0=sTexture","#c0=cAlpha","tex t0, v0, s0 <2d, linear,repeat, miplinear>","mov t0.w, c0.w","mov o0, t0"],"diffuseProcedure");
      
      private static const diffuseOpacityProcedure:Procedure = new Procedure(["#v0=vUV","#s0=sTexture","#s1=sOpacity","#c0=cAlpha","tex t0, v0, s0 <2d, linear,repeat, miplinear>","tex t1, v0, s1 <2d, linear,repeat, miplinear>","mov t0.w, t1.x","mul t0.w, t0.w, c0.w","mov o0, t0"],"diffuseOpacityProcedure");
      
      public var diffuseMap:TextureResource;
      
      public var lightMap:TextureResource;
      
      public var lightMapChannel:uint = 0;
      
      public var opacityMap:TextureResource;
      
      public var alpha:Number = 1;
      
      public function MapMaterial(diffuseMap:TextureResource, lightMap:TextureResource, lightMapChannel:uint = 0, opacityMap:TextureResource = null)
      {
         super();
         this.diffuseMap = diffuseMap;
         this.lightMap = lightMap;
         this.lightMapChannel = lightMapChannel;
         this.opacityMap = opacityMap;
      }
      
      public static function setFogTexture(texture:TextureResource) : void
      {
         fogTexture = texture;
      }
      
      override alternativa3d function fillResources(resources:Dictionary, resourceType:Class) : void
      {
         super.alternativa3d::fillResources(resources,resourceType);
         if(this.diffuseMap != null && Boolean(A3DUtils.alternativa3d::checkParent(getDefinitionByName(getQualifiedClassName(this.diffuseMap)) as Class,resourceType)))
         {
            resources[this.diffuseMap] = true;
         }
         if(this.lightMap != null && Boolean(A3DUtils.alternativa3d::checkParent(getDefinitionByName(getQualifiedClassName(this.lightMap)) as Class,resourceType)))
         {
            resources[this.lightMap] = true;
         }
         if(this.opacityMap != null && Boolean(A3DUtils.alternativa3d::checkParent(getDefinitionByName(getQualifiedClassName(this.opacityMap)) as Class,resourceType)))
         {
            resources[this.opacityMap] = true;
         }
      }
      
      private function final(targetObject:Object3D, shadows:Vector.<ShadowRenderer>, numShadows:int) : MapMaterialProgram
      {
         var i:int = 0;
         var renderer:ShadowRenderer = null;
         var sProc:Procedure = null;
         var vertexLinker:Linker = new Linker(Context3DProgramType.VERTEX);
         var positionVar:String = "aPosition";
         vertexLinker.declareVariable(positionVar,VariableType.ATTRIBUTE);
         if(targetObject.alternativa3d::transformProcedure != null)
         {
            positionVar = alternativa3d::appendPositionTransformProcedure(targetObject.alternativa3d::transformProcedure,vertexLinker);
         }
         vertexLinker.addProcedure(alternativa3d::_projectProcedure);
         vertexLinker.setInputParams(alternativa3d::_projectProcedure,positionVar);
         vertexLinker.addProcedure(passUVProcedure);
         vertexLinker.addProcedure(_passLightMapUVProcedure);
         if(fogMode == SIMPLE)
         {
            vertexLinker.addProcedure(passSimpleFogConstProcedure);
            vertexLinker.setInputParams(passSimpleFogConstProcedure,positionVar);
         }
         else if(fogMode == ADVANCED)
         {
            vertexLinker.declareVariable("tProjected");
            vertexLinker.setOutputParams(alternativa3d::_projectProcedure,"tProjected");
            vertexLinker.addProcedure(passAdvancedFogConstProcedure);
            vertexLinker.setInputParams(passAdvancedFogConstProcedure,positionVar,"tProjected");
         }
         var fragmentLinker:Linker = new Linker(Context3DProgramType.FRAGMENT);
         var procedure:Procedure = this.opacityMap == null ? diffuseProcedure : diffuseOpacityProcedure;
         fragmentLinker.declareVariable("tOutColor");
         fragmentLinker.addProcedure(procedure);
         fragmentLinker.setOutputParams(procedure,"tOutColor");
         if(shadows != null)
         {
            fragmentLinker.declareVariable("tLight");
            fragmentLinker.addProcedure(getLightMapProcedure);
            fragmentLinker.setOutputParams(getLightMapProcedure,"tLight");
            fragmentLinker.declareVariable("tShadow");
            for(i = 0; i < numShadows; i++)
            {
               renderer = shadows[i];
               vertexLinker.addProcedure(renderer.getVShader(i));
               sProc = renderer.getFShader(i);
               fragmentLinker.addProcedure(sProc);
               fragmentLinker.setOutputParams(sProc,"tShadow");
               if(renderer.alternativa3d::needMultiplyBlend)
               {
                  fragmentLinker.addProcedure(mulShadowProcedure);
                  fragmentLinker.setInputParams(mulShadowProcedure,"tShadow");
                  fragmentLinker.setOutputParams(mulShadowProcedure,"tLight");
               }
               else
               {
                  fragmentLinker.addProcedure(minShadowProcedure);
                  fragmentLinker.setInputParams(minShadowProcedure,"tShadow");
                  fragmentLinker.setOutputParams(minShadowProcedure,"tLight");
               }
            }
         }
         else
         {
            fragmentLinker.declareVariable("tLight");
            fragmentLinker.addProcedure(getLightMapProcedure);
            fragmentLinker.setOutputParams(getLightMapProcedure,"tLight");
         }
         if(fogMode == SIMPLE)
         {
            fragmentLinker.addProcedure(applyLightMapAndSimpleFogProcedure);
            fragmentLinker.setInputParams(applyLightMapAndSimpleFogProcedure,"tOutColor","tLight");
         }
         else if(fogMode == ADVANCED)
         {
            fragmentLinker.addProcedure(applyLightMapAndAdvancedFogProcedure);
            fragmentLinker.setInputParams(applyLightMapAndAdvancedFogProcedure,"tOutColor","tLight");
         }
         else
         {
            fragmentLinker.addProcedure(applyLightMapProcedure);
            fragmentLinker.setInputParams(applyLightMapProcedure,"tOutColor","tLight");
         }
         fragmentLinker.setOppositeLinker(vertexLinker);
         return new MapMaterialProgram(vertexLinker,fragmentLinker);
      }
      
      override alternativa3d function collectDraws(camera:Camera3D, surface:Surface, geometry:Geometry, lights:Vector.<Light3D>, lightsLength:int, objectRenderPriority:int = -1) : void
      {
         var i:int = 0;
         var renderer:ShadowRenderer = null;
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
         var len:Number = NaN;
         var uScale:Number = NaN;
         var uRight:Number = NaN;
         var bmd:BitmapData = null;
         if(this.diffuseMap == null || this.diffuseMap.alternativa3d::_texture == null || this.lightMap == null || this.lightMap.alternativa3d::_texture == null)
         {
            return;
         }
         if(this.opacityMap != null && this.opacityMap.alternativa3d::_texture == null)
         {
            return;
         }
         var positionBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(VertexAttributes.POSITION);
         var uvBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(VertexAttributes.TEXCOORDS[0]);
         var lightMapUVBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(VertexAttributes.TEXCOORDS[this.lightMapChannel]);
         if(positionBuffer == null || uvBuffer == null || lightMapUVBuffer == null)
         {
            return;
         }
         var object:Object3D = surface.alternativa3d::object;
         var optionsPrograms:Vector.<MapMaterialProgram> = _programs[object.alternativa3d::transformProcedure];
         if(optionsPrograms == null)
         {
            optionsPrograms = new Vector.<MapMaterialProgram>(32,true);
            _programs[object.alternativa3d::transformProcedure] = optionsPrograms;
         }
         var index:int = this.opacityMap == null ? 0 : 1;
         if(fogMode > 0)
         {
            index |= 1 << fogMode;
         }
         var numShadows:int = object.alternativa3d::numShadowRenderers;
         index |= numShadows << 3;
         var program:MapMaterialProgram = optionsPrograms[index];
         if(program == null)
         {
            program = this.final(object,object.alternativa3d::shadowRenderers,numShadows);
            program.upload(camera.alternativa3d::context3D);
            optionsPrograms[index] = program;
         }
         var drawUnit:DrawUnit = camera.alternativa3d::renderer.alternativa3d::createDrawUnit(object,program.program,geometry.name_EM,surface.indexBegin,surface.numTriangles,program);
         drawUnit.alternativa3d::setVertexBufferAt(program.aPosition,positionBuffer,geometry.alternativa3d::_attributesOffsets[VertexAttributes.POSITION],VertexAttributes.alternativa3d::FORMATS[VertexAttributes.POSITION]);
         drawUnit.alternativa3d::setVertexBufferAt(program.aUV,uvBuffer,geometry.alternativa3d::_attributesOffsets[VertexAttributes.TEXCOORDS[0]],VertexAttributes.alternativa3d::FORMATS[VertexAttributes.TEXCOORDS[0]]);
         drawUnit.alternativa3d::setVertexBufferAt(program.aUV1,lightMapUVBuffer,geometry.alternativa3d::_attributesOffsets[VertexAttributes.TEXCOORDS[this.lightMapChannel]],VertexAttributes.alternativa3d::FORMATS[VertexAttributes.TEXCOORDS[this.lightMapChannel]]);
         object.alternativa3d::setTransformConstants(drawUnit,surface,program.vertexShader,camera);
         drawUnit.alternativa3d::setProjectionConstants(camera,program.cProjMatrix,object.alternativa3d::localToCameraTransform);
         drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.cAlpha,0,0,0,this.alpha);
         drawUnit.alternativa3d::setTextureAt(program.sTexture,this.diffuseMap.alternativa3d::_texture);
         drawUnit.alternativa3d::setTextureAt(program.sLightMap,this.lightMap.alternativa3d::_texture);
         if(this.opacityMap != null)
         {
            drawUnit.alternativa3d::setTextureAt(program.sOpacity,this.opacityMap.alternativa3d::_texture);
         }
         for(i = 0; i < numShadows; )
         {
            renderer = object.alternativa3d::shadowRenderers[i];
            renderer.applyShader(drawUnit,program,object,camera,i);
            i++;
         }
         if(fogMode == SIMPLE || fogMode == ADVANCED)
         {
            lm = object.alternativa3d::localToCameraTransform;
            dist = fogFar - fogNear;
            drawUnit.alternativa3d::setVertexConstantsFromNumbers(program.cFogSpace,lm.i / dist,lm.j / dist,lm.k / dist,(lm.l - fogNear) / dist);
            drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.cFogRange,fogMaxDensity,1,0,1 - fogMaxDensity);
         }
         if(fogMode == SIMPLE)
         {
            drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.cFogColor,fogColorR,fogColorG,fogColorB);
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
            len = Number(Math.sqrt(dx * dx + dy * dy));
            leftX /= len;
            leftY /= len;
            rightX /= len;
            rightY /= len;
            uScale = Math.acos(leftX * rightX + leftY * rightY) / Math.PI / 2;
            uRight = angle / Math.PI / 2;
            drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.cFogConsts,0.5 * uScale,0.5 - uRight,0);
            drawUnit.alternativa3d::setTextureAt(program.sFogTexture,fogTexture.alternativa3d::_texture);
         }
         if(this.opacityMap != null || this.alpha < 1)
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

import alternativa.engine3d.materials.ShaderProgram;
import alternativa.engine3d.materials.compiler.Linker;

class MapMaterialProgram extends ShaderProgram
{
   public var aPosition:int;
   
   public var aUV:int;
   
   public var aUV1:int;
   
   public var cProjMatrix:int;
   
   public var cAlpha:int;
   
   public var sTexture:int;
   
   public var sLightMap:int;
   
   public var sOpacity:int;
   
   public var cFogSpace:int;
   
   public var cFogRange:int;
   
   public var cFogColor:int;
   
   public var cFogConsts:int;
   
   public var sFogTexture:int;
   
   public function MapMaterialProgram(vertex:Linker, fragment:Linker)
   {
      super(vertex,fragment);
      this.aPosition = vertex.findVariable("aPosition");
      this.aUV = vertex.findVariable("aUV");
      this.aUV1 = vertex.findVariable("aUV1");
      this.cProjMatrix = vertex.findVariable("cProjMatrix");
      this.cAlpha = fragment.findVariable("cAlpha");
      this.sTexture = fragment.findVariable("sTexture");
      this.sLightMap = fragment.findVariable("sLightMap");
      this.sOpacity = fragment.findVariable("sOpacity");
      this.cFogSpace = vertex.findVariable("cFogSpace");
      this.cFogRange = fragment.findVariable("cFogRange");
      this.cFogColor = fragment.findVariable("cFogColor");
      this.cFogConsts = fragment.findVariable("cFogConsts");
      this.sFogTexture = fragment.findVariable("sFogTexture");
   }
}
