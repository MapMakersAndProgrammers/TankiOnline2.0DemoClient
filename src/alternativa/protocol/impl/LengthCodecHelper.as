package alternativa.protocol.impl
{
   import alternativa.protocol.ProtocolBuffer;
   
   public class LengthCodecHelper
   {
      public function LengthCodecHelper()
      {
         super();
      }
      
      public static function encodeLength(protocolBuffer:ProtocolBuffer, length:int) : void
      {
         var tmp:Number = NaN;
         if(length < 0)
         {
            throw new Error("Length is incorrect (" + length + ")");
         }
         if(length < 128)
         {
            protocolBuffer.writer.writeByte(int(length & 0x7F));
         }
         else if(length < 16384)
         {
            tmp = (length & 0x3FFF) + 32768;
            protocolBuffer.writer.writeByte(int((tmp & 0xFF00) >> 8));
            protocolBuffer.writer.writeByte(int(tmp & 0xFF));
         }
         else
         {
            if(length >= 4194304)
            {
               throw new Error("Length is incorrect (" + length + ")");
            }
            tmp = (length & 0x3FFFFF) + 12582912;
            protocolBuffer.writer.writeByte(int((tmp & 0xFF0000) >> 16));
            protocolBuffer.writer.writeByte(int((tmp & 0xFF00) >> 8));
            protocolBuffer.writer.writeByte(int(tmp & 0xFF));
         }
      }
      
      public static function decodeLength(protocolBuffer:ProtocolBuffer) : int
      {
         var _loc4_:int = 0;
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         var firstByte:int = int(protocolBuffer.reader.readByte());
         var singleByte:Boolean = (firstByte & 0x80) == 0;
         if(singleByte)
         {
            return firstByte;
         }
         _loc4_ = int(protocolBuffer.reader.readByte());
         _loc5_ = (firstByte & 0x40) == 0;
         if(_loc5_)
         {
            return ((firstByte & 0x3F) << 8) + (_loc4_ & 0xFF);
         }
         _loc6_ = int(protocolBuffer.reader.readByte());
         return ((firstByte & 0x3F) << 16) + ((_loc4_ & 0xFF) << 8) + (_loc6_ & 0xFF);
      }
   }
}

