package alternativa.tanks.game.entities.map
{
   import alternativa.engine3d.alternativa3d;
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
   import package_30.name_114;
   import package_30.name_115;
   import package_30.name_121;
   import package_4.class_4;
   import package_4.name_127;
   import package_4.name_28;
   
   use namespace alternativa3d;
   
   public class VisibleLightMaterial extends class_4
   {
      public static var fadeRadius:Number = 100;
      
      public static var spotAngle:Number = 0;
      
      public static var fallofAngle:Number = Math.PI;
      
      private static var _programs:Dictionary = new Dictionary();
      
      private static const passColorProcedure:name_114 = new name_114(["#a0=aUV","#v0=vUV","#v1=vCameraPos","#v2=vNormal","#c0=cCameraPos","mov v0, a0","sub v1, c0, i0","mov v2, i1"],"passColor");
      
      private static const outputProcedure:name_114 = new name_114(["#v0=vUV","#v1=vCameraPos","#v2=vNormal","#c0=cZone","#s0=sTexture","dp3 t1.w, v1, v1","rsq t1.w, t1.w","mul t0.xyz, v1.xyz, t1.w","nrm t1.xyz, v2","dp3 t1.x, t0.xyz, t1.xyz","add t1.x, t1.x, c0.z","mul t1.x, t1.x, c0.y","sat t1.x, t1.x","div t1.w, c0.x, t1.w","sat t1.w, t1.w","mul t1.x, t1.x, t1.w","tex t0, v0, s0 <2d, clamp, linear, miplinear>","mul t0, t0.x, t1.x","mov o0, t0"],"output");
      
      public var texture:name_129;
      
      public function VisibleLightMaterial(texture:name_129)
      {
         super();
         this.texture = texture;
      }
      
      override alternativa3d function fillResources(resources:Dictionary, resourceType:Class) : void
      {
         super.alternativa3d::fillResources(resources,resourceType);
         if(this.texture != null && Boolean(name_28.alternativa3d::name_131(getDefinitionByName(getQualifiedClassName(this.texture)) as Class,resourceType)))
         {
            resources[this.texture] = true;
         }
      }
      
      private function setupProgram(targetObject:name_78) : name_127
      {
         var vertexLinker:name_121 = new name_121(Context3DProgramType.VERTEX);
         var fragmentLinker:name_121 = new name_121(Context3DProgramType.FRAGMENT);
         var positionVar:String = "aPosition";
         vertexLinker.name_120(positionVar,name_115.ATTRIBUTE);
         if(targetObject.alternativa3d::transformProcedure != null)
         {
            positionVar = alternativa3d::method_74(targetObject.alternativa3d::transformProcedure,vertexLinker);
         }
         vertexLinker.name_123(alternativa3d::_projectProcedure);
         vertexLinker.name_118(alternativa3d::_projectProcedure,positionVar);
         var normalVar:String = "aNormal";
         vertexLinker.name_120(normalVar,name_115.ATTRIBUTE);
         if(targetObject.alternativa3d::deltaTransformProcedure != null)
         {
            vertexLinker.name_120("tTransformedNormal");
            vertexLinker.name_123(targetObject.alternativa3d::deltaTransformProcedure);
            vertexLinker.name_118(targetObject.alternativa3d::deltaTransformProcedure,normalVar);
            vertexLinker.name_125(targetObject.alternativa3d::deltaTransformProcedure,"tTransformedNormal");
            normalVar = "tTransformedNormal";
         }
         vertexLinker.name_123(passColorProcedure);
         vertexLinker.name_118(passColorProcedure,positionVar,normalVar);
         fragmentLinker.name_123(outputProcedure);
         fragmentLinker.name_133(vertexLinker);
         vertexLinker.name_142();
         fragmentLinker.name_142();
         return new name_127(vertexLinker,fragmentLinker);
      }
      
      override alternativa3d function collectDraws(camera:name_124, surface:name_117, geometry:name_119, lights:Vector.<name_116>, lightsLength:int, objectRenderPriority:int = -1) : void
      {
         if(this.texture == null || this.texture.alternativa3d::_texture == null)
         {
            return;
         }
         var positionBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(name_126.POSITION);
         var uvBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(name_126.TEXCOORDS[0]);
         var normalsBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(name_126.NORMAL);
         if(positionBuffer == null || uvBuffer == null || normalsBuffer == null)
         {
            return;
         }
         var object:name_78 = surface.alternativa3d::object;
         var program:name_127 = _programs[object.alternativa3d::transformProcedure];
         if(program == null)
         {
            program = this.setupProgram(object);
            program.upload(camera.alternativa3d::context3D);
            _programs[object.alternativa3d::transformProcedure] = program;
         }
         var drawUnit:name_135 = camera.alternativa3d::renderer.alternativa3d::name_137(object,program.program,geometry.alternativa3d::name_132,surface.indexBegin,surface.numTriangles,program);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aPosition"),positionBuffer,geometry.alternativa3d::_attributesOffsets[name_126.POSITION],name_126.alternativa3d::FORMATS[name_126.POSITION]);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aUV"),uvBuffer,geometry.alternativa3d::_attributesOffsets[name_126.TEXCOORDS[0]],name_126.alternativa3d::FORMATS[name_126.TEXCOORDS[0]]);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aNormal"),normalsBuffer,geometry.alternativa3d::_attributesOffsets[name_126.NORMAL],name_126.alternativa3d::FORMATS[name_126.NORMAL]);
         object.alternativa3d::setTransformConstants(drawUnit,surface,program.vertexShader,camera);
         drawUnit.alternativa3d::name_136(camera,program.vertexShader.getVariableIndex("cProjMatrix") << 2,object.alternativa3d::localToCameraTransform);
         var tm:name_139 = object.alternativa3d::cameraToLocalTransform;
         drawUnit.alternativa3d::name_144(program.vertexShader.getVariableIndex("cCameraPos"),tm.d,tm.h,tm.l);
         var offset:Number = Number(Math.cos(fallofAngle / 2));
         var mul:Number = Math.cos(spotAngle / 2) - offset;
         if(mul < 0.00001)
         {
            mul = 0.00001;
         }
         drawUnit.alternativa3d::name_134(program.fragmentShader.getVariableIndex("cZone"),1 / fadeRadius,(1 - offset) / mul,-offset);
         drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sTexture"),this.texture.alternativa3d::_texture);
         drawUnit.alternativa3d::blendSource = Context3DBlendFactor.ONE;
         drawUnit.alternativa3d::blendDestination = Context3DBlendFactor.ONE;
         camera.alternativa3d::renderer.alternativa3d::name_130(drawUnit,objectRenderPriority >= 0 ? objectRenderPriority : name_128.TRANSPARENT_SORT);
      }
   }
}

