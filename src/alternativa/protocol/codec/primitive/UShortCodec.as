package alternativa.protocol.codec.primitive
{
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   
   public class UShortCodec implements ICodec
   {
      public function UShortCodec()
      {
         super();
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         throw new Error("Not implemented");
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         return protocolBuffer.reader.readUnsignedShort();
      }
      
      public function init(protocol:IProtocol) : void
      {
      }
   }
}

