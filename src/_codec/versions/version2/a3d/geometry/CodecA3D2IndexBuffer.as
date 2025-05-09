package _codec.versions.version2.a3d.geometry
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import flash.utils.ByteArray;
   import versions.version2.a3d.geometry.A3D2IndexBuffer;
   
   public class CodecA3D2IndexBuffer implements ICodec
   {
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var var_240:ICodec;
      
      private var var_243:ICodec;
      
      private var var_308:ICodec;
      
      public function CodecA3D2IndexBuffer()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.var_240 = protocol.getCodec(new TypeCodecInfo(ByteArray,false));
         this.var_243 = protocol.getCodec(new TypeCodecInfo(int,false));
         this.var_308 = protocol.getCodec(new TypeCodecInfo(int,false));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_byteBuffer:ByteArray = this.var_240.decode(protocolBuffer) as ByteArray;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.geometry.A3D2IndexBuffer","byteBuffer",value_byteBuffer);
         var value_id:int = int(this.var_243.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.geometry.A3D2IndexBuffer","id",value_id);
         var value_indexCount:int = int(this.var_308.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.geometry.A3D2IndexBuffer","indexCount",value_indexCount);
         return new A3D2IndexBuffer(value_byteBuffer,value_id,value_indexCount);
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3D2IndexBuffer = A3D2IndexBuffer(object);
         this.var_240.encode(protocolBuffer,struct.byteBuffer);
         this.var_243.encode(protocolBuffer,struct.id);
         this.var_308.encode(protocolBuffer,struct.indexCount);
      }
   }
}

