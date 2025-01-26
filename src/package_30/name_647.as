package package_30
{
   import flash.utils.ByteArray;
   
   public class name_647 extends name_434
   {
      public function name_647(source:String)
      {
         super();
         var relname:Array = source.match(/[A-Za-z]/g);
         index = parseInt(source.match(/\d+/g)[0],10);
         switch(relname[0])
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
            case "i":
               type = name_115.INPUT;
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
         name_438 = reloffset << 16 | index;
         name_439 |= type << 8;
         name_439 |= relsel << 16;
         name_439 |= 1 << 31;
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

