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
   import flash.display3D.Context3DBlendFactor;
   import flash.display3D.Context3DProgramType;
   import flash.display3D.VertexBuffer3D;
   import flash.utils.Dictionary;
   
   use namespace alternativa3d;
   
   public class FillMaterial extends Material
   {
      private static var outColorProcedure:Procedure = new Procedure(["#c0=cColor","mov o0, c0"],"outColorProcedure");
      
      private static var _programs:Dictionary = new Dictionary();
      
      public var alpha:Number = 1;
      
      private var red:Number;
      
      private var green:Number;
      
      private var blue:Number;
      
      public function FillMaterial(color:uint = 8355711, alpha:Number = 1)
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
         var fragmentLinker:Linker = new Linker(Context3DProgramType.FRAGMENT);
         fragmentLinker.addProcedure(outColorProcedure);
         fragmentLinker.setOppositeLinker(vertexLinker);
         return new ShaderProgram(vertexLinker,fragmentLinker);
      }
      
      override alternativa3d function collectDraws(camera:Camera3D, surface:Surface, geometry:Geometry, lights:Vector.<Light3D>, lightsLength:int, objectRenderPriority:int = -1) : void
      {
         var object:Object3D = surface.alternativa3d::object;
         var positionBuffer:VertexBuffer3D = geometry.alternativa3d::getVertexBuffer(VertexAttributes.POSITION);
         if(positionBuffer == null)
         {
            return;
         }
         var program:ShaderProgram = _programs[object.alternativa3d::transformProcedure];
         if(program == null)
         {
            program = this.final(object);
            program.upload(camera.alternativa3d::context3D);
            _programs[object.alternativa3d::transformProcedure] = program;
         }
         var drawUnit:DrawUnit = camera.alternativa3d::renderer.alternativa3d::createDrawUnit(object,program.program,geometry.alternativa3d::_-EM,surface.indexBegin,surface.numTriangles,program);
         drawUnit.alternativa3d::setVertexBufferAt(program.vertexShader.getVariableIndex("aPosition"),positionBuffer,geometry.alternativa3d::_attributesOffsets[VertexAttributes.POSITION],VertexAttributes.alternativa3d::FORMATS[VertexAttributes.POSITION]);
         object.alternativa3d::setTransformConstants(drawUnit,surface,program.vertexShader,camera);
         drawUnit.alternativa3d::setProjectionConstants(camera,program.vertexShader.getVariableIndex("cProjMatrix"),object.alternativa3d::localToCameraTransform);
         drawUnit.alternativa3d::setFragmentConstantsFromNumbers(program.fragmentShader.getVariableIndex("cColor"),this.red,this.green,this.blue,this.alpha);
         if(this.alpha < 1)
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
         var res:FillMaterial = new FillMaterial(this.color,this.alpha);
         res.clonePropertiesFrom(this);
         return res;
      }
   }
}

