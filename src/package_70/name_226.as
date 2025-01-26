package package_70
{
   import package_36.name_163;
   import package_36.name_442;
   
   public class name_226 implements name_451
   {
      public function name_226()
      {
         super();
      }
      
      public function name_452() : Object
      {
         return Number.NEGATIVE_INFINITY;
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         protocolBuffer.name_483.writeFloat(Number(object));
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         return protocolBuffer.reader.readFloat();
      }
      
      public function init(protocol:name_163) : void
      {
      }
   }
}

