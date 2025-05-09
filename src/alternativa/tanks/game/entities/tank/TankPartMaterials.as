package alternativa.tanks.game.entities.tank
{
   import alternativa.engine3d.materials.TextureMaterial;
   
   public class TankPartMaterials
   {
      public var normalMaterial:TextureMaterial;
      
      public var deadMaterial:TextureMaterial;
      
      public function TankPartMaterials(normalMaterial:TextureMaterial, deadMaterial:TextureMaterial)
      {
         super();
         this.normalMaterial = normalMaterial;
         this.deadMaterial = deadMaterial;
      }
   }
}

