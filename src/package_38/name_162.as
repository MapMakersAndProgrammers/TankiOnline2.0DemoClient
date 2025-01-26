package package_38
{
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   import package_36.name_442;
   import package_36.name_449;
   import package_39.name_160;
   import alternativa.osgi.OSGi;
   
   public class name_162
   {
      [Inject]
      public static var clientLog:name_160;
      
      private static const LOG_CHANNEL:String = "protocol";
      
      private static const ZIP_PACKET_SIZE_DELIMITER:int = 2000;
      
      private static const MAXIMUM_DATA_LENGTH:int = 2147483647;
      
      private static const LONG_SIZE_DELIMITER:int = 16384;
      
      private static const ZIPPED_FLAG:int = 64;
      
      private static const BIG_LENGTH_FLAG:int = 128;
      
      public function name_162()
      {
         super();
      }
      
      public static function method_303(source:IDataInput, dest:name_442) : Boolean
      {
         var isZipped:Boolean = false;
         var packetSize:int = 0;
         var hiByte:int = 0;
         var middleByte:int = 0;
         var loByte:int = 0;
         var loByte2:int = 0;
         if(source.bytesAvailable < 2)
         {
            return false;
         }
         var flagByte:int = int(source.readByte());
         var longSize:Boolean = (flagByte & BIG_LENGTH_FLAG) != 0;
         if(longSize)
         {
            if(source.bytesAvailable < 3)
            {
               return false;
            }
            isZipped = true;
            hiByte = (flagByte ^ BIG_LENGTH_FLAG) << 24;
            middleByte = (source.readByte() & 0xFF) << 16;
            loByte = (source.readByte() & 0xFF) << 8;
            loByte2 = source.readByte() & 0xFF;
            packetSize = hiByte + middleByte + loByte + loByte2;
         }
         else
         {
            isZipped = (flagByte & ZIPPED_FLAG) != 0;
            hiByte = (flagByte & 0x3F) << 8;
            loByte = source.readByte() & 0xFF;
            packetSize = hiByte + loByte;
         }
         if(source.bytesAvailable < packetSize)
         {
            return false;
         }
         var data:ByteArray = new ByteArray();
         if(packetSize != 0)
         {
            source.readBytes(data,0,packetSize);
         }
         if(isZipped)
         {
            data.uncompress();
         }
         clientLog.log(LOG_CHANNEL,"Packet::unwrapPacket() source (size=%1, compressed=%2)\n%3\n",packetSize,isZipped,bytesToString(data,0,data.length,6));
         data.position = 0;
         dest.optionalMap = name_453.name_454(data);
         var destByteArray:ByteArray = new ByteArray();
         dest.reader = destByteArray;
         destByteArray.writeBytes(data,data.position,data.length - data.position);
         destByteArray.position = 0;
         clientLog.log(LOG_CHANNEL,"Packet::unwrapPacket() unwrapped \n%1\n",bytesToString(destByteArray,0,data.length,6));
         return true;
      }
      
      public static function method_305(dst:IDataOutput, source:name_442, compressionType:name_449) : void
      {
         var sizeToWrite:int = 0;
         var hiByte:int = 0;
         var loByte:int = 0;
         var zipped:Boolean = false;
         switch(compressionType)
         {
            case name_449.NONE:
               break;
            case name_449.DEFLATE:
               zipped = true;
               break;
            case name_449.DEFLATE_AUTO:
               zipped = method_307(source.reader);
         }
         var toWrap:ByteArray = new ByteArray();
         var encodedNullmap:ByteArray = name_453.name_455(source.optionalMap);
         encodedNullmap.position = 0;
         toWrap.writeBytes(encodedNullmap);
         source.reader.readBytes(toWrap,toWrap.position,source.reader.bytesAvailable);
         toWrap.position = 0;
         var longSize:Boolean = method_306(toWrap);
         if(zipped)
         {
            toWrap.compress();
         }
         var length:int = int(toWrap.length);
         if(length > MAXIMUM_DATA_LENGTH)
         {
            throw new Error("Packet size too big (" + length + ")");
         }
         if(longSize)
         {
            sizeToWrite = length + (BIG_LENGTH_FLAG << 24);
            dst.writeInt(sizeToWrite);
         }
         else
         {
            hiByte = int(int(((length & 0xFF00) >> 8) + (zipped ? ZIPPED_FLAG : 0)));
            loByte = int(int(length & 0xFF));
            dst.writeByte(hiByte);
            dst.writeByte(loByte);
         }
         dst.writeBytes(toWrap,0,length);
         clientLog.log("protocol","packet length  " + length);
      }
      
      private static function method_306(reader:IDataInput) : Boolean
      {
         return reader.bytesAvailable >= LONG_SIZE_DELIMITER || reader.bytesAvailable == -1;
      }
      
      private static function method_307(reader:IDataInput) : Boolean
      {
         return reader.bytesAvailable == -1 || reader.bytesAvailable > ZIP_PACKET_SIZE_DELIMITER;
      }
      
      private static function method_308() : name_160
      {
         if(clientLog == null)
         {
            clientLog = name_160(OSGi.name_8().name_30(name_160));
         }
         return clientLog;
      }
      
      private static function bytesToString(bytes:ByteArray, startPosition:int, count:int, numColumns:int) : String
      {
         var columnIndex:int = 0;
         var longIndex:int = 0;
         var bytesRead:int = 0;
         var s:String = null;
         var result:String = "";
         var position:int = int(bytes.position);
         bytes.position = startPosition;
         while(bytes.bytesAvailable > 0 && bytesRead < count)
         {
            bytesRead++;
            s = bytes.readUnsignedByte().toString(16);
            if(s.length == 1)
            {
               s = "0" + s;
            }
            result += s;
            longIndex++;
            if(longIndex == 4)
            {
               longIndex = 0;
               columnIndex++;
               if(columnIndex == numColumns)
               {
                  columnIndex = 0;
                  result += "\n";
               }
               else
               {
                  result += "  ";
               }
            }
            else
            {
               result += " ";
            }
         }
         if(bytesRead < count)
         {
            result += "\nOnly " + bytesRead + " of " + count + " bytes have been read";
         }
         bytes.position = position;
         return result;
      }
   }
}

