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
      
      private var name_Yc:ICodec;
      
      private var name_SV:ICodec;
      
      private var name_Ni:ICodec;
      
      private var name_2o:ICodec;
      
      private var name_nb:ICodec;
      
      private var name_23:ICodec;
      
      private var name_TW:ICodec;
      
      public function CodecA3D2CubeMap()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.name_Yc = protocol.getCodec(new TypeCodecInfo(int,true));
         this.name_SV = protocol.getCodec(new TypeCodecInfo(int,true));
         this.name_Ni = protocol.getCodec(new TypeCodecInfo(int,true));
         this.name_2o = protocol.getCodec(new TypeCodecInfo(int,false));
         this.name_nb = protocol.getCodec(new TypeCodecInfo(int,true));
         this.name_23 = protocol.getCodec(new TypeCodecInfo(int,true));
         this.name_TW = protocol.getCodec(new TypeCodecInfo(int,false));
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         log = IClientLog(OSGi.getInstance().getService(IClientLog));
         var value_backId:int = int(this.name_Yc.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2CubeMap","backId",value_backId);
         var value_bottomId:int = int(this.name_SV.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2CubeMap","bottomId",value_bottomId);
         var value_frontId:int = int(this.name_Ni.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2CubeMap","frontId",value_frontId);
         var value_id:int = int(this.name_2o.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2CubeMap","id",value_id);
         var value_leftId:int = int(this.name_nb.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2CubeMap","leftId",value_leftId);
         var value_rightId:int = int(this.name_23.decode(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2CubeMap","rightId",value_rightId);
         var value_topId:int = int(this.name_TW.decode(protocolBuffer) as int);
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
         this.name_Yc.encode(protocolBuffer,struct.backId);
         this.name_SV.encode(protocolBuffer,struct.bottomId);
         this.name_Ni.encode(protocolBuffer,struct.frontId);
         this.name_2o.encode(protocolBuffer,struct.id);
         this.name_nb.encode(protocolBuffer,struct.leftId);
         this.name_23.encode(protocolBuffer,struct.rightId);
         this.name_TW.encode(protocolBuffer,struct.topId);
      }
   }
}

