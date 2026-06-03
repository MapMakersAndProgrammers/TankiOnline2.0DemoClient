package platform.client.fp10.core.protocol.codec
{
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Byte;
   import alternativa.types.Long;
   import platform.client.fp10.core.dispatcher.DispatcherItemId;
   
   public class DispatcherItemIdCodec implements ICodec
   {
      
      private var byteCodec:ICodec;
      
      private var longCodec:ICodec;
      
      public function DispatcherItemIdCodec()
      {
         super();
      }
      
      public function init(param1:IProtocol) : void
      {
         this.byteCodec = param1.getCodec(new TypeCodecInfo(Byte,false));
         this.longCodec = param1.getCodec(new TypeCodecInfo(Long,false));
      }
      
      public function encode(param1:ProtocolBuffer, param2:Object) : void
      {
      }
      
      public function decode(param1:ProtocolBuffer) : Object
      {
         var _loc2_:int = int(this.byteCodec.decode(param1));
         var _loc3_:Long = Long(this.longCodec.decode(param1));
         return new DispatcherItemId(_loc2_,_loc3_);
      }
   }
}

