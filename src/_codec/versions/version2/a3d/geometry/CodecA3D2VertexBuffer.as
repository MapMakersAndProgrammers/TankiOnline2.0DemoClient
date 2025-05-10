package _codec.versions.version2.a3d.geometry
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.CollectionCodecInfo;
   import alternativa.protocol.info.EnumCodecInfo;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.UShort;
   import flash.utils.ByteArray;
   import versions.version2.a3d.geometry.A3D2VertexAttributes;
   import versions.version2.a3d.geometry.A3D2VertexBuffer;
   
   public class CodecA3D2VertexBuffer implements ICodec
   {
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var name_Lj:ICodec;
      
      private var name_GN:ICodec;
      
      private var name_2o:ICodec;
      
      private var name_hc:ICodec;
      
      public function CodecA3D2VertexBuffer()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.name_Lj = protocol.getCodec(new CollectionCodecInfo(new EnumCodecInfo(A3D2VertexAttributes,false),false,1));
         this.name_GN = protocol.getCodec(new TypeCodecInfo(ByteArray,false));
         this.name_2o = protocol.getCodec(new TypeCodecInfo(int,false));
         this.name_hc = protocol.getCodec(new TypeCodecInfo(UShort,false));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_attributes:Vector.<A3D2VertexAttributes> = this.name_Lj.decode(protocolBuffer) as Vector.<A3D2VertexAttributes>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.geometry.A3D2VertexBuffer","attributes",value_attributes);
         var value_byteBuffer:ByteArray = this.name_GN.decode(protocolBuffer) as ByteArray;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.geometry.A3D2VertexBuffer","byteBuffer",value_byteBuffer);
         var value_id:int = int(this.name_2o.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.geometry.A3D2VertexBuffer","id",value_id);
         var value_vertexCount:uint = uint(this.name_hc.decode(protocolBuffer) as uint);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.geometry.A3D2VertexBuffer","vertexCount",value_vertexCount);
         return new A3D2VertexBuffer(value_attributes,value_byteBuffer,value_id,value_vertexCount);
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3D2VertexBuffer = A3D2VertexBuffer(object);
         this.name_Lj.encode(protocolBuffer,struct.attributes);
         this.name_GN.encode(protocolBuffer,struct.byteBuffer);
         this.name_2o.encode(protocolBuffer,struct.id);
         this.name_hc.encode(protocolBuffer,struct.vertexCount);
      }
   }
}

