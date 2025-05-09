package alternativa.engine3d.loaders
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.Camera3D;
   import alternativa.engine3d.core.Light3D;
   import alternativa.engine3d.materials.*;
   import alternativa.engine3d.objects.Surface;
   import alternativa.engine3d.resources.ExternalTextureResource;
   import alternativa.engine3d.resources.Geometry;
   import alternativa.engine3d.resources.TextureResource;
   import avmplus.getQualifiedClassName;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   
   use namespace alternativa3d;
   
   public class ParserMaterial extends Material
   {
      public var colors:Object;
      
      public var textures:Object;
      
      public var transparency:Number = 0;
      
      public var var_670:String = "diffuse";
      
      private var textureMaterial:TextureMaterial;
      
      private var var_669:FillMaterial;
      
      public function ParserMaterial()
      {
         super();
         this.textures = new Object();
         this.colors = new Object();
      }
      
      override alternativa3d function fillResources(resources:Dictionary, resourceType:Class) : void
      {
         var texture:TextureResource = null;
         super.alternativa3d::fillResources(resources,resourceType);
         for each(texture in this.textures)
         {
            if(texture != null && Boolean(A3DUtils.alternativa3d::checkParent(getDefinitionByName(getQualifiedClassName(texture)) as Class,resourceType)))
            {
               resources[texture] = true;
            }
         }
      }
      
      override alternativa3d function collectDraws(camera:Camera3D, surface:Surface, geometry:Geometry, lights:Vector.<Light3D>, lightsLength:int, objectRenderPriority:int = -1) : void
      {
         var map:ExternalTextureResource = null;
         var colorO:Object = this.colors[this.var_670];
         if(colorO != null)
         {
            if(this.var_669 == null)
            {
               this.var_669 = new FillMaterial(int(colorO));
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
                  this.textureMaterial = new TextureMaterial(map);
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

