package package_78
{
   import package_19.name_380;
   import package_21.name_386;
   import package_46.Matrix4;
   import package_46.name_194;
   import package_86.name_484;
   
   public class name_531
   {
      public function name_531()
      {
         super();
      }
      
      public static function name_532(mesh:name_380) : name_484
      {
         mesh.calculateBoundBox();
         var bb:name_386 = mesh.boundBox;
         var hs:name_194 = new name_194(0.5 * (bb.maxX - bb.minX),0.5 * (bb.maxY - bb.minY),0.5 * (bb.maxZ - bb.minZ));
         var midPoint:name_194 = new name_194(0.5 * (bb.minX + bb.maxX),0.5 * (bb.minY + bb.maxY),0.5 * (bb.minZ + bb.maxZ));
         var matrix:Matrix4 = new Matrix4();
         matrix.name_196(mesh.rotationX,mesh.rotationY,mesh.rotationZ);
         matrix.name_75(mesh.x,mesh.y,mesh.z);
         midPoint.transform4(matrix);
         matrix.name_201(midPoint);
         return new name_484(hs,matrix);
      }
   }
}

