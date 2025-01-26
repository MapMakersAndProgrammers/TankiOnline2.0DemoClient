package package_61
{
   import package_32.name_148;
   import package_32.name_149;
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   import package_39.name_160;
   import alternativa.osgi.OSGi;
   import package_55.A3D2Keyframe;
   import package_55.A3D2Track;
   
   public class CodecA3D2Track implements name_152
   {
      public static var log:name_160 = name_160(OSGi.name_8().name_30(name_160));
      
      private var var_252:name_152;
      
      private var var_394:name_152;
      
      private var var_393:name_152;
      
      public function CodecA3D2Track()
      {
         super();
      }
      
      public function init(protocol:name_163) : void
      {
         this.var_252 = protocol.name_448(new name_148(int,false));
         this.var_394 = protocol.name_448(new name_149(new name_148(A3D2Keyframe,false),false,1));
         this.var_393 = protocol.name_448(new name_148(String,false));
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         log = name_160(OSGi.name_8().name_30(name_160));
         var value_id:int = int(this.var_252.method_296(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.animation.A3D2Track","id",value_id);
         var value_keyframes:Vector.<A3D2Keyframe> = this.var_394.method_296(protocolBuffer) as Vector.<A3D2Keyframe>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.animation.A3D2Track","keyframes",value_keyframes);
         var value_objectName:String = this.var_393.method_296(protocolBuffer) as String;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.animation.A3D2Track","objectName",value_objectName);
         return new A3D2Track(value_id,value_keyframes,value_objectName);
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3D2Track = A3D2Track(object);
         this.var_252.method_295(protocolBuffer,struct.id);
         this.var_394.method_295(protocolBuffer,struct.keyframes);
         this.var_393.method_295(protocolBuffer,struct.objectName);
      }
   }
}

