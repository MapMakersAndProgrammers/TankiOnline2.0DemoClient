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
      
      private var var_245:ICodec;
      
      private var var_243:ICodec;
      
      private var var_247:ICodec;
      
      private var var_252:ICodec;
      
      private var var_244:ICodec;
      
      private var var_251:ICodec;
      
      private var var_246:ICodec;
      
      private var var_254:ICodec;
      
      private var var_248:ICodec;
      
      private var var_249:ICodec;
      
      private var var_250:ICodec;
      
      private var var_253:ICodec;
      
      public function CodecA3D2Skin()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.var_245 = protocol.getCodec(new TypeCodecInfo(int,true));
         this.var_243 = protocol.getCodec(new TypeCodecInfo(Long,false));
         this.var_247 = protocol.getCodec(new TypeCodecInfo(int,false));
         this.var_252 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2JointBindTransform,false),false,1));
         this.var_244 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,false),false,1));
         this.var_251 = protocol.getCodec(new TypeCodecInfo(String,true));
         this.var_246 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(UShort,false),false,1));
         this.var_254 = protocol.getCodec(new TypeCodecInfo(Long,true));
         this.var_248 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3D2Surface,false),false,1));
         this.var_249 = protocol.getCodec(new TypeCodecInfo(A3D2Transform,true));
         this.var_250 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(int,false),false,1));
         this.var_253 = protocol.getCodec(new TypeCodecInfo(Boolean,false));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_boundBoxId:int = int(this.var_245.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Skin","boundBoxId",value_boundBoxId);
         var value_id:Long = this.var_243.decode(protocolBuffer) as Long;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Skin","id",value_id);
         var value_indexBufferId:int = int(this.var_247.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Skin","indexBufferId",value_indexBufferId);
         var value_jointBindTransforms:Vector.<A3D2JointBindTransform> = this.var_252.decode(protocolBuffer) as Vector.<A3D2JointBindTransform>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Skin","jointBindTransforms",value_jointBindTransforms);
         var value_joints:Vector.<Long> = this.var_244.decode(protocolBuffer) as Vector.<Long>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Skin","joints",value_joints);
         var value_name:String = this.var_251.decode(protocolBuffer) as String;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Skin","name",value_name);
         var value_numJoints:Vector.<uint> = this.var_246.decode(protocolBuffer) as Vector.<uint>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Skin","numJoints",value_numJoints);
         var value_parentId:Long = this.var_254.decode(protocolBuffer) as Long;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Skin","parentId",value_parentId);
         var value_surfaces:Vector.<A3D2Surface> = this.var_248.decode(protocolBuffer) as Vector.<A3D2Surface>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Skin","surfaces",value_surfaces);
         var value_transform:A3D2Transform = this.var_249.decode(protocolBuffer) as A3D2Transform;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Skin","transform",value_transform);
         var value_vertexBuffers:Vector.<int> = this.var_250.decode(protocolBuffer) as Vector.<int>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Skin","vertexBuffers",value_vertexBuffers);
         var value_visible:Boolean = Boolean(this.var_253.decode(protocolBuffer) as Boolean);
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
         this.var_245.encode(protocolBuffer,struct.boundBoxId);
         this.var_243.encode(protocolBuffer,struct.id);
         this.var_247.encode(protocolBuffer,struct.indexBufferId);
         this.var_252.encode(protocolBuffer,struct.jointBindTransforms);
         this.var_244.encode(protocolBuffer,struct.joints);
         this.var_251.encode(protocolBuffer,struct.name);
         this.var_246.encode(protocolBuffer,struct.numJoints);
         this.var_254.encode(protocolBuffer,struct.parentId);
         this.var_248.encode(protocolBuffer,struct.surfaces);
         this.var_249.encode(protocolBuffer,struct.transform);
         this.var_250.encode(protocolBuffer,struct.vertexBuffers);
         this.var_253.encode(protocolBuffer,struct.visible);
      }
   }
}

