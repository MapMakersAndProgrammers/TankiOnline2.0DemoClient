package alternativa.engine3d.materials
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.Camera3D;
   import alternativa.engine3d.core.DrawUnit;
   import alternativa.engine3d.core.Light3D;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.RenderPriority;
   import alternativa.engine3d.core.VertexAttributes;
   import alternativa.engine3d.materials.compiler.Linker;
   import alternativa.engine3d.materials.compiler.Procedure;
   import alternativa.engine3d.materials.compiler.VariableType;
   import alternativa.engine3d.objects.Surface;
   import alternativa.engine3d.resources.Geometry;
   import alternativa.engine3d.resources.TextureResource;
   import avmplus.getQualifiedClassName;
   import flash.display3D.Context3DBlendFactor;
   import flash.display3D.Context3DProgramType;
   import flash.display3D.VertexBuffer3D;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   
   use namespace alternativa3d;
   
   public class TextureMaterial extends Material
   {
      alternativa3d static const _samplerSetProcedure:Procedure = new Procedure(["#v0=vUV","#s0=sTexture","#c0=cAlpha","tex t0, v0, s0 <2d, linear,repeat, miplinear>","mov t0.w, c0.w","mov o0, t0"],"samplerSetProcedure");
      
      alternativa3d static const _samplerSetProcedureOpacity:Procedure = new Procedure(["#v0=vUV","#s0=sTexture","#s1=sOpacity","#c0=cAlpha","tex t0, v0, s0 <2d, linear,repeat, miplinear>","tex t1, v0, s1 <2d, linear,repeat, miplinear>","mov t0.w, t1.x","mul t0.w, t0.w, c0.w","mov o0, t0"],"samplerSetProcedureOpacity");
      
      alternativa3d static const _samplerSetProcedureDiffuseAlpha:Procedure = new Procedure(["#v0=vUV","#s0=sTexture","#c0=cAlpha","tex t0, v0, s0 <2d, linear,repeat, miplinear>","mul t0.w, t0.w, c0.w","mov o0, t0"],"samplerSetProcedureDiffuseAlpha");
      
      alternativa3d static const _passUVProcedure:Procedure = new Procedure(["#v0=vUV","#a0=aUV","mov v0, a0"],"passUVProcedure");
      
      private static var _programs:Dictionary = new Dictionary();
      
      public var diffuseMap:TextureResource;
      
      public var opacityMap:TextureResource;
      
      public var alpha:Number = 1;
      
      public var name_L4:Boolean = false;
      
      public function TextureMaterial(diffuseMap:TextureResource = null, opacityMap:TextureResource = null, alpha:Number = 1)
      {
         super();
         this.diffuseMap = diffuseMap;
         this.opacityMap = opacityMap;
         this.alpha = alpha;
      }
      
      override alternativa3d function get canDrawInShadowMap() : Boolean
      {
         return !this.name_L4 && this.opacityMap == null;
      }
      
      override alternativa3d function fillResources(resources:Dictionary, resourceType:Class) : void
      {
         super.alternativa3d::fillResources(resources,resourceType);
         if(this.diffuseMap != null && Boolean(A3DUtils.alternativa3d::checkParent(getDefinitionByName(getQualifiedClassName(this.diffuseMap)) as Class,resourceType)))
         {
            resources[this.diffuseMap] = true;
         }
         if(this.opacityMap != null && Boolean(A3DUtils.alternativa3d::checkParent(getDefinitionByName(getQualifiedClassName(this.opacityMap)) as Class,resourceType)))
         {
            resources[this.opacityMap] = true;
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
         vertexLinker.addProcedure(alternativa3d::_passUVProcedure);
         var outProcedure:Procedure = this.name_L4 ? alternativa3d::_samplerSetProcedureDiffuseAlpha : (this.opacityMap != null ? alternativa3d::_samplerSetProcedureOpacity : alternativa3d::_samplerSetProcedure);
         var fragmentLinker:Linker = new Linker(Context3DProgramType.FRAGMENT);
         fragmentLinker.addProcedure(outProcedure);
         fragmentLinker.setOppositeLinker(vertexLinker);
         return new ShaderProgram(vertexLinker,fragmentLinker);
      }
      
      override alternativa3d function collectDraws(camera:Camera3D, surface:Surface, geometry:Geometry, lights:Vector.<Light3D>, lightsLength:int, objectRenderPriority:int = -1) : void
      {
         var program:ShaderProgram = null;
         var object:Object3D = surface.alternativa3d::object;
         var positionBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(VertexAttributes.POSITION);
         var uvBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(VertexAttributes.TEXCOORDS[0]);
         var key:int = this.name_L4 ? 2 : (this.opacityMap != null ? 1 : 0);
         var optionsPrograms:Vector.<ShaderProgram> = _programs[object.alternativa3d::transformProcedure];
         if(optionsPrograms == null)
         {
            optionsPrograms = new Vector.<ShaderProgram>(3,true);
            _programs[object.alternativa3d::transformProcedure] = optionsPrograms;
            program = this.final(object);
            program.upload(camera.alternativa3d::context3D);
            optionsPrograms[key] = program;
         }
         else
         {
            program = optionsPrograms[key];
            if(program == null)
            {
               program = this.final(object);
               program.upload(camera.alternativa3d::context3D);
               optionsPrograms[key] = program;
            }
         }
         if(positionBuffer == null || uvBuffer == null || this.diffuseMap == null || this.diffuseMap.alternativa3d::_texture == null)
         {
            return;
         }
         if(!this.name_L4 && this.opacityMap != null && this.opacityMap.alternativa3d::_texture == null)
         {
            return;
         }
         var drawUnit:DrawUnit = camera.alternativa3d::renderer.alternativa3d::createDrawUnit(object,program.program,geometry.name_EM,surface.indexBegin,surface.numTriangles,program);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aPosition"),positionBuffer,geometry.alternativa3d::_attributesOffsets[VertexAttributes.POSITION],VertexAttributes.alternativa3d::FORMATS[VertexAttributes.POSITION]);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aUV"),uvBuffer,geometry.alternativa3d::_attributesOffsets[VertexAttributes.TEXCOORDS[0]],VertexAttributes.alternativa3d::FORMATS[VertexAttributes.TEXCOORDS[0]]);
         object.alternativa3d::setTransformConstants(drawUnit,surface,program.vertexShader,camera);
         drawUnit.alternativa3d::setProjectionConstants(camera,program.vertexShader.getVariableIndex("cProjMatrix"),object.alternativa3d::localToCameraTransform);
         drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.fragmentShader.getVariableIndex("cAlpha"),0,0,0,this.alpha);
         drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sTexture"),this.diffuseMap.alternativa3d::_texture);
         if(!this.name_L4 && this.opacityMap != null)
         {
            drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sOpacity"),this.opacityMap.alternativa3d::_texture);
         }
         if(this.name_L4 || this.opacityMap != null || this.alpha < 1)
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
      
      override public function clone() : Material
      {
         var res:TextureMaterial = new TextureMaterial(null,null,this.alpha);
         res.clonePropertiesFrom(this);
         return res;
      }
      
      override protected function clonePropertiesFrom(source:Material) : void
      {
         super.clonePropertiesFrom(source);
         var t:TextureMaterial = source as TextureMaterial;
         this.diffuseMap = t.diffuseMap;
         this.opacityMap = t.opacityMap;
      }
   }
}

