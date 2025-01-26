package package_30
{
   import flash.utils.ByteArray;
   
   public class name_437 extends name_434
   {
      public var relative:name_647;
      
      public function name_437(source:String)
      {
         var regmask:uint = 0;
         var isRel:Boolean = false;
         var cv:int = 0;
         var maskLength:uint = 0;
         var i:int = 0;
         super();
         var strType:String = String(source.match(/[catsoiv]/g)[0]);
         var relreg:Array = source.match(/\[.*\]/g);
         isRel = relreg.length > 0;
         if(isRel)
         {
            source = source.replace(relreg[0],"0");
         }
         else
         {
            index = parseInt(source.match(/\d+/g)[0],10);
         }
         var swizzle:Array = source.match(/\.[xyzw]{1,4}/);
         var maskmatch:String = Boolean(swizzle) ? swizzle[0] : null;
         if(Boolean(maskmatch))
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
               regmask |= cv << (i - 1 << 1);
            }
            while(i <= 4)
            {
               regmask |= cv << (i - 1 << 1);
               i++;
            }
         }
         else
         {
            regmask = 228;
         }
         name_438 = regmask << 24 | index;
         switch(strType)
         {
            case "a":
               type = name_115.ATTRIBUTE;
               break;
            case "c":
               type = name_115.CONSTANT;
               break;
            case "t":
               type = name_115.TEMPORARY;
               break;
            case "o":
               type = name_115.OUTPUT;
               break;
            case "v":
               type = name_115.VARYING;
               break;
            case "i":
               type = name_115.INPUT;
               break;
            default:
               throw new ArgumentError("Wrong source register type, must be \"a\" or \"c\" or \"t\" or \"o\" or \"v\" or \"i\", var = " + source);
         }
         name_439 = type;
         if(isRel)
         {
            this.relative = new name_647(relreg[0]);
            name_438 |= this.relative.name_438;
            name_439 |= this.relative.name_439;
            isRelative = true;
         }
      }
      
      override public function get size() : uint
      {
         if(Boolean(this.relative))
         {
            return 0;
         }
         return super.size;
      }
      
      override public function writeToByteArray(byteCode:ByteArray, newIndex:int, newType:int) : void
      {
         if(this.relative == null)
         {
            super.writeToByteArray(byteCode,newIndex,newType);
         }
         else
         {
            byteCode.position = position + 2;
         }
         byteCode.position = position + 4;
         byteCode.writeByte(newType);
      }
   }
}

