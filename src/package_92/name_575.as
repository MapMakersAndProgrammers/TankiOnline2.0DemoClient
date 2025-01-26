package package_92
{
   import package_46.Matrix3;
   import package_46.name_194;
   
   public class name_575
   {
      public function name_575()
      {
         super();
      }
      
      public static function name_589(mass:Number, halfSize:name_194, result:Matrix3) : void
      {
         if(mass <= 0)
         {
            throw new ArgumentError();
         }
         result.copy(Matrix3.ZERO);
         if(mass == Infinity)
         {
            return;
         }
         var xx:Number = halfSize.x * halfSize.x;
         var yy:Number = halfSize.y * halfSize.y;
         var zz:Number = halfSize.z * halfSize.z;
         result.a = 3 / (mass * (yy + zz));
         result.f = 3 / (mass * (zz + xx));
         result.k = 3 / (mass * (xx + yy));
      }
      
      public static function method_773(mass:Number, r:Number, h:Number, result:Matrix3) : void
      {
         if(mass <= 0)
         {
            throw new ArgumentError();
         }
         result.copy(Matrix3.ZERO);
         if(mass == Infinity)
         {
            return;
         }
         result.a = result.f = 1 / (mass * (h * h / 12 + r * r / 4));
         result.k = 2 / (mass * r * r);
      }
   }
}

