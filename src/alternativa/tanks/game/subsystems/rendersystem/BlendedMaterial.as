package alternativa.tanks.game.subsystems.rendersystem
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.Camera3D;
   import alternativa.engine3d.core.Light3D;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Surface;
   import alternativa.engine3d.resources.Geometry;
   import alternativa.engine3d.resources.TextureResource;
   
   use namespace alternativa3d;
   
   public class BlendedMaterial extends TextureMaterial
   {
      public var blendModeSource:String = "one";
      
      public var blendModeDestination:String = "zero";
      
      public function BlendedMaterial(diffuseMap:TextureResource = null, opacityMap:TextureResource = null, alpha:Number = 1, blendModeSource:String = "one", blendModeDestination:String = "zero")
      {
         super(diffuseMap,opacityMap,alpha);
         this.blendModeSource = blendModeSource;
         this.blendModeDestination = blendModeDestination;
      }
      
      override alternativa3d function collectDraws(camera:Camera3D, surface:Surface, geometry:Geometry, lights:Vector.<Light3D>, lightsLength:int, objectRenderPriority:int = -1) : void
      {
      }
   }
}

