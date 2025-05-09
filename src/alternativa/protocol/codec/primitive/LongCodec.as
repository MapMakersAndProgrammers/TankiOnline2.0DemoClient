package alternativa.protocol.codec.primitive
{
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.types.Long;
   
   public class LongCodec implements ICodec
   {
      public function LongCodec()
      {
         super();
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         protocolBuffer.writer.writeInt(Long(object).high);
         protocolBuffer.writer.writeInt(Long(object).low);
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         return Long.getLong(protocolBuffer.reader.readInt(),protocolBuffer.reader.readInt());
      }
      
      public function init(protocol:IProtocol) : void
      {
      }
   }
}

