package _codec.versions.version2.a3d.objects
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Long;
   import versions.version2.a3d.objects.A3D2Joint;
   import versions.version2.a3d.objects.A3D2Transform;
   
   public class CodecA3D2Joint implements ICodec
   {
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var name_Dh:ICodec;
      
      private var name_2o:ICodec;
      
      private var name_XW:ICodec;
      
      private var name_jk:ICodec;
      
      private var name_S2:ICodec;
      
      private var name_h9:ICodec;
      
      public function CodecA3D2Joint()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.name_Dh = protocol.getCodec(new TypeCodecInfo(int,true));
         this.name_2o = protocol.getCodec(new TypeCodecInfo(Long,false));
         this.name_XW = protocol.getCodec(new TypeCodecInfo(String,true));
         this.name_jk = protocol.getCodec(new TypeCodecInfo(Long,true));
         this.name_S2 = protocol.getCodec(new TypeCodecInfo(A3D2Transform,true));
         this.name_h9 = protocol.getCodec(new TypeCodecInfo(Boolean,false));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_boundBoxId:int = int(this.name_Dh.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Joint","boundBoxId",value_boundBoxId);
         var value_id:Long = this.name_2o.decode(protocolBuffer) as Long;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Joint","id",value_id);
         var value_name:String = this.name_XW.decode(protocolBuffer) as String;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Joint","name",value_name);
         var value_parentId:Long = this.name_jk.decode(protocolBuffer) as Long;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Joint","parentId",value_parentId);
         var value_transform:A3D2Transform = this.name_S2.decode(protocolBuffer) as A3D2Transform;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Joint","transform",value_transform);
         var value_visible:Boolean = Boolean(this.name_h9.decode(protocolBuffer) as Boolean);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Joint","visible",value_visible);
         return new A3D2Joint(value_boundBoxId,value_id,value_name,value_parentId,value_transform,value_visible);
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3D2Joint = A3D2Joint(object);
         this.name_Dh.encode(protocolBuffer,struct.boundBoxId);
         this.name_2o.encode(protocolBuffer,struct.id);
         this.name_XW.encode(protocolBuffer,struct.name);
         this.name_jk.encode(protocolBuffer,struct.parentId);
         this.name_S2.encode(protocolBuffer,struct.transform);
         this.name_h9.encode(protocolBuffer,struct.visible);
      }
   }
}

