package alternativa.protocol.impl
{
   import alternativa.protocol.OptionalMap;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class OptionalMapCodecHelper
   {
      private static const INPLACE_MASK_FLAG:int = 128;
      
      private static const MASK_LENGTH_2_BYTES_FLAG:int = 64;
      
      private static const INPLACE_MASK_1_BYTES:int = 32;
      
      private static const INPLACE_MASK_3_BYTES:int = 96;
      
      private static const INPLACE_MASK_2_BYTES:int = 64;
      
      private static const MASK_LENGTH_1_BYTE:int = 128;
      
      private static const MASK_LEGTH_3_BYTE:int = 12582912;
      
      public function OptionalMapCodecHelper()
      {
         super();
      }
      
      public static function encodeNullMap(nullMap:OptionalMap) : ByteArray
      {
         var sizeInBytes:int = 0;
         var firstByte:int = 0;
         var sizeEncoded:int = 0;
         var secondByte:int = 0;
         var thirdByte:int = 0;
         var nullMapSize:int = nullMap.getSize();
         var map:ByteArray = nullMap.getMap();
         var res:ByteArray = new ByteArray();
         if(nullMapSize <= 5)
         {
            res.writeByte(int((map[0] & 0xFF) >>> 3));
            return res;
         }
         if(nullMapSize <= 13)
         {
            res.writeByte(int(((map[0] & 0xFF) >>> 3) + INPLACE_MASK_1_BYTES));
            res.writeByte(((map[1] & 0xFF) >>> 3) + (map[0] << 5));
            return res;
         }
         if(nullMapSize <= 21)
         {
            res.writeByte(int(((map[0] & 0xFF) >>> 3) + INPLACE_MASK_2_BYTES));
            res.writeByte(int(((map[1] & 0xFF) >>> 3) + (map[0] << 5)));
            res.writeByte(int(((map[2] & 0xFF) >>> 3) + (map[1] << 5)));
            return res;
         }
         if(nullMapSize <= 29)
         {
            res.writeByte(int(((map[0] & 0xFF) >>> 3) + INPLACE_MASK_3_BYTES));
            res.writeByte(int(((map[1] & 0xFF) >>> 3) + (map[0] << 5)));
            res.writeByte(int(((map[2] & 0xFF) >>> 3) + (map[1] << 5)));
            res.writeByte(int(((map[3] & 0xFF) >>> 3) + (map[2] << 5)));
            return res;
         }
         if(nullMapSize <= 504)
         {
            sizeInBytes = (nullMapSize >>> 3) + ((nullMapSize & 7) == 0 ? 0 : 1);
            firstByte = int(int((sizeInBytes & 0xFF) + MASK_LENGTH_1_BYTE));
            res.writeByte(firstByte);
            res.writeBytes(map,0,sizeInBytes);
            return res;
         }
         if(nullMapSize <= 33554432)
         {
            sizeInBytes = (nullMapSize >>> 3) + ((nullMapSize & 7) == 0 ? 0 : 1);
            sizeEncoded = sizeInBytes + MASK_LEGTH_3_BYTE;
            firstByte = int(int((sizeEncoded & 0xFF0000) >>> 16));
            secondByte = int(int((sizeEncoded & 0xFF00) >>> 8));
            thirdByte = int(int(sizeEncoded & 0xFF));
            res.writeByte(firstByte);
            res.writeByte(secondByte);
            res.writeByte(thirdByte);
            res.writeBytes(map,0,sizeInBytes);
            return res;
         }
         throw new Error("NullMap overflow");
      }
      
      public static function decodeNullMap(reader:IDataInput) : OptionalMap
      {
         var maskLength:int = 0;
         var firstByteValue:int = 0;
         var isLength22bit:Boolean = false;
         var sizeInBits:int = 0;
         var secondByte:int = 0;
         var thirdByte:int = 0;
         var _loc11_:int = 0;
         var mask:ByteArray = new ByteArray();
         var firstByte:int = int(reader.readByte());
         var isLongNullMap:Boolean = (firstByte & INPLACE_MASK_FLAG) != 0;
         if(isLongNullMap)
         {
            firstByteValue = firstByte & 0x3F;
            isLength22bit = (firstByte & MASK_LENGTH_2_BYTES_FLAG) != 0;
            if(isLength22bit)
            {
               secondByte = int(reader.readByte());
               thirdByte = int(reader.readByte());
               maskLength = (firstByteValue << 16) + ((secondByte & 0xFF) << 8) + (thirdByte & 0xFF);
            }
            else
            {
               maskLength = firstByteValue;
            }
            reader.readBytes(mask,0,maskLength);
            sizeInBits = maskLength << 3;
            return new OptionalMap(sizeInBits,mask);
         }
         firstByteValue = int(int(firstByte << 3));
         maskLength = int(int((firstByte & 0x60) >> 5));
         switch(maskLength)
         {
            case 0:
               mask.writeByte(firstByteValue);
               return new OptionalMap(5,mask);
            case 1:
               secondByte = int(reader.readByte());
               mask.writeByte(int(firstByteValue + ((secondByte & 0xFF) >>> 5)));
               mask.writeByte(int(secondByte << 3));
               return new OptionalMap(13,mask);
            case 2:
               secondByte = int(reader.readByte());
               thirdByte = int(reader.readByte());
               mask.writeByte(int(firstByteValue + ((secondByte & 0xFF) >>> 5)));
               mask.writeByte(int((secondByte << 3) + ((thirdByte & 0xFF) >>> 5)));
               mask.writeByte(int(thirdByte << 3));
               return new OptionalMap(21,mask);
            case 3:
               secondByte = int(reader.readByte());
               thirdByte = int(reader.readByte());
               _loc11_ = int(reader.readByte());
               mask.writeByte(int(firstByteValue + ((secondByte & 0xFF) >>> 5)));
               mask.writeByte(int((secondByte << 3) + ((thirdByte & 0xFF) >>> 5)));
               mask.writeByte(int((thirdByte << 3) + ((_loc11_ & 0xFF) >>> 5)));
               mask.writeByte(int(_loc11_ << 3));
               return new OptionalMap(29,mask);
            default:
               return null;
         }
      }
   }
}

