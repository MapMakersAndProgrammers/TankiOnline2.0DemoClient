package package_67
{
   import package_32.name_148;
   import package_32.name_149;
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   import package_39.name_160;
   import package_5.name_3;
   import package_50.A3DBox;
   import package_50.A3DObject;
   import package_53.A3DImage;
   import package_53.A3DMap;
   import package_53.A3DMaterial;
   import package_54.A3DGeometry;
   import package_65.name_210;
   
   public class name_219 implements name_152
   {
      public static var log:name_160 = name_160(name_3.name_8().name_30(name_160));
      
      private var var_356:name_152;
      
      private var var_419:name_152;
      
      private var var_355:name_152;
      
      private var var_366:name_152;
      
      private var var_361:name_152;
      
      private var var_360:name_152;
      
      public function name_219()
      {
         super();
      }
      
      public function init(protocol:name_163) : void
      {
         this.var_356 = protocol.name_448(new name_149(new name_148(A3DBox,false),true,1));
         this.var_419 = protocol.name_448(new name_149(new name_148(A3DGeometry,false),true,1));
         this.var_355 = protocol.name_448(new name_149(new name_148(A3DImage,false),true,1));
         this.var_366 = protocol.name_448(new name_149(new name_148(A3DMap,false),true,1));
         this.var_361 = protocol.name_448(new name_149(new name_148(A3DMaterial,false),true,1));
         this.var_360 = protocol.name_448(new name_149(new name_148(A3DObject,false),true,1));
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         log = name_160(name_3.name_8().name_30(name_160));
         var value_boxes:Vector.<A3DBox> = this.var_356.method_296(protocolBuffer) as Vector.<A3DBox>;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.A3D","boxes",value_boxes);
         var value_geometries:Vector.<A3DGeometry> = this.var_419.method_296(protocolBuffer) as Vector.<A3DGeometry>;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.A3D","geometries",value_geometries);
         var value_images:Vector.<A3DImage> = this.var_355.method_296(protocolBuffer) as Vector.<A3DImage>;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.A3D","images",value_images);
         var value_maps:Vector.<A3DMap> = this.var_366.method_296(protocolBuffer) as Vector.<A3DMap>;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.A3D","maps",value_maps);
         var value_materials:Vector.<A3DMaterial> = this.var_361.method_296(protocolBuffer) as Vector.<A3DMaterial>;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.A3D","materials",value_materials);
         var value_objects:Vector.<A3DObject> = this.var_360.method_296(protocolBuffer) as Vector.<A3DObject>;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.A3D","objects",value_objects);
         return new name_210(value_boxes,value_geometries,value_images,value_maps,value_materials,value_objects);
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:name_210 = name_210(object);
         this.var_356.method_295(protocolBuffer,struct.boxes);
         this.var_419.method_295(protocolBuffer,struct.geometries);
         this.var_355.method_295(protocolBuffer,struct.images);
         this.var_366.method_295(protocolBuffer,struct.maps);
         this.var_361.method_295(protocolBuffer,struct.materials);
         this.var_360.method_295(protocolBuffer,struct.objects);
      }
   }
}

