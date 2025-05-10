package _codec.versions.version1.a3d.geometry
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import flash.utils.ByteArray;
   import versions.version1.a3d.geometry.A3DIndexBuffer;
   
   public class CodecA3DIndexBuffer implements ICodec
   {
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var §_-GN§:ICodec;
      
      private var §_-mz§:ICodec;
      
      public function CodecA3DIndexBuffer()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.§_-GN§ = protocol.getCodec(new TypeCodecInfo(ByteArray,true));
         this.§_-mz§ = protocol.getCodec(new TypeCodecInfo(int,false));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_byteBuffer:ByteArray = this.§_-GN§.decode(protocolBuffer) as ByteArray;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.geometry.A3DIndexBuffer","byteBuffer",value_byteBuffer);
         var value_indexCount:int = int(this.§_-mz§.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.geometry.A3DIndexBuffer","indexCount",value_indexCount);
         return new A3DIndexBuffer(value_byteBuffer,value_indexCount);
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3DIndexBuffer = A3DIndexBuffer(object);
         this.§_-GN§.encode(protocolBuffer,struct.byteBuffer);
         this.§_-mz§.encode(protocolBuffer,struct.indexCount);
      }
   }
}

