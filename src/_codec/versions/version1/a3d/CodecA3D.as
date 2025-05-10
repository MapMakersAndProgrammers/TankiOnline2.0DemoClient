package _codec.versions.version1.a3d
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.CollectionCodecInfo;
   import alternativa.protocol.info.TypeCodecInfo;
   import versions.version1.a3d.A3D;
   import versions.version1.a3d.geometry.A3DGeometry;
   import versions.version1.a3d.materials.A3DImage;
   import versions.version1.a3d.materials.A3DMap;
   import versions.version1.a3d.materials.A3DMaterial;
   import versions.version1.a3d.objects.A3DBox;
   import versions.version1.a3d.objects.A3DObject;
   
   public class CodecA3D implements ICodec
   {
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var name_EA:ICodec;
      
      private var name_PA:ICodec;
      
      private var name_Sd:ICodec;
      
      private var name_dB:ICodec;
      
      private var name_77:ICodec;
      
      private var name_1x:ICodec;
      
      public function CodecA3D()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.name_EA = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3DBox,false),true,1));
         this.name_PA = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3DGeometry,false),true,1));
         this.name_Sd = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3DImage,false),true,1));
         this.name_dB = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3DMap,false),true,1));
         this.name_77 = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3DMaterial,false),true,1));
         this.name_1x = protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(A3DObject,false),true,1));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_boxes:Vector.<A3DBox> = this.name_EA.decode(protocolBuffer) as Vector.<A3DBox>;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.A3D","boxes",value_boxes);
         var value_geometries:Vector.<A3DGeometry> = this.name_PA.decode(protocolBuffer) as Vector.<A3DGeometry>;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.A3D","geometries",value_geometries);
         var value_images:Vector.<A3DImage> = this.name_Sd.decode(protocolBuffer) as Vector.<A3DImage>;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.A3D","images",value_images);
         var value_maps:Vector.<A3DMap> = this.name_dB.decode(protocolBuffer) as Vector.<A3DMap>;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.A3D","maps",value_maps);
         var value_materials:Vector.<A3DMaterial> = this.name_77.decode(protocolBuffer) as Vector.<A3DMaterial>;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.A3D","materials",value_materials);
         var value_objects:Vector.<A3DObject> = this.name_1x.decode(protocolBuffer) as Vector.<A3DObject>;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.A3D","objects",value_objects);
         return new A3D(value_boxes,value_geometries,value_images,value_maps,value_materials,value_objects);
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3D = A3D(object);
         this.name_EA.encode(protocolBuffer,struct.boxes);
         this.name_PA.encode(protocolBuffer,struct.geometries);
         this.name_Sd.encode(protocolBuffer,struct.images);
         this.name_dB.encode(protocolBuffer,struct.maps);
         this.name_77.encode(protocolBuffer,struct.materials);
         this.name_1x.encode(protocolBuffer,struct.objects);
      }
   }
}

