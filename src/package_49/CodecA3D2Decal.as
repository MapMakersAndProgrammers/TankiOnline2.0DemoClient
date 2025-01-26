package package_49
{
   import package_32.name_148;
   import package_32.name_149;
   import package_33.name_155;
   import package_33.name_157;
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   import package_39.name_160;
   import package_48.A3D2Decal;
   import package_48.A3D2Surface;
   import package_48.A3D2Transform;
   import alternativa.osgi.OSGi;
   
   public class CodecA3D2Decal implements name_152
   {
      public static var log:name_160 = name_160(OSGi.name_8().name_30(name_160));
      
      private var var_244:name_152;
      
      private var var_252:name_152;
      
      private var var_246:name_152;
      
      private var var_253:name_152;
      
      private var var_309:name_152;
      
      private var var_254:name_152;
      
      private var var_250:name_152;
      
      private var var_249:name_152;
      
      private var var_248:name_152;
      
      private var var_247:name_152;
      
      public function CodecA3D2Decal()
      {
         super();
      }
      
      public function init(protocol:name_163) : void
      {
         this.var_244 = protocol.name_448(new name_148(int,true));
         this.var_252 = protocol.name_448(new name_148(name_155,false));
         this.var_246 = protocol.name_448(new name_148(int,false));
         this.var_253 = protocol.name_448(new name_148(String,true));
         this.var_309 = protocol.name_448(new name_148(name_157,false));
         this.var_254 = protocol.name_448(new name_148(name_155,true));
         this.var_250 = protocol.name_448(new name_149(new name_148(A3D2Surface,false),false,1));
         this.var_249 = protocol.name_448(new name_148(A3D2Transform,true));
         this.var_248 = protocol.name_448(new name_149(new name_148(int,false),false,1));
         this.var_247 = protocol.name_448(new name_148(Boolean,false));
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         log = name_160(OSGi.name_8().name_30(name_160));
         var value_boundBoxId:int = int(this.var_244.method_296(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Decal","boundBoxId",value_boundBoxId);
         var value_id:name_155 = this.var_252.method_296(protocolBuffer) as name_155;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Decal","id",value_id);
         var value_indexBufferId:int = int(this.var_246.method_296(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Decal","indexBufferId",value_indexBufferId);
         var value_name:String = this.var_253.method_296(protocolBuffer) as String;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Decal","name",value_name);
         var value_offset:Number = Number(this.var_309.method_296(protocolBuffer) as Number);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Decal","offset",value_offset);
         var value_parentId:name_155 = this.var_254.method_296(protocolBuffer) as name_155;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Decal","parentId",value_parentId);
         var value_surfaces:Vector.<A3D2Surface> = this.var_250.method_296(protocolBuffer) as Vector.<A3D2Surface>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Decal","surfaces",value_surfaces);
         var value_transform:A3D2Transform = this.var_249.method_296(protocolBuffer) as A3D2Transform;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Decal","transform",value_transform);
         var value_vertexBuffers:Vector.<int> = this.var_248.method_296(protocolBuffer) as Vector.<int>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Decal","vertexBuffers",value_vertexBuffers);
         var value_visible:Boolean = Boolean(this.var_247.method_296(protocolBuffer) as Boolean);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.objects.A3D2Decal","visible",value_visible);
         return new A3D2Decal(value_boundBoxId,value_id,value_indexBufferId,value_name,value_offset,value_parentId,value_surfaces,value_transform,value_vertexBuffers,value_visible);
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3D2Decal = A3D2Decal(object);
         this.var_244.method_295(protocolBuffer,struct.boundBoxId);
         this.var_252.method_295(protocolBuffer,struct.id);
         this.var_246.method_295(protocolBuffer,struct.indexBufferId);
         this.var_253.method_295(protocolBuffer,struct.name);
         this.var_309.method_295(protocolBuffer,struct.offset);
         this.var_254.method_295(protocolBuffer,struct.parentId);
         this.var_250.method_295(protocolBuffer,struct.surfaces);
         this.var_249.method_295(protocolBuffer,struct.transform);
         this.var_248.method_295(protocolBuffer,struct.vertexBuffers);
         this.var_247.method_295(protocolBuffer,struct.visible);
      }
   }
}

