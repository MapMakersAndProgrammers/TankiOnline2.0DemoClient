package alternativa.utils
{
   import flash.geom.Point;
   
   public final class MathUtils
   {
      private static const toRad:Number = Math.PI / 180;
      
      private static const toDeg:Number = 180 / Math.PI;
      
      public static const DEG1:Number = toRad;
      
      public static const DEG5:Number = Math.PI / 36;
      
      public static const DEG10:Number = Math.PI / 18;
      
      public static const DEG30:Number = Math.PI / 6;
      
      public static const DEG45:Number = Math.PI / 4;
      
      public static const DEG60:Number = Math.PI / 3;
      
      public static const DEG90:Number = Math.PI / 2;
      
      public static const DEG180:Number = Math.PI;
      
      public static const DEG360:Number = Math.PI + Math.PI;
      
      public function MathUtils()
      {
         super();
      }
      
      public static function toRadian(angle:Number) : Number
      {
         return angle * toRad;
      }
      
      public static function toDegree(angle:Number) : Number
      {
         return angle * toDeg;
      }
      
      public static function limitAngle(angle:Number) : Number
      {
         var res:Number = angle % DEG360;
         return res > 0 ? (res > DEG180 ? res - DEG360 : res) : (res < -DEG180 ? res + DEG360 : res);
      }
      
      public static function deltaAngle(a:Number, b:Number) : Number
      {
         var delta:Number = b - a;
         if(delta > DEG180)
         {
            return delta - DEG360;
         }
         if(delta < -DEG180)
         {
            return delta + DEG360;
         }
         return delta;
      }
      
      public static function random(a:Number = NaN, b:Number = NaN) : Number
      {
         if(isNaN(a))
         {
            return Math.random();
         }
         if(isNaN(b))
         {
            return Math.random() * a;
         }
         return Math.random() * (b - a) + a;
      }
      
      public static function randomAngle() : Number
      {
         return Math.random() * DEG360;
      }
      
      public static function equals(a:Number, b:Number, threshold:Number = 0) : Boolean
      {
         return b - a <= threshold && b - a >= -threshold;
      }
      
      public static function segmentDistance(first:Point, second:Point, point:Point) : Number
      {
         var dx:Number = second.x - first.x;
         var dy:Number = second.y - first.y;
         var px:Number = point.x - first.x;
         var py:Number = point.y - first.y;
         return (dx * py - dy * px) / Math.sqrt(dx * dx + dy * dy);
      }
      
      public static function triangleHasPoint(a:Point, b:Point, c:Point, point:Point) : Boolean
      {
         if(vectorCross(c.subtract(a),point.subtract(a)) <= 0)
         {
            if(vectorCross(b.subtract(c),point.subtract(c)) <= 0)
            {
               if(vectorCross(a.subtract(b),point.subtract(b)) <= 0)
               {
                  return true;
               }
               return false;
            }
            return false;
         }
         return false;
      }
      
      public static function vectorCross(a:Point, b:Point) : Number
      {
         return a.x * b.y - a.y * b.x;
      }
      
      public static function vectorDot(a:Point, b:Point) : Number
      {
         return a.x * b.x + a.y * b.y;
      }
      
      public static function vectorAngle(a:Point, b:Point) : Number
      {
         var len:Number = a.length * b.length;
         var cos:Number = len != 0 ? vectorDot(a,b) / len : 1;
         return Math.acos(cos);
      }
      
      public static function vectorAngleFast(a:Point, b:Point) : Number
      {
         var dot:Number = vectorDot(a,b);
         if(Math.abs(dot) > 1)
         {
            dot = dot > 0 ? 1 : -1;
         }
         return Math.acos(dot);
      }
   }
}

