package alternativa.protocol.codec.complex
{
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.impl.LengthCodecHelper;
   import flash.utils.ByteArray;
   
   public class StringCodec implements ICodec
   {
      public function StringCodec()
      {
         super();
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         var bytes:ByteArray = new ByteArray();
         bytes.writeUTFBytes(String(object));
         var length:int = int(bytes.length);
         LengthCodecHelper.encodeLength(protocolBuffer,length);
         protocolBuffer.writer.writeBytes(bytes,0,length);
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         var length:int = LengthCodecHelper.decodeLength(protocolBuffer);
         return protocolBuffer.reader.readUTFBytes(length);
      }
      
      public function init(protocol:IProtocol) : void
      {
      }
   }
}

