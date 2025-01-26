package package_4
{
   import alternativa.engine3d.alternativa3d;
   import flash.display3D.Context3DBlendFactor;
   import flash.display3D.Context3DProgramType;
   import flash.display3D.VertexBuffer3D;
   import flash.utils.Dictionary;
   import package_19.name_117;
   import package_21.name_116;
   import package_21.name_124;
   import package_21.name_126;
   import package_21.name_128;
   import package_21.name_135;
   import package_21.name_78;
   import package_28.name_119;
   import package_30.name_114;
   import package_30.name_115;
   import package_30.name_121;
   
   use namespace alternativa3d;
   
   public class name_313 extends class_4
   {
      private static var outColorProcedure:name_114 = new name_114(["#c0=cColor","mov o0, c0"],"outColorProcedure");
      
      private static var _programs:Dictionary = new Dictionary();
      
      public var alpha:Number = 1;
      
      private var red:Number;
      
      private var green:Number;
      
      private var blue:Number;
      
      public function name_313(color:uint = 8355711, alpha:Number = 1)
      {
         super();
         this.color = color;
         this.alpha = alpha;
         alternativa3d::priority = 1;
      }
      
      public function get color() : uint
      {
         return (this.red * 255 << 16) + (this.green * 255 << 8) + this.blue * 255;
      }
      
      public function set color(value:uint) : void
      {
         this.red = (value >> 16 & 0xFF) / 255;
         this.green = (value >> 8 & 0xFF) / 255;
         this.blue = (value & 0xFF) / 255;
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
         var fragmentLinker:name_121 = new name_121(Context3DProgramType.FRAGMENT);
         fragmentLinker.name_123(outColorProcedure);
         fragmentLinker.name_133(vertexLinker);
         return new name_127(vertexLinker,fragmentLinker);
      }
      
      override alternativa3d function collectDraws(camera:name_124, surface:name_117, geometry:name_119, lights:Vector.<name_116>, lightsLength:int, objectRenderPriority:int = -1) : void
      {
         var object:name_78 = surface.alternativa3d::object;
         var positionBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(name_126.POSITION);
         if(positionBuffer == null)
         {
            return;
         }
         var program:name_127 = _programs[object.alternativa3d::transformProcedure];
         if(program == null)
         {
            program = this.method_75(object);
            program.upload(camera.alternativa3d::context3D);
            _programs[object.alternativa3d::transformProcedure] = program;
         }
         var drawUnit:name_135 = camera.alternativa3d::renderer.alternativa3d::name_137(object,program.program,geometry.alternativa3d::name_132,surface.indexBegin,surface.numTriangles,program);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aPosition"),positionBuffer,geometry.alternativa3d::_attributesOffsets[name_126.POSITION],name_126.alternativa3d::FORMATS[name_126.POSITION]);
         object.alternativa3d::setTransformConstants(drawUnit,surface,program.vertexShader,camera);
         drawUnit.alternativa3d::name_136(camera,program.vertexShader.getVariableIndex("cProjMatrix"),object.alternativa3d::localToCameraTransform);
         drawUnit.alternativa3d::name_134(program.fragmentShader.getVariableIndex("cColor"),this.red,this.green,this.blue,this.alpha);
         if(this.alpha < 1)
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
         var res:name_313 = new name_313(this.color,this.alpha);
         res.clonePropertiesFrom(this);
         return res;
      }
   }
}

