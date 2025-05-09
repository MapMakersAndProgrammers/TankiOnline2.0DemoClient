package alternativa.protocol.codec.primitive
{
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   
   public class FloatCodec implements IPrimitiveCodec
   {
      public function FloatCodec()
      {
         super();
      }
      
      public function nullValue() : Object
      {
         return Number.NEGATIVE_INFINITY;
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         protocolBuffer.writer.writeFloat(Number(object));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         return protocolBuffer.reader.readFloat();
      }
      
      public function init(protocol:IProtocol) : void
      {
      }
   }
}

