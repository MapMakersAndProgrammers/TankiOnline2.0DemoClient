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
   import versions.version2.a3d.objects.A3D2SpotLight;
   import versions.version2.a3d.objects.A3D2Transform;
   
   public class CodecA3D2SpotLight implements ICodec
   {
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var name_KK:ICodec;
      
      private var name_H3:ICodec;
      
      private var name_Dh:ICodec;
      
      private var name_Po:ICodec;
      
      private var name_GX:ICodec;
      
      private var name_YW:ICodec;
      
      private var name_2o:ICodec;
      
      private var name_JX:ICodec;
      
      private var name_XW:ICodec;
      
      private var name_jk:ICodec;
      
      private var name_S2:ICodec;
      
      private var name_h9:ICodec;
      
      public function CodecA3D2SpotLight()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.name_KK = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.name_H3 = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.name_Dh = protocol.getCodec(new TypeCodecInfo(int,true));
         this.name_Po = protocol.getCodec(new TypeCodecInfo(uint,false));
         this.name_GX = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.name_YW = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.name_2o = protocol.getCodec(new TypeCodecInfo(Long,false));
         this.name_JX = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.name_XW = protocol.getCodec(new TypeCodecInfo(String,true));
         this.name_jk = protocol.getCodec(new TypeCodecInfo(Long,true));
         this.name_S2 = protocol.getCodec(new TypeCodecInfo(A3D2Transform,true));
         this.name_h9 = protocol.getCodec(new TypeCodecInfo(Boolean,false));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_attenuationBegin:Number = Number(this.name_KK.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2SpotLight","attenuationBegin",value_attenuationBegin);
         var value_attenuationEnd:Number = Number(this.name_H3.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2SpotLight","attenuationEnd",value_attenuationEnd);
         var value_boundBoxId:int = int(this.name_Dh.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2SpotLight","boundBoxId",value_boundBoxId);
         var value_color:uint = uint(this.name_Po.decode(protocolBuffer) as uint);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2SpotLight","color",value_color);
         var value_falloff:Number = Number(this.name_GX.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2SpotLight","falloff",value_falloff);
         var value_hotspot:Number = Number(this.name_YW.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2SpotLight","hotspot",value_hotspot);
         var value_id:Long = this.name_2o.decode(protocolBuffer) as Long;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2SpotLight","id",value_id);
         var value_intensity:Number = Number(this.name_JX.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2SpotLight","intensity",value_intensity);
         var value_name:String = this.name_XW.decode(protocolBuffer) as String;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2SpotLight","name",value_name);
         var value_parentId:Long = this.name_jk.decode(protocolBuffer) as Long;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2SpotLight","parentId",value_parentId);
         var value_transform:A3D2Transform = this.name_S2.decode(protocolBuffer) as A3D2Transform;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2SpotLight","transform",value_transform);
         var value_visible:Boolean = Boolean(this.name_h9.decode(protocolBuffer) as Boolean);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2SpotLight","visible",value_visible);
         return new A3D2SpotLight(value_attenuationBegin,value_attenuationEnd,value_boundBoxId,value_color,value_falloff,value_hotspot,value_id,value_intensity,value_name,value_parentId,value_transform,value_visible);
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3D2SpotLight = A3D2SpotLight(object);
         this.name_KK.encode(protocolBuffer,struct.attenuationBegin);
         this.name_H3.encode(protocolBuffer,struct.attenuationEnd);
         this.name_Dh.encode(protocolBuffer,struct.boundBoxId);
         this.name_Po.encode(protocolBuffer,struct.color);
         this.name_GX.encode(protocolBuffer,struct.falloff);
         this.name_YW.encode(protocolBuffer,struct.hotspot);
         this.name_2o.encode(protocolBuffer,struct.id);
         this.name_JX.encode(protocolBuffer,struct.intensity);
         this.name_XW.encode(protocolBuffer,struct.name);
         this.name_jk.encode(protocolBuffer,struct.parentId);
         this.name_S2.encode(protocolBuffer,struct.transform);
         this.name_h9.encode(protocolBuffer,struct.visible);
      }
   }
}

