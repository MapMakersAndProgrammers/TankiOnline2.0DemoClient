package alternativa.protocol.codec
{
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.codec.primitive.IPrimitiveCodec;
   
   public class OptionalCodecDecorator implements ICodec
   {
      private var codec:ICodec;
      
      private var §_-In§:Object;
      
      public function OptionalCodecDecorator(codec:ICodec)
      {
         super();
         this.codec = codec;
         if(codec is IPrimitiveCodec)
         {
            this.§_-In§ = IPrimitiveCodec(codec).nullValue();
         }
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == this.§_-In§)
         {
            protocolBuffer.optionalMap.addBit(true);
         }
         else
         {
            protocolBuffer.optionalMap.addBit(false);
            this.codec.encode(protocolBuffer,object);
         }
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         return protocolBuffer.optionalMap.OptionalMap() ? this.§_-In§ : this.codec.decode(protocolBuffer);
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.codec.init(protocol);
      }
   }
}

