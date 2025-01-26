package package_56
{
   import package_32.name_148;
   import package_32.name_149;
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   import package_39.name_160;
   import alternativa.osgi.OSGi;
   import package_50.A3DObject;
   import package_50.A3DSurface;
   import package_50.A3DTransformation;
   import package_57.name_213;
   import package_64.name_212;
   
   public class CodecA3DObject implements name_152
   {
      public static var log:name_160 = name_160(OSGi.name_8().name_30(name_160));
      
      private var var_244:name_152;
      
      private var var_256:name_152;
      
      private var var_252:name_152;
      
      private var var_253:name_152;
      
      private var var_254:name_152;
      
      private var var_250:name_152;
      
      private var var_255:name_152;
      
      private var var_247:name_152;
      
      public function CodecA3DObject()
      {
         super();
      }
      
      public function init(protocol:name_163) : void
      {
         this.var_244 = protocol.name_448(new name_148(name_213,true));
         this.var_256 = protocol.name_448(new name_148(name_213,true));
         this.var_252 = protocol.name_448(new name_148(name_213,true));
         this.var_253 = protocol.name_448(new name_148(String,true));
         this.var_254 = protocol.name_448(new name_148(name_212,true));
         this.var_250 = protocol.name_448(new name_149(new name_148(A3DSurface,false),true,1));
         this.var_255 = protocol.name_448(new name_148(A3DTransformation,true));
         this.var_247 = protocol.name_448(new name_148(Boolean,true));
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         log = name_160(OSGi.name_8().name_30(name_160));
         var value_boundBoxId:name_213 = this.var_244.method_296(protocolBuffer) as name_213;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DObject","boundBoxId",value_boundBoxId);
         var value_geometryId:name_213 = this.var_256.method_296(protocolBuffer) as name_213;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DObject","geometryId",value_geometryId);
         var value_id:name_213 = this.var_252.method_296(protocolBuffer) as name_213;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DObject","id",value_id);
         var value_name:String = this.var_253.method_296(protocolBuffer) as String;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DObject","name",value_name);
         var value_parentId:name_212 = this.var_254.method_296(protocolBuffer) as name_212;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DObject","parentId",value_parentId);
         var value_surfaces:Vector.<A3DSurface> = this.var_250.method_296(protocolBuffer) as Vector.<A3DSurface>;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DObject","surfaces",value_surfaces);
         var value_transformation:A3DTransformation = this.var_255.method_296(protocolBuffer) as A3DTransformation;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DObject","transformation",value_transformation);
         var value_visible:Boolean = Boolean(this.var_247.method_296(protocolBuffer) as Boolean);
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DObject","visible",value_visible);
         return new A3DObject(value_boundBoxId,value_geometryId,value_id,value_name,value_parentId,value_surfaces,value_transformation,value_visible);
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3DObject = A3DObject(object);
         this.var_244.method_295(protocolBuffer,struct.boundBoxId);
         this.var_256.method_295(protocolBuffer,struct.geometryId);
         this.var_252.method_295(protocolBuffer,struct.id);
         this.var_253.method_295(protocolBuffer,struct.name);
         this.var_254.method_295(protocolBuffer,struct.parentId);
         this.var_250.method_295(protocolBuffer,struct.surfaces);
         this.var_255.method_295(protocolBuffer,struct.transformation);
         this.var_247.method_295(protocolBuffer,struct.visible);
      }
   }
}

