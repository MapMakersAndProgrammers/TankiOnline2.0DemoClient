package package_70
{
   import package_36.name_163;
   import package_36.name_442;
   
   public class name_224 implements name_451
   {
      public function name_224()
      {
         super();
      }
      
      public function name_452() : Object
      {
         return int.MIN_VALUE;
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         protocolBuffer.name_483.writeShort(int(object));
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         return protocolBuffer.reader.readShort();
      }
      
      public function init(protocol:name_163) : void
      {
      }
   }
}

