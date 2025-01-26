package package_62
{
   import flash.utils.ByteArray;
   import package_32.name_148;
   import package_32.name_149;
   import package_33.name_154;
   import package_33.name_156;
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   import package_39.name_160;
   import alternativa.osgi.OSGi;
   import package_54.A3DVertexBuffer;
   
   public class CodecA3DVertexBuffer implements name_152
   {
      public static var log:name_160 = name_160(OSGi.name_8().name_30(name_160));
      
      private var var_240:name_152;
      
      private var var_241:name_152;
      
      private var var_242:name_152;
      
      public function CodecA3DVertexBuffer()
      {
         super();
      }
      
      public function init(protocol:name_163) : void
      {
         this.var_240 = protocol.name_448(new name_149(new name_148(name_154,false),true,1));
         this.var_241 = protocol.name_448(new name_148(ByteArray,true));
         this.var_242 = protocol.name_448(new name_148(name_156,false));
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         log = name_160(OSGi.name_8().name_30(name_160));
         var value_attributes:Vector.<int> = this.var_240.method_296(protocolBuffer) as Vector.<int>;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.geometry.A3DVertexBuffer","attributes",value_attributes);
         var value_byteBuffer:ByteArray = this.var_241.method_296(protocolBuffer) as ByteArray;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.geometry.A3DVertexBuffer","byteBuffer",value_byteBuffer);
         var value_vertexCount:uint = uint(this.var_242.method_296(protocolBuffer) as uint);
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.geometry.A3DVertexBuffer","vertexCount",value_vertexCount);
         return new A3DVertexBuffer(value_attributes,value_byteBuffer,value_vertexCount);
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3DVertexBuffer = A3DVertexBuffer(object);
         this.var_240.method_295(protocolBuffer,struct.attributes);
         this.var_241.method_295(protocolBuffer,struct.byteBuffer);
         this.var_242.method_295(protocolBuffer,struct.vertexCount);
      }
   }
}

