package package_116
{
   import alternativa.engine3d.alternativa3d;
   import avmplus.getQualifiedClassName;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import package_19.name_117;
   import package_21.name_116;
   import package_21.name_124;
   import package_28.name_119;
   import package_28.name_129;
   import package_28.name_167;
   import package_4.*;
   
   use namespace alternativa3d;
   
   public class name_641 extends class_4
   {
      public var colors:Object;
      
      public var textures:Object;
      
      public var transparency:Number = 0;
      
      public var var_670:String = "diffuse";
      
      private var textureMaterial:class_5;
      
      private var var_669:name_313;
      
      public function name_641()
      {
         super();
         this.textures = new Object();
         this.colors = new Object();
      }
      
      override alternativa3d function fillResources(resources:Dictionary, resourceType:Class) : void
      {
         var texture:name_129 = null;
         super.alternativa3d::fillResources(resources,resourceType);
         for each(texture in this.textures)
         {
            if(texture != null && Boolean(name_28.alternativa3d::name_131(getDefinitionByName(getQualifiedClassName(texture)) as Class,resourceType)))
            {
               resources[texture] = true;
            }
         }
      }
      
      override alternativa3d function collectDraws(camera:name_124, surface:name_117, geometry:name_119, lights:Vector.<name_116>, lightsLength:int, objectRenderPriority:int = -1) : void
      {
         var map:name_167 = null;
         var colorO:Object = this.colors[this.var_670];
         if(colorO != null)
         {
            if(this.var_669 == null)
            {
               this.var_669 = new name_313(int(colorO));
            }
            else
            {
               this.var_669.color = int(colorO);
            }
            this.var_669.alternativa3d::collectDraws(camera,surface,geometry,lights,lightsLength,objectRenderPriority);
         }
         else
         {
            map = this.textures[this.var_670];
            if(map != null)
            {
               if(this.textureMaterial == null)
               {
                  this.textureMaterial = new class_5(map);
               }
               else
               {
                  this.textureMaterial.diffuseMap = map;
               }
               this.textureMaterial.alternativa3d::collectDraws(camera,surface,geometry,lights,lightsLength,objectRenderPriority);
            }
         }
      }
   }
}

