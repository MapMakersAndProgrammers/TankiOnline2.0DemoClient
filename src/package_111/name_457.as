package package_111
{
   import flash.utils.ByteArray;
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   import package_38.name_443;
   
   public class name_457 implements name_152
   {
      public function name_457()
      {
         super();
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         var bytes:ByteArray = new ByteArray();
         bytes.writeUTFBytes(String(object));
         var length:int = int(bytes.length);
         name_443.name_446(protocolBuffer,length);
         protocolBuffer.name_483.writeBytes(bytes,0,length);
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         var length:int = name_443.name_445(protocolBuffer);
         return protocolBuffer.reader.readUTFBytes(length);
      }
      
      public function init(protocol:name_163) : void
      {
      }
   }
}

