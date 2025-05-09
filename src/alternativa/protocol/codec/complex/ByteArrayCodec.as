package alternativa.protocol.codec.complex
{
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.impl.LengthCodecHelper;
   import flash.utils.ByteArray;
   
   public class ByteArrayCodec implements ICodec
   {
      public function ByteArrayCodec()
      {
         super();
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         var bytes:ByteArray = ByteArray(object);
         LengthCodecHelper.encodeLength(protocolBuffer,bytes.length);
         protocolBuffer.writer.writeBytes(bytes);
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         var size:int = LengthCodecHelper.decodeLength(protocolBuffer);
         var bytes:ByteArray = new ByteArray();
         protocolBuffer.reader.readBytes(bytes,0,size);
         return bytes;
      }
      
      public function init(protocol:IProtocol) : void
      {
      }
   }
}

