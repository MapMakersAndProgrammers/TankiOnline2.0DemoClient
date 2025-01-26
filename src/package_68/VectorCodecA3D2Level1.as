package package_68
{
   import package_32.name_148;
   import package_34.name_150;
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   import package_38.name_443;
   import package_66.name_211;
   
   public class VectorCodecA3D2Level1 implements name_152
   {
      private var elementCodec:name_152;
      
      private var optionalElement:Boolean;
      
      public function VectorCodecA3D2Level1(optionalElement:Boolean)
      {
         super();
         this.optionalElement = optionalElement;
      }
      
      public function init(protocol:name_163) : void
      {
         this.elementCodec = protocol.name_448(new name_148(name_211,false));
         if(this.optionalElement)
         {
            this.elementCodec = new name_150(this.elementCodec);
         }
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         var length:int = name_443.name_445(protocolBuffer);
         var result:Vector.<name_211> = new Vector.<name_211>(length,true);
         for(var i:int = 0; i < length; i++)
         {
            result[i] = name_211(this.elementCodec.method_296(protocolBuffer));
         }
         return result;
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var data:Vector.<name_211> = Vector.<name_211>(object);
         var length:int = int(data.length);
         name_443.name_446(protocolBuffer,length);
         for(var i:int = 0; i < length; i++)
         {
            this.elementCodec.method_295(protocolBuffer,data[i]);
         }
      }
   }
}

