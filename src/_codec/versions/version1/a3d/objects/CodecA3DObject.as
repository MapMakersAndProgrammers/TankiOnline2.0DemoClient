package _codec.versions.version1.a3d.objects
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.CollectionCodecInfo;
   import alternativa.protocol.info.TypeCodecInfo;
   import commons.Id;
   import versions.version1.a3d.id.ParentId;
   import versions.version1.a3d.objects.A3DObject;
   import versions.version1.a3d.objects.A3DSurface;
   import versions.version1.a3d.objects.A3DTransformation;
   
   public class CodecA3DObject implements ICodec
   {
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var var_245:ICodec;
      
      private var var_256:ICodec;
      
      private var var_243:ICodec;
      
      private var var_251:ICodec;
      
      private var var_254:ICodec;
      
      private var var_248:ICodec;
      
      private var var_255:ICodec;
      
      private var var_253:ICodec;
      
      public function CodecA3DObject()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.var_245 = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.var_256 = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.var_243 = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.var_251 = protocol.getCodec(new TypeCodecInfo(String,true));
         this.var_254 = protocol.getCodec(new TypeCodecInfo(ParentId,true));
         this.var_248 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3DSurface,false),true,1));
         this.var_255 = protocol.getCodec(new TypeCodecInfo(A3DTransformation,true));
         this.var_253 = protocol.getCodec(new TypeCodecInfo(Boolean,true));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_boundBoxId:Id = this.var_245.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DObject","boundBoxId",value_boundBoxId);
         var value_geometryId:Id = this.var_256.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DObject","geometryId",value_geometryId);
         var value_id:Id = this.var_243.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DObject","id",value_id);
         var value_name:String = this.var_251.decode(protocolBuffer) as String;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DObject","name",value_name);
         var value_parentId:ParentId = this.var_254.decode(protocolBuffer) as ParentId;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DObject","parentId",value_parentId);
         var value_surfaces:Vector.<A3DSurface> = this.var_248.decode(protocolBuffer) as Vector.<A3DSurface>;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DObject","surfaces",value_surfaces);
         var value_transformation:A3DTransformation = this.var_255.decode(protocolBuffer) as A3DTransformation;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DObject","transformation",value_transformation);
         var value_visible:Boolean = Boolean(this.var_253.decode(protocolBuffer) as Boolean);
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DObject","visible",value_visible);
         return new A3DObject(value_boundBoxId,value_geometryId,value_id,value_name,value_parentId,value_surfaces,value_transformation,value_visible);
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3DObject = A3DObject(object);
         this.var_245.encode(protocolBuffer,struct.boundBoxId);
         this.var_256.encode(protocolBuffer,struct.geometryId);
         this.var_243.encode(protocolBuffer,struct.id);
         this.var_251.encode(protocolBuffer,struct.name);
         this.var_254.encode(protocolBuffer,struct.parentId);
         this.var_248.encode(protocolBuffer,struct.surfaces);
         this.var_255.encode(protocolBuffer,struct.transformation);
         this.var_253.encode(protocolBuffer,struct.visible);
      }
   }
}

