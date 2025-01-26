package package_49
{
   import package_32.name_148;
   import package_33.name_155;
   import package_33.name_157;
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   import package_39.name_160;
   import package_48.A3D2SpotLight;
   import package_48.A3D2Transform;
   import alternativa.osgi.OSGi;
   
   public class CodecA3D2SpotLight implements name_152
   {
      public static var log:name_160 = name_160(OSGi.name_8().name_30(name_160));
      
      private var var_260:name_152;
      
      private var var_258:name_152;
      
      private var var_244:name_152;
      
      private var var_259:name_152;
      
      private var var_286:name_152;
      
      private var var_287:name_152;
      
      private var var_252:name_152;
      
      private var var_257:name_152;
      
      private var var_253:name_152;
      
      private var var_254:name_152;
      
      private var var_249:name_152;
      
      private var var_247:name_152;
      
      public function CodecA3D2SpotLight()
      {
         super();
      }
      
      public function init(protocol:name_163) : void
      {
         this.var_260 = protocol.name_448(new name_148(name_157,false));
         this.var_258 = protocol.name_448(new name_148(name_157,false));
         this.var_244 = protocol.name_448(new name_148(int,true));
         this.var_259 = protocol.name_448(new name_148(uint,false));
         this.var_286 = protocol.name_448(new name_148(name_157,false));
         this.var_287 = protocol.name_448(new name_148(name_157,false));
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
         var value_attenuationBegin:Number = Number(this.var_260.method_296(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2SpotLight","attenuationBegin",value_attenuationBegin);
         var value_attenuationEnd:Number = Number(this.var_258.method_296(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2SpotLight","attenuationEnd",value_attenuationEnd);
         var value_boundBoxId:int = int(this.var_244.method_296(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2SpotLight","boundBoxId",value_boundBoxId);
         var value_color:uint = uint(this.var_259.method_296(protocolBuffer) as uint);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2SpotLight","color",value_color);
         var value_falloff:Number = Number(this.var_286.method_296(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2SpotLight","falloff",value_falloff);
         var value_hotspot:Number = Number(this.var_287.method_296(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2SpotLight","hotspot",value_hotspot);
         var value_id:name_155 = this.var_252.method_296(protocolBuffer) as name_155;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2SpotLight","id",value_id);
         var value_intensity:Number = Number(this.var_257.method_296(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2SpotLight","intensity",value_intensity);
         var value_name:String = this.var_253.method_296(protocolBuffer) as String;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2SpotLight","name",value_name);
         var value_parentId:name_155 = this.var_254.method_296(protocolBuffer) as name_155;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2SpotLight","parentId",value_parentId);
         var value_transform:A3D2Transform = this.var_249.method_296(protocolBuffer) as A3D2Transform;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2SpotLight","transform",value_transform);
         var value_visible:Boolean = Boolean(this.var_247.method_296(protocolBuffer) as Boolean);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2SpotLight","visible",value_visible);
         return new A3D2SpotLight(value_attenuationBegin,value_attenuationEnd,value_boundBoxId,value_color,value_falloff,value_hotspot,value_id,value_intensity,value_name,value_parentId,value_transform,value_visible);
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3D2SpotLight = A3D2SpotLight(object);
         this.var_260.method_295(protocolBuffer,struct.attenuationBegin);
         this.var_258.method_295(protocolBuffer,struct.attenuationEnd);
         this.var_244.method_295(protocolBuffer,struct.boundBoxId);
         this.var_259.method_295(protocolBuffer,struct.color);
         this.var_286.method_295(protocolBuffer,struct.falloff);
         this.var_287.method_295(protocolBuffer,struct.hotspot);
         this.var_252.method_295(protocolBuffer,struct.id);
         this.var_257.method_295(protocolBuffer,struct.intensity);
         this.var_253.method_295(protocolBuffer,struct.name);
         this.var_254.method_295(protocolBuffer,struct.parentId);
         this.var_249.method_295(protocolBuffer,struct.transform);
         this.var_247.method_295(protocolBuffer,struct.visible);
      }
   }
}

