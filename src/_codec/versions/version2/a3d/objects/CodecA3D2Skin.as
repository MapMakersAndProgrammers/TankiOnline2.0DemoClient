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
      
      private var §_-Dh§:ICodec;
      
      private var §_-2o§:ICodec;
      
      private var §_-PO§:ICodec;
      
      private var §_-dR§:ICodec;
      
      private var §_-3f§:ICodec;
      
      private var §_-XW§:ICodec;
      
      private var §_-Mx§:ICodec;
      
      private var §_-jk§:ICodec;
      
      private var §_-Qr§:ICodec;
      
      private var §_-S2§:ICodec;
      
      private var §_-U9§:ICodec;
      
      private var §_-h9§:ICodec;
      
      public function CodecA3D2Skin()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.§_-Dh§ = protocol.getCodec(new TypeCodecInfo(int,true));
         this.§_-2o§ = protocol.getCodec(new TypeCodecInfo(Long,false));
         this.§_-PO§ = protocol.getCodec(new TypeCodecInfo(int,false));
         this.§_-dR§ = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2JointBindTransform,false),false,1));
         this.§_-3f§ = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,false),false,1));
         this.§_-XW§ = protocol.getCodec(new TypeCodecInfo(String,true));
         this.§_-Mx§ = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(UShort,false),false,1));
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
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Skin","boundBoxId",value_boundBoxId);
         var value_id:Long = this.§_-2o§.decode(protocolBuffer) as Long;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Skin","id",value_id);
         var value_indexBufferId:int = int(this.§_-PO§.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Skin","indexBufferId",value_indexBufferId);
         var value_jointBindTransforms:Vector.<A3D2JointBindTransform> = this.§_-dR§.decode(protocolBuffer) as Vector.<A3D2JointBindTransform>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Skin","jointBindTransforms",value_jointBindTransforms);
         var value_joints:Vector.<Long> = this.§_-3f§.decode(protocolBuffer) as Vector.<Long>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Skin","joints",value_joints);
         var value_name:String = this.§_-XW§.decode(protocolBuffer) as String;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Skin","name",value_name);
         var value_numJoints:Vector.<uint> = this.§_-Mx§.decode(protocolBuffer) as Vector.<uint>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Skin","numJoints",value_numJoints);
         var value_parentId:Long = this.§_-jk§.decode(protocolBuffer) as Long;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Skin","parentId",value_parentId);
         var value_surfaces:Vector.<A3D2Surface> = this.§_-Qr§.decode(protocolBuffer) as Vector.<A3D2Surface>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Skin","surfaces",value_surfaces);
         var value_transform:A3D2Transform = this.§_-S2§.decode(protocolBuffer) as A3D2Transform;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Skin","transform",value_transform);
         var value_vertexBuffers:Vector.<int> = this.§_-U9§.decode(protocolBuffer) as Vector.<int>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Skin","vertexBuffers",value_vertexBuffers);
         var value_visible:Boolean = Boolean(this.§_-h9§.decode(protocolBuffer) as Boolean);
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
         this.§_-Dh§.encode(protocolBuffer,struct.boundBoxId);
         this.§_-2o§.encode(protocolBuffer,struct.id);
         this.§_-PO§.encode(protocolBuffer,struct.indexBufferId);
         this.§_-dR§.encode(protocolBuffer,struct.jointBindTransforms);
         this.§_-3f§.encode(protocolBuffer,struct.joints);
         this.§_-XW§.encode(protocolBuffer,struct.name);
         this.§_-Mx§.encode(protocolBuffer,struct.numJoints);
         this.§_-jk§.encode(protocolBuffer,struct.parentId);
         this.§_-Qr§.encode(protocolBuffer,struct.surfaces);
         this.§_-S2§.encode(protocolBuffer,struct.transform);
         this.§_-U9§.encode(protocolBuffer,struct.vertexBuffers);
         this.§_-h9§.encode(protocolBuffer,struct.visible);
      }
   }
}

