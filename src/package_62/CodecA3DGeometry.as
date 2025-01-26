package package_62
{
   import package_32.name_148;
   import package_32.name_149;
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   import package_39.name_160;
   import alternativa.osgi.OSGi;
   import package_54.A3DGeometry;
   import package_54.A3DIndexBuffer;
   import package_54.A3DVertexBuffer;
   import package_57.name_213;
   
   public class CodecA3DGeometry implements name_152
   {
      public static var log:name_160 = name_160(OSGi.name_8().name_30(name_160));
      
      private var var_252:name_152;
      
      private var var_275:name_152;
      
      private var var_248:name_152;
      
      public function CodecA3DGeometry()
      {
         super();
      }
      
      public function init(protocol:name_163) : void
      {
         this.var_252 = protocol.name_448(new name_148(name_213,true));
         this.var_275 = protocol.name_448(new name_148(A3DIndexBuffer,true));
         this.var_248 = protocol.name_448(new name_149(new name_148(A3DVertexBuffer,false),true,1));
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         log = name_160(OSGi.name_8().name_30(name_160));
         var value_id:name_213 = this.var_252.method_296(protocolBuffer) as name_213;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.geometry.A3DGeometry","id",value_id);
         var value_indexBuffer:A3DIndexBuffer = this.var_275.method_296(protocolBuffer) as A3DIndexBuffer;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.geometry.A3DGeometry","indexBuffer",value_indexBuffer);
         var value_vertexBuffers:Vector.<A3DVertexBuffer> = this.var_248.method_296(protocolBuffer) as Vector.<A3DVertexBuffer>;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.geometry.A3DGeometry","vertexBuffers",value_vertexBuffers);
         return new A3DGeometry(value_id,value_indexBuffer,value_vertexBuffers);
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3DGeometry = A3DGeometry(object);
         this.var_252.method_295(protocolBuffer,struct.id);
         this.var_275.method_295(protocolBuffer,struct.indexBuffer);
         this.var_248.method_295(protocolBuffer,struct.vertexBuffers);
      }
   }
}

