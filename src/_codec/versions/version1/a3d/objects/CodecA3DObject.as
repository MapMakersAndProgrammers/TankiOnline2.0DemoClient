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
      
      private var §_-Dh§:ICodec;
      
      private var §_-e§:ICodec;
      
      private var §_-2o§:ICodec;
      
      private var §_-XW§:ICodec;
      
      private var §_-jk§:ICodec;
      
      private var §_-Qr§:ICodec;
      
      private var §_-9u§:ICodec;
      
      private var §_-h9§:ICodec;
      
      public function CodecA3DObject()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.§_-Dh§ = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.§_-e§ = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.§_-2o§ = protocol.getCodec(new TypeCodecInfo(Id,true));
         this.§_-XW§ = protocol.getCodec(new TypeCodecInfo(String,true));
         this.§_-jk§ = protocol.getCodec(new TypeCodecInfo(ParentId,true));
         this.§_-Qr§ = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3DSurface,false),true,1));
         this.§_-9u§ = protocol.getCodec(new TypeCodecInfo(A3DTransformation,true));
         this.§_-h9§ = protocol.getCodec(new TypeCodecInfo(Boolean,true));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_boundBoxId:Id = this.§_-Dh§.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DObject","boundBoxId",value_boundBoxId);
         var value_geometryId:Id = this.§_-e§.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DObject","geometryId",value_geometryId);
         var value_id:Id = this.§_-2o§.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DObject","id",value_id);
         var value_name:String = this.§_-XW§.decode(protocolBuffer) as String;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DObject","name",value_name);
         var value_parentId:ParentId = this.§_-jk§.decode(protocolBuffer) as ParentId;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DObject","parentId",value_parentId);
         var value_surfaces:Vector.<A3DSurface> = this.§_-Qr§.decode(protocolBuffer) as Vector.<A3DSurface>;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DObject","surfaces",value_surfaces);
         var value_transformation:A3DTransformation = this.§_-9u§.decode(protocolBuffer) as A3DTransformation;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DObject","transformation",value_transformation);
         var value_visible:Boolean = Boolean(this.§_-h9§.decode(protocolBuffer) as Boolean);
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
         this.§_-Dh§.encode(protocolBuffer,struct.boundBoxId);
         this.§_-e§.encode(protocolBuffer,struct.geometryId);
         this.§_-2o§.encode(protocolBuffer,struct.id);
         this.§_-XW§.encode(protocolBuffer,struct.name);
         this.§_-jk§.encode(protocolBuffer,struct.parentId);
         this.§_-Qr§.encode(protocolBuffer,struct.surfaces);
         this.§_-9u§.encode(protocolBuffer,struct.transformation);
         this.§_-h9§.encode(protocolBuffer,struct.visible);
      }
   }
}

