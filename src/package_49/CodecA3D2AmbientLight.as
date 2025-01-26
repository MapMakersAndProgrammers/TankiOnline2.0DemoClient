package package_49
{
   import package_32.name_148;
   import package_33.name_155;
   import package_33.name_157;
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   import package_39.name_160;
   import package_48.A3D2AmbientLight;
   import package_48.A3D2Transform;
   import alternativa.osgi.OSGi;
   
   public class CodecA3D2AmbientLight implements name_152
   {
      public static var log:name_160 = name_160(OSGi.name_8().name_30(name_160));
      
      private var var_244:name_152;
      
      private var var_259:name_152;
      
      private var var_252:name_152;
      
      private var var_257:name_152;
      
      private var var_253:name_152;
      
      private var var_254:name_152;
      
      private var var_249:name_152;
      
      private var var_247:name_152;
      
      public function CodecA3D2AmbientLight()
      {
         super();
      }
      
      public function init(protocol:name_163) : void
      {
         this.var_244 = protocol.name_448(new name_148(int,true));
         this.var_259 = protocol.name_448(new name_148(uint,false));
         this.var_252 = protocol.name_448(new name_148(name_155,false));
         this.var_257 = protocol.name_448(new name_148(name_157,false));
         this.var_253 = protocol.name_448(new name_148(String,true));
         this.var_254 = protocol.name_448(new name_148(name_155,true));
         this.var_249 = protocol.name_448(new name_148(A3D2Transform,true));
         this.var_247 = protocol.name_448(new name_148(Boolean,false));
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         log = name_160(OSGi.name_8().name_30(name_160));
         var value_boundBoxId:int = int(this.var_244.method_296(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2AmbientLight","boundBoxId",value_boundBoxId);
         var value_color:uint = uint(this.var_259.method_296(protocolBuffer) as uint);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2AmbientLight","color",value_color);
         var value_id:name_155 = this.var_252.method_296(protocolBuffer) as name_155;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2AmbientLight","id",value_id);
         var value_intensity:Number = Number(this.var_257.method_296(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2AmbientLight","intensity",value_intensity);
         var value_name:String = this.var_253.method_296(protocolBuffer) as String;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2AmbientLight","name",value_name);
         var value_parentId:name_155 = this.var_254.method_296(protocolBuffer) as name_155;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2AmbientLight","parentId",value_parentId);
         var value_transform:A3D2Transform = this.var_249.method_296(protocolBuffer) as A3D2Transform;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2AmbientLight","transform",value_transform);
         var value_visible:Boolean = Boolean(this.var_247.method_296(protocolBuffer) as Boolean);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2AmbientLight","visible",value_visible);
         return new A3D2AmbientLight(value_boundBoxId,value_color,value_id,value_intensity,value_name,value_parentId,value_transform,value_visible);
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3D2AmbientLight = A3D2AmbientLight(object);
         this.var_244.method_295(protocolBuffer,struct.boundBoxId);
         this.var_259.method_295(protocolBuffer,struct.color);
         this.var_252.method_295(protocolBuffer,struct.id);
         this.var_257.method_295(protocolBuffer,struct.intensity);
         this.var_253.method_295(protocolBuffer,struct.name);
         this.var_254.method_295(protocolBuffer,struct.parentId);
         this.var_249.method_295(protocolBuffer,struct.transform);
         this.var_247.method_295(protocolBuffer,struct.visible);
      }
   }
}

