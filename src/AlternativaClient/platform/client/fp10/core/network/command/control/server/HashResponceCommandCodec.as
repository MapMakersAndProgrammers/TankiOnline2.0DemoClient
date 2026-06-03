package platform.client.fp10.core.network.command.control.server
{
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Byte;
   import flash.utils.ByteArray;
   
   public class HashResponceCommandCodec implements ICodec
   {
      
      private static const HASH_BYTE_LENGTH:int = 32;
      
      private var byteCodec:ICodec;
      
      public function HashResponceCommandCodec(param1:IProtocol)
      {
         super();
         this.init(param1);
      }
      
      public function init(param1:IProtocol) : void
      {
         this.byteCodec = param1.getCodec(new TypeCodecInfo(Byte,false));
      }
      
      public function encode(param1:ProtocolBuffer, param2:Object) : void
      {
      }
      
      public function decode(param1:ProtocolBuffer) : Object
      {
         var _loc2_:ByteArray = new ByteArray();
         var _loc3_:int = 0;
         while(_loc3_ < HASH_BYTE_LENGTH)
         {
            _loc2_.writeByte(int(this.byteCodec.decode(param1)));
            _loc3_++;
         }
         _loc2_.position = 0;
         return new HashResponceCommand(_loc2_);
      }
   }
}

