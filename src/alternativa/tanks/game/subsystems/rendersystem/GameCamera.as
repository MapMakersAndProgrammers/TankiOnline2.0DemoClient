package alternativa.tanks.game.subsystems.rendersystem
{
   import package_21.name_124;
   import package_46.Matrix3;
   import package_46.name_194;
   
   public class GameCamera extends name_124
   {
      private static var matrix3:Matrix3 = new Matrix3();
      
      public var position:name_194 = new name_194();
      
      public var xAxis:name_194 = new name_194();
      
      public var yAxis:name_194 = new name_194();
      
      public var zAxis:name_194 = new name_194();
      
      public function GameCamera(nearClipping:Number, farClipping:Number)
      {
         super(nearClipping,farClipping);
      }
      
      public function name_112() : void
      {
         matrix3.name_196(rotationX,rotationY,rotationZ);
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

