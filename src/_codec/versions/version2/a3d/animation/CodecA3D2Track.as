package _codec.versions.version2.a3d.animation
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.CollectionCodecInfo;
   import alternativa.protocol.info.TypeCodecInfo;
   import versions.version2.a3d.animation.A3D2Keyframe;
   import versions.version2.a3d.animation.A3D2Track;
   
   public class CodecA3D2Track implements ICodec
   {
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var var_243:ICodec;
      
      private var var_394:ICodec;
      
      private var var_393:ICodec;
      
      public function CodecA3D2Track()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.var_243 = protocol.getCodec(new TypeCodecInfo(int,false));
         this.var_394 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Keyframe,false),false,1));
         this.var_393 = protocol.getCodec(new TypeCodecInfo(String,false));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_id:int = int(this.var_243.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.animation.A3D2Track","id",value_id);
         var value_keyframes:Vector.<A3D2Keyframe> = this.var_394.decode(protocolBuffer) as Vector.<A3D2Keyframe>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.animation.A3D2Track","keyframes",value_keyframes);
         var value_objectName:String = this.var_393.decode(protocolBuffer) as String;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.animation.A3D2Track","objectName",value_objectName);
         return new A3D2Track(value_id,value_keyframes,value_objectName);
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3D2Track = A3D2Track(object);
         this.var_243.encode(protocolBuffer,struct.id);
         this.var_394.encode(protocolBuffer,struct.keyframes);
         this.var_393.encode(protocolBuffer,struct.objectName);
      }
   }
}

