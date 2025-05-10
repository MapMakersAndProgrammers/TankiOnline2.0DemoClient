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
      
      private var name_Dh:ICodec;
      
      private var name_e:ICodec;
      
      private var name_2o:ICodec;
      
      private var name_XW:ICodec;
      
      private var name_jk:ICodec;
      
      private var name_Qr:ICodec;
      
      private var name_9u:ICodec;
      
      private var name_h9:ICodec;
      
      public function CodecA3DObject()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.name_Dh = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.name_e = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.name_2o = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.name_XW = protocol.getCodec(new TypeCodecInfo(String,true));
         this.name_jk = protocol.getCodec(new TypeCodecInfo(ParentId,true));
         this.name_Qr = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3DSurface,false),true,1));
         this.name_9u = protocol.getCodec(new TypeCodecInfo(A3DTransformation,true));
         this.name_h9 = protocol.getCodec(new TypeCodecInfo(Boolean,true));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_boundBoxId:Id = this.name_Dh.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DObject","boundBoxId",value_boundBoxId);
         var value_geometryId:Id = this.name_e.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DObject","geometryId",value_geometryId);
         var value_id:Id = this.name_2o.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DObject","id",value_id);
         var value_name:String = this.name_XW.decode(protocolBuffer) as String;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DObject","name",value_name);
         var value_parentId:ParentId = this.name_jk.decode(protocolBuffer) as ParentId;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DObject","parentId",value_parentId);
         var value_surfaces:Vector.<A3DSurface> = this.name_Qr.decode(protocolBuffer) as Vector.<A3DSurface>;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DObject","surfaces",value_surfaces);
         var value_transformation:A3DTransformation = this.name_9u.decode(protocolBuffer) as A3DTransformation;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DObject","transformation",value_transformation);
         var value_visible:Boolean = Boolean(this.name_h9.decode(protocolBuffer) as Boolean);
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
         this.name_Dh.encode(protocolBuffer,struct.boundBoxId);
         this.name_e.encode(protocolBuffer,struct.geometryId);
         this.name_2o.encode(protocolBuffer,struct.id);
         this.name_XW.encode(protocolBuffer,struct.name);
         this.name_jk.encode(protocolBuffer,struct.parentId);
         this.name_Qr.encode(protocolBuffer,struct.surfaces);
         this.name_9u.encode(protocolBuffer,struct.transformation);
         this.name_h9.encode(protocolBuffer,struct.visible);
      }
   }
}

