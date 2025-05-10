package _codec.versions.version1.a3d.geometry
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.CollectionCodecInfo;
   import alternativa.protocol.info.TypeCodecInfo;
   import commons.Id;
   import versions.version1.a3d.geometry.A3DGeometry;
   import versions.version1.a3d.geometry.A3DIndexBuffer;
   import versions.version1.a3d.geometry.A3DVertexBuffer;
   
   public class CodecA3DGeometry implements ICodec
   {
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var §_-2o§:ICodec;
      
      private var §_-XF§:ICodec;
      
      private var §_-U9§:ICodec;
      
      public function CodecA3DGeometry()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.§_-2o§ = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.§_-XF§ = protocol.getCodec(new TypeCodecInfo(A3DIndexBuffer,true));
         this.§_-U9§ = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3DVertexBuffer,false),true,1));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_id:Id = this.§_-2o§.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.geometry.A3DGeometry","id",value_id);
         var value_indexBuffer:A3DIndexBuffer = this.§_-XF§.decode(protocolBuffer) as A3DIndexBuffer;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.geometry.A3DGeometry","indexBuffer",value_indexBuffer);
         var value_vertexBuffers:Vector.<A3DVertexBuffer> = this.§_-U9§.decode(protocolBuffer) as Vector.<A3DVertexBuffer>;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.geometry.A3DGeometry","vertexBuffers",value_vertexBuffers);
         return new A3DGeometry(value_id,value_indexBuffer,value_vertexBuffers);
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3DGeometry = A3DGeometry(object);
         this.§_-2o§.encode(protocolBuffer,struct.id);
         this.§_-XF§.encode(protocolBuffer,struct.indexBuffer);
         this.§_-U9§.encode(protocolBuffer,struct.vertexBuffers);
      }
   }
}

