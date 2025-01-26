package package_62
{
   import flash.utils.ByteArray;
   import package_32.name_148;
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   import package_39.name_160;
   import package_5.name_3;
   import package_54.A3DIndexBuffer;
   
   public class CodecA3DIndexBuffer implements name_152
   {
      public static var log:name_160 = name_160(name_3.name_8().name_30(name_160));
      
      private var var_241:name_152;
      
      private var var_308:name_152;
      
      public function CodecA3DIndexBuffer()
      {
         super();
      }
      
      public function init(protocol:name_163) : void
      {
         this.var_241 = protocol.name_448(new name_148(ByteArray,true));
         this.var_308 = protocol.name_448(new name_148(int,false));
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         log = name_160(name_3.name_8().name_30(name_160));
         var value_byteBuffer:ByteArray = this.var_241.method_296(protocolBuffer) as ByteArray;
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.geometry.A3DIndexBuffer","byteBuffer",value_byteBuffer);
         var value_indexCount:int = int(this.var_308.method_296(protocolBuffer) as int);
         log.log("codec","struct %1 field %2 value %3","versions.version1.a3d.geometry.A3DIndexBuffer","indexCount",value_indexCount);
         return new A3DIndexBuffer(value_byteBuffer,value_indexCount);
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var struct:A3DIndexBuffer = A3DIndexBuffer(object);
         this.var_241.method_295(protocolBuffer,struct.byteBuffer);
         this.var_308.method_295(protocolBuffer,struct.indexCount);
      }
   }
}

