package _codec.versions.version2.a3d.geometry
{
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.codec.OptionalCodecDecorator;
   import alternativa.protocol.impl.LengthCodecHelper;
   import alternativa.protocol.info.EnumCodecInfo;
   import versions.version2.a3d.geometry.A3D2VertexAttributes;
   
   public class VectorCodecA3D2VertexAttributesLevel1 implements ICodec
   {
      private var elementCodec:ICodec;
      
      private var optionalElement:Boolean;
      
      public function VectorCodecA3D2VertexAttributesLevel1(optionalElement:Boolean)
      {
         super();
         this.optionalElement = optionalElement;
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.elementCodec = protocol.getCodec(new EnumCodecInfo(A3D2VertexAttributes,false));
         if(this.optionalElement)
         {
            this.elementCodec = new OptionalCodecDecorator(this.elementCodec);
         }
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         var length:int = LengthCodecHelper.decodeLength(protocolBuffer);
         var result:Vector.<A3D2VertexAttributes> = new Vector.<A3D2VertexAttributes>(length,true);
         for(var i:int = 0; i < length; i++)
         {
            result[i] = A3D2VertexAttributes(this.elementCodec.decode(protocolBuffer));
         }
         return result;
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var data:Vector.<A3D2VertexAttributes> = Vector.<A3D2VertexAttributes>(object);
         var length:int = int(data.length);
         LengthCodecHelper.encodeLength(protocolBuffer,length);
         for(var i:int = 0; i < length; i++)
         {
            this.elementCodec.encode(protocolBuffer,data[i]);
         }
      }
   }
}

