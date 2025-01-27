package alternativa.tanks.game.entities.map
{
   import alternativa.engine3d.alternativa3d;
   import avmplus.getQualifiedClassName;
   import flash.display.BitmapData;
   import flash.display3D.Context3DBlendFactor;
   import flash.display3D.Context3DProgramType;
   import flash.display3D.VertexBuffer3D;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import package_19.name_117;
   import package_21.name_116;
   import package_21.name_124;
   import package_21.name_126;
   import package_21.name_128;
   import package_21.name_135;
   import package_21.name_139;
   import package_21.name_78;
   import package_23.name_103;
   import package_28.name_119;
   import package_28.name_129;
   import package_28.name_93;
   import package_30.name_114;
   import package_30.name_115;
   import package_30.name_121;
   import package_4.class_4;
   import package_4.name_28;
   
   use namespace alternativa3d;
   
   public class MapMaterial extends class_4
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
      
      private static var _programs:Dictionary = new Dictionary();
      
      private static const getLightMapProcedure:name_114 = name_114.name_140(["#v0=vUV1","#s0=sLightMap","tex o0, v0, s0 <2d,repeat,linear,mipnone>"],"getLightMap");
      
      private static const minShadowProcedure:name_114 = name_114.name_140(["min o0, o0, i0"],"minShadowProc");
      
      private static const mulShadowProcedure:name_114 = name_114.name_140(["mul o0, o0, i0"],"mulShadowProc");
      
      private static const applyLightMapProcedure:name_114 = name_114.name_140(["add i1, i1, i1","mul i0.xyz, i0.xyz, i1.xyz","mov o0, i0"],"applyLightMap");
      
      private static const _passLightMapUVProcedure:name_114 = new name_114(["#a0=aUV1","#v0=vUV1","mov v0, a0"],"passLightMapUV");
      
      private static const passSimpleFogConstProcedure:name_114 = new name_114(["#v0=vZDistance","#c0=cFogSpace","dp4 t0.z, i0, c0","mov v0, t0.zzzz","sub v0.y, i0.w, t0.z"],"passSimpleFogConst");
      
      private static const applyLightMapAndSimpleFogProcedure:name_114 = new name_114(["#v0=vZDistance","#c0=cFogColor","#c1=cFogRange","add i1, i1, i1","mul i0.xyz, i0.xyz, i1.xyz","min t0.xy, v0.xy, c1.xy","max t0.xy, t0.xy, c1.zw","mul i0.xyz, i0.xyz, t0.y","mul t0.xyz, c0.xyz, t0.x","add i0.xyz, i0.xyz, t0.xyz","mov o0, i0"],"applyLightMapAndSimpleFog");
      
      private static const passAdvancedFogConstProcedure:name_114 = new name_114(["#v0=vZDistance","#c0=cFogSpace","dp4 t0.z, i0, c0","mov v0, t0.zzzz","sub v0.y, i0.w, t0.z","mov v0.zw, i1.xwxw","mov o0, i1"],"projAndPassAdvancedFogConst");
      
      private static const applyLightMapAndAdvancedFogProcedure:name_114 = new name_114(["#v0=vZDistance","#c0=cFogConsts","#c1=cFogRange","#s0=sFogTexture","add i1, i1, i1","mul i0.xyz, i0.xyz, i1.xyz","min t0.xy, v0.xy, c1.xy","max t0.xy, t0.xy, c1.zw","mul i0.xyz, i0.xyz, t0.y","mov t1.xyzw, c0.yyzw","div t0.z, v0.z, v0.w","mul t0.z, t0.z, c0.x","add t1.x, t1.x, t0.z","tex t1, t1, s0 <2d, repeat, linear, miplinear>","mul t0.xyz, t1.xyz, t0.x","add i0.xyz, i0.xyz, t0.xyz","mov o0, i0"],"applyLightMapAndAdvancedFog");
      
      alternativa3d static const outputOpacity:name_114 = new name_114(["#v0=vUV","#s0=sTexture","#s1=sOpacity","#c0=cAlpha","tex t0, v0, s0 <2d, linear,repeat, miplinear>","tex t1, v0, s1 <2d, linear,repeat, miplinear>","mov t0.w, t1.x","sub t1.x, t1.x, c0.w","kil t1.x","mov o0, t0"],"samplerSetProcedureOpacity");
      
      private static const passUVProcedure:name_114 = new name_114(["#v0=vUV","#a0=aUV","mov v0, a0"],"passUVProcedure");
      
      private static const diffuseProcedure:name_114 = new name_114(["#v0=vUV","#s0=sTexture","#c0=cAlpha","tex t0, v0, s0 <2d, linear,repeat, miplinear>","mov t0.w, c0.w","mov o0, t0"],"diffuseProcedure");
      
      private static const diffuseOpacityProcedure:name_114 = new name_114(["#v0=vUV","#s0=sTexture","#s1=sOpacity","#c0=cAlpha","tex t0, v0, s0 <2d, linear,repeat, miplinear>","tex t1, v0, s1 <2d, linear,repeat, miplinear>","mov t0.w, t1.x","mul t0.w, t0.w, c0.w","mov o0, t0"],"diffuseOpacityProcedure");
      
      public var diffuseMap:name_129;
      
      public var lightMap:name_129;
      
      public var lightMapChannel:uint = 0;
      
      public var opacityMap:name_129;
      
      public var alpha:Number = 1;
      
      public function MapMaterial(diffuseMap:name_129, lightMap:name_129, lightMapChannel:uint = 0, opacityMap:name_129 = null)
      {
         super();
         this.diffuseMap = diffuseMap;
         this.lightMap = lightMap;
         this.lightMapChannel = lightMapChannel;
         this.opacityMap = opacityMap;
      }
      
      public static function method_33(texture:name_129) : void
      {
         fogTexture = texture;
      }
      
      override alternativa3d function fillResources(resources:Dictionary, resourceType:Class) : void
      {
         super.alternativa3d::fillResources(resources,resourceType);
         if(this.diffuseMap != null && Boolean(name_28.alternativa3d::name_131(getDefinitionByName(getQualifiedClassName(this.diffuseMap)) as Class,resourceType)))
         {
            resources[this.diffuseMap] = true;
         }
         if(this.lightMap != null && Boolean(name_28.alternativa3d::name_131(getDefinitionByName(getQualifiedClassName(this.lightMap)) as Class,resourceType)))
         {
            resources[this.lightMap] = true;
         }
         if(this.opacityMap != null && Boolean(name_28.alternativa3d::name_131(getDefinitionByName(getQualifiedClassName(this.opacityMap)) as Class,resourceType)))
         {
            resources[this.opacityMap] = true;
         }
      }
      
      private function setupProgram(targetObject:name_78, shadows:Vector.<name_103>, numShadows:int) : MapMaterialProgram
      {
         var i:int = 0;
         var renderer:name_103 = null;
         var sProc:name_114 = null;
         var vertexLinker:name_121 = new name_121(Context3DProgramType.VERTEX);
         var positionVar:String = "aPosition";
         vertexLinker.name_120(positionVar,name_115.ATTRIBUTE);
         if(targetObject.alternativa3d::transformProcedure != null)
         {
            positionVar = alternativa3d::method_74(targetObject.alternativa3d::transformProcedure,vertexLinker);
         }
         vertexLinker.name_123(alternativa3d::_projectProcedure);
         vertexLinker.name_118(alternativa3d::_projectProcedure,positionVar);
         vertexLinker.name_123(passUVProcedure);
         vertexLinker.name_123(_passLightMapUVProcedure);
         if(fogMode == SIMPLE)
         {
            vertexLinker.name_123(passSimpleFogConstProcedure);
            vertexLinker.name_118(passSimpleFogConstProcedure,positionVar);
         }
         else if(fogMode == ADVANCED)
         {
            vertexLinker.name_120("tProjected");
            vertexLinker.name_125(alternativa3d::_projectProcedure,"tProjected");
            vertexLinker.name_123(passAdvancedFogConstProcedure);
            vertexLinker.name_118(passAdvancedFogConstProcedure,positionVar,"tProjected");
         }
         var fragmentLinker:name_121 = new name_121(Context3DProgramType.FRAGMENT);
         var procedure:name_114 = this.opacityMap == null ? diffuseProcedure : diffuseOpacityProcedure;
         fragmentLinker.name_120("tOutColor");
         fragmentLinker.name_123(procedure);
         fragmentLinker.name_125(procedure,"tOutColor");
         if(shadows != null)
         {
            fragmentLinker.name_120("tLight");
            fragmentLinker.name_123(getLightMapProcedure);
            fragmentLinker.name_125(getLightMapProcedure,"tLight");
            fragmentLinker.name_120("tShadow");
            for(i = 0; i < numShadows; i++)
            {
               renderer = shadows[i];
               vertexLinker.name_123(renderer.getVShader(i));
               sProc = renderer.getFShader(i);
               fragmentLinker.name_123(sProc);
               fragmentLinker.name_125(sProc,"tShadow");
               if(renderer.alternativa3d::name_372)
               {
                  fragmentLinker.name_123(mulShadowProcedure);
                  fragmentLinker.name_118(mulShadowProcedure,"tShadow");
                  fragmentLinker.name_125(mulShadowProcedure,"tLight");
               }
               else
               {
                  fragmentLinker.name_123(minShadowProcedure);
                  fragmentLinker.name_118(minShadowProcedure,"tShadow");
                  fragmentLinker.name_125(minShadowProcedure,"tLight");
               }
            }
         }
         else
         {
            fragmentLinker.name_120("tLight");
            fragmentLinker.name_123(getLightMapProcedure);
            fragmentLinker.name_125(getLightMapProcedure,"tLight");
         }
         if(fogMode == SIMPLE)
         {
            fragmentLinker.name_123(applyLightMapAndSimpleFogProcedure);
            fragmentLinker.name_118(applyLightMapAndSimpleFogProcedure,"tOutColor","tLight");
         }
         else if(fogMode == ADVANCED)
         {
            fragmentLinker.name_123(applyLightMapAndAdvancedFogProcedure);
            fragmentLinker.name_118(applyLightMapAndAdvancedFogProcedure,"tOutColor","tLight");
         }
         else
         {
            fragmentLinker.name_123(applyLightMapProcedure);
            fragmentLinker.name_118(applyLightMapProcedure,"tOutColor","tLight");
         }
         fragmentLinker.name_133(vertexLinker);
         return new MapMaterialProgram(vertexLinker,fragmentLinker);
      }
      
      override alternativa3d function collectDraws(camera:name_124, surface:name_117, geometry:name_119, lights:Vector.<name_116>, lightsLength:int, objectRenderPriority:int = -1) : void
      {
         var i:int = 0;
         var renderer:name_103 = null;
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
         var positionBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(name_126.POSITION);
         var uvBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(name_126.TEXCOORDS[0]);
         var lightMapUVBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(name_126.TEXCOORDS[this.lightMapChannel]);
         if(positionBuffer == null || uvBuffer == null || lightMapUVBuffer == null)
         {
            return;
         }
         var object:name_78 = surface.alternativa3d::object;
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
         var numShadows:int = int(object.alternativa3d::numShadowRenderers);
         index |= numShadows << 3;
         var program:MapMaterialProgram = optionsPrograms[index];
         if(program == null)
         {
            program = this.setupProgram(object,object.alternativa3d::shadowRenderers,numShadows);
            program.upload(camera.alternativa3d::context3D);
            optionsPrograms[index] = program;
         }
         var drawUnit:name_135 = camera.alternativa3d::renderer.alternativa3d::name_137(object,program.program,geometry.alternativa3d::name_132,surface.indexBegin,surface.numTriangles,program);
         drawUnit.alternativa3d::setVertexBufferAt(program.aPosition,positionBuffer,geometry.alternativa3d::_attributesOffsets[name_126.POSITION],name_126.alternativa3d::FORMATS[name_126.POSITION]);
         drawUnit.alternativa3d::setVertexBufferAt(program.aUV,uvBuffer,geometry.alternativa3d::_attributesOffsets[name_126.TEXCOORDS[0]],name_126.alternativa3d::FORMATS[name_126.TEXCOORDS[0]]);
         drawUnit.alternativa3d::setVertexBufferAt(program.aUV1,lightMapUVBuffer,geometry.alternativa3d::_attributesOffsets[name_126.TEXCOORDS[this.lightMapChannel]],name_126.alternativa3d::FORMATS[name_126.TEXCOORDS[this.lightMapChannel]]);
         object.alternativa3d::setTransformConstants(drawUnit,surface,program.vertexShader,camera);
         drawUnit.alternativa3d::name_136(camera,program.cProjMatrix,object.alternativa3d::localToCameraTransform);
         drawUnit.alternativa3d::name_134(program.cAlpha,0,0,0,this.alpha);
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
            len = Number(Math.sqrt(dx * dx + dy * dy));
            leftX /= len;
            leftY /= len;
            rightX /= len;
            rightY /= len;
            uScale = Math.acos(leftX * rightX + leftY * rightY) / Math.PI / 2;
            uRight = angle / Math.PI / 2;
            drawUnit.alternativa3d::name_134(program.cFogConsts,0.5 * uScale,0.5 - uRight,0);
            drawUnit.alternativa3d::setTextureAt(program.sFogTexture,fogTexture.alternativa3d::_texture);
         }
         if(this.opacityMap != null || this.alpha < 1)
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

import package_30.name_121;
import package_4.name_127;

class MapMaterialProgram extends name_127
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
   
   public function MapMaterialProgram(vertex:name_121, fragment:name_121)
   {
      super(vertex,fragment);
      this.aPosition = vertex.name_207("aPosition");
      this.aUV = vertex.name_207("aUV");
      this.aUV1 = vertex.name_207("aUV1");
      this.cProjMatrix = vertex.name_207("cProjMatrix");
      this.cAlpha = fragment.name_207("cAlpha");
      this.sTexture = fragment.name_207("sTexture");
      this.sLightMap = fragment.name_207("sLightMap");
      this.sOpacity = fragment.name_207("sOpacity");
      this.cFogSpace = vertex.name_207("cFogSpace");
      this.cFogRange = fragment.name_207("cFogRange");
      this.cFogColor = fragment.name_207("cFogColor");
      this.cFogConsts = fragment.name_207("cFogConsts");
      this.sFogTexture = fragment.name_207("sFogTexture");
   }
}
