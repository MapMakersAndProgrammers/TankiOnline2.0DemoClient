package _codec.platform.client.core.general.spaces.models.quadro
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.CollectionCodecInfo;
   import alternativa.protocol.info.TypeCodecInfo;
   import platform.client.core.general.spaces.models.quadro.Test;
   
   public class CodecTest implements ICodec
   {
      
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var codec_listString:ICodec;
      
      private var codec_value:ICodec;
      
      private var codec_valueNull:ICodec;
      
      public function CodecTest()
      {
         super();
      }
      
      public function init(param1:IProtocol) : void
      {
         this.codec_listString = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(String,false),false,1));
         this.codec_value = param1.getCodec(new TypeCodecInfo(int,false));
         this.codec_valueNull = param1.getCodec(new TypeCodecInfo(int,false));
      }
      
      public function decode(param1:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var _loc2_:Vector.<String> = this.codec_listString.decode(param1) as Vector.<String>;
         log.log("codec","struct %1 field %2 value %3","platform.client.core.general.spaces.models.quadro.Test","listString",_loc2_);
         var _loc3_:int = this.codec_value.decode(param1) as int;
         log.log("codec","struct %1 field %2 value %3","platform.client.core.general.spaces.models.quadro.Test","value",_loc3_);
         var _loc4_:int = this.codec_valueNull.decode(param1) as int;
         log.log("codec","struct %1 field %2 value %3","platform.client.core.general.spaces.models.quadro.Test","valueNull",_loc4_);
         return new Test(_loc2_,_loc3_,_loc4_);
      }
      
      public function encode(param1:ProtocolBuffer, param2:Object) : void
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:Test = Test(param2);
         this.codec_listString.encode(param1,_loc3_.listString);
         this.codec_value.encode(param1,_loc3_.value);
         this.codec_valueNull.encode(param1,_loc3_.valueNull);
      }
   }
}

