package _codec.versions.version2.a3d.objects
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.CollectionCodecInfo;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Long;
   import alternativa.types.UShort;
   import versions.version2.a3d.objects.A3D2JointBindTransform;
   import versions.version2.a3d.objects.A3D2Skin;
   import versions.version2.a3d.objects.A3D2Surface;
   import versions.version2.a3d.objects.A3D2Transform;
   
   public class CodecA3D2Skin implements ICodec
   {
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var name_Dh:ICodec;
      
      private var name_2o:ICodec;
      
      private var name_PO:ICodec;
      
      private var name_dR:ICodec;
      
      private var name_3f:ICodec;
      
      private var name_XW:ICodec;
      
      private var name_Mx:ICodec;
      
      private var name_jk:ICodec;
      
      private var name_Qr:ICodec;
      
      private var name_S2:ICodec;
      
      private var name_U9:ICodec;
      
      private var name_h9:ICodec;
      
      public function CodecA3D2Skin()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.name_Dh = protocol.getCodec(new TypeCodecInfo(int,true));
         this.name_2o = protocol.getCodec(new TypeCodecInfo(Long,false));
         this.name_PO = protocol.getCodec(new TypeCodecInfo(int,false));
         this.name_dR = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2JointBindTransform,false),false,1));
         this.name_3f = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,false),false,1));
         this.name_XW = protocol.getCodec(new TypeCodecInfo(String,true));
         this.name_Mx = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(UShort,false),false,1));
         this.name_jk = protocol.getCodec(new TypeCodecInfo(Long,true));
         this.name_Qr = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Surface,false),false,1));
         this.name_S2 = protocol.getCodec(new TypeCodecInfo(A3D2Transform,true));
         this.name_U9 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(int,false),false,1));
         this.name_h9 = protocol.getCodec(new TypeCodecInfo(Boolean,false));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_boundBoxId:int = int(this.name_Dh.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Skin","boundBoxId",value_boundBoxId);
         var value_id:Long = this.name_2o.decode(protocolBuffer) as Long;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Skin","id",value_id);
         var value_indexBufferId:int = int(this.name_PO.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Skin","indexBufferId",value_indexBufferId);
         var value_jointBindTransforms:Vector.<A3D2JointBindTransform> = this.name_dR.decode(protocolBuffer) as Vector.<A3D2JointBindTransform>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Skin","jointBindTransforms",value_jointBindTransforms);
         var value_joints:Vector.<Long> = this.name_3f.decode(protocolBuffer) as Vector.<Long>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Skin","joints",value_joints);
         var value_name:String = this.name_XW.decode(protocolBuffer) as String;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Skin","name",value_name);
         var value_numJoints:Vector.<uint> = this.name_Mx.decode(protocolBuffer) as Vector.<uint>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Skin","numJoints",value_numJoints);
         var value_parentId:Long = this.name_jk.decode(protocolBuffer) as Long;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Skin","parentId",value_parentId);
         var value_surfaces:Vector.<A3D2Surface> = this.name_Qr.decode(protocolBuffer) as Vector.<A3D2Surface>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Skin","surfaces",value_surfaces);
         var value_transform:A3D2Transform = this.name_S2.decode(protocolBuffer) as A3D2Transform;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Skin","transform",value_transform);
         var value_vertexBuffers:Vector.<int> = this.name_U9.decode(protocolBuffer) as Vector.<int>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Skin","vertexBuffers",value_vertexBuffers);
         var value_visible:Boolean = Boolean(this.name_h9.decode(protocolBuffer) as Boolean);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Skin","visible",value_visible);
         return new A3D2Skin(value_boundBoxId,value_id,value_indexBufferId,value_jointBindTransforms,value_joints,value_name,value_numJoints,value_parentId,value_surfaces,value_transform,value_vertexBuffers,value_visible);
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3D2Skin = A3D2Skin(object);
         this.name_Dh.encode(protocolBuffer,struct.boundBoxId);
         this.name_2o.encode(protocolBuffer,struct.id);
         this.name_PO.encode(protocolBuffer,struct.indexBufferId);
         this.name_dR.encode(protocolBuffer,struct.jointBindTransforms);
         this.name_3f.encode(protocolBuffer,struct.joints);
         this.name_XW.encode(protocolBuffer,struct.name);
         this.name_Mx.encode(protocolBuffer,struct.numJoints);
         this.name_jk.encode(protocolBuffer,struct.parentId);
         this.name_Qr.encode(protocolBuffer,struct.surfaces);
         this.name_S2.encode(protocolBuffer,struct.transform);
         this.name_U9.encode(protocolBuffer,struct.vertexBuffers);
         this.name_h9.encode(protocolBuffer,struct.visible);
      }
   }
}

