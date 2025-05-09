package _codec.versions.version2.a3d.animation
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.CollectionCodecInfo;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Long;
   import versions.version2.a3d.animation.A3D2AnimationClip;
   
   public class CodecA3D2AnimationClip implements ICodec
   {
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var var_243:ICodec;
      
      private var var_304:ICodec;
      
      private var var_251:ICodec;
      
      private var var_305:ICodec;
      
      private var var_306:ICodec;
      
      public function CodecA3D2AnimationClip()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.var_243 = protocol.getCodec(new TypeCodecInfo(int,false));
         this.var_304 = protocol.getCodec(new TypeCodecInfo(Boolean,false));
         this.var_251 = protocol.getCodec(new TypeCodecInfo(String,true));
         this.var_305 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,false),true,1));
         this.var_306 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(int,false),false,1));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_id:int = int(this.var_243.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.animation.A3D2AnimationClip","id",value_id);
         var value_loop:Boolean = Boolean(this.var_304.decode(protocolBuffer) as Boolean);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.animation.A3D2AnimationClip","loop",value_loop);
         var value_name:String = this.var_251.decode(protocolBuffer) as String;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.animation.A3D2AnimationClip","name",value_name);
         var value_objectIDs:Vector.<Long> = this.var_305.decode(protocolBuffer) as Vector.<Long>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.animation.A3D2AnimationClip","objectIDs",value_objectIDs);
         var value_tracks:Vector.<int> = this.var_306.decode(protocolBuffer) as Vector.<int>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.animation.A3D2AnimationClip","tracks",value_tracks);
         return new A3D2AnimationClip(value_id,value_loop,value_name,value_objectIDs,value_tracks);
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3D2AnimationClip = A3D2AnimationClip(object);
         this.var_243.encode(protocolBuffer,struct.id);
         this.var_304.encode(protocolBuffer,struct.loop);
         this.var_251.encode(protocolBuffer,struct.name);
         this.var_305.encode(protocolBuffer,struct.objectIDs);
         this.var_306.encode(protocolBuffer,struct.tracks);
      }
   }
}

