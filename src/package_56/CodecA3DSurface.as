package package_56
{
   import package_32.name_148;
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   import package_39.name_160;
   import package_5.name_3;
   import package_50.A3DSurface;
   import package_57.name_213;
   
   public class CodecA3DSurface implements name_152
   {
      public static var log:name_160 = name_160(name_3.name_8().name_30(name_160));
      
      private var var_302:name_152;
      
      private var var_296:name_152;
      
      private var var_303:name_152;
      
      public function CodecA3DSurface()
      {
         super();
      }
      
      public function init(protocol:name_163) : void
      {
         this.var_302 = protocol.name_448(new name_148(int,false));
         this.var_296 = protocol.name_448(new name_148(name_213,true));
         this.var_303 = protocol.name_448(new name_148(int,false));
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         log = name_160(name_3.name_8().name_30(name_160));
         var value_indexBegin:int = int(this.var_302.method_296(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DSurface","indexBegin",value_indexBegin);
         var value_materialId:name_213 = this.var_296.method_296(protocolBuffer) as name_213;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DSurface","materialId",value_materialId);
         var value_numTriangles:int = int(this.var_303.method_296(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.objects.A3DSurface","numTriangles",value_numTriangles);
         return new A3DSurface(value_indexBegin,value_materialId,value_numTriangles);
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3DSurface = A3DSurface(object);
         this.var_302.method_295(protocolBuffer,struct.indexBegin);
         this.var_296.method_295(protocolBuffer,struct.materialId);
         this.var_303.method_295(protocolBuffer,struct.numTriangles);
      }
   }
}

