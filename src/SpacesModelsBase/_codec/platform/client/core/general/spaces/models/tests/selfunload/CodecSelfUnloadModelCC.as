package _codec.platform.client.core.general.spaces.models.tests.selfunload
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Long;
   import platform.client.core.general.spaces.models.tests.selfunload.SelfUnloadModelCC;
   
   public class CodecSelfUnloadModelCC implements ICodec
   {
      
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var codec_ind:ICodec;
      
      private var codec_str:ICodec;
      
      public function CodecSelfUnloadModelCC()
      {
         super();
      }
      
      public function init(param1:IProtocol) : void
      {
         this.codec_ind = param1.getCodec(new TypeCodecInfo(Long,false));
         this.codec_str = param1.getCodec(new TypeCodecInfo(String,false));
      }
      
      public function decode(param1:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var _loc2_:Long = this.codec_ind.decode(param1) as Long;
         log.log("codec","struct %1 field %2 value %3","platform.client.core.general.spaces.models.tests.selfunload.SelfUnloadModelCC","ind",_loc2_);
         var _loc3_:String = this.codec_str.decode(param1) as String;
         log.log("codec","struct %1 field %2 value %3","platform.client.core.general.spaces.models.tests.selfunload.SelfUnloadModelCC","str",_loc3_);
         return new SelfUnloadModelCC(_loc2_,_loc3_);
      }
      
      public function encode(param1:ProtocolBuffer, param2:Object) : void
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:SelfUnloadModelCC = SelfUnloadModelCC(param2);
         this.codec_ind.encode(param1,_loc3_.ind);
         this.codec_str.encode(param1,_loc3_.str);
      }
   }
}

