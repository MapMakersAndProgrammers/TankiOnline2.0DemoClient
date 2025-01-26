package package_18
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
   import package_28.name_119;
   import package_28.name_129;
   import package_28.name_93;
   import package_30.name_114;
   import package_30.name_115;
   import package_30.name_121;
   import package_4.class_4;
   import package_4.name_127;
   import package_4.name_28;
   
   use namespace alternativa3d;
   
   public class name_79 extends class_4
   {
      private static var fogTexture:name_129;
      
      public static const DISABLED:int = 0;
      
      public static const SIMPLE:int = 1;
      
      public static const ADVANCED:int = 2;
      
      public static var fogMode:int = DISABLED;
      
      public static var fogOffset:Number = 0;
      
      public static var fogHeight:Number = 5000;
      
      public static var fogMaxDensity:Number = 1;
      
      public static var fogColorR:Number = 200 / 255;
      
      public static var fogColorG:Number = 162 / 255;
      
      public static var fogColorB:Number = 200 / 255;
      
      alternativa3d static const _samplerSetProcedure:name_114 = new name_114(["#v0=vUV","#s0=sTexture","#c0=cAlpha","tex t0, v0, s0 <2d, linear,clamp, miplinear>","mov t0.w, c0.w","mov o0, t0"]);
      
      alternativa3d static const _samplerSetProcedureOpacity:name_114 = new name_114(["#v0=vUV","#s0=sTexture","#s1=sOpacity","#c0=cAlpha","tex t0, v0, s0 <2d, linear,clamp, miplinear>","tex t1, v0, s1 <2d, linear,clamp, miplinear>","mov t0.w, t1.x","mul t0.w, t0.w, c0.w","mov o0, t0"]);
      
      alternativa3d static const _samplerSetProcedureDiffuseAlpha:name_114 = new name_114(["#v0=vUV","#s0=sTexture","#c0=cAlpha","tex t0, v0, s0 <2d, linear,clamp, miplinear>","mul t0.w, t0.w, c0.w","mov o0, t0"]);
      
      alternativa3d static const _passUVProcedure:name_114 = new name_114(["#v0=vUV","#a0=aUV","mov v0, a0"]);
      
      private static const passSimpleFogConstProcedure:name_114 = new name_114(["#v0=vZDistance","#c0=cFogSpace","dp4 t0.z, i0, c0","mov v0, t0.zzzz","sub v0.y, i0.w, t0.z"],"passSimpleFogConst");
      
      private static const outputWithSimpleFogProcedure:name_114 = new name_114(["#v0=vZDistance","#c0=cFogColor","#c1=cFogRange","min t0.xy, v0.xy, c1.xy","max t0.xy, t0.xy, c1.zw","mul i0.xyz, i0.xyz, t0.y","mul t0.xyz, c0.xyz, t0.x","add i0.xyz, i0.xyz, t0.xyz","mov o0, i0"],"outputWithSimpleFog");
      
      private static const postPassAdvancedFogConstProcedure:name_114 = new name_114(["#v0=vZDistance","#c0=cFogSpace","dp4 t0.z, i0, c0","mov v0, t0.zzzz","sub v0.y, i0.w, t0.z","mov v0.zw, i1.xwxw","mov o0, i1"],"postPassAdvancedFogConst");
      
      private static const outputWithAdvancedFogProcedure:name_114 = new name_114(["#v0=vZDistance","#c0=cFogConsts","#c1=cFogRange","#s0=sFogTexture","min t0.xy, v0.xy, c1.xy","max t0.xy, t0.xy, c1.zw","mul i0.xyz, i0.xyz, t0.y","mov t1.xyzw, c0.yyzw","div t0.z, v0.z, v0.w","mul t0.z, t0.z, c0.x","add t1.x, t1.x, t0.z","tex t1, t1, s0 <2d, repeat, linear, miplinear>","mul t0.xyz, t1.xyz, t0.x","add i0.xyz, i0.xyz, t0.xyz","mov o0, i0"],"outputWithAdvancedFog");
      
      private static var _programs:Dictionary = new Dictionary();
      
      public var diffuseMap:name_129;
      
      public var opacityMap:name_129;
      
      public var alpha:Number = 1;
      
      public var var_21:Boolean = false;
      
      public function name_79(diffuseMap:name_129 = null, opacityMap:name_129 = null, alpha:Number = 1)
      {
         super();
         this.diffuseMap = diffuseMap;
         this.opacityMap = opacityMap;
         this.alpha = alpha;
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
         if(this.opacityMap != null && Boolean(name_28.alternativa3d::name_131(getDefinitionByName(getQualifiedClassName(this.opacityMap)) as Class,resourceType)))
         {
            resources[this.opacityMap] = true;
         }
      }
      
      private function method_75(targetObject:name_78, key:int, fogMode:int) : name_127
      {
         var outputProcedure:name_114 = null;
         var vertexLinker:name_121 = new name_121(Context3DProgramType.VERTEX);
         var positionVar:String = "aPosition";
         vertexLinker.name_120(positionVar,name_115.ATTRIBUTE);
         if(targetObject.alternativa3d::transformProcedure != null)
         {
            positionVar = alternativa3d::method_74(targetObject.alternativa3d::transformProcedure,vertexLinker);
         }
         vertexLinker.name_123(alternativa3d::_projectProcedure);
         vertexLinker.name_118(alternativa3d::_projectProcedure,positionVar);
         vertexLinker.name_123(alternativa3d::_passUVProcedure);
         var fragmentLinker:name_121 = new name_121(Context3DProgramType.FRAGMENT);
         if(key == 0)
         {
            outputProcedure = alternativa3d::_samplerSetProcedure;
         }
         else if(key == 1)
         {
            outputProcedure = alternativa3d::_samplerSetProcedureOpacity;
         }
         else
         {
            outputProcedure = alternativa3d::_samplerSetProcedureDiffuseAlpha;
         }
         fragmentLinker.name_123(outputProcedure);
         if(fogMode == SIMPLE)
         {
            vertexLinker.name_123(passSimpleFogConstProcedure);
            vertexLinker.name_118(passSimpleFogConstProcedure,positionVar);
            fragmentLinker.name_120("outColor");
            fragmentLinker.name_125(outputProcedure,"outColor");
            fragmentLinker.name_123(outputWithSimpleFogProcedure);
            fragmentLinker.name_118(outputWithSimpleFogProcedure,"outColor");
         }
         else if(fogMode == ADVANCED)
         {
            vertexLinker.name_120("tProjected");
            vertexLinker.name_125(alternativa3d::_projectProcedure,"tProjected");
            vertexLinker.name_123(postPassAdvancedFogConstProcedure);
            vertexLinker.name_118(postPassAdvancedFogConstProcedure,positionVar,"tProjected");
            fragmentLinker.name_120("outColor");
            fragmentLinker.name_125(outputProcedure,"outColor");
            fragmentLinker.name_123(outputWithAdvancedFogProcedure);
            fragmentLinker.name_118(outputWithAdvancedFogProcedure,"outColor");
         }
         vertexLinker.name_142();
         fragmentLinker.name_133(vertexLinker);
         fragmentLinker.name_142();
         return new name_127(vertexLinker,fragmentLinker);
      }
      
      override alternativa3d function collectDraws(camera:name_124, surface:name_117, geometry:name_119, lights:Vector.<name_116>, lightsLength:int, objectRenderPriority:int = -1) : void
      {
         var program:name_127 = null;
         var key:int = 0;
         var gM:name_139 = null;
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
         var i:int = 0;
         if(this.diffuseMap == null || this.diffuseMap.alternativa3d::_texture == null)
         {
            return;
         }
         if(!this.var_21 && this.opacityMap != null && this.opacityMap.alternativa3d::_texture == null)
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
         var optionsPrograms:Array = _programs[object.alternativa3d::transformProcedure];
         if(optionsPrograms == null)
         {
            optionsPrograms = [];
            _programs[object.alternativa3d::transformProcedure] = optionsPrograms;
         }
         if(!this.var_21 && !this.opacityMap)
         {
            key = 0;
         }
         else if(!this.var_21 && Boolean(this.opacityMap))
         {
            key = 1;
         }
         else if(this.var_21)
         {
            key = 2;
         }
         key += 3 * fogMode;
         program = optionsPrograms[key];
         if(program == null)
         {
            program = this.method_75(object,key,fogMode);
            program.upload(camera.alternativa3d::context3D);
            optionsPrograms[key] = program;
         }
         var drawUnit:name_135 = camera.alternativa3d::renderer.alternativa3d::name_137(object,program.program,geometry.alternativa3d::name_132,surface.indexBegin,surface.numTriangles,program);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aPosition"),positionBuffer,geometry.alternativa3d::_attributesOffsets[name_126.POSITION],name_126.alternativa3d::FORMATS[name_126.POSITION]);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aUV"),uvBuffer,geometry.alternativa3d::_attributesOffsets[name_126.TEXCOORDS[0]],name_126.alternativa3d::FORMATS[name_126.TEXCOORDS[0]]);
         object.alternativa3d::setTransformConstants(drawUnit,surface,program.vertexShader,camera);
         drawUnit.alternativa3d::name_136(camera,program.vertexShader.getVariableIndex("cProjMatrix"),object.alternativa3d::localToCameraTransform);
         drawUnit.alternativa3d::name_134(program.fragmentShader.getVariableIndex("cAlpha"),0,0,0,this.alpha);
         drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sTexture"),this.diffuseMap.alternativa3d::_texture);
         if(Boolean(this.opacityMap) && !this.var_21)
         {
            drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sOpacity"),this.opacityMap.alternativa3d::_texture);
         }
         if(fogMode == SIMPLE || fogMode == ADVANCED)
         {
            gM = new name_139();
            gM.copy(object.alternativa3d::localToCameraTransform);
            gM.append(camera.alternativa3d::localToGlobalTransform);
            dist = fogHeight;
            drawUnit.alternativa3d::name_144(program.vertexShader.getVariableIndex("cFogSpace"),-gM.i / dist,-gM.j / dist,-gM.k / dist,(camera.alternativa3d::localToGlobalTransform.l + gM.l + fogOffset + fogHeight) / dist);
            drawUnit.alternativa3d::name_134(program.fragmentShader.getVariableIndex("cFogRange"),fogMaxDensity,1,0,1 - fogMaxDensity);
         }
         if(fogMode == SIMPLE)
         {
            drawUnit.alternativa3d::name_134(program.fragmentShader.getVariableIndex("cFogColor"),fogColorR,fogColorG,fogColorB);
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
            drawUnit.alternativa3d::name_134(program.fragmentShader.getVariableIndex("cFogConsts"),0.5 * uScale,0.5 - uRight,0);
            drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sFogTexture"),fogTexture.alternativa3d::_texture);
         }
         if(this.var_21 || this.opacityMap != null || this.alpha < 1)
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

