package _codec.versions.version2.a3d.objects
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.CollectionCodecInfo;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Float;
   import alternativa.types.Long;
   import versions.version2.a3d.objects.A3D2Decal;
   import versions.version2.a3d.objects.A3D2Surface;
   import versions.version2.a3d.objects.A3D2Transform;
   
   public class CodecA3D2Decal implements ICodec
   {
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var §_-Dh§:ICodec;
      
      private var §_-2o§:ICodec;
      
      private var §_-PO§:ICodec;
      
      private var §_-XW§:ICodec;
      
      private var §_-Zb§:ICodec;
      
      private var §_-jk§:ICodec;
      
      private var §_-Qr§:ICodec;
      
      private var §_-S2§:ICodec;
      
      private var §_-U9§:ICodec;
      
      private var §_-h9§:ICodec;
      
      public function CodecA3D2Decal()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.§_-Dh§ = protocol.getCodec(new TypeCodecInfo(int,true));
         this.§_-2o§ = protocol.getCodec(new TypeCodecInfo(Long,false));
         this.§_-PO§ = protocol.getCodec(new TypeCodecInfo(int,false));
         this.§_-XW§ = protocol.getCodec(new TypeCodecInfo(String,true));
         this.§_-Zb§ = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.§_-jk§ = protocol.getCodec(new TypeCodecInfo(Long,true));
         this.§_-Qr§ = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Surface,false),false,1));
         this.§_-S2§ = protocol.getCodec(new TypeCodecInfo(A3D2Transform,true));
         this.§_-U9§ = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(int,false),false,1));
         this.§_-h9§ = protocol.getCodec(new TypeCodecInfo(Boolean,false));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_boundBoxId:int = int(this.§_-Dh§.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Decal","boundBoxId",value_boundBoxId);
         var value_id:Long = this.§_-2o§.decode(protocolBuffer) as Long;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Decal","id",value_id);
         var value_indexBufferId:int = int(this.§_-PO§.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Decal","indexBufferId",value_indexBufferId);
         var value_name:String = this.§_-XW§.decode(protocolBuffer) as String;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Decal","name",value_name);
         var value_offset:Number = Number(this.§_-Zb§.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Decal","offset",value_offset);
         var value_parentId:Long = this.§_-jk§.decode(protocolBuffer) as Long;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Decal","parentId",value_parentId);
         var value_surfaces:Vector.<A3D2Surface> = this.§_-Qr§.decode(protocolBuffer) as Vector.<A3D2Surface>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Decal","surfaces",value_surfaces);
         var value_transform:A3D2Transform = this.§_-S2§.decode(protocolBuffer) as A3D2Transform;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Decal","transform",value_transform);
         var value_vertexBuffers:Vector.<int> = this.§_-U9§.decode(protocolBuffer) as Vector.<int>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Decal","vertexBuffers",value_vertexBuffers);
         var value_visible:Boolean = Boolean(this.§_-h9§.decode(protocolBuffer) as Boolean);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Decal","visible",value_visible);
         return new A3D2Decal(value_boundBoxId,value_id,value_indexBufferId,value_name,value_offset,value_parentId,value_surfaces,value_transform,value_vertexBuffers,value_visible);
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3D2Decal = A3D2Decal(object);
         this.§_-Dh§.encode(protocolBuffer,struct.boundBoxId);
         this.§_-2o§.encode(protocolBuffer,struct.id);
         this.§_-PO§.encode(protocolBuffer,struct.indexBufferId);
         this.§_-XW§.encode(protocolBuffer,struct.name);
         this.§_-Zb§.encode(protocolBuffer,struct.offset);
         this.§_-jk§.encode(protocolBuffer,struct.parentId);
         this.§_-Qr§.encode(protocolBuffer,struct.surfaces);
         this.§_-S2§.encode(protocolBuffer,struct.transform);
         this.§_-U9§.encode(protocolBuffer,struct.vertexBuffers);
         this.§_-h9§.encode(protocolBuffer,struct.visible);
      }
   }
}

