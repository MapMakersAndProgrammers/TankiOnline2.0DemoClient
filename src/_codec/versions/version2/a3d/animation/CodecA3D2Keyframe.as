package _codec.versions.version2.a3d.animation
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Float;
   import versions.version2.a3d.animation.A3D2Keyframe;
   import versions.version2.a3d.objects.A3D2Transform;
   
   public class CodecA3D2Keyframe implements ICodec
   {
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var var_395:ICodec;
      
      private var var_249:ICodec;
      
      public function CodecA3D2Keyframe()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.var_395 = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.var_249 = protocol.getCodec(new TypeCodecInfo(A3D2Transform,false));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_time:Number = Number(this.var_395.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.animation.A3D2Keyframe","time",value_time);
         var value_transform:A3D2Transform = this.var_249.decode(protocolBuffer) as A3D2Transform;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.animation.A3D2Keyframe","transform",value_transform);
         return new A3D2Keyframe(value_time,value_transform);
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3D2Keyframe = A3D2Keyframe(object);
         this.var_395.encode(protocolBuffer,struct.time);
         this.var_249.encode(protocolBuffer,struct.transform);
      }
   }
}

