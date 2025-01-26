package package_10
{
   import package_21.name_124;
   import package_21.name_78;
   import package_46.Matrix3;
   import package_46.name_194;
   
   public class name_195
   {
      private static var matrix:Matrix3 = new Matrix3();
      
      private static var vector:name_194 = new name_194();
      
      private var var_234:name_78;
      
      public function name_195()
      {
         super();
      }
      
      public function get object() : name_78
      {
         return this.var_234;
      }
      
      public function set object(value:name_78) : void
      {
         this.var_234 = value;
      }
      
      public function name_201(x:Number, y:Number, z:Number) : void
      {
         this.var_234.x = x;
         this.var_234.y = y;
         this.var_234.z = z;
      }
      
      public function method_368(rx:Number, ry:Number, rz:Number) : void
      {
         this.var_234.rotationX = rx;
         this.var_234.rotationY = ry;
         this.var_234.rotationZ = rz;
      }
      
      public function method_367(dx:Number, dy:Number, dz:Number) : void
      {
         matrix.name_196(this.var_234.rotationX,this.var_234.rotationY,this.var_234.rotationZ);
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
      
      public function name_76(x:Number, y:Number, z:Number) : void
      {
         var dx:Number = x - this.var_234.x;
         var dy:Number = y - this.var_234.y;
         var dz:Number = z - this.var_234.z;
         this.var_234.rotationX = Math.atan2(dz,Math.sqrt(dx * dx + dy * dy));
         if(this.var_234 is name_124)
         {
            this.var_234.rotationX -= 0.5 * Math.PI;
         }
         this.var_234.rotationY = 0;
         this.var_234.rotationZ = -Math.atan2(dx,dy);
      }
   }
}

