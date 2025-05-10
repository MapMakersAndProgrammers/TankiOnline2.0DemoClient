package _codec.versions.version1.a3d.objects
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.CollectionCodecInfo;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Float;
   import commons.Id;
   import versions.version1.a3d.objects.A3DBox;
   
   public class CodecA3DBox implements ICodec
   {
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var name_pM:ICodec;
      
      private var name_2o:ICodec;
      
      public function CodecA3DBox()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.name_pM = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Float,false),true,1));
         this.name_2o = protocol.getCodec(new TypeCodecInfo(Id,true));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_box:Vector.<Number> = this.name_pM.decode(protocolBuffer) as Vector.<Number>;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DBox","box",value_box);
         var value_id:Id = this.name_2o.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DBox","id",value_id);
         return new A3DBox(value_box,value_id);
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3DBox = A3DBox(object);
         this.name_pM.encode(protocolBuffer,struct.box);
         this.name_2o.encode(protocolBuffer,struct.id);
      }
   }
}

