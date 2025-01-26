package package_58
{
   import package_32.name_148;
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   import package_39.name_160;
   import package_5.name_3;
   import package_51.A3D2CubeMap;
   
   public class CodecA3D2CubeMap implements name_152
   {
      public static var log:name_160 = name_160(name_3.name_8().name_30(name_160));
      
      private var var_369:name_152;
      
      private var var_373:name_152;
      
      private var var_368:name_152;
      
      private var var_252:name_152;
      
      private var var_372:name_152;
      
      private var var_371:name_152;
      
      private var var_370:name_152;
      
      public function CodecA3D2CubeMap()
      {
         super();
      }
      
      public function init(protocol:name_163) : void
      {
         this.var_369 = protocol.name_448(new name_148(int,true));
         this.var_373 = protocol.name_448(new name_148(int,true));
         this.var_368 = protocol.name_448(new name_148(int,true));
         this.var_252 = protocol.name_448(new name_148(int,false));
         this.var_372 = protocol.name_448(new name_148(int,true));
         this.var_371 = protocol.name_448(new name_148(int,true));
         this.var_370 = protocol.name_448(new name_148(int,false));
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         log = name_160(name_3.name_8().name_30(name_160));
         var value_backId:int = int(this.var_369.method_296(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2CubeMap","backId",value_backId);
         var value_bottomId:int = int(this.var_373.method_296(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2CubeMap","bottomId",value_bottomId);
         var value_frontId:int = int(this.var_368.method_296(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2CubeMap","frontId",value_frontId);
         var value_id:int = int(this.var_252.method_296(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2CubeMap","id",value_id);
         var value_leftId:int = int(this.var_372.method_296(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2CubeMap","leftId",value_leftId);
         var value_rightId:int = int(this.var_371.method_296(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2CubeMap","rightId",value_rightId);
         var value_topId:int = int(this.var_370.method_296(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2CubeMap","topId",value_topId);
         return new A3D2CubeMap(value_backId,value_bottomId,value_frontId,value_id,value_leftId,value_rightId,value_topId);
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3D2CubeMap = A3D2CubeMap(object);
         this.var_369.method_295(protocolBuffer,struct.backId);
         this.var_373.method_295(protocolBuffer,struct.bottomId);
         this.var_368.method_295(protocolBuffer,struct.frontId);
         this.var_252.method_295(protocolBuffer,struct.id);
         this.var_372.method_295(protocolBuffer,struct.leftId);
         this.var_371.method_295(protocolBuffer,struct.rightId);
         this.var_370.method_295(protocolBuffer,struct.topId);
      }
   }
}

