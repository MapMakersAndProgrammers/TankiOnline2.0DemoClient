package § var§
{
   import alternativa.engine3d.core.BoundBox;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.math.Matrix4;
   import alternativa.math.Vector3;
   import alternativa.tanks.game.physics.BoxData;
   
   public class TankPartParsingUtils
   {
      public function TankPartParsingUtils()
      {
         super();
      }
      
      public static function parseCollisionBoxData(mesh:Mesh) : BoxData
      {
         mesh.calculateBoundBox();
         var bb:BoundBox = mesh.boundBox;
         var hs:Vector3 = new Vector3(0.5 * (bb.maxX - bb.minX),0.5 * (bb.maxY - bb.minY),0.5 * (bb.maxZ - bb.minZ));
         var midPoint:Vector3 = new Vector3(0.5 * (bb.minX + bb.maxX),0.5 * (bb.minY + bb.maxY),0.5 * (bb.minZ + bb.maxZ));
         var matrix:Matrix4 = new Matrix4();
         matrix.setRotationMatrix(mesh.rotationX,mesh.rotationY,mesh.rotationZ);
         matrix.setPositionXYZ(mesh.x,mesh.y,mesh.z);
         midPoint.transform4(matrix);
         matrix.setPosition(midPoint);
         return new BoxData(hs,matrix);
      }
   }
}

