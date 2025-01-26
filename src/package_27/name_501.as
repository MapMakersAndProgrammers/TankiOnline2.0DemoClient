package package_27
{
   public class name_501
   {
      public static const EPSILON:Number = 0.001;
      
      public static const BIG_VALUE:Number = 1000000;
      
      public static const PI2:Number = 2 * Math.PI;
      
      public function name_501()
      {
         super();
      }
      
      public static function clamp(value:Number, min:Number, max:Number) : Number
      {
         if(value < min)
         {
            return min;
         }
         if(value > max)
         {
            return max;
         }
         return value;
      }
      
      public static function name_506(radians:Number) : Number
      {
         radians %= PI2;
         if(radians < -Math.PI)
         {
            return PI2 + radians;
         }
         if(radians > Math.PI)
         {
            return radians - PI2;
         }
         return radians;
      }
      
      public static function name_628(radians:Number) : Number
      {
         if(radians < -Math.PI)
         {
            return PI2 + radians;
         }
         if(radians > Math.PI)
         {
            return radians - PI2;
         }
         return radians;
      }
      
      public static function name_504(value:Number, targetValue:Number, delta:Number) : Number
      {
         if(value < targetValue)
         {
            value += delta;
            if(value > targetValue)
            {
               value = targetValue;
            }
         }
         else if(value > targetValue)
         {
            value -= delta;
            if(value < targetValue)
            {
               value = targetValue;
            }
         }
         return value;
      }
   }
}

