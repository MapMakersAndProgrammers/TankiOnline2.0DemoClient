package alternativa.engine3d.materials.compiler
{
   import flash.utils.ByteArray;
   
   public class RelativeVariable extends Variable
   {
      public function RelativeVariable(source:String)
      {
         super();
         var relname:Array = source.match(/[A-Za-z]/g);
         index = parseInt(source.match(/\d+/g)[0],10);
         switch(relname[0])
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
            case "i":
               type = VariableType.INPUT;
         }
         var selmatch:Array = source.match(/(\.[xyzw]{1,1})/);
         if(selmatch.length == 0)
         {
            throw new Error("error: bad index register select");
         }
         var relsel:int = selmatch[0].charCodeAt(1) - X_CHAR_CODE;
         if(relsel == -1)
         {
            relsel = 3;
         }
         var relofs:Array = source.match(/\+\d{1,3}/g);
         var reloffset:int = 0;
         if(relofs.length > 0)
         {
            reloffset = int(parseInt(relofs[0],10));
         }
         if(reloffset < 0 || reloffset > 255)
         {
            throw new Error("Error: index offset " + reloffset + " out of bounds. [0..255]");
         }
         name_0J = reloffset << 16 | index;
         name_oc |= type << 8;
         name_oc |= relsel << 16;
         name_oc |= 1 << 31;
      }
      
      override public function writeToByteArray(byteCode:ByteArray, newIndex:int, newType:int) : void
      {
         byteCode.position = position;
         byteCode.writeShort(newIndex);
         byteCode.position = position + 5;
         byteCode.writeByte(newType);
      }
   }
}

