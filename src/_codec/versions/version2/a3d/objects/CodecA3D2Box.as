package _codec.versions.version2.a3d.objects
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.CollectionCodecInfo;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Float;
   import versions.version2.a3d.objects.A3D2Box;
   
   public class CodecA3D2Box implements ICodec
   {
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var var_284:ICodec;
      
      private var var_243:ICodec;
      
      public function CodecA3D2Box()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.var_284 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Float,false),false,1));
         this.var_243 = protocol.getCodec(new TypeCodecInfo(int,false));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_box:Vector.<Number> = this.var_284.decode(protocolBuffer) as Vector.<Number>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Box","box",value_box);
         var value_id:int = int(this.var_243.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Box","id",value_id);
         return new A3D2Box(value_box,value_id);
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3D2Box = A3D2Box(object);
         this.var_284.encode(protocolBuffer,struct.box);
         this.var_243.encode(protocolBuffer,struct.id);
      }
   }
}

