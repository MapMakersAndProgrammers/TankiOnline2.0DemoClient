package _codec.versions.version1.a3d.geometry
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.CollectionCodecInfo;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Byte;
   import alternativa.types.UShort;
   import flash.utils.ByteArray;
   import versions.version1.a3d.geometry.A3DVertexBuffer;
   
   public class CodecA3DVertexBuffer implements ICodec
   {
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var name_Lj:ICodec;
      
      private var name_GN:ICodec;
      
      private var name_hc:ICodec;
      
      public function CodecA3DVertexBuffer()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.name_Lj = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Byte,false),true,1));
         this.name_GN = protocol.getCodec(new TypeCodecInfo(ByteArray,true));
         this.name_hc = protocol.getCodec(new TypeCodecInfo(UShort,false));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_attributes:Vector.<int> = this.name_Lj.decode(protocolBuffer) as Vector.<int>;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.geometry.A3DVertexBuffer","attributes",value_attributes);
         var value_byteBuffer:ByteArray = this.name_GN.decode(protocolBuffer) as ByteArray;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.geometry.A3DVertexBuffer","byteBuffer",value_byteBuffer);
         var value_vertexCount:uint = uint(this.name_hc.decode(protocolBuffer) as uint);
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.geometry.A3DVertexBuffer","vertexCount",value_vertexCount);
         return new A3DVertexBuffer(value_attributes,value_byteBuffer,value_vertexCount);
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3DVertexBuffer = A3DVertexBuffer(object);
         this.name_Lj.encode(protocolBuffer,struct.attributes);
         this.name_GN.encode(protocolBuffer,struct.byteBuffer);
         this.name_hc.encode(protocolBuffer,struct.vertexCount);
      }
   }
}

