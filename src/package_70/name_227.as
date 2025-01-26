package package_70
{
   import package_33.name_155;
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   
   public class name_227 implements name_152
   {
      public function name_227()
      {
         super();
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         protocolBuffer.name_483.writeInt(name_155(object).high);
         protocolBuffer.name_483.writeInt(name_155(object).low);
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         return name_155.method_298(protocolBuffer.reader.readInt(),protocolBuffer.reader.readInt());
      }
      
      public function init(protocol:name_163) : void
      {
      }
   }
}

