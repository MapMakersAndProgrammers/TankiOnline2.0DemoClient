package package_4
{
   import alternativa.engine3d.alternativa3d;
   import flash.utils.Dictionary;
   import package_19.name_117;
   import package_21.name_116;
   import package_21.name_124;
   import package_21.name_77;
   import package_28.name_119;
   import package_30.name_114;
   import package_30.name_115;
   import package_30.name_121;
   
   use namespace alternativa3d;
   
   public class class_4
   {
      alternativa3d static const _projectProcedure:name_114 = method_73();
      
      public var name:String;
      
      alternativa3d var priority:int = 0;
      
      public function class_4()
      {
         super();
      }
      
      private static function method_73() : name_114
      {
         var res:name_114 = new name_114(["m44 o0, i0, c0"],"projectProcedure");
         res.name_122(name_115.CONSTANT,0,"cProjMatrix",4);
         return res;
      }
      
      alternativa3d function get canDrawInShadowMap() : Boolean
      {
         return true;
      }
      
      alternativa3d function method_74(transformProcedure:name_114, vertexShader:name_121) : String
      {
         vertexShader.name_120("tTransformedPosition");
         vertexShader.name_123(transformProcedure);
         vertexShader.name_118(transformProcedure,"aPosition");
         vertexShader.name_125(transformProcedure,"tTransformedPosition");
         return "tTransformedPosition";
      }
      
      public function getResources(resourceType:Class = null) : Vector.<name_77>
      {
         var key:* = undefined;
         var res:Vector.<name_77> = new Vector.<name_77>();
         var dict:Dictionary = new Dictionary();
         var count:int = 0;
         this.alternativa3d::fillResources(dict,resourceType);
         for(key in dict)
         {
            var _loc8_:* = count++;
            res[_loc8_] = key as name_77;
         }
         return res;
      }
      
      alternativa3d function fillResources(resources:Dictionary, resourceType:Class) : void
      {
      }
      
      alternativa3d function collectDraws(camera:name_124, surface:name_117, geometry:name_119, lights:Vector.<name_116>, lightsLength:int, objectRenderPriority:int = -1) : void
      {
      }
      
      public function clone() : class_4
      {
         var res:class_4 = new class_4();
         res.clonePropertiesFrom(this);
         return res;
      }
      
      protected function clonePropertiesFrom(source:class_4) : void
      {
      }
   }
}

