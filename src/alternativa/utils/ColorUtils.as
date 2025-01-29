package alternativa.utils
{
   import flash.geom.ColorTransform;
   
   public class ColorUtils
   {
      public static const BLACK:uint = 0;
      
      public static const RED:uint = 8323072;
      
      public static const GREEN:uint = 32512;
      
      public static const BLUE:uint = 127;
      
      public static const BROWN:uint = 8355584;
      
      public static const CYAN:uint = 32639;
      
      public static const MAGENTA:uint = 8323199;
      
      public static const GRAY:uint = 8355711;
      
      public static const LIGHT_RED:uint = 16711680;
      
      public static const LIGHT_GREEN:uint = 65280;
      
      public static const LIGHT_BLUE:uint = 255;
      
      public static const YELLOW:uint = 16776960;
      
      public static const LIGHT_CYAN:uint = 65535;
      
      public static const LIGHT_MAGENTA:uint = 16711935;
      
      public static const WHITE:uint = 16777215;
      
      public function ColorUtils()
      {
         super();
      }
      
      public static function sum(a:uint, b:uint) : uint
      {
         var red:int = (a & 0xFF0000) + (b & 0xFF0000);
         var green:int = (a & 0xFF00) + (b & 0xFF00);
         var blue:int = (a & 0xFF) + (b & 0xFF);
         return (Boolean(red >>> 24) ? 16711680 : red) + (Boolean(green >>> 16) ? 65280 : green) + (Boolean(blue >>> 8) ? 255 : blue);
      }
      
      public static function difference(a:uint, b:uint) : uint
      {
         var red:int = (a & 0xFF0000) - (b & 0xFF0000);
         var green:int = (a & 0xFF00) - (b & 0xFF00);
         var blue:int = (a & 0xFF) - (b & 0xFF);
         return (red < 0 ? 0 : red) + (green < 0 ? 0 : green) + (blue < 0 ? 0 : blue);
      }
      
      public static function method_552(color:uint, multiplier:Number) : uint
      {
         var red:int = ((color & 0xFF0000) >>> 16) * multiplier;
         var green:int = ((color & 0xFF00) >>> 8) * multiplier;
         var blue:int = (color & 0xFF) * multiplier;
         return name_345(red,green,blue);
      }
      
      public static function interpolate(a:uint, b:uint, k:Number = 0.5) : uint
      {
         var red:int = (a & 0xFF0000) >>> 16;
         red += (((b & 0xFF0000) >>> 16) - red) * k;
         var green:int = (a & 0xFF00) >>> 8;
         green += (((b & 0xFF00) >>> 8) - green) * k;
         var blue:int = a & 0xFF;
         blue += ((b & 0xFF) - blue) * k;
         return name_345(red,green,blue);
      }
      
      public static function method_551(fromColor:ColorTransform, toColor:ColorTransform, progress:Number, result:ColorTransform = null) : ColorTransform
      {
         if(result == null)
         {
            result = new ColorTransform();
         }
         var k:Number = 1 - progress;
         result.redMultiplier = fromColor.redMultiplier * k + toColor.redMultiplier * progress;
         result.greenMultiplier = fromColor.greenMultiplier * k + toColor.greenMultiplier * progress;
         result.blueMultiplier = fromColor.blueMultiplier * k + toColor.blueMultiplier * progress;
         result.alphaMultiplier = fromColor.alphaMultiplier * k + toColor.alphaMultiplier * progress;
         result.redOffset = fromColor.redOffset * k + toColor.redOffset * progress;
         result.greenOffset = fromColor.greenOffset * k + toColor.greenOffset * progress;
         result.blueOffset = fromColor.blueOffset * k + toColor.blueOffset * progress;
         result.alphaOffset = fromColor.alphaOffset * k + toColor.alphaOffset * progress;
         return result;
      }
      
      public static function random(redMin:uint = 0, redMax:uint = 255, greenMin:uint = 0, greenMax:uint = 255, blueMin:uint = 0, blueMax:uint = 255) : uint
      {
         return name_345(MathUtils.random(redMin,redMax),MathUtils.random(greenMin,greenMax),MathUtils.random(blueMin,blueMax));
      }
      
      public static function name_345(red:int, green:int, blue:int) : uint
      {
         return (red < 0 ? 0 : (Boolean(red >>> 8) ? 16711680 : red << 16)) + (green < 0 ? 0 : (Boolean(green >>> 8) ? 65280 : green << 8)) + (blue < 0 ? 0 : (Boolean(blue >>> 8) ? 255 : blue));
      }
      
      public static function red(color:uint) : uint
      {
         return (color & 0xFF0000) >>> 16;
      }
      
      public static function green(color:uint) : uint
      {
         return (color & 0xFF00) >>> 8;
      }
      
      public static function blue(color:uint) : uint
      {
         return color & 0xFF;
      }
   }
}

