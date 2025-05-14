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
   import alternativa.engine3d.materials.A3DUtils;
   import alternativa.engine3d.materials.FogMode;
   import alternativa.engine3d.materials.Material;
   import alternativa.engine3d.materials.ShaderProgram;
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
   import alternativa.engine3d.core.Renderer;
   
   use namespace alternativa3d;
   
   public class GiShadowMaterial extends Material
   {
      public static var fogTexture:TextureResource;
      
      public static var fogMode:int = FogMode.DISABLED;
      
      public static var fogNear:Number = 1000;
      
      public static var fogFar:Number = 5000;
      
      public static var fogMaxDensity:Number = 1;
      
      public static var fogColorR:Number = 200 / 255;
      
      public static var fogColorG:Number = 162 / 255;
      
      public static var fogColorB:Number = 200 / 255;
      
      private static const passSimpleFogConstProcedure:Procedure = new Procedure(["#v0=vZDistance","#c0=cFogSpace","dp4 t0.z, i0, c0","mov v0, t0.zzzz","sub v0.y, i0.w, t0.z"],"passSimpleFogConst");
      
      private static const outputWithSimpleFogProcedure:Procedure = new Procedure(["#v0=vZDistance","#c0=cFogColor","#c1=cFogRange","min t0.xy, v0.xy, c1.xy","max t0.xy, t0.xy, c1.zw","mul i0.xyz, i0.xyz, t0.y","mul t0.xyz, c0.xyz, t0.x","add i0.xyz, i0.xyz, t0.xyz","mov o0, i0"],"outputWithSimpleFog");
      
      private static const postPassAdvancedFogConstProcedure:Procedure = new Procedure(["#v0=vZDistance","#c0=cFogSpace","dp4 t0.z, i0, c0","mov v0, t0.zzzz","sub v0.y, i0.w, t0.z","mov v0.zw, i1.xwxw","mov o0, i1"],"postPassAdvancedFogConst");
      
      private static const outputWithAdvancedFogProcedure:Procedure = new Procedure(["#v0=vZDistance","#c0=cFogConsts","#c1=cFogRange","#s0=sFogTexture","min t0.xy, v0.xy, c1.xy","max t0.xy, t0.xy, c1.zw","mul i0.xyz, i0.xyz, t0.y","mov t1.xyzw, c0.yyzw","div t0.z, v0.z, v0.w","mul t0.z, t0.z, c0.x","add t1.x, t1.x, t0.z","tex t1, t1, s0 <2d, repeat, linear, miplinear>","mul t0.xyz, t1.xyz, t0.x","add i0.xyz, i0.xyz, t0.xyz","mov o0, i0"],"outputWithAdvancedFog");
      
      private static var _programs:Dictionary = new Dictionary();
      
      private static const passUVProcedure:Procedure = new Procedure(["#a0=aUV","#v0=vUV","mov v0, a0"],"passUVProcedure");
      
      private static const outputProcedure:Procedure = new Procedure(["#v0=vUV","#s0=sTexture","#c0=cColor","tex t0, v0, s0 <2d, linear, mipnone>","mov t0.w, t0.x","mov t0.xyz, c0.xyz","mov o0, t0"],"outputProcedure");
      
      public var texture:TextureResource;
      
      public function GiShadowMaterial(texture:TextureResource)
      {
         super();
         this.texture = texture;
      }
      
      public static function setFogTexture(texture:TextureResource) : void
      {
         fogTexture = texture;
      }
      
      override alternativa3d function fillResources(resources:Dictionary, resourceType:Class) : void
      {
         super.alternativa3d::fillResources(resources,resourceType);
         if(this.texture != null && Boolean(A3DUtils.alternativa3d::checkParent(getDefinitionByName(getQualifiedClassName(this.texture)) as Class,resourceType)))
         {
            resources[this.texture] = true;
         }
      }
      
      private function final(object:Object3D) : ShaderProgram
      {
         var vertexLinker:Linker = new Linker(Context3DProgramType.VERTEX);
         var positionVar:String = "aPosition";
         vertexLinker.declareVariable(positionVar,VariableType.ATTRIBUTE);
         if(object.alternativa3d::transformProcedure != null)
         {
            positionVar = alternativa3d::appendPositionTransformProcedure(object.alternativa3d::transformProcedure,vertexLinker);
         }
         vertexLinker.addProcedure(alternativa3d::_projectProcedure);
         vertexLinker.setInputParams(alternativa3d::_projectProcedure,positionVar);
         vertexLinker.addProcedure(passUVProcedure);
         var fragmentLinker:Linker = new Linker(Context3DProgramType.FRAGMENT);
         fragmentLinker.addProcedure(outputProcedure);
         if(fogMode == FogMode.SIMPLE || fogMode == FogMode.ADVANCED)
         {
            fragmentLinker.declareVariable("outColor");
            fragmentLinker.setOutputParams(outputProcedure,"outColor");
         }
         if(fogMode == FogMode.SIMPLE)
         {
            vertexLinker.addProcedure(passSimpleFogConstProcedure);
            vertexLinker.setInputParams(passSimpleFogConstProcedure,positionVar);
            fragmentLinker.addProcedure(outputWithSimpleFogProcedure);
            fragmentLinker.setInputParams(outputWithSimpleFogProcedure,"outColor");
         }
         else if(fogMode == FogMode.ADVANCED)
         {
            vertexLinker.declareVariable("tProjected");
            vertexLinker.setOutputParams(alternativa3d::_projectProcedure,"tProjected");
            vertexLinker.addProcedure(postPassAdvancedFogConstProcedure);
            vertexLinker.setInputParams(postPassAdvancedFogConstProcedure,positionVar,"tProjected");
            fragmentLinker.addProcedure(outputWithAdvancedFogProcedure);
            fragmentLinker.setInputParams(outputWithAdvancedFogProcedure,"outColor");
         }
         //fragmentLinker.setOppositeLinker(vertexLinker);
         return new ShaderProgram(vertexLinker,fragmentLinker);
      }
      
      override alternativa3d function collectDraws(camera:Camera3D, surface:Surface, geometry:Geometry, lights:Vector.<Light3D>, lightsLength:int, useShadow:Boolean, objectRenderPriority:int = -1) : void
      {
         var program:ShaderProgram = null;
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
         var object:Object3D = surface.alternativa3d::object;
         var positionBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(VertexAttributes.POSITION);
         var uvBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(VertexAttributes.TEXCOORDS[0]);
         if(positionBuffer == null || uvBuffer == null || this.texture == null || this.texture.alternativa3d::_texture == null)
         {
            return;
         }
         var programs:Vector.<ShaderProgram> = _programs[object.alternativa3d::transformProcedure];
         if(programs == null)
         {
            programs = new Vector.<ShaderProgram>(3,true);
            program = this.final(object);
            program.upload(camera.alternativa3d::context3D);
            programs[fogMode] = program;
            _programs[object.alternativa3d::transformProcedure] = programs;
         }
         else
         {
            program = programs[fogMode];
            if(program == null)
            {
               program = this.final(object);
               program.upload(camera.alternativa3d::context3D);
               programs[fogMode] = program;
            }
         }
         var drawUnit:DrawUnit = camera.renderer.alternativa3d::createDrawUnit(object,program.program,geometry._indexBuffer,surface.indexBegin,surface.numTriangles,program);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aPosition"),positionBuffer,geometry.alternativa3d::_attributesOffsets[VertexAttributes.POSITION],VertexAttributes.alternativa3d::FORMATS[VertexAttributes.POSITION]);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aUV"),uvBuffer,geometry.alternativa3d::_attributesOffsets[VertexAttributes.TEXCOORDS[0]],VertexAttributes.alternativa3d::FORMATS[VertexAttributes.TEXCOORDS[0]]);
         object.alternativa3d::setTransformConstants(drawUnit,surface,program.vertexShader,camera);
         drawUnit.alternativa3d::setProjectionConstants(camera,program.vertexShader.getVariableIndex("cProjMatrix"),object.alternativa3d::localToCameraTransform);
         drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.fragmentShader.getVariableIndex("cColor"),0,0,0,1);
         drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sTexture"),this.texture.alternativa3d::_texture);
         if(fogMode == FogMode.SIMPLE || fogMode == FogMode.ADVANCED)
         {
            lm = object.alternativa3d::localToCameraTransform;
            dist = fogFar - fogNear;
            drawUnit.alternativa3d::setVertexConstantsFromNumbers(program.vertexShader.getVariableIndex("cFogSpace"),lm.i / dist,lm.j / dist,lm.k / dist,(lm.l - fogNear) / dist);
            drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.fragmentShader.getVariableIndex("cFogRange"),fogMaxDensity,1,0,1 - fogMaxDensity);
         }
         if(fogMode == FogMode.SIMPLE)
         {
            drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.fragmentShader.getVariableIndex("cFogColor"),fogColorR,fogColorG,fogColorB);
         }
         if(fogMode == FogMode.ADVANCED)
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
         if(fogMode == FogMode.DISABLED)
         {
            drawUnit.alternativa3d::blendSource = Context3DBlendFactor.ZERO;
            drawUnit.alternativa3d::blendDestination = Context3DBlendFactor.SOURCE_ALPHA;
         }
         else
         {
            drawUnit.alternativa3d::blendSource = Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA;
            drawUnit.alternativa3d::blendDestination = Context3DBlendFactor.SOURCE_ALPHA;
         }
         camera.renderer.alternativa3d::addDrawUnit(drawUnit,Renderer.DECALS);
      }
      
      override public function clone() : Material
      {
         return new GiShadowMaterial(this.texture);
      }
   }
}

