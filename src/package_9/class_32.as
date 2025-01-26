package package_9
{
   import package_18.name_90;
   import package_46.name_194;
   
   public class class_32
   {
      protected var camera:name_90;
      
      public function class_32()
      {
         super();
      }
      
      protected function name_201(position:name_194) : void
      {
         this.camera.x = position.x;
         this.camera.y = position.y;
         this.camera.z = position.z;
      }
      
      protected function name_352(eulerAngles:name_194) : void
      {
         this.camera.rotationX = eulerAngles.x;
         this.camera.rotationY = eulerAngles.y;
         this.camera.rotationZ = eulerAngles.z;
      }
      
      protected function method_479(rx:Number, ry:Number, rz:Number) : void
      {
         this.camera.rotationX = rx;
         this.camera.rotationY = ry;
         this.camera.rotationZ = rz;
      }
      
      protected function method_532(dx:Number, dy:Number, dz:Number) : void
      {
         this.camera.x += dx;
         this.camera.y += dy;
         this.camera.z += dz;
      }
      
      protected function method_533(rx:Number, ry:Number, rz:Number) : void
      {
         this.camera.rotationX += rx;
         this.camera.rotationY += ry;
         this.camera.rotationZ += rz;
      }
   }
}

