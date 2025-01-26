package package_70
{
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   
   public class name_458 implements name_152
   {
      public function name_458()
      {
         super();
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         protocolBuffer.name_483.writeByte(!!Boolean(object) ? int(int(1)) : int(int(0)));
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         return protocolBuffer.reader.readByte() != 0;
      }
      
      public function init(protocol:name_163) : void
      {
      }
   }
}

