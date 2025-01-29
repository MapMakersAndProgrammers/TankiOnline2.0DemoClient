package alternativa.tanks.game.subsystems.rendersystem
{
   import flash.display.BitmapData;
   
   public class RenderUtils
   {
      public function RenderUtils()
      {
         super();
      }
      
      public static function name_109(textureParams:String, textureWidth:int) : BitmapData
      {
         var i:int = 0;
         var angle:Number = NaN;
         var color:uint = 0;
         var bitmapData:BitmapData = null;
         var angles:Vector.<Number> = null;
         var colors:Vector.<uint> = null;
         var paramValues:Array = textureParams.split(" ");
         if(paramValues.length > 1)
         {
            bitmapData = new BitmapData(textureWidth,1,false,16777215);
            paramValues.sort(compareByAngle);
            angles = new Vector.<Number>(paramValues.length);
            colors = new Vector.<uint>(paramValues.length);
            for(i = 0; i < paramValues.length; i++)
            {
               angle = Number(parseFloat(paramValues[i].substr(0,paramValues[i].indexOf(":"))));
               color = uint(parseInt(paramValues[i].substr(paramValues[i].indexOf(":") + 1),16));
               angles[i] = angle;
               colors[i] = color;
            }
            for(i = 0; i < textureWidth; i++)
            {
               angle = i / textureWidth * 360;
               color = getColor(angle,angles,colors);
               bitmapData.setPixel(i,0,color);
            }
         }
         else
         {
            color = uint(parseInt(paramValues[0].substr(paramValues[0].indexOf(":") + 1),16));
            bitmapData = new BitmapData(1,1,false,color);
         }
         return bitmapData;
      }
      
      private static function compareByAngle(a:String, b:String) : int
      {
         var valA:Number = Number(parseFloat(a.substr(0,a.indexOf(":"))));
         var valB:Number = Number(parseFloat(b.substr(0,b.indexOf(":"))));
         return valA > valB ? 1 : (valA < valB ? -1 : 0);
      }
      
      private static function getColor(currAngle:Number, angles:Vector.<Number>, colors:Vector.<uint>) : uint
      {
         var leftAngle:Number = NaN;
         var rightAngle:Number = NaN;
         var leftColor:uint = 0;
         var rightColor:uint = 0;
         var weight:Number = NaN;
         var i:int = 0;
         if(currAngle <= angles[0] || currAngle >= angles[angles.length - 1])
         {
            leftAngle = angles[angles.length - 1];
            leftColor = colors[angles.length - 1];
            rightAngle = angles[0];
            rightColor = colors[0];
            if(currAngle <= rightAngle)
            {
               weight = 1 - (rightAngle - currAngle) / (rightAngle - leftAngle + 360);
            }
            else
            {
               weight = (currAngle - leftAngle) / (rightAngle - leftAngle + 360);
            }
         }
         else
         {
            leftAngle = angles[0];
            for(i = 1; i < angles.length; i++)
            {
               rightAngle = angles[i];
               if(currAngle >= leftAngle && currAngle <= rightAngle)
               {
                  leftColor = colors[i - 1];
                  rightColor = colors[i];
                  weight = (currAngle - leftAngle) / (rightAngle - leftAngle);
                  break;
               }
               leftAngle = rightAngle;
            }
         }
         var lR:uint = uint(leftColor >> 16 & 0xFF);
         var lG:uint = uint(leftColor >> 8 & 0xFF);
         var lB:uint = uint(leftColor & 0xFF);
         var rR:uint = uint(rightColor >> 16 & 0xFF);
         var rG:uint = uint(rightColor >> 8 & 0xFF);
         var rB:uint = uint(rightColor & 0xFF);
         var r:uint = rR * weight + lR * (1 - weight);
         var g:uint = rG * weight + lG * (1 - weight);
         var b:uint = rB * weight + lB * (1 - weight);
         return r << 16 | g << 8 | b;
      }
   }
}

