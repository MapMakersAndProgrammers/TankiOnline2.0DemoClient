package _codec.platform.core.general.resource.types.swf
{
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.codec.OptionalCodecDecorator;
   import alternativa.protocol.impl.LengthCodecHelper;
   import alternativa.protocol.info.TypeCodecInfo;
   import platform.core.general.resource.types.swf.ResourceSWFParams;
   
   public class VectorCodecResourceSWFParamsLevel2 implements ICodec
   {
      
      private var elementCodec:ICodec;
      
      private var optionalElement:Boolean;
      
      public function VectorCodecResourceSWFParamsLevel2(param1:Boolean)
      {
         super();
         this.optionalElement = param1;
      }
      
      public function init(param1:IProtocol) : void
      {
         this.elementCodec = param1.getCodec(new TypeCodecInfo(ResourceSWFParams,false));
         if(this.optionalElement)
         {
            this.elementCodec = new OptionalCodecDecorator(this.elementCodec);
         }
      }
      
      public function decode(param1:ProtocolBuffer) : Object
      {
         var _loc5_:int = 0;
         var _loc6_:Vector.<ResourceSWFParams> = null;
         var _loc7_:int = 0;
         var _loc2_:int = int(LengthCodecHelper.decodeLength(param1));
         var _loc3_:Vector.<Vector.<ResourceSWFParams>> = new Vector.<Vector.<ResourceSWFParams>>(_loc2_,true);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            if(!param1.optionalMap.get())
            {
               _loc5_ = int(LengthCodecHelper.decodeLength(param1));
               _loc6_ = new Vector.<ResourceSWFParams>(_loc5_,true);
               _loc3_[_loc4_] = _loc6_;
               _loc7_ = 0;
               while(_loc7_ < _loc5_)
               {
                  _loc6_[_loc7_] = ResourceSWFParams(this.elementCodec.decode(param1));
                  _loc7_++;
               }
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function encode(param1:ProtocolBuffer, param2:Object) : void
      {
         var _loc6_:Vector.<ResourceSWFParams> = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:Vector.<Vector.<ResourceSWFParams>> = Vector.<Vector.<ResourceSWFParams>>(param2);
         var _loc4_:int = int(_loc3_.length);
         LengthCodecHelper.encodeLength(param1,_loc4_);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = _loc3_[_loc5_];
            if(_loc6_ != null)
            {
               param1.optionalMap.addBit(false);
               _loc7_ = int(_loc6_.length);
               LengthCodecHelper.encodeLength(param1,_loc7_);
               _loc8_ = 0;
               while(_loc8_ < _loc7_)
               {
                  this.elementCodec.encode(param1,_loc6_[_loc8_]);
                  _loc8_++;
               }
            }
            else
            {
               param1.optionalMap.addBit(true);
            }
            _loc5_++;
         }
      }
   }
}

