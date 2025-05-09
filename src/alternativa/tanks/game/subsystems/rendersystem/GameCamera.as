package alternativa.tanks.game.subsystems.rendersystem
{
   import alternativa.engine3d.core.Camera3D;
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   
   public class GameCamera extends Camera3D
   {
      private static var matrix3:Matrix3 = new Matrix3();
      
      public var position:Vector3 = new Vector3();
      
      public var xAxis:Vector3 = new Vector3();
      
      public var yAxis:Vector3 = new Vector3();
      
      public var zAxis:Vector3 = new Vector3();
      
      public function GameCamera(nearClipping:Number, farClipping:Number)
      {
         super(nearClipping,farClipping);
      }
      
      public function calculateAxis() : void
      {
         matrix3.setRotationMatrix(rotationX,rotationY,rotationZ);
         this.position.x = x;
         this.position.y = y;
         this.position.z = z;
         this.xAxis.x = matrix3.a;
         this.xAxis.y = matrix3.e;
         this.xAxis.z = matrix3.i;
         this.yAxis.x = matrix3.b;
         this.yAxis.y = matrix3.f;
         this.yAxis.z = matrix3.j;
         this.zAxis.x = matrix3.c;
         this.zAxis.y = matrix3.g;
         this.zAxis.z = matrix3.k;
      }
   }
}

