package _codec.versions.version1.a3d.objects
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import commons.A3DMatrix;
   import versions.version1.a3d.objects.A3DTransformation;
   
   public class CodecA3DTransformation implements ICodec
   {
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var name_dG:ICodec;
      
      public function CodecA3DTransformation()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.name_dG = protocol.getCodec(new TypeCodecInfo(A3DMatrix,true));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_matrix:A3DMatrix = this.name_dG.decode(protocolBuffer) as A3DMatrix;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DTransformation","matrix",value_matrix);
         return new A3DTransformation(value_matrix);
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3DTransformation = A3DTransformation(object);
         this.name_dG.encode(protocolBuffer,struct.matrix);
      }
   }
}

