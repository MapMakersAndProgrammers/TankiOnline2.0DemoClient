package package_49
{
   import package_32.name_148;
   import package_33.name_155;
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   import package_39.name_160;
   import package_48.A3D2JointBindTransform;
   import package_48.A3D2Transform;
   import alternativa.osgi.OSGi;
   
   public class CodecA3D2JointBindTransform implements name_152
   {
      public static var log:name_160 = name_160(OSGi.name_8().name_30(name_160));
      
      private var var_380:name_152;
      
      private var var_252:name_152;
      
      public function CodecA3D2JointBindTransform()
      {
         super();
      }
      
      public function init(protocol:name_163) : void
      {
         this.var_380 = protocol.name_448(new name_148(A3D2Transform,false));
         this.var_252 = protocol.name_448(new name_148(name_155,false));
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         log = name_160(OSGi.name_8().name_30(name_160));
         var value_bindPoseTransform:A3D2Transform = this.var_380.method_296(protocolBuffer) as A3D2Transform;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2JointBindTransform","bindPoseTransform",value_bindPoseTransform);
         var value_id:name_155 = this.var_252.method_296(protocolBuffer) as name_155;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2JointBindTransform","id",value_id);
         return new A3D2JointBindTransform(value_bindPoseTransform,value_id);
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3D2JointBindTransform = A3D2JointBindTransform(object);
         this.var_380.method_295(protocolBuffer,struct.bindPoseTransform);
         this.var_252.method_295(protocolBuffer,struct.id);
      }
   }
}

