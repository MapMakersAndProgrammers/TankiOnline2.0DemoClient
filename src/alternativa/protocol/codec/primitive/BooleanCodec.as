package alternativa.protocol.codec.primitive
{
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   
   public class BooleanCodec implements ICodec
   {
      public function BooleanCodec()
      {
         super();
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         protocolBuffer.writer.writeByte(!!Boolean(object) ? int(int(1)) : int(int(0)));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         return protocolBuffer.reader.readByte() != 0;
      }
      
      public function init(protocol:IProtocol) : void
      {
      }
   }
}

