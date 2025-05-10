package _codec.versions.version1.a3d.objects
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import commons.Id;
   import versions.version1.a3d.objects.A3DSurface;
   
   public class CodecA3DSurface implements ICodec
   {
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var §_-AL§:ICodec;
      
      private var §_-Av§:ICodec;
      
      private var §_-pJ§:ICodec;
      
      public function CodecA3DSurface()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.§_-AL§ = protocol.getCodec(new TypeCodecInfo(int,false));
         this.§_-Av§ = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.§_-pJ§ = protocol.getCodec(new TypeCodecInfo(int,false));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_indexBegin:int = int(this.§_-AL§.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DSurface","indexBegin",value_indexBegin);
         var value_materialId:Id = this.§_-Av§.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DSurface","materialId",value_materialId);
         var value_numTriangles:int = int(this.§_-pJ§.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DSurface","numTriangles",value_numTriangles);
         return new A3DSurface(value_indexBegin,value_materialId,value_numTriangles);
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3DSurface = A3DSurface(object);
         this.§_-AL§.encode(protocolBuffer,struct.indexBegin);
         this.§_-Av§.encode(protocolBuffer,struct.materialId);
         this.§_-pJ§.encode(protocolBuffer,struct.numTriangles);
      }
   }
}

