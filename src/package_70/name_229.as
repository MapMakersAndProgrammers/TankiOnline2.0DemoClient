package package_70
{
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   
   public class name_229 implements name_152
   {
      public function name_229()
      {
         super();
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         protocolBuffer.name_483.writeUnsignedInt(uint(object));
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         return protocolBuffer.reader.readUnsignedByte();
      }
      
      public function init(protocol:name_163) : void
      {
      }
   }
}

