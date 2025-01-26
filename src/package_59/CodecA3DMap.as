package package_59
{
   import package_32.name_148;
   import package_33.name_156;
   import package_33.name_157;
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   import package_39.name_160;
   import package_5.name_3;
   import package_53.A3DMap;
   import package_57.name_213;
   
   public class CodecA3DMap implements name_152
   {
      public static var log:name_160 = name_160(name_3.name_8().name_30(name_160));
      
      private var var_322:name_152;
      
      private var var_252:name_152;
      
      private var var_321:name_152;
      
      private var var_407:name_152;
      
      private var var_408:name_152;
      
      private var var_409:name_152;
      
      private var var_410:name_152;
      
      public function CodecA3DMap()
      {
         super();
      }
      
      public function init(protocol:name_163) : void
      {
         this.var_322 = protocol.name_448(new name_148(name_156,false));
         this.var_252 = protocol.name_448(new name_148(name_213,true));
         this.var_321 = protocol.name_448(new name_148(name_213,true));
         this.var_407 = protocol.name_448(new name_148(name_157,true));
         this.var_408 = protocol.name_448(new name_148(name_157,true));
         this.var_409 = protocol.name_448(new name_148(name_157,true));
         this.var_410 = protocol.name_448(new name_148(name_157,true));
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         log = name_160(name_3.name_8().name_30(name_160));
         var value_channel:uint = uint(this.var_322.method_296(protocolBuffer) as uint);
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMap","channel",value_channel);
         var value_id:name_213 = this.var_252.method_296(protocolBuffer) as name_213;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMap","id",value_id);
         var value_imageId:name_213 = this.var_321.method_296(protocolBuffer) as name_213;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMap","imageId",value_imageId);
         var value_uOffset:Number = Number(this.var_407.method_296(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMap","uOffset",value_uOffset);
         var value_uScale:Number = Number(this.var_408.method_296(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMap","uScale",value_uScale);
         var value_vOffset:Number = Number(this.var_409.method_296(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMap","vOffset",value_vOffset);
         var value_vScale:Number = Number(this.var_410.method_296(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMap","vScale",value_vScale);
         return new A3DMap(value_channel,value_id,value_imageId,value_uOffset,value_uScale,value_vOffset,value_vScale);
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3DMap = A3DMap(object);
         this.var_322.method_295(protocolBuffer,struct.channel);
         this.var_252.method_295(protocolBuffer,struct.id);
         this.var_321.method_295(protocolBuffer,struct.imageId);
         this.var_407.method_295(protocolBuffer,struct.uOffset);
         this.var_408.method_295(protocolBuffer,struct.uScale);
         this.var_409.method_295(protocolBuffer,struct.vOffset);
         this.var_410.method_295(protocolBuffer,struct.vScale);
      }
   }
}

