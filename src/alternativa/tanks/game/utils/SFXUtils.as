package alternativa.tanks.game.utils
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   
   public class SFXUtils
   {
      private static var axis1:Vector3 = new Vector3();
      
      private static var axis2:Vector3 = new Vector3();
      
      private static var eulerAngles:Vector3 = new Vector3();
      
      private static var targetAxisZ:Vector3 = new Vector3();
      
      private static var objectAxis:Vector3 = new Vector3();
      
      private static var matrix1:Matrix3 = new Matrix3();
      
      private static var matrix2:Matrix3 = new Matrix3();
      
      public function SFXUtils()
      {
         super();
      }
      
      public static function alignObjectPlaneToView(object:Object3D, objectPosition:Vector3, objectDirection:Vector3, cameraPosition:Vector3) : void
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
         matrix1.fromAxisAngle(axis1,angle);
         targetAxisZ.x = cameraPosition.x - objectPosition.x;
         targetAxisZ.y = cameraPosition.y - objectPosition.y;
         targetAxisZ.z = cameraPosition.z - objectPosition.z;
         var dot:Number = targetAxisZ.x * objectDirection.x + targetAxisZ.y * objectDirection.y + targetAxisZ.z * objectDirection.z;
         targetAxisZ.x -= dot * objectDirection.x;
         targetAxisZ.y -= dot * objectDirection.y;
         targetAxisZ.z -= dot * objectDirection.z;
         targetAxisZ.normalize();
         matrix1.transformVector(Vector3.Z_AXIS,objectAxis);
         dot = objectAxis.x * targetAxisZ.x + objectAxis.y * targetAxisZ.y + objectAxis.z * targetAxisZ.z;
         axis2.x = objectAxis.y * targetAxisZ.z - objectAxis.z * targetAxisZ.y;
         axis2.y = objectAxis.z * targetAxisZ.x - objectAxis.x * targetAxisZ.z;
         axis2.z = objectAxis.x * targetAxisZ.y - objectAxis.y * targetAxisZ.x;
         axis2.normalize();
         angle = Number(Math.acos(dot));
         matrix2.fromAxisAngle(axis2,angle);
         matrix1.append(matrix2);
         matrix1.getEulerAngles(eulerAngles);
         object.rotationX = eulerAngles.x;
         object.rotationY = eulerAngles.y;
         object.rotationZ = eulerAngles.z;
         object.x = objectPosition.x;
         object.y = objectPosition.y;
         object.z = objectPosition.z;
      }
   }
}

