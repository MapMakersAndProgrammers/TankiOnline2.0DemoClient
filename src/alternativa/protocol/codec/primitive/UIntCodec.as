package alternativa.protocol.codec.primitive
{
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   
   public class UIntCodec implements ICodec
   {
      public function UIntCodec()
      {
         super();
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         protocolBuffer.writer.writeUnsignedInt(uint(object));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         return protocolBuffer.reader.readUnsignedInt();
      }
      
      public function init(protocol:IProtocol) : void
      {
      }
   }
}

