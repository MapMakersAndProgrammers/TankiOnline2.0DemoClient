package alternativa.engine3d.materials.compiler
{
   import flash.utils.ByteArray;
   
   public class SourceVariable extends Variable
   {
      public var relative:RelativeVariable;
      
      public function SourceVariable(source:String)
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
         name_0J = regmask << 24 | index;
         switch(strType)
         {
            case "a":
               type = VariableType.ATTRIBUTE;
               break;
            case "c":
               type = VariableType.CONSTANT;
               break;
            case "t":
               type = VariableType.TEMPORARY;
               break;
            case "o":
               type = VariableType.OUTPUT;
               break;
            case "v":
               type = VariableType.VARYING;
               break;
            case "i":
               type = VariableType.INPUT;
               break;
            default:
               throw new ArgumentError("Wrong source register type, must be \"a\" or \"c\" or \"t\" or \"o\" or \"v\" or \"i\", var = " + source);
         }
         name_oc = type;
         if(isRel)
         {
            this.relative = new RelativeVariable(relreg[0]);
            name_0J |= this.relative.name_0J;
            name_oc |= this.relative.name_oc;
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

