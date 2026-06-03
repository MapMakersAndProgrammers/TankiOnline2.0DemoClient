package _codec.platform.client.core.general.spaces.models.quadrosimple
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.CollectionCodecInfo;
   import alternativa.protocol.info.TypeCodecInfo;
   import platform.client.core.general.spaces.models.quadrosimple.QuadroSimpleModelCC;
   import platform.client.fp10.core.resource.types.ImageResource;
   
   public class CodecQuadroSimpleModelCC implements ICodec
   {
      
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var codec_imageType:ICodec;
      
      private var codec_listString:ICodec;
      
      private var codec_name:ICodec;
      
      public function CodecQuadroSimpleModelCC()
      {
         super();
      }
      
      public function init(param1:IProtocol) : void
      {
         this.codec_imageType = param1.getCodec(new TypeCodecInfo(ImageResource,false));
         this.codec_listString = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(String,false),false,1));
         this.codec_name = param1.getCodec(new TypeCodecInfo(String,false));
      }
      
      public function decode(param1:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var _loc2_:ImageResource = this.codec_imageType.decode(param1) as ImageResource;
         log.log("codec","struct %1 field %2 value %3","platform.client.core.general.spaces.models.quadrosimple.QuadroSimpleModelCC","imageType",_loc2_);
         var _loc3_:Vector.<String> = this.codec_listString.decode(param1) as Vector.<String>;
         log.log("codec","struct %1 field %2 value %3","platform.client.core.general.spaces.models.quadrosimple.QuadroSimpleModelCC","listString",_loc3_);
         var _loc4_:String = this.codec_name.decode(param1) as String;
         log.log("codec","struct %1 field %2 value %3","platform.client.core.general.spaces.models.quadrosimple.QuadroSimpleModelCC","name",_loc4_);
         return new QuadroSimpleModelCC(_loc2_,_loc3_,_loc4_);
      }
      
      public function encode(param1:ProtocolBuffer, param2:Object) : void
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:QuadroSimpleModelCC = QuadroSimpleModelCC(param2);
         this.codec_imageType.encode(param1,_loc3_.imageType);
         this.codec_listString.encode(param1,_loc3_.listString);
         this.codec_name.encode(param1,_loc3_.name);
      }
   }
}

