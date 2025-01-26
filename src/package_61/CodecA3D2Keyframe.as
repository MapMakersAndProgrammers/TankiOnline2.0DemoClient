package package_61
{
   import package_32.name_148;
   import package_33.name_157;
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   import package_39.name_160;
   import package_48.A3D2Transform;
   import alternativa.osgi.OSGi;
   import package_55.A3D2Keyframe;
   
   public class CodecA3D2Keyframe implements name_152
   {
      public static var log:name_160 = name_160(OSGi.name_8().name_30(name_160));
      
      private var var_395:name_152;
      
      private var var_249:name_152;
      
      public function CodecA3D2Keyframe()
      {
         super();
      }
      
      public function init(protocol:name_163) : void
      {
         this.var_395 = protocol.name_448(new name_148(name_157,false));
         this.var_249 = protocol.name_448(new name_148(A3D2Transform,false));
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         log = name_160(OSGi.name_8().name_30(name_160));
         var value_time:Number = Number(this.var_395.method_296(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.animation.A3D2Keyframe","time",value_time);
         var value_transform:A3D2Transform = this.var_249.method_296(protocolBuffer) as A3D2Transform;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.animation.A3D2Keyframe","transform",value_transform);
         return new A3D2Keyframe(value_time,value_transform);
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3D2Keyframe = A3D2Keyframe(object);
         this.var_395.method_295(protocolBuffer,struct.time);
         this.var_249.method_295(protocolBuffer,struct.transform);
      }
   }
}

