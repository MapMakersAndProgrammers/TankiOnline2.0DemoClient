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
   import package_28.name_119;
   import package_28.name_129;
   import package_28.name_93;
   import package_30.name_114;
   import package_30.name_115;
   import package_30.name_121;
   import package_4.class_4;
   import package_4.name_11;
   import package_4.name_127;
   import package_4.name_28;
   
   use namespace alternativa3d;
   
   public class name_29 extends class_4
   {
      public static var fogTexture:name_129;
      
      public static var fogMode:int = name_11.DISABLED;
      
      public static var fogNear:Number = 1000;
      
      public static var fogFar:Number = 5000;
      
      public static var fogMaxDensity:Number = 1;
      
      public static var fogColorR:Number = 200 / 255;
      
      public static var fogColorG:Number = 162 / 255;
      
      public static var fogColorB:Number = 200 / 255;
      
      private static const passSimpleFogConstProcedure:name_114 = new name_114(["#v0=vZDistance","#c0=cFogSpace","dp4 t0.z, i0, c0","mov v0, t0.zzzz","sub v0.y, i0.w, t0.z"],"passSimpleFogConst");
      
      private static const outputWithSimpleFogProcedure:name_114 = new name_114(["#v0=vZDistance","#c0=cFogColor","#c1=cFogRange","min t0.xy, v0.xy, c1.xy","max t0.xy, t0.xy, c1.zw","mul i0.xyz, i0.xyz, t0.y","mul t0.xyz, c0.xyz, t0.x","add i0.xyz, i0.xyz, t0.xyz","mov o0, i0"],"outputWithSimpleFog");
      
      private static const postPassAdvancedFogConstProcedure:name_114 = new name_114(["#v0=vZDistance","#c0=cFogSpace","dp4 t0.z, i0, c0","mov v0, t0.zzzz","sub v0.y, i0.w, t0.z","mov v0.zw, i1.xwxw","mov o0, i1"],"postPassAdvancedFogConst");
      
      private static const outputWithAdvancedFogProcedure:name_114 = new name_114(["#v0=vZDistance","#c0=cFogConsts","#c1=cFogRange","#s0=sFogTexture","min t0.xy, v0.xy, c1.xy","max t0.xy, t0.xy, c1.zw","mul i0.xyz, i0.xyz, t0.y","mov t1.xyzw, c0.yyzw","div t0.z, v0.z, v0.w","mul t0.z, t0.z, c0.x","add t1.x, t1.x, t0.z","tex t1, t1, s0 <2d, repeat, linear, miplinear>","mul t0.xyz, t1.xyz, t0.x","add i0.xyz, i0.xyz, t0.xyz","mov o0, i0"],"outputWithAdvancedFog");
      
      private static var _programs:Dictionary = new Dictionary();
      
      private static const passUVProcedure:name_114 = new name_114(["#a0=aUV","#v0=vUV","mov v0, a0"],"passUVProcedure");
      
      private static const outputProcedure:name_114 = new name_114(["#v0=vUV","#s0=sTexture","#c0=cColor","tex t0, v0, s0 <2d, linear, mipnone>","mov t0.w, t0.x","mov t0.xyz, c0.xyz","mov o0, t0"],"outputProcedure");
      
      public var texture:name_129;
      
      public function name_29(texture:name_129)
      {
         super();
         this.texture = texture;
      }
      
      public static function method_33(texture:name_129) : void
      {
         fogTexture = texture;
      }
      
      override alternativa3d function fillResources(resources:Dictionary, resourceType:Class) : void
      {
         super.alternativa3d::fillResources(resources,resourceType);
         if(this.texture != null && Boolean(name_28.alternativa3d::name_131(getDefinitionByName(getQualifiedClassName(this.texture)) as Class,resourceType)))
         {
            resources[this.texture] = true;
         }
      }
      
      private function method_75(object:name_78) : name_127
      {
         var vertexLinker:name_121 = new name_121(Context3DProgramType.VERTEX);
         var positionVar:String = "aPosition";
         vertexLinker.name_120(positionVar,name_115.ATTRIBUTE);
         if(object.alternativa3d::transformProcedure != null)
         {
            positionVar = alternativa3d::method_74(object.alternativa3d::transformProcedure,vertexLinker);
         }
         vertexLinker.name_123(alternativa3d::_projectProcedure);
         vertexLinker.name_118(alternativa3d::_projectProcedure,positionVar);
         vertexLinker.name_123(passUVProcedure);
         var fragmentLinker:name_121 = new name_121(Context3DProgramType.FRAGMENT);
         fragmentLinker.name_123(outputProcedure);
         if(fogMode == name_11.SIMPLE || fogMode == name_11.ADVANCED)
         {
            fragmentLinker.name_120("outColor");
            fragmentLinker.name_125(outputProcedure,"outColor");
         }
         if(fogMode == name_11.SIMPLE)
         {
            vertexLinker.name_123(passSimpleFogConstProcedure);
            vertexLinker.name_118(passSimpleFogConstProcedure,positionVar);
            fragmentLinker.name_123(outputWithSimpleFogProcedure);
            fragmentLinker.name_118(outputWithSimpleFogProcedure,"outColor");
         }
         else if(fogMode == name_11.ADVANCED)
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
      
      override alternativa3d function collectDraws(camera:name_124, surface:name_117, geometry:name_119, lights:Vector.<name_116>, lightsLength:int, objectRenderPriority:int = -1) : void
      {
         var program:name_127 = null;
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
         var object:name_78 = surface.alternativa3d::object;
         var positionBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(name_126.POSITION);
         var uvBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(name_126.TEXCOORDS[0]);
         if(positionBuffer == null || uvBuffer == null || this.texture == null || this.texture.alternativa3d::_texture == null)
         {
            return;
         }
         var programs:Vector.<name_127> = _programs[object.alternativa3d::transformProcedure];
         if(programs == null)
         {
            programs = new Vector.<name_127>(3,true);
            program = this.method_75(object);
            program.upload(camera.alternativa3d::context3D);
            programs[fogMode] = program;
            _programs[object.alternativa3d::transformProcedure] = programs;
         }
         else
         {
            program = programs[fogMode];
            if(program == null)
            {
               program = this.method_75(object);
               program.upload(camera.alternativa3d::context3D);
               programs[fogMode] = program;
            }
         }
         var drawUnit:name_135 = camera.alternativa3d::renderer.alternativa3d::name_137(object,program.program,geometry.alternativa3d::name_132,surface.indexBegin,surface.numTriangles,program);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aPosition"),positionBuffer,geometry.alternativa3d::_attributesOffsets[name_126.POSITION],name_126.alternativa3d::FORMATS[name_126.POSITION]);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aUV"),uvBuffer,geometry.alternativa3d::_attributesOffsets[name_126.TEXCOORDS[0]],name_126.alternativa3d::FORMATS[name_126.TEXCOORDS[0]]);
         object.alternativa3d::setTransformConstants(drawUnit,surface,program.vertexShader,camera);
         drawUnit.alternativa3d::name_136(camera,program.vertexShader.getVariableIndex("cProjMatrix"),object.alternativa3d::localToCameraTransform);
         drawUnit.alternativa3d::name_134(program.fragmentShader.getVariableIndex("cColor"),0,0,0,1);
         drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sTexture"),this.texture.alternativa3d::_texture);
         if(fogMode == name_11.SIMPLE || fogMode == name_11.ADVANCED)
         {
            lm = object.alternativa3d::localToCameraTransform;
            dist = fogFar - fogNear;
            drawUnit.alternativa3d::name_144(program.vertexShader.getVariableIndex("cFogSpace"),lm.i / dist,lm.j / dist,lm.k / dist,(lm.l - fogNear) / dist);
            drawUnit.alternativa3d::name_134(program.fragmentShader.getVariableIndex("cFogRange"),fogMaxDensity,1,0,1 - fogMaxDensity);
         }
         if(fogMode == name_11.SIMPLE)
         {
            drawUnit.alternativa3d::name_134(program.fragmentShader.getVariableIndex("cFogColor"),fogColorR,fogColorG,fogColorB);
         }
         if(fogMode == name_11.ADVANCED)
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
            drawUnit.alternativa3d::name_134(program.fragmentShader.getVariableIndex("cFogConsts"),0.5 * uScale,0.5 - uRight,0);
            drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sFogTexture"),fogTexture.alternativa3d::_texture);
         }
         if(fogMode == name_11.DISABLED)
         {
            drawUnit.alternativa3d::blendSource = Context3DBlendFactor.ZERO;
            drawUnit.alternativa3d::blendDestination = Context3DBlendFactor.SOURCE_ALPHA;
         }
         else
         {
            drawUnit.alternativa3d::blendSource = Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA;
            drawUnit.alternativa3d::blendDestination = Context3DBlendFactor.SOURCE_ALPHA;
         }
         camera.alternativa3d::renderer.alternativa3d::name_130(drawUnit,name_128.TANK_SHADOW);
      }
      
      override public function clone() : class_4
      {
         return new name_29(this.texture);
      }
   }
}

