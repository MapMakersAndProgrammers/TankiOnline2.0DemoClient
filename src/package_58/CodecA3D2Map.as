package package_58
{
   import package_32.name_148;
   import package_33.name_156;
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   import package_39.name_160;
   import alternativa.osgi.OSGi;
   import package_51.A3D2Map;
   
   public class CodecA3D2Map implements name_152
   {
      public static var log:name_160 = name_160(OSGi.name_8().name_30(name_160));
      
      private var var_322:name_152;
      
      private var var_252:name_152;
      
      private var var_321:name_152;
      
      public function CodecA3D2Map()
      {
         super();
      }
      
      public function init(protocol:name_163) : void
      {
         this.var_322 = protocol.name_448(new name_148(name_156,false));
         this.var_252 = protocol.name_448(new name_148(int,false));
         this.var_321 = protocol.name_448(new name_148(int,false));
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         log = name_160(OSGi.name_8().name_30(name_160));
         var value_channel:uint = uint(this.var_322.method_296(protocolBuffer) as uint);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Map","channel",value_channel);
         var value_id:int = int(this.var_252.method_296(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Map","id",value_id);
         var value_imageId:int = int(this.var_321.method_296(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.materials.A3D2Map","imageId",value_imageId);
         return new A3D2Map(value_channel,value_id,value_imageId);
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3D2Map = A3D2Map(object);
         this.var_322.method_295(protocolBuffer,struct.channel);
         this.var_252.method_295(protocolBuffer,struct.id);
         this.var_321.method_295(protocolBuffer,struct.imageId);
      }
   }
}

