package package_49
{
   import package_32.name_148;
   import package_33.name_155;
   import package_33.name_157;
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   import package_39.name_160;
   import package_48.A3D2Sprite;
   import package_48.A3D2Transform;
   import alternativa.osgi.OSGi;
   import package_57.name_213;
   
   public class CodecA3D2Sprite implements name_152
   {
      public static var log:name_160 = name_160(OSGi.name_8().name_30(name_160));
      
      private var var_298:name_152;
      
      private var var_244:name_152;
      
      private var var_297:name_152;
      
      private var var_252:name_152;
      
      private var var_296:name_152;
      
      private var var_253:name_152;
      
      private var var_293:name_152;
      
      private var var_295:name_152;
      
      private var var_254:name_152;
      
      private var var_294:name_152;
      
      private var var_292:name_152;
      
      private var var_249:name_152;
      
      private var var_247:name_152;
      
      private var var_291:name_152;
      
      public function CodecA3D2Sprite()
      {
         super();
      }
      
      public function init(protocol:name_163) : void
      {
         this.var_298 = protocol.name_448(new name_148(Boolean,false));
         this.var_244 = protocol.name_448(new name_148(int,true));
         this.var_297 = protocol.name_448(new name_148(name_157,false));
         this.var_252 = protocol.name_448(new name_148(name_155,false));
         this.var_296 = protocol.name_448(new name_148(name_213,false));
         this.var_253 = protocol.name_448(new name_148(String,true));
         this.var_293 = protocol.name_448(new name_148(name_157,false));
         this.var_295 = protocol.name_448(new name_148(name_157,false));
         this.var_254 = protocol.name_448(new name_148(name_155,true));
         this.var_294 = protocol.name_448(new name_148(Boolean,false));
         this.var_292 = protocol.name_448(new name_148(name_157,false));
         this.var_249 = protocol.name_448(new name_148(A3D2Transform,true));
         this.var_247 = protocol.name_448(new name_148(Boolean,false));
         this.var_291 = protocol.name_448(new name_148(name_157,false));
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         log = name_160(OSGi.name_8().name_30(name_160));
         var value_alwaysOnTop:Boolean = Boolean(this.var_298.method_296(protocolBuffer) as Boolean);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","alwaysOnTop",value_alwaysOnTop);
         var value_boundBoxId:int = int(this.var_244.method_296(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","boundBoxId",value_boundBoxId);
         var value_height:Number = Number(this.var_297.method_296(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","height",value_height);
         var value_id:name_155 = this.var_252.method_296(protocolBuffer) as name_155;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","id",value_id);
         var value_materialId:name_213 = this.var_296.method_296(protocolBuffer) as name_213;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","materialId",value_materialId);
         var value_name:String = this.var_253.method_296(protocolBuffer) as String;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","name",value_name);
         var value_originX:Number = Number(this.var_293.method_296(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","originX",value_originX);
         var value_originY:Number = Number(this.var_295.method_296(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","originY",value_originY);
         var value_parentId:name_155 = this.var_254.method_296(protocolBuffer) as name_155;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","parentId",value_parentId);
         var value_perspectiveScale:Boolean = Boolean(this.var_294.method_296(protocolBuffer) as Boolean);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","perspectiveScale",value_perspectiveScale);
         var value_rotation:Number = Number(this.var_292.method_296(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","rotation",value_rotation);
         var value_transform:A3D2Transform = this.var_249.method_296(protocolBuffer) as A3D2Transform;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","transform",value_transform);
         var value_visible:Boolean = Boolean(this.var_247.method_296(protocolBuffer) as Boolean);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","visible",value_visible);
         var value_width:Number = Number(this.var_291.method_296(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Sprite","width",value_width);
         return new A3D2Sprite(value_alwaysOnTop,value_boundBoxId,value_height,value_id,value_materialId,value_name,value_originX,value_originY,value_parentId,value_perspectiveScale,value_rotation,value_transform,value_visible,value_width);
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3D2Sprite = A3D2Sprite(object);
         this.var_298.method_295(protocolBuffer,struct.alwaysOnTop);
         this.var_244.method_295(protocolBuffer,struct.boundBoxId);
         this.var_297.method_295(protocolBuffer,struct.height);
         this.var_252.method_295(protocolBuffer,struct.id);
         this.var_296.method_295(protocolBuffer,struct.materialId);
         this.var_253.method_295(protocolBuffer,struct.name);
         this.var_293.method_295(protocolBuffer,struct.originX);
         this.var_295.method_295(protocolBuffer,struct.originY);
         this.var_254.method_295(protocolBuffer,struct.parentId);
         this.var_294.method_295(protocolBuffer,struct.perspectiveScale);
         this.var_292.method_295(protocolBuffer,struct.rotation);
         this.var_249.method_295(protocolBuffer,struct.transform);
         this.var_247.method_295(protocolBuffer,struct.visible);
         this.var_291.method_295(protocolBuffer,struct.width);
      }
   }
}

