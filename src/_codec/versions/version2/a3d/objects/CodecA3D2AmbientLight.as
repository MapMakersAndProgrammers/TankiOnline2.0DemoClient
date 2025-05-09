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
   import versions.version2.a3d.objects.A3D2AmbientLight;
   import versions.version2.a3d.objects.A3D2Transform;
   
   public class CodecA3D2AmbientLight implements ICodec
   {
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var var_245:ICodec;
      
      private var var_260:ICodec;
      
      private var var_243:ICodec;
      
      private var var_258:ICodec;
      
      private var var_251:ICodec;
      
      private var var_254:ICodec;
      
      private var var_249:ICodec;
      
      private var var_253:ICodec;
      
      public function CodecA3D2AmbientLight()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.var_245 = protocol.getCodec(new TypeCodecInfo(int,true));
         this.var_260 = protocol.getCodec(new TypeCodecInfo(uint,false));
         this.var_243 = protocol.getCodec(new TypeCodecInfo(Long,false));
         this.var_258 = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.var_251 = protocol.getCodec(new TypeCodecInfo(String,true));
         this.var_254 = protocol.getCodec(new TypeCodecInfo(Long,true));
         this.var_249 = protocol.getCodec(new TypeCodecInfo(A3D2Transform,true));
         this.var_253 = protocol.getCodec(new TypeCodecInfo(Boolean,false));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_boundBoxId:int = int(this.var_245.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2AmbientLight","boundBoxId",value_boundBoxId);
         var value_color:uint = uint(this.var_260.decode(protocolBuffer) as uint);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2AmbientLight","color",value_color);
         var value_id:Long = this.var_243.decode(protocolBuffer) as Long;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2AmbientLight","id",value_id);
         var value_intensity:Number = Number(this.var_258.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2AmbientLight","intensity",value_intensity);
         var value_name:String = this.var_251.decode(protocolBuffer) as String;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2AmbientLight","name",value_name);
         var value_parentId:Long = this.var_254.decode(protocolBuffer) as Long;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2AmbientLight","parentId",value_parentId);
         var value_transform:A3D2Transform = this.var_249.decode(protocolBuffer) as A3D2Transform;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2AmbientLight","transform",value_transform);
         var value_visible:Boolean = Boolean(this.var_253.decode(protocolBuffer) as Boolean);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2AmbientLight","visible",value_visible);
         return new A3D2AmbientLight(value_boundBoxId,value_color,value_id,value_intensity,value_name,value_parentId,value_transform,value_visible);
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3D2AmbientLight = A3D2AmbientLight(object);
         this.var_245.encode(protocolBuffer,struct.boundBoxId);
         this.var_260.encode(protocolBuffer,struct.color);
         this.var_243.encode(protocolBuffer,struct.id);
         this.var_258.encode(protocolBuffer,struct.intensity);
         this.var_251.encode(protocolBuffer,struct.name);
         this.var_254.encode(protocolBuffer,struct.parentId);
         this.var_249.encode(protocolBuffer,struct.transform);
         this.var_253.encode(protocolBuffer,struct.visible);
      }
   }
}

