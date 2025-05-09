package _codec.versions.version2.a3d.objects
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import commons.A3DMatrix;
   import versions.version2.a3d.objects.A3D2Transform;
   
   public class CodecA3D2Transform implements ICodec
   {
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var var_411:ICodec;
      
      public function CodecA3D2Transform()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.var_411 = protocol.getCodec(new TypeCodecInfo(A3DMatrix,false));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_matrix:A3DMatrix = this.var_411.decode(protocolBuffer) as A3DMatrix;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Transform","matrix",value_matrix);
         return new A3D2Transform(value_matrix);
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3D2Transform = A3D2Transform(object);
         this.var_411.encode(protocolBuffer,struct.matrix);
      }
   }
}

