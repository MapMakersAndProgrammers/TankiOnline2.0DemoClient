package package_49
{
   import package_32.name_148;
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   import package_39.name_160;
   import package_48.A3D2Transform;
   import alternativa.osgi.OSGi;
   import package_57.name_214;
   
   public class CodecA3D2Transform implements name_152
   {
      public static var log:name_160 = name_160(OSGi.name_8().name_30(name_160));
      
      private var var_411:name_152;
      
      public function CodecA3D2Transform()
      {
         super();
      }
      
      public function init(protocol:name_163) : void
      {
         this.var_411 = protocol.name_448(new name_148(name_214,false));
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         log = name_160(OSGi.name_8().name_30(name_160));
         var value_matrix:name_214 = this.var_411.method_296(protocolBuffer) as name_214;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Transform","matrix",value_matrix);
         return new A3D2Transform(value_matrix);
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3D2Transform = A3D2Transform(object);
         this.var_411.method_295(protocolBuffer,struct.matrix);
      }
   }
}

