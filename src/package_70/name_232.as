package package_70
{
   import package_36.name_163;
   import package_36.name_442;
   
   public class name_232 implements name_451
   {
      public function name_232()
      {
         super();
      }
      
      public function name_452() : Object
      {
         return int.MIN_VALUE;
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         protocolBuffer.name_483.writeInt(int(object));
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         return protocolBuffer.reader.readInt();
      }
      
      public function init(protocol:name_163) : void
      {
      }
   }
}

