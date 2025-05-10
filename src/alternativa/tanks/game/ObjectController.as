package alternativa.tanks.game
{
   import alternativa.engine3d.core.Camera3D;
   import alternativa.engine3d.core.Object3D;
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   
   public class ObjectController
   {
      private static var matrix:Matrix3 = new Matrix3();
      
      private static var vector:Vector3 = new Vector3();
      
      private var name_G7:Object3D;
      
      public function ObjectController()
      {
         super();
      }
      
      public function get object() : Object3D
      {
         return this.name_G7;
      }
      
      public function set object(value:Object3D) : void
      {
         this.name_G7 = value;
      }
      
      public function setPosition(x:Number, y:Number, z:Number) : void
      {
         this.name_G7.x = x;
         this.name_G7.y = y;
         this.name_G7.z = z;
      }
      
      public function setRotation(rx:Number, ry:Number, rz:Number) : void
      {
         this.name_G7.rotationX = rx;
         this.name_G7.rotationY = ry;
         this.name_G7.rotationZ = rz;
      }
      
      public function moveRelative(dx:Number, dy:Number, dz:Number) : void
      {
         matrix.setRotationMatrix(this.name_G7.rotationX,this.name_G7.rotationY,this.name_G7.rotationZ);
         vector.reset(dx,dy,dz);
         vector.transform3(matrix);
         this.name_G7.x += vector.x;
         this.name_G7.y += vector.y;
         this.name_G7.z += vector.z;
      }
      
      public function move(dx:Number, dy:Number, dz:Number) : void
      {
         this.name_G7.x += dx;
         this.name_G7.y += dy;
         this.name_G7.z += dz;
      }
      
      public function rotate(rdx:Number, rdy:Number, rdz:Number) : void
      {
         this.name_G7.rotationX += rdx;
         this.name_G7.rotationY += rdy;
         this.name_G7.rotationZ += rdz;
      }
      
      public function lookAtXYZ(x:Number, y:Number, z:Number) : void
      {
         var dx:Number = x - this.name_G7.x;
         var dy:Number = y - this.name_G7.y;
         var dz:Number = z - this.name_G7.z;
         this.name_G7.rotationX = Math.atan2(dz,Math.sqrt(dx * dx + dy * dy));
         if(this.name_G7 is Camera3D)
         {
            this.name_G7.rotationX -= 0.5 * Math.PI;
         }
         this.name_G7.rotationY = 0;
         this.name_G7.rotationZ = -Math.atan2(dx,dy);
      }
   }
}

