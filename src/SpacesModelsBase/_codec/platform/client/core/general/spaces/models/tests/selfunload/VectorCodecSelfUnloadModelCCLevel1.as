package _codec.platform.client.core.general.spaces.models.tests.selfunload
{
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.codec.OptionalCodecDecorator;
   import alternativa.protocol.impl.LengthCodecHelper;
   import alternativa.protocol.info.TypeCodecInfo;
   import platform.client.core.general.spaces.models.tests.selfunload.SelfUnloadModelCC;
   
   public class VectorCodecSelfUnloadModelCCLevel1 implements ICodec
   {
      
      private var elementCodec:ICodec;
      
      private var optionalElement:Boolean;
      
      public function VectorCodecSelfUnloadModelCCLevel1(param1:Boolean)
      {
         super();
         this.optionalElement = param1;
      }
      
      public function init(param1:IProtocol) : void
      {
         this.elementCodec = param1.getCodec(new TypeCodecInfo(SelfUnloadModelCC,false));
         if(this.optionalElement)
         {
            this.elementCodec = new OptionalCodecDecorator(this.elementCodec);
         }
      }
      
      public function decode(param1:ProtocolBuffer) : Object
      {
         var _loc2_:int = int(LengthCodecHelper.decodeLength(param1));
         var _loc3_:Vector.<SelfUnloadModelCC> = new Vector.<SelfUnloadModelCC>(_loc2_,true);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_[_loc4_] = SelfUnloadModelCC(this.elementCodec.decode(param1));
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function encode(param1:ProtocolBuffer, param2:Object) : void
      {
         var _loc4_:SelfUnloadModelCC = null;
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:Vector.<SelfUnloadModelCC> = Vector.<SelfUnloadModelCC>(param2);
         var _loc5_:int = int(_loc3_.length);
         LengthCodecHelper.encodeLength(param1,_loc5_);
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            this.elementCodec.encode(param1,_loc3_[_loc6_]);
            _loc6_++;
         }
      }
   }
}

