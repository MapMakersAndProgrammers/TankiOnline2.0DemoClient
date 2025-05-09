package _codec.versions.version2.a3d.objects
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Long;
   import versions.version2.a3d.objects.A3D2Object;
   import versions.version2.a3d.objects.A3D2Transform;
   
   public class CodecA3D2Object implements ICodec
   {
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var §_-Dh§:ICodec;
      
      private var §_-2o§:ICodec;
      
      private var §_-XW§:ICodec;
      
      private var §_-jk§:ICodec;
      
      private var §_-S2§:ICodec;
      
      private var §_-h9§:ICodec;
      
      public function CodecA3D2Object()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.§_-Dh§ = protocol.getCodec(new TypeCodecInfo(int,true));
         this.§_-2o§ = protocol.getCodec(new TypeCodecInfo(Long,false));
         this.§_-XW§ = protocol.getCodec(new TypeCodecInfo(String,true));
         this.§_-jk§ = protocol.getCodec(new TypeCodecInfo(Long,true));
         this.§_-S2§ = protocol.getCodec(new TypeCodecInfo(A3D2Transform,true));
         this.§_-h9§ = protocol.getCodec(new TypeCodecInfo(Boolean,false));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_boundBoxId:int = int(this.§_-Dh§.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Object","boundBoxId",value_boundBoxId);
         var value_id:Long = this.§_-2o§.decode(protocolBuffer) as Long;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Object","id",value_id);
         var value_name:String = this.§_-XW§.decode(protocolBuffer) as String;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Object","name",value_name);
         var value_parentId:Long = this.§_-jk§.decode(protocolBuffer) as Long;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Object","parentId",value_parentId);
         var value_transform:A3D2Transform = this.§_-S2§.decode(protocolBuffer) as A3D2Transform;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Object","transform",value_transform);
         var value_visible:Boolean = Boolean(this.§_-h9§.decode(protocolBuffer) as Boolean);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Object","visible",value_visible);
         return new A3D2Object(value_boundBoxId,value_id,value_name,value_parentId,value_transform,value_visible);
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3D2Object = A3D2Object(object);
         this.§_-Dh§.encode(protocolBuffer,struct.boundBoxId);
         this.§_-2o§.encode(protocolBuffer,struct.id);
         this.§_-XW§.encode(protocolBuffer,struct.name);
         this.§_-jk§.encode(protocolBuffer,struct.parentId);
         this.§_-S2§.encode(protocolBuffer,struct.transform);
         this.§_-h9§.encode(protocolBuffer,struct.visible);
      }
   }
}

