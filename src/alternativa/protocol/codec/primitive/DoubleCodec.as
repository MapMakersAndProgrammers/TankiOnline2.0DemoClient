package alternativa.protocol.codec.primitive
{
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   
   public class DoubleCodec implements IPrimitiveCodec
   {
      public function DoubleCodec()
      {
         super();
      }
      
      public function nullValue() : Object
      {
         return Number.NEGATIVE_INFINITY;
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         protocolBuffer.writer.writeDouble(Number(object));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         return protocolBuffer.reader.readDouble();
      }
      
      public function init(protocol:IProtocol) : void
      {
      }
   }
}

