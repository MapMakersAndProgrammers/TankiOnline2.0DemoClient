package package_4
{
   import alternativa.engine3d.alternativa3d;
   import avmplus.getQualifiedClassName;
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
   import package_21.name_78;
   import package_28.name_119;
   import package_28.name_129;
   import package_30.name_114;
   import package_30.name_115;
   import package_30.name_121;
   
   use namespace alternativa3d;
   
   public class class_5 extends class_4
   {
      alternativa3d static const _samplerSetProcedure:name_114 = new name_114(["#v0=vUV","#s0=sTexture","#c0=cAlpha","tex t0, v0, s0 <2d, linear,repeat, miplinear>","mov t0.w, c0.w","mov o0, t0"],"samplerSetProcedure");
      
      alternativa3d static const _samplerSetProcedureOpacity:name_114 = new name_114(["#v0=vUV","#s0=sTexture","#s1=sOpacity","#c0=cAlpha","tex t0, v0, s0 <2d, linear,repeat, miplinear>","tex t1, v0, s1 <2d, linear,repeat, miplinear>","mov t0.w, t1.x","mul t0.w, t0.w, c0.w","mov o0, t0"],"samplerSetProcedureOpacity");
      
      alternativa3d static const _samplerSetProcedureDiffuseAlpha:name_114 = new name_114(["#v0=vUV","#s0=sTexture","#c0=cAlpha","tex t0, v0, s0 <2d, linear,repeat, miplinear>","mul t0.w, t0.w, c0.w","mov o0, t0"],"samplerSetProcedureDiffuseAlpha");
      
      alternativa3d static const _passUVProcedure:name_114 = new name_114(["#v0=vUV","#a0=aUV","mov v0, a0"],"passUVProcedure");
      
      private static var _programs:Dictionary = new Dictionary();
      
      public var diffuseMap:name_129;
      
      public var opacityMap:name_129;
      
      public var alpha:Number = 1;
      
      public var var_21:Boolean = false;
      
      public function class_5(diffuseMap:name_129 = null, opacityMap:name_129 = null, alpha:Number = 1)
      {
         super();
         this.diffuseMap = diffuseMap;
         this.opacityMap = opacityMap;
         this.alpha = alpha;
      }
      
      override alternativa3d function get canDrawInShadowMap() : Boolean
      {
         return !this.var_21 && this.opacityMap == null;
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
         vertexLinker.name_123(alternativa3d::_passUVProcedure);
         var outProcedure:name_114 = this.var_21 ? alternativa3d::_samplerSetProcedureDiffuseAlpha : (this.opacityMap != null ? alternativa3d::_samplerSetProcedureOpacity : alternativa3d::_samplerSetProcedure);
         var fragmentLinker:name_121 = new name_121(Context3DProgramType.FRAGMENT);
         fragmentLinker.name_123(outProcedure);
         fragmentLinker.name_133(vertexLinker);
         return new name_127(vertexLinker,fragmentLinker);
      }
      
      override alternativa3d function collectDraws(camera:name_124, surface:name_117, geometry:name_119, lights:Vector.<name_116>, lightsLength:int, objectRenderPriority:int = -1) : void
      {
         var program:name_127 = null;
         var object:name_78 = surface.alternativa3d::object;
         var positionBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(name_126.POSITION);
         var uvBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(name_126.TEXCOORDS[0]);
         var key:int = this.var_21 ? 2 : (this.opacityMap != null ? 1 : 0);
         var optionsPrograms:Vector.<name_127> = _programs[object.alternativa3d::transformProcedure];
         if(optionsPrograms == null)
         {
            optionsPrograms = new Vector.<name_127>(3,true);
            _programs[object.alternativa3d::transformProcedure] = optionsPrograms;
            program = this.method_75(object);
            program.upload(camera.alternativa3d::context3D);
            optionsPrograms[key] = program;
         }
         else
         {
            program = optionsPrograms[key];
            if(program == null)
            {
               program = this.method_75(object);
               program.upload(camera.alternativa3d::context3D);
               optionsPrograms[key] = program;
            }
         }
         if(positionBuffer == null || uvBuffer == null || this.diffuseMap == null || this.diffuseMap.alternativa3d::_texture == null)
         {
            return;
         }
         if(!this.var_21 && this.opacityMap != null && this.opacityMap.alternativa3d::_texture == null)
         {
            return;
         }
         var drawUnit:name_135 = camera.alternativa3d::renderer.alternativa3d::name_137(object,program.program,geometry.alternativa3d::name_132,surface.indexBegin,surface.numTriangles,program);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aPosition"),positionBuffer,geometry.alternativa3d::_attributesOffsets[name_126.POSITION],name_126.alternativa3d::FORMATS[name_126.POSITION]);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aUV"),uvBuffer,geometry.alternativa3d::_attributesOffsets[name_126.TEXCOORDS[0]],name_126.alternativa3d::FORMATS[name_126.TEXCOORDS[0]]);
         object.alternativa3d::setTransformConstants(drawUnit,surface,program.vertexShader,camera);
         drawUnit.alternativa3d::name_136(camera,program.vertexShader.getVariableIndex("cProjMatrix"),object.alternativa3d::localToCameraTransform);
         drawUnit.alternativa3d::name_134(program.fragmentShader.getVariableIndex("cAlpha"),0,0,0,this.alpha);
         drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sTexture"),this.diffuseMap.alternativa3d::_texture);
         if(!this.var_21 && this.opacityMap != null)
         {
            drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sOpacity"),this.opacityMap.alternativa3d::_texture);
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
      
      override public function clone() : class_4
      {
         var res:class_5 = new class_5(null,null,this.alpha);
         res.clonePropertiesFrom(this);
         return res;
      }
      
      override protected function clonePropertiesFrom(source:class_4) : void
      {
         super.clonePropertiesFrom(source);
         var t:class_5 = source as class_5;
         this.diffuseMap = t.diffuseMap;
         this.opacityMap = t.opacityMap;
      }
   }
}

