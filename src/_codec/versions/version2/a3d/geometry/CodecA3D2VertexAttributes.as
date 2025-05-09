package _codec.versions.version2.a3d.geometry
{
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import versions.version2.a3d.geometry.A3D2VertexAttributes;
   
   public class CodecA3D2VertexAttributes implements ICodec
   {
      public function CodecA3D2VertexAttributes()
      {
         super();
      }
      
      public function init(protocol:IProtocol) : void
      {
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
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
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var value:int = int(object.value);
         protocolBuffer.writer.writeInt(value);
      }
   }
}

