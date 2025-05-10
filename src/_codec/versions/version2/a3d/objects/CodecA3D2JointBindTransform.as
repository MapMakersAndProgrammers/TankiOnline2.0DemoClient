package _codec.versions.version2.a3d.objects
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Long;
   import versions.version2.a3d.objects.A3D2JointBindTransform;
   import versions.version2.a3d.objects.A3D2Transform;
   
   public class CodecA3D2JointBindTransform implements ICodec
   {
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var §_-Ov§:ICodec;
      
      private var §_-2o§:ICodec;
      
      public function CodecA3D2JointBindTransform()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.§_-Ov§ = protocol.getCodec(new TypeCodecInfo(A3D2Transform,false));
         this.§_-2o§ = protocol.getCodec(new TypeCodecInfo(Long,false));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_bindPoseTransform:A3D2Transform = this.§_-Ov§.decode(protocolBuffer) as A3D2Transform;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2JointBindTransform","bindPoseTransform",value_bindPoseTransform);
         var value_id:Long = this.§_-2o§.decode(protocolBuffer) as Long;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2JointBindTransform","id",value_id);
         return new A3D2JointBindTransform(value_bindPoseTransform,value_id);
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3D2JointBindTransform = A3D2JointBindTransform(object);
         this.§_-Ov§.encode(protocolBuffer,struct.bindPoseTransform);
         this.§_-2o§.encode(protocolBuffer,struct.id);
      }
   }
}

