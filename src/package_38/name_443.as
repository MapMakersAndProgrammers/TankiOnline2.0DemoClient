package package_38
{
   import package_36.name_442;
   
   public class name_443
   {
      public function name_443()
      {
         super();
      }
      
      public static function name_446(protocolBuffer:name_442, length:int) : void
      {
         var tmp:Number = NaN;
         if(length < 0)
         {
            throw new Error("Length is incorrect (" + length + ")");
         }
         if(length < 128)
         {
            protocolBuffer.name_483.writeByte(int(length & 0x7F));
         }
         else if(length < 16384)
         {
            tmp = (length & 0x3FFF) + 32768;
            protocolBuffer.name_483.writeByte(int((tmp & 0xFF00) >> 8));
            protocolBuffer.name_483.writeByte(int(tmp & 0xFF));
         }
         else
         {
            if(length >= 4194304)
            {
               throw new Error("Length is incorrect (" + length + ")");
            }
            tmp = (length & 0x3FFFFF) + 12582912;
            protocolBuffer.name_483.writeByte(int((tmp & 0xFF0000) >> 16));
            protocolBuffer.name_483.writeByte(int((tmp & 0xFF00) >> 8));
            protocolBuffer.name_483.writeByte(int(tmp & 0xFF));
         }
      }
      
      public static function name_445(protocolBuffer:name_442) : int
      {
         var secondByte:int = 0;
         var doubleByte:Boolean = false;
         var thirdByte:int = 0;
         var firstByte:int = int(protocolBuffer.reader.readByte());
         var singleByte:Boolean = (firstByte & 0x80) == 0;
         if(singleByte)
         {
            return firstByte;
         }
         secondByte = int(protocolBuffer.reader.readByte());
         doubleByte = (firstByte & 0x40) == 0;
         if(doubleByte)
         {
            return ((firstByte & 0x3F) << 8) + (secondByte & 0xFF);
         }
         thirdByte = int(protocolBuffer.reader.readByte());
         return ((firstByte & 0x3F) << 16) + ((secondByte & 0xFF) << 8) + (thirdByte & 0xFF);
      }
   }
}

