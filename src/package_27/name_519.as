package package_27
{
   import package_21.name_78;
   import package_46.Matrix3;
   import package_46.name_194;
   
   public class name_519
   {
      private static var axis1:name_194 = new name_194();
      
      private static var axis2:name_194 = new name_194();
      
      private static var eulerAngles:name_194 = new name_194();
      
      private static var targetAxisZ:name_194 = new name_194();
      
      private static var objectAxis:name_194 = new name_194();
      
      private static var matrix1:Matrix3 = new Matrix3();
      
      private static var matrix2:Matrix3 = new Matrix3();
      
      public function name_519()
      {
         super();
      }
      
      public static function name_521(object:name_78, objectPosition:name_194, objectDirection:name_194, cameraPosition:name_194) : void
      {
         var angle:Number = NaN;
         if(objectDirection.y < -0.99999 || objectDirection.y > 0.99999)
         {
            axis1.x = 0;
            axis1.y = 0;
            axis1.z = 1;
            angle = objectDirection.y < 0 ? Number(Math.PI) : 0;
         }
         else
         {
            axis1.x = objectDirection.z;
            axis1.y = 0;
            axis1.z = -objectDirection.x;
            axis1.normalize();
            angle = Number(Math.acos(objectDirection.y));
         }
         matrix1.method_344(axis1,angle);
         targetAxisZ.x = cameraPosition.x - objectPosition.x;
         targetAxisZ.y = cameraPosition.y - objectPosition.y;
         targetAxisZ.z = cameraPosition.z - objectPosition.z;
         var dot:Number = targetAxisZ.x * objectDirection.x + targetAxisZ.y * objectDirection.y + targetAxisZ.z * objectDirection.z;
         targetAxisZ.x -= dot * objectDirection.x;
         targetAxisZ.y -= dot * objectDirection.y;
         targetAxisZ.z -= dot * objectDirection.z;
         targetAxisZ.normalize();
         matrix1.method_345(name_194.Z_AXIS,objectAxis);
         dot = objectAxis.x * targetAxisZ.x + objectAxis.y * targetAxisZ.y + objectAxis.z * targetAxisZ.z;
         axis2.x = objectAxis.y * targetAxisZ.z - objectAxis.z * targetAxisZ.y;
         axis2.y = objectAxis.z * targetAxisZ.x - objectAxis.x * targetAxisZ.z;
         axis2.z = objectAxis.x * targetAxisZ.y - objectAxis.y * targetAxisZ.x;
         axis2.normalize();
         angle = Number(Math.acos(dot));
         matrix2.method_344(axis2,angle);
         matrix1.append(matrix2);
         matrix1.name_341(eulerAngles);
         object.rotationX = eulerAngles.x;
         object.rotationY = eulerAngles.y;
         object.rotationZ = eulerAngles.z;
         object.x = objectPosition.x;
         object.y = objectPosition.y;
         object.z = objectPosition.z;
      }
   }
}

