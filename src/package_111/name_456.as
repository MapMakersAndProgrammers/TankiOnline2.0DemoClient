package package_111
{
   import flash.utils.ByteArray;
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   import package_38.name_443;
   
   public class name_456 implements name_152
   {
      public function name_456()
      {
         super();
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         var bytes:ByteArray = ByteArray(object);
         name_443.name_446(protocolBuffer,bytes.length);
         protocolBuffer.name_483.writeBytes(bytes);
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         var size:int = name_443.name_445(protocolBuffer);
         var bytes:ByteArray = new ByteArray();
         protocolBuffer.reader.readBytes(bytes,0,size);
         return bytes;
      }
      
      public function init(protocol:name_163) : void
      {
      }
   }
}

