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
      
      private var name_XZ:ICodec;
      
      private var name_Dh:ICodec;
      
      private var name_X:ICodec;
      
      private var name_2o:ICodec;
      
      private var name_Av:ICodec;
      
      private var name_XW:ICodec;
      
      private var name_Pk:ICodec;
      
      private var name_j1:ICodec;
      
      private var name_jk:ICodec;
      
      private var name_Yz:ICodec;
      
      private var name_SJ:ICodec;
      
      private var name_S2:ICodec;
      
      private var name_h9:ICodec;
      
      private var name_pD:ICodec;
      
      public function CodecA3D2Sprite()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.name_XZ = protocol.getCodec(new TypeCodecInfo(Boolean,false));
         this.name_Dh = protocol.getCodec(new TypeCodecInfo(int,true));
         this.name_X = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.name_2o = protocol.getCodec(new TypeCodecInfo(Long,false));
         this.name_Av = protocol.getCodec(new TypeCodecInfo(Id,false));
         this.name_XW = protocol.getCodec(new TypeCodecInfo(String,true));
         this.name_Pk = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.name_j1 = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.name_jk = protocol.getCodec(new TypeCodecInfo(Long,true));
         this.name_Yz = protocol.getCodec(new TypeCodecInfo(Boolean,false));
         this.name_SJ = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.name_S2 = protocol.getCodec(new TypeCodecInfo(A3D2Transform,true));
         this.name_h9 = protocol.getCodec(new TypeCodecInfo(Boolean,false));
         this.name_pD = protocol.getCodec(new TypeCodecInfo(Float,false));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_alwaysOnTop:Boolean = Boolean(this.name_XZ.decode(protocolBuffer) as Boolean);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","alwaysOnTop",value_alwaysOnTop);
         var value_boundBoxId:int = int(this.name_Dh.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","boundBoxId",value_boundBoxId);
         var value_height:Number = Number(this.name_X.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","height",value_height);
         var value_id:Long = this.name_2o.decode(protocolBuffer) as Long;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","id",value_id);
         var value_materialId:Id = this.name_Av.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","materialId",value_materialId);
         var value_name:String = this.name_XW.decode(protocolBuffer) as String;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","name",value_name);
         var value_originX:Number = Number(this.name_Pk.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","originX",value_originX);
         var value_originY:Number = Number(this.name_j1.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","originY",value_originY);
         var value_parentId:Long = this.name_jk.decode(protocolBuffer) as Long;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","parentId",value_parentId);
         var value_perspectiveScale:Boolean = Boolean(this.name_Yz.decode(protocolBuffer) as Boolean);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","perspectiveScale",value_perspectiveScale);
         var value_rotation:Number = Number(this.name_SJ.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","rotation",value_rotation);
         var value_transform:A3D2Transform = this.name_S2.decode(protocolBuffer) as A3D2Transform;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","transform",value_transform);
         var value_visible:Boolean = Boolean(this.name_h9.decode(protocolBuffer) as Boolean);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","visible",value_visible);
         var value_width:Number = Number(this.name_pD.decode(protocolBuffer) as Number);
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
         this.name_XZ.encode(protocolBuffer,struct.alwaysOnTop);
         this.name_Dh.encode(protocolBuffer,struct.boundBoxId);
         this.name_X.encode(protocolBuffer,struct.height);
         this.name_2o.encode(protocolBuffer,struct.id);
         this.name_Av.encode(protocolBuffer,struct.materialId);
         this.name_XW.encode(protocolBuffer,struct.name);
         this.name_Pk.encode(protocolBuffer,struct.originX);
         this.name_j1.encode(protocolBuffer,struct.originY);
         this.name_jk.encode(protocolBuffer,struct.parentId);
         this.name_Yz.encode(protocolBuffer,struct.perspectiveScale);
         this.name_SJ.encode(protocolBuffer,struct.rotation);
         this.name_S2.encode(protocolBuffer,struct.transform);
         this.name_h9.encode(protocolBuffer,struct.visible);
         this.name_pD.encode(protocolBuffer,struct.width);
      }
   }
}

