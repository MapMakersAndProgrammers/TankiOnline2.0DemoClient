package _codec.versions.version2.a3d.materials
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import versions.version2.a3d.materials.A3D2CubeMap;
   
   public class CodecA3D2CubeMap implements ICodec
   {
      public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var var_372:ICodec;
      
      private var var_370:ICodec;
      
      private var var_369:ICodec;
      
      private var var_243:ICodec;
      
      private var var_373:ICodec;
      
      private var var_368:ICodec;
      
      private var var_371:ICodec;
      
      public function CodecA3D2CubeMap()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.var_372 = protocol.getCodec(new TypeCodecInfo(int,true));
         this.var_370 = protocol.getCodec(new TypeCodecInfo(int,true));
         this.var_369 = protocol.getCodec(new TypeCodecInfo(int,true));
         this.var_243 = protocol.getCodec(new TypeCodecInfo(int,false));
         this.var_373 = protocol.getCodec(new TypeCodecInfo(int,true));
         this.var_368 = protocol.getCodec(new TypeCodecInfo(int,true));
         this.var_371 = protocol.getCodec(new TypeCodecInfo(int,false));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_backId:int = int(this.var_372.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2CubeMap","backId",value_backId);
         var value_bottomId:int = int(this.var_370.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2CubeMap","bottomId",value_bottomId);
         var value_frontId:int = int(this.var_369.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2CubeMap","frontId",value_frontId);
         var value_id:int = int(this.var_243.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2CubeMap","id",value_id);
         var value_leftId:int = int(this.var_373.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2CubeMap","leftId",value_leftId);
         var value_rightId:int = int(this.var_368.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2CubeMap","rightId",value_rightId);
         var value_topId:int = int(this.var_371.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2CubeMap","topId",value_topId);
         return new A3D2CubeMap(value_backId,value_bottomId,value_frontId,value_id,value_leftId,value_rightId,value_topId);
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3D2CubeMap = A3D2CubeMap(object);
         this.var_372.encode(protocolBuffer,struct.backId);
         this.var_370.encode(protocolBuffer,struct.bottomId);
         this.var_369.encode(protocolBuffer,struct.frontId);
         this.var_243.encode(protocolBuffer,struct.id);
         this.var_373.encode(protocolBuffer,struct.leftId);
         this.var_368.encode(protocolBuffer,struct.rightId);
         this.var_371.encode(protocolBuffer,struct.topId);
      }
   }
}

