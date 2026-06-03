package _codec.platform.core.general.resource.types.l10n.protocol
{
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.codec.OptionalCodecDecorator;
   import alternativa.protocol.impl.LengthCodecHelper;
   import alternativa.protocol.info.TypeCodecInfo;
   import platform.core.general.resource.types.l10n.protocol.ImagePair;
   
   public class VectorCodecImagePairLevel3 implements ICodec
   {
      
      private var elementCodec:ICodec;
      
      private var optionalElement:Boolean;
      
      public function VectorCodecImagePairLevel3(param1:Boolean)
      {
         super();
         this.optionalElement = param1;
      }
      
      public function init(param1:IProtocol) : void
      {
         this.elementCodec = param1.getCodec(new TypeCodecInfo(ImagePair,false));
         if(this.optionalElement)
         {
            this.elementCodec = new OptionalCodecDecorator(this.elementCodec);
         }
      }
      
      public function decode(param1:ProtocolBuffer) : Object
      {
         var _loc5_:int = 0;
         var _loc6_:Vector.<Vector.<ImagePair>> = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Vector.<ImagePair> = null;
         var _loc10_:int = 0;
         var _loc2_:int = int(LengthCodecHelper.decodeLength(param1));
         var _loc3_:Vector.<Vector.<Vector.<ImagePair>>> = new Vector.<Vector.<Vector.<ImagePair>>>(_loc2_,true);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            if(!param1.optionalMap.get())
            {
               _loc5_ = int(LengthCodecHelper.decodeLength(param1));
               _loc6_ = new Vector.<Vector.<ImagePair>>(_loc5_,true);
               _loc3_[_loc4_] = _loc6_;
               _loc7_ = 0;
               while(_loc7_ < _loc5_)
               {
                  if(!param1.optionalMap.get())
                  {
                     _loc8_ = int(LengthCodecHelper.decodeLength(param1));
                     _loc9_ = new Vector.<ImagePair>(_loc8_,true);
                     _loc6_[_loc7_] = _loc9_;
                     _loc10_ = 0;
                     while(_loc10_ < _loc8_)
                     {
                        _loc9_[_loc10_] = ImagePair(this.elementCodec.decode(param1));
                        _loc10_++;
                     }
                  }
                  _loc7_++;
               }
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function encode(param1:ProtocolBuffer, param2:Object) : void
      {
         var _loc6_:Vector.<Vector.<ImagePair>> = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Vector.<ImagePair> = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:Vector.<Vector.<Vector.<ImagePair>>> = Vector.<Vector.<Vector.<ImagePair>>>(param2);
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
                  _loc9_ = _loc6_[_loc5_];
                  if(_loc9_ != null)
                  {
                     param1.optionalMap.addBit(false);
                     _loc10_ = int(_loc9_.length);
                     LengthCodecHelper.encodeLength(param1,_loc10_);
                     _loc11_ = 0;
                     while(_loc11_ < _loc10_)
                     {
                        this.elementCodec.encode(param1,_loc9_[_loc11_]);
                        _loc11_++;
                     }
                  }
                  else
                  {
                     param1.optionalMap.addBit(true);
                  }
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

