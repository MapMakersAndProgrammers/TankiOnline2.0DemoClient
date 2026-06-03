package platform.client.fp10.core.protocol.codec
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.codec.complex.SimpleStringCodec;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Byte;
   import alternativa.types.Long;
   import alternativa.types.Short;
   import flash.utils.ByteArray;
   import platform.client.fp10.core.dispatcher.ClassDispatcherItem;
   import platform.client.fp10.core.dispatcher.DispatcherItem;
   import platform.client.fp10.core.dispatcher.ResourceDispatcherItem;
   import platform.client.fp10.core.registry.ModelRegistry;
   import platform.client.fp10.core.registry.ResourceRegistry;
   import platform.client.fp10.core.resource.ResourceFileInfo;
   import platform.client.fp10.core.resource.ResourceInfo;
   import platform.client.fp10.core.service.serverlog.IServerLog;
   
   public class DispatcherItemCodec implements ICodec
   {
      
      [Inject]
      public static var logger:IServerLog;
      
      [Inject]
      public static var clientLog:IClientLog;
      
      [Inject]
      public static var modelRegistry:ModelRegistry;
      
      private static const LOG_CHANNEL:String = "codec";
      
      private var protocol:IProtocol;
      
      private var byteCodec:ICodec;
      
      private var shortCodec:ICodec;
      
      private var intCodec:ICodec;
      
      private var longCodec:ICodec;
      
      private var longOptionalCodec:ICodec;
      
      private var booleanCodec:ICodec;
      
      private var simpleStringCodec:ICodec;
      
      public function DispatcherItemCodec()
      {
         super();
      }
      
      public function init(param1:IProtocol) : void
      {
         this.protocol = param1;
         this.byteCodec = param1.getCodec(new TypeCodecInfo(Byte,false));
         this.shortCodec = param1.getCodec(new TypeCodecInfo(Short,false));
         this.intCodec = param1.getCodec(new TypeCodecInfo(int,false));
         this.longCodec = param1.getCodec(new TypeCodecInfo(Long,false));
         this.longOptionalCodec = param1.getCodec(new TypeCodecInfo(Long,true));
         this.booleanCodec = param1.getCodec(new TypeCodecInfo(Boolean,false));
         this.simpleStringCodec = new SimpleStringCodec(param1);
      }
      
      public function encode(param1:ProtocolBuffer, param2:Object) : void
      {
      }
      
      public function decode(param1:ProtocolBuffer) : Object
      {
         var _loc2_:int = int(this.byteCodec.decode(param1));
         switch(_loc2_)
         {
            case DispatcherItem.CLASS:
               return this.decodeClass(param1);
            case DispatcherItem.RESOURCE:
               return this.decodeResourceData(param1);
            case DispatcherItem.LEVEL_SEPARATOR:
               return new DispatcherItem(_loc2_);
            default:
               return null;
         }
      }
      
      private function decodeClass(param1:ProtocolBuffer) : DispatcherItem
      {
         var _loc5_:Vector.<Long> = null;
         var _loc6_:ByteArray = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc2_:Long = Long(this.longCodec.decode(param1));
         var _loc3_:Long = Long(this.longOptionalCodec.decode(param1));
         var _loc4_:int = int(this.intCodec.decode(param1));
         if(_loc4_ > 0)
         {
            _loc5_ = new Vector.<Long>(_loc4_);
            _loc8_ = 0;
            while(_loc8_ < _loc4_)
            {
               _loc5_[_loc8_] = Long(this.longCodec.decode(param1));
               _loc8_++;
            }
            _loc9_ = int(this.intCodec.decode(param1));
            _loc10_ = int(this.shortCodec.decode(param1));
            _loc7_ = int(param1.optionalMap.getReadPosition());
            param1.optionalMap.setReadPosition(_loc7_ + _loc10_);
            _loc6_ = new ByteArray();
            param1.reader.readBytes(_loc6_,0,_loc9_);
         }
         return new ClassDispatcherItem(_loc2_,_loc3_,_loc5_,new ProtocolBuffer(_loc6_,_loc6_,param1.optionalMap),_loc7_);
      }
      
      private function decodeResourceData(param1:ProtocolBuffer) : ResourceDispatcherItem
      {
         var _loc4_:Object = null;
         var _loc6_:ICodec = null;
         var _loc2_:ResourceInfo = this.decodeResourceInfo(param1);
         var _loc3_:ResourceRegistry = ResourceRegistry(OSGi.getInstance().getService(ResourceRegistry));
         var _loc5_:Class = _loc3_.getResourceParametersClass(_loc2_.type);
         if(_loc5_ != null)
         {
            _loc6_ = this.protocol.getCodec(new TypeCodecInfo(_loc5_,false));
            _loc4_ = _loc6_.decode(param1);
         }
         return new ResourceDispatcherItem(_loc2_,_loc4_);
      }
      
      private function decodeResourceInfo(param1:ProtocolBuffer) : ResourceInfo
      {
         var _loc6_:int = 0;
         var _loc12_:String = null;
         var _loc13_:int = 0;
         var _loc2_:Long = Long(this.longCodec.decode(param1));
         var _loc3_:int = int(this.shortCodec.decode(param1));
         var _loc4_:Long = Long(this.longCodec.decode(param1));
         var _loc5_:Boolean = Boolean(this.booleanCodec.decode(param1));
         var _loc7_:int = int(this.byteCodec.decode(param1));
         var _loc8_:Vector.<String> = new Vector.<String>(_loc7_);
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            _loc8_[_loc6_] = String(this.simpleStringCodec.decode(param1));
            _loc6_++;
         }
         var _loc9_:int = int(this.shortCodec.decode(param1));
         var _loc10_:Vector.<ResourceFileInfo> = new Vector.<ResourceFileInfo>();
         _loc6_ = 0;
         while(_loc6_ < _loc9_)
         {
            _loc12_ = String(this.simpleStringCodec.decode(param1));
            _loc13_ = int(this.intCodec.decode(param1));
            _loc10_[_loc6_] = new ResourceFileInfo(_loc12_,_loc13_);
            _loc6_++;
         }
         return new ResourceInfo(_loc3_,_loc2_,_loc4_,_loc5_,_loc8_,_loc10_);
      }
      
      private function log(param1:String) : void
      {
         clientLog.log(LOG_CHANNEL,param1);
      }
   }
}

