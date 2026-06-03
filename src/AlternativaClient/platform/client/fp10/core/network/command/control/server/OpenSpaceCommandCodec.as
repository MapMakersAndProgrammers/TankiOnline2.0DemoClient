package platform.client.fp10.core.network.command.control.server
{
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Byte;
   import alternativa.types.Long;
   
   public class OpenSpaceCommandCodec implements ICodec
   {
      
      private var byteCodec:ICodec;
      
      private var intCodec:ICodec;
      
      private var longCodec:ICodec;
      
      private var stringCodec:ICodec;
      
      public function OpenSpaceCommandCodec(param1:IProtocol)
      {
         super();
         this.init(param1);
      }
      
      public function init(param1:IProtocol) : void
      {
         this.byteCodec = param1.getCodec(new TypeCodecInfo(Byte,false));
         this.intCodec = param1.getCodec(new TypeCodecInfo(int,false));
         this.longCodec = param1.getCodec(new TypeCodecInfo(Long,false));
         this.stringCodec = param1.getCodec(new TypeCodecInfo(String,false));
      }
      
      public function encode(param1:ProtocolBuffer, param2:Object) : void
      {
      }
      
      public function decode(param1:ProtocolBuffer) : Object
      {
         var _loc2_:Long = Long(this.longCodec.decode(param1));
         var _loc3_:String = String(this.stringCodec.decode(param1));
         var _loc4_:Vector.<int> = new Vector.<int>();
         var _loc5_:int = int(this.byteCodec.decode(param1));
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_.push(this.intCodec.decode(param1));
            _loc6_++;
         }
         return new OpenSpaceCommand(_loc2_,_loc3_,_loc4_);
      }
   }
}

