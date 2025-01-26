package package_60
{
   import flash.utils.ByteArray;
   import package_32.name_148;
   import package_32.name_149;
   import package_32.name_209;
   import package_33.name_156;
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   import package_39.name_160;
   import alternativa.osgi.OSGi;
   import package_52.A3D2VertexAttributes;
   import package_52.A3D2VertexBuffer;
   
   public class CodecA3D2VertexBuffer implements name_152
   {
      public static var log:name_160 = name_160(OSGi.name_8().name_30(name_160));
      
      private var var_240:name_152;
      
      private var var_241:name_152;
      
      private var var_252:name_152;
      
      private var var_242:name_152;
      
      public function CodecA3D2VertexBuffer()
      {
         super();
      }
      
      public function init(protocol:name_163) : void
      {
         this.var_240 = protocol.name_448(new name_149(new name_209(A3D2VertexAttributes,false),false,1));
         this.var_241 = protocol.name_448(new name_148(ByteArray,false));
         this.var_252 = protocol.name_448(new name_148(int,false));
         this.var_242 = protocol.name_448(new name_148(name_156,false));
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         log = name_160(OSGi.name_8().name_30(name_160));
         var value_attributes:Vector.<A3D2VertexAttributes> = this.var_240.method_296(protocolBuffer) as Vector.<A3D2VertexAttributes>;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.geometry.A3D2VertexBuffer","attributes",value_attributes);
         var value_byteBuffer:ByteArray = this.var_241.method_296(protocolBuffer) as ByteArray;
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.geometry.A3D2VertexBuffer","byteBuffer",value_byteBuffer);
         var value_id:int = int(this.var_252.method_296(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.geometry.A3D2VertexBuffer","id",value_id);
         var value_vertexCount:uint = uint(this.var_242.method_296(protocolBuffer) as uint);
         log.log("codec","struct %1 field %2 value %3","versions.version2.a3d.geometry.A3D2VertexBuffer","vertexCount",value_vertexCount);
         return new A3D2VertexBuffer(value_attributes,value_byteBuffer,value_id,value_vertexCount);
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3D2VertexBuffer = A3D2VertexBuffer(object);
         this.var_240.method_295(protocolBuffer,struct.attributes);
         this.var_241.method_295(protocolBuffer,struct.byteBuffer);
         this.var_252.method_295(protocolBuffer,struct.id);
         this.var_242.method_295(protocolBuffer,struct.vertexCount);
      }
   }
}

