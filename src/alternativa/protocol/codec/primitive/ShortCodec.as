package alternativa.protocol.codec.primitive
{
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   
   public class ShortCodec implements IPrimitiveCodec
   {
      public function ShortCodec()
      {
         super();
      }
      
      public function nullValue() : Object
      {
         return int.MIN_VALUE;
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         protocolBuffer.writer.writeShort(int(object));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         return protocolBuffer.reader.readShort();
      }
      
      public function init(protocol:IProtocol) : void
      {
      }
   }
}

