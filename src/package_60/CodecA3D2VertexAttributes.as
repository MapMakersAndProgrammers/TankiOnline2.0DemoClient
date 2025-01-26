package package_60
{
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   import package_52.A3D2VertexAttributes;
   
   public class CodecA3D2VertexAttributes implements name_152
   {
      public function CodecA3D2VertexAttributes()
      {
         super();
      }
      
      public function init(protocol:name_163) : void
      {
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         var result:A3D2VertexAttributes = null;
         var value:int = int(protocolBuffer.reader.readInt());
         switch(value)
         {
            case 0:
               result = A3D2VertexAttributes.POSITION;
               break;
            case 1:
               result = A3D2VertexAttributes.NORMAL;
               break;
            case 2:
               result = A3D2VertexAttributes.TANGENT4;
               break;
            case 3:
               result = A3D2VertexAttributes.JOINT;
               break;
            case 4:
               result = A3D2VertexAttributes.TEXCOORD;
         }
         return result;
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var value:int = int(object.value);
         protocolBuffer.name_483.writeInt(value);
      }
   }
}

