package package_60
{
   import package_32.name_209;
   import package_34.name_150;
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   import package_38.name_443;
   import package_52.A3D2VertexAttributes;
   
   public class VectorCodecA3D2VertexAttributesLevel1 implements name_152
   {
      private var elementCodec:name_152;
      
      private var optionalElement:Boolean;
      
      public function VectorCodecA3D2VertexAttributesLevel1(optionalElement:Boolean)
      {
         super();
         this.optionalElement = optionalElement;
      }
      
      public function init(protocol:name_163) : void
      {
         this.elementCodec = protocol.name_448(new name_209(A3D2VertexAttributes,false));
         if(this.optionalElement)
         {
            this.elementCodec = new name_150(this.elementCodec);
         }
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         var length:int = name_443.name_445(protocolBuffer);
         var result:Vector.<A3D2VertexAttributes> = new Vector.<A3D2VertexAttributes>(length,true);
         for(var i:int = 0; i < length; i++)
         {
            result[i] = A3D2VertexAttributes(this.elementCodec.method_296(protocolBuffer));
         }
         return result;
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var data:Vector.<A3D2VertexAttributes> = Vector.<A3D2VertexAttributes>(object);
         var length:int = int(data.length);
         name_443.name_446(protocolBuffer,length);
         for(var i:int = 0; i < length; i++)
         {
            this.elementCodec.method_295(protocolBuffer,data[i]);
         }
      }
   }
}

