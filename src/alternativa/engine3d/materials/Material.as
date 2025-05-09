package alternativa.engine3d.materials
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.Camera3D;
   import alternativa.engine3d.core.Light3D;
   import alternativa.engine3d.core.Resource;
   import alternativa.engine3d.materials.compiler.Linker;
   import alternativa.engine3d.materials.compiler.Procedure;
   import alternativa.engine3d.materials.compiler.VariableType;
   import alternativa.engine3d.objects.Surface;
   import alternativa.engine3d.resources.Geometry;
   import flash.utils.Dictionary;
   
   use namespace alternativa3d;
   
   public class Material
   {
      alternativa3d static const _projectProcedure:Procedure = getPojectProcedure();
      
      public var name:String;
      
      alternativa3d var priority:int = 0;
      
      public function Material()
      {
         super();
      }
      
      private static function getPojectProcedure() : Procedure
      {
         var res:Procedure = new Procedure(["m44 o0, i0, c0"],"projectProcedure");
         res.assignVariableName(VariableType.CONSTANT,0,"cProjMatrix",4);
         return res;
      }
      
      alternativa3d function get canDrawInShadowMap() : Boolean
      {
         return true;
      }
      
      alternativa3d function appendPositionTransformProcedure(transformProcedure:Procedure, vertexShader:Linker) : String
      {
         vertexShader.declareVariable("tTransformedPosition");
         vertexShader.addProcedure(transformProcedure);
         vertexShader.setInputParams(transformProcedure,"aPosition");
         vertexShader.setOutputParams(transformProcedure,"tTransformedPosition");
         return "tTransformedPosition";
      }
      
      public function getResources(resourceType:Class = null) : Vector.<Resource>
      {
         var key:* = undefined;
         var res:Vector.<Resource> = new Vector.<Resource>();
         var dict:Dictionary = new Dictionary();
         var count:int = 0;
         this.alternativa3d::fillResources(dict,resourceType);
         for(key in dict)
         {
            var _loc8_:* = count++;
            res[_loc8_] = key as Resource;
         }
         return res;
      }
      
      alternativa3d function fillResources(resources:Dictionary, resourceType:Class) : void
      {
      }
      
      alternativa3d function collectDraws(camera:Camera3D, surface:Surface, geometry:Geometry, lights:Vector.<Light3D>, lightsLength:int, objectRenderPriority:int = -1) : void
      {
      }
      
      public function clone() : Material
      {
         var res:Material = new Material();
         res.clonePropertiesFrom(this);
         return res;
      }
      
      protected function clonePropertiesFrom(source:Material) : void
      {
      }
   }
}

