package package_58
{
   import package_32.name_148;
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   import package_39.name_160;
   import package_5.name_3;
   import package_51.A3D2Material;
   
   public class CodecA3D2Material implements name_152
   {
      public static var log:name_160 = name_160(name_3.name_8().name_30(name_160));
      
      private var var_386:name_152;
      
      private var var_383:name_152;
      
      private var var_252:name_152;
      
      private var var_384:name_152;
      
      private var var_385:name_152;
      
      private var var_382:name_152;
      
      private var var_418:name_152;
      
      private var var_381:name_152;
      
      public function CodecA3D2Material()
      {
         super();
      }
      
      public function init(protocol:name_163) : void
      {
         this.var_386 = protocol.name_448(new name_148(int,true));
         this.var_383 = protocol.name_448(new name_148(int,true));
         this.var_252 = protocol.name_448(new name_148(int,false));
         this.var_384 = protocol.name_448(new name_148(int,true));
         this.var_385 = protocol.name_448(new name_148(int,true));
         this.var_382 = protocol.name_448(new name_148(int,true));
         this.var_418 = protocol.name_448(new name_148(int,true));
         this.var_381 = protocol.name_448(new name_148(int,true));
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         log = name_160(name_3.name_8().name_30(name_160));
         var value_diffuseMapId:int = int(this.var_386.method_296(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Material","diffuseMapId",value_diffuseMapId);
         var value_glossinessMapId:int = int(this.var_383.method_296(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Material","glossinessMapId",value_glossinessMapId);
         var value_id:int = int(this.var_252.method_296(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Material","id",value_id);
         var value_lightMapId:int = int(this.var_384.method_296(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Material","lightMapId",value_lightMapId);
         var value_normalMapId:int = int(this.var_385.method_296(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Material","normalMapId",value_normalMapId);
         var value_opacityMapId:int = int(this.var_382.method_296(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Material","opacityMapId",value_opacityMapId);
         var value_reflectionCubeMapId:int = int(this.var_418.method_296(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Material","reflectionCubeMapId",value_reflectionCubeMapId);
         var value_specularMapId:int = int(this.var_381.method_296(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Material","specularMapId",value_specularMapId);
         return new A3D2Material(value_diffuseMapId,value_glossinessMapId,value_id,value_lightMapId,value_normalMapId,value_opacityMapId,value_reflectionCubeMapId,value_specularMapId);
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3D2Material = A3D2Material(object);
         this.var_386.method_295(protocolBuffer,struct.diffuseMapId);
         this.var_383.method_295(protocolBuffer,struct.glossinessMapId);
         this.var_252.method_295(protocolBuffer,struct.id);
         this.var_384.method_295(protocolBuffer,struct.lightMapId);
         this.var_385.method_295(protocolBuffer,struct.normalMapId);
         this.var_382.method_295(protocolBuffer,struct.opacityMapId);
         this.var_418.method_295(protocolBuffer,struct.reflectionCubeMapId);
         this.var_381.method_295(protocolBuffer,struct.specularMapId);
      }
   }
}

