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
      
      private var var_295:ICodec;
      
      private var var_245:ICodec;
      
      private var var_294:ICodec;
      
      private var var_243:ICodec;
      
      private var var_291:ICodec;
      
      private var var_251:ICodec;
      
      private var var_292:ICodec;
      
      private var var_297:ICodec;
      
      private var var_254:ICodec;
      
      private var var_296:ICodec;
      
      private var var_293:ICodec;
      
      private var var_249:ICodec;
      
      private var var_253:ICodec;
      
      private var var_298:ICodec;
      
      public function CodecA3D2Sprite()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.var_295 = protocol.getCodec(new TypeCodecInfo(Boolean,false));
         this.var_245 = protocol.getCodec(new TypeCodecInfo(int,true));
         this.var_294 = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.var_243 = protocol.getCodec(new TypeCodecInfo(Long,false));
         this.var_291 = protocol.getCodec(new TypeCodecInfo(Id,false));
         this.var_251 = protocol.getCodec(new TypeCodecInfo(String,true));
         this.var_292 = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.var_297 = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.var_254 = protocol.getCodec(new TypeCodecInfo(Long,true));
         this.var_296 = protocol.getCodec(new TypeCodecInfo(Boolean,false));
         this.var_293 = protocol.getCodec(new TypeCodecInfo(Float,false));
         this.var_249 = protocol.getCodec(new TypeCodecInfo(A3D2Transform,true));
         this.var_253 = protocol.getCodec(new TypeCodecInfo(Boolean,false));
         this.var_298 = protocol.getCodec(new TypeCodecInfo(Float,false));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_alwaysOnTop:Boolean = Boolean(this.var_295.decode(protocolBuffer) as Boolean);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","alwaysOnTop",value_alwaysOnTop);
         var value_boundBoxId:int = int(this.var_245.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","boundBoxId",value_boundBoxId);
         var value_height:Number = Number(this.var_294.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","height",value_height);
         var value_id:Long = this.var_243.decode(protocolBuffer) as Long;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","id",value_id);
         var value_materialId:Id = this.var_291.decode(protocolBuffer) as Id;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","materialId",value_materialId);
         var value_name:String = this.var_251.decode(protocolBuffer) as String;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","name",value_name);
         var value_originX:Number = Number(this.var_292.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","originX",value_originX);
         var value_originY:Number = Number(this.var_297.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","originY",value_originY);
         var value_parentId:Long = this.var_254.decode(protocolBuffer) as Long;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","parentId",value_parentId);
         var value_perspectiveScale:Boolean = Boolean(this.var_296.decode(protocolBuffer) as Boolean);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","perspectiveScale",value_perspectiveScale);
         var value_rotation:Number = Number(this.var_293.decode(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","rotation",value_rotation);
         var value_transform:A3D2Transform = this.var_249.decode(protocolBuffer) as A3D2Transform;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","transform",value_transform);
         var value_visible:Boolean = Boolean(this.var_253.decode(protocolBuffer) as Boolean);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","visible",value_visible);
         var value_width:Number = Number(this.var_298.decode(protocolBuffer) as Number);
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
         this.var_295.encode(protocolBuffer,struct.alwaysOnTop);
         this.var_245.encode(protocolBuffer,struct.boundBoxId);
         this.var_294.encode(protocolBuffer,struct.height);
         this.var_243.encode(protocolBuffer,struct.id);
         this.var_291.encode(protocolBuffer,struct.materialId);
         this.var_251.encode(protocolBuffer,struct.name);
         this.var_292.encode(protocolBuffer,struct.originX);
         this.var_297.encode(protocolBuffer,struct.originY);
         this.var_254.encode(protocolBuffer,struct.parentId);
         this.var_296.encode(protocolBuffer,struct.perspectiveScale);
         this.var_293.encode(protocolBuffer,struct.rotation);
         this.var_249.encode(protocolBuffer,struct.transform);
         this.var_253.encode(protocolBuffer,struct.visible);
         this.var_298.encode(protocolBuffer,struct.width);
      }
   }
}

