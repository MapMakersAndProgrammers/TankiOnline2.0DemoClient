package _codec.versions.version2.a3d.objects
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Float;
   import alternativa.types.Long;
   import commons.Id;
   import versions.version2.a3d.objects.A3D2Sprite;
   import versions.version2.a3d.objects.A3D2Transform;
   
   public class CodecA3D2Sprite implements ICodec
   {
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var §_-XZ§:ICodec;
      
      private var §_-Dh§:ICodec;
      
      private var §_-X§:ICodec;
      
      private var §_-2o§:ICodec;
      
      private var §_-Av§:ICodec;
      
      private var §_-XW§:ICodec;
      
      private var §_-Pk§:ICodec;
      
      private var §_-j1§:ICodec;
      
      private var §_-jk§:ICodec;
      
      private var §_-Yz§:ICodec;
      
      private var §_-SJ§:ICodec;
      
      private var §_-S2§:ICodec;
      
      private var §_-h9§:ICodec;
      
      private var §_-pD§:ICodec;
      
      public function CodecA3D2Sprite()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.§_-XZ§ = protocol.getCodec(new TypeCodecInfo(Boolean,false));
         this.§_-Dh§ = protocol.getCodec(new TypeCodecInfo(int,true));
         this.§_-X§ = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.§_-2o§ = protocol.getCodec(new TypeCodecInfo(Long,false));
         this.§_-Av§ = protocol.getCodec(new TypeCodecInfo(Id,false));
         this.§_-XW§ = protocol.getCodec(new TypeCodecInfo(String,true));
         this.§_-Pk§ = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.§_-j1§ = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.§_-jk§ = protocol.getCodec(new TypeCodecInfo(Long,true));
         this.§_-Yz§ = protocol.getCodec(new TypeCodecInfo(Boolean,false));
         this.§_-SJ§ = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.§_-S2§ = protocol.getCodec(new TypeCodecInfo(A3D2Transform,true));
         this.§_-h9§ = protocol.getCodec(new TypeCodecInfo(Boolean,false));
         this.§_-pD§ = protocol.getCodec(new TypeCodecInfo(Float,false));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_alwaysOnTop:Boolean = Boolean(this.§_-XZ§.decode(protocolBuffer) as Boolean);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","alwaysOnTop",value_alwaysOnTop);
         var value_boundBoxId:int = int(this.§_-Dh§.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","boundBoxId",value_boundBoxId);
         var value_height:Number = Number(this.§_-X§.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","height",value_height);
         var value_id:Long = this.§_-2o§.decode(protocolBuffer) as Long;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","id",value_id);
         var value_materialId:Id = this.§_-Av§.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","materialId",value_materialId);
         var value_name:String = this.§_-XW§.decode(protocolBuffer) as String;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","name",value_name);
         var value_originX:Number = Number(this.§_-Pk§.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","originX",value_originX);
         var value_originY:Number = Number(this.§_-j1§.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","originY",value_originY);
         var value_parentId:Long = this.§_-jk§.decode(protocolBuffer) as Long;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","parentId",value_parentId);
         var value_perspectiveScale:Boolean = Boolean(this.§_-Yz§.decode(protocolBuffer) as Boolean);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","perspectiveScale",value_perspectiveScale);
         var value_rotation:Number = Number(this.§_-SJ§.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","rotation",value_rotation);
         var value_transform:A3D2Transform = this.§_-S2§.decode(protocolBuffer) as A3D2Transform;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","transform",value_transform);
         var value_visible:Boolean = Boolean(this.§_-h9§.decode(protocolBuffer) as Boolean);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","visible",value_visible);
         var value_width:Number = Number(this.§_-pD§.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","width",value_width);
         return new A3D2Sprite(value_alwaysOnTop,value_boundBoxId,value_height,value_id,value_materialId,value_name,value_originX,value_originY,value_parentId,value_perspectiveScale,value_rotation,value_transform,value_visible,value_width);
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3D2Sprite = A3D2Sprite(object);
         this.§_-XZ§.encode(protocolBuffer,struct.alwaysOnTop);
         this.§_-Dh§.encode(protocolBuffer,struct.boundBoxId);
         this.§_-X§.encode(protocolBuffer,struct.height);
         this.§_-2o§.encode(protocolBuffer,struct.id);
         this.§_-Av§.encode(protocolBuffer,struct.materialId);
         this.§_-XW§.encode(protocolBuffer,struct.name);
         this.§_-Pk§.encode(protocolBuffer,struct.originX);
         this.§_-j1§.encode(protocolBuffer,struct.originY);
         this.§_-jk§.encode(protocolBuffer,struct.parentId);
         this.§_-Yz§.encode(protocolBuffer,struct.perspectiveScale);
         this.§_-SJ§.encode(protocolBuffer,struct.rotation);
         this.§_-S2§.encode(protocolBuffer,struct.transform);
         this.§_-h9§.encode(protocolBuffer,struct.visible);
         this.§_-pD§.encode(protocolBuffer,struct.width);
      }
   }
}

