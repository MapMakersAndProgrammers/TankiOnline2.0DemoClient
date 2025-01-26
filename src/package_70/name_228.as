package package_70
{
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   
   public class name_228 implements name_152
   {
      public function name_228()
      {
         super();
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         protocolBuffer.name_483.writeUnsignedInt(uint(object));
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         return protocolBuffer.reader.readUnsignedInt();
      }
      
      public function init(protocol:name_163) : void
      {
      }
   }
}

