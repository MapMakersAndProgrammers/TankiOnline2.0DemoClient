package _codec.platform.client.core.general.spaces.models.dispatcher
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Long;
   import platform.client.core.general.spaces.models.dispatcher.ModelData;
   
   public class CodecModelData implements ICodec
   {
      
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var codec_data:ICodec;
      
      private var codec_id:ICodec;
      
      public function CodecModelData()
      {
         super();
      }
      
      public function init(param1:IProtocol) : void
      {
         this.codec_data = param1.getCodec(new TypeCodecInfo(Object,false));
         this.codec_id = param1.getCodec(new TypeCodecInfo(Long,false));
      }
      
      public function decode(param1:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var _loc2_:Object = this.codec_data.decode(param1) as Object;
         log.log("codec","struct %1 field %2 value %3","platform.client.core.general.spaces.models.dispatcher.ModelData","data",_loc2_);
         var _loc3_:Long = this.codec_id.decode(param1) as Long;
         log.log("codec","struct %1 field %2 value %3","platform.client.core.general.spaces.models.dispatcher.ModelData","id",_loc3_);
         return new ModelData(_loc2_,_loc3_);
      }
      
      public function encode(param1:ProtocolBuffer, param2:Object) : void
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:ModelData = ModelData(param2);
         this.codec_data.encode(param1,_loc3_.data);
         this.codec_id.encode(param1,_loc3_.id);
      }
   }
}

