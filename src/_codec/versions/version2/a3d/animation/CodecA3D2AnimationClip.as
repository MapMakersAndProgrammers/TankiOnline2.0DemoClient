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
      
      private var §_-2o§:ICodec;
      
      private var §_-HX§:ICodec;
      
      private var §_-XW§:ICodec;
      
      private var §_-Td§:ICodec;
      
      private var §_-Z-§:ICodec;
      
      public function CodecA3D2AnimationClip()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.§_-2o§ = protocol.getCodec(new TypeCodecInfo(int,false));
         this.§_-HX§ = protocol.getCodec(new TypeCodecInfo(Boolean,false));
         this.§_-XW§ = protocol.getCodec(new TypeCodecInfo(String,true));
         this.§_-Td§ = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,false),true,1));
         this.§_-Z-§ = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(int,false),false,1));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_id:int = int(this.§_-2o§.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.animation.A3D2AnimationClip","id",value_id);
         var value_loop:Boolean = Boolean(this.§_-HX§.decode(protocolBuffer) as Boolean);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.animation.A3D2AnimationClip","loop",value_loop);
         var value_name:String = this.§_-XW§.decode(protocolBuffer) as String;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.animation.A3D2AnimationClip","name",value_name);
         var value_objectIDs:Vector.<Long> = this.§_-Td§.decode(protocolBuffer) as Vector.<Long>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.animation.A3D2AnimationClip","objectIDs",value_objectIDs);
         var value_tracks:Vector.<int> = this.§_-Z-§.decode(protocolBuffer) as Vector.<int>;
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
         this.§_-2o§.encode(protocolBuffer,struct.id);
         this.§_-HX§.encode(protocolBuffer,struct.loop);
         this.§_-XW§.encode(protocolBuffer,struct.name);
         this.§_-Td§.encode(protocolBuffer,struct.objectIDs);
         this.§_-Z-§.encode(protocolBuffer,struct.tracks);
      }
   }
}

