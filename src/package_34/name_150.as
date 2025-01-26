package package_34
{
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   import package_70.name_451;
   
   public class name_150 implements name_152
   {
      private var codec:name_152;
      
      private var var_189:Object;
      
      public function name_150(codec:name_152)
      {
         super();
         this.codec = codec;
         if(codec is name_451)
         {
            this.var_189 = name_451(codec).name_452();
         }
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         if(object == this.var_189)
         {
            protocolBuffer.optionalMap.name_444(true);
         }
         else
         {
            protocolBuffer.optionalMap.name_444(false);
            this.codec.method_295(protocolBuffer,object);
         }
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         return protocolBuffer.optionalMap.name_447() ? this.var_189 : this.codec.method_296(protocolBuffer);
      }
      
      public function init(protocol:name_163) : void
      {
         this.codec.init(protocol);
      }
   }
}

