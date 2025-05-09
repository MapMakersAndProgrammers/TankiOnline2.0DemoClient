package alternativa.protocol.codec.primitive
{
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   
   public class ByteCodec implements IPrimitiveCodec
   {
      public function ByteCodec()
      {
         super();
      }
      
      public function nullValue() : Object
      {
         return int.MAX_VALUE;
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         protocolBuffer.writer.writeByte(int(object));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         return protocolBuffer.reader.readByte();
      }
      
      public function init(protocol:IProtocol) : void
      {
      }
   }
}

