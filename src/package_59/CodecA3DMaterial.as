package package_59
{
   import package_32.name_148;
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   import package_39.name_160;
   import package_5.name_3;
   import package_53.A3DMaterial;
   import package_57.name_213;
   
   public class CodecA3DMaterial implements name_152
   {
      public static var log:name_160 = name_160(name_3.name_8().name_30(name_160));
      
      private var var_386:name_152;
      
      private var var_383:name_152;
      
      private var var_252:name_152;
      
      private var var_384:name_152;
      
      private var var_385:name_152;
      
      private var var_382:name_152;
      
      private var var_381:name_152;
      
      public function CodecA3DMaterial()
      {
         super();
      }
      
      public function init(protocol:name_163) : void
      {
         this.var_386 = protocol.name_448(new name_148(name_213,true));
         this.var_383 = protocol.name_448(new name_148(name_213,true));
         this.var_252 = protocol.name_448(new name_148(name_213,true));
         this.var_384 = protocol.name_448(new name_148(name_213,true));
         this.var_385 = protocol.name_448(new name_148(name_213,true));
         this.var_382 = protocol.name_448(new name_148(name_213,true));
         this.var_381 = protocol.name_448(new name_148(name_213,true));
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         log = name_160(name_3.name_8().name_30(name_160));
         var value_diffuseMapId:name_213 = this.var_386.method_296(protocolBuffer) as name_213;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMaterial","diffuseMapId",value_diffuseMapId);
         var value_glossinessMapId:name_213 = this.var_383.method_296(protocolBuffer) as name_213;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMaterial","glossinessMapId",value_glossinessMapId);
         var value_id:name_213 = this.var_252.method_296(protocolBuffer) as name_213;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMaterial","id",value_id);
         var value_lightMapId:name_213 = this.var_384.method_296(protocolBuffer) as name_213;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMaterial","lightMapId",value_lightMapId);
         var value_normalMapId:name_213 = this.var_385.method_296(protocolBuffer) as name_213;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMaterial","normalMapId",value_normalMapId);
         var value_opacityMapId:name_213 = this.var_382.method_296(protocolBuffer) as name_213;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMaterial","opacityMapId",value_opacityMapId);
         var value_specularMapId:name_213 = this.var_381.method_296(protocolBuffer) as name_213;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.materials.A3DMaterial","specularMapId",value_specularMapId);
         return new A3DMaterial(value_diffuseMapId,value_glossinessMapId,value_id,value_lightMapId,value_normalMapId,value_opacityMapId,value_specularMapId);
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3DMaterial = A3DMaterial(object);
         this.var_386.method_295(protocolBuffer,struct.diffuseMapId);
         this.var_383.method_295(protocolBuffer,struct.glossinessMapId);
         this.var_252.method_295(protocolBuffer,struct.id);
         this.var_384.method_295(protocolBuffer,struct.lightMapId);
         this.var_385.method_295(protocolBuffer,struct.normalMapId);
         this.var_382.method_295(protocolBuffer,struct.opacityMapId);
         this.var_381.method_295(protocolBuffer,struct.specularMapId);
      }
   }
}

