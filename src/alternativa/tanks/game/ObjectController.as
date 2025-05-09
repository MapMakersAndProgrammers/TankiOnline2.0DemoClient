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
      
      private var var_234:Object3D;
      
      public function ObjectController()
      {
         super();
      }
      
      public function get object() : Object3D
      {
         return this.var_234;
      }
      
      public function set object(value:Object3D) : void
      {
         this.var_234 = value;
      }
      
      public function setPosition(x:Number, y:Number, z:Number) : void
      {
         this.var_234.x = x;
         this.var_234.y = y;
         this.var_234.z = z;
      }
      
      public function setRotation(rx:Number, ry:Number, rz:Number) : void
      {
         this.var_234.rotationX = rx;
         this.var_234.rotationY = ry;
         this.var_234.rotationZ = rz;
      }
      
      public function moveRelative(dx:Number, dy:Number, dz:Number) : void
      {
         matrix.setRotationMatrix(this.var_234.rotationX,this.var_234.rotationY,this.var_234.rotationZ);
         vector.reset(dx,dy,dz);
         vector.transform3(matrix);
         this.var_234.x += vector.x;
         this.var_234.y += vector.y;
         this.var_234.z += vector.z;
      }
      
      public function move(dx:Number, dy:Number, dz:Number) : void
      {
         this.var_234.x += dx;
         this.var_234.y += dy;
         this.var_234.z += dz;
      }
      
      public function rotate(rdx:Number, rdy:Number, rdz:Number) : void
      {
         this.var_234.rotationX += rdx;
         this.var_234.rotationY += rdy;
         this.var_234.rotationZ += rdz;
      }
      
      public function lookAtXYZ(x:Number, y:Number, z:Number) : void
      {
         var dx:Number = x - this.var_234.x;
         var dy:Number = y - this.var_234.y;
         var dz:Number = z - this.var_234.z;
         this.var_234.rotationX = Math.atan2(dz,Math.sqrt(dx * dx + dy * dy));
         if(this.var_234 is Camera3D)
         {
            this.var_234.rotationX -= 0.5 * Math.PI;
         }
         this.var_234.rotationY = 0;
         this.var_234.rotationZ = -Math.atan2(dx,dy);
      }
   }
}

