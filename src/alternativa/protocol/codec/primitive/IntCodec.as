package alternativa.protocol.codec.primitive
{
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   
   public class IntCodec implements IPrimitiveCodec
   {
      public function IntCodec()
      {
         super();
      }
      
      public function nullValue() : Object
      {
         return int.MIN_VALUE;
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         protocolBuffer.writer.writeInt(int(object));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         return protocolBuffer.reader.readInt();
      }
      
      public function init(protocol:IProtocol) : void
      {
      }
   }
}

