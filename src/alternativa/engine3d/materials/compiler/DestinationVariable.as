package alternativa.engine3d.materials.compiler
{
   import flash.utils.ByteArray;
   
   public class DestinationVariable extends Variable
   {
      public function DestinationVariable(source:String)
      {
         var regmask:uint = 0;
         var cv:int = 0;
         var maskLength:uint = 0;
         var i:int = 0;
         super();
         var strType:String = source.match(/[tovi]/)[0];
         index = parseInt(source.match(/\d+/)[0],10);
         var swizzle:Array = source.match(/\.[xyzw]{1,4}/);
         var maskmatch:String = Boolean(swizzle) ? swizzle[0] : null;
         if(maskmatch != null)
         {
            regmask = 0;
            maskLength = uint(maskmatch.length);
            for(i = 1; i < maskLength; i++)
            {
               cv = maskmatch.charCodeAt(i) - X_CHAR_CODE;
               if(cv == -1)
               {
                  cv = 3;
               }
               regmask |= 1 << cv;
            }
         }
         else
         {
            regmask = 15;
         }
         name_345 = regmask << 16 | index;
         switch(strType)
         {
            case "t":
               name_345 |= 33554432;
               type = 2;
               break;
            case "o":
               name_345 |= 50331648;
               type = 3;
               break;
            case "v":
               name_345 |= 67108864;
               type = 4;
               break;
            case "i":
               name_345 |= 100663296;
               type = 6;
               break;
            default:
               throw new ArgumentError("Wrong destination register type, must be \"t\" or \"o\" or \"v\", var = " + source);
         }
      }
      
      override public function writeToByteArray(byteCode:ByteArray, newIndex:int, newType:int) : void
      {
         byteCode.position = position;
         byteCode.writeUnsignedInt(name_345 & ~0x0F00FFFF | newIndex | newType << 24);
      }
   }
}

