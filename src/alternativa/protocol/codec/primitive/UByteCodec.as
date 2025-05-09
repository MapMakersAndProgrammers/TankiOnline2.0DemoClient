package alternativa.protocol.codec.primitive
{
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   
   public class UByteCodec implements ICodec
   {
      public function UByteCodec()
      {
         super();
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         protocolBuffer.writer.writeUnsignedInt(uint(object));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         return protocolBuffer.reader.readUnsignedByte();
      }
      
      public function init(protocol:IProtocol) : void
      {
      }
   }
}

