package _codec.versions.version1.a3d.objects
{
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.codec.OptionalCodecDecorator;
   import alternativa.protocol.impl.LengthCodecHelper;
   import alternativa.protocol.info.TypeCodecInfo;
   import versions.version1.a3d.objects.A3DTransformation;
   
   public class VectorCodecA3DTransformationLevel1 implements ICodec
   {
      private var elementCodec:ICodec;
      
      private var optionalElement:Boolean;
      
      public function VectorCodecA3DTransformationLevel1(optionalElement:Boolean)
      {
         super();
         this.optionalElement = optionalElement;
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.elementCodec = protocol.getCodec(new TypeCodecInfo(A3DTransformation,false));
         if(this.optionalElement)
         {
            this.elementCodec = new OptionalCodecDecorator(this.elementCodec);
         }
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         var length:int = LengthCodecHelper.decodeLength(protocolBuffer);
         var result:Vector.<A3DTransformation> = new Vector.<A3DTransformation>(length,true);
         for(var i:int = 0; i < length; i++)
         {
            result[i] = A3DTransformation(this.elementCodec.decode(protocolBuffer));
         }
         return result;
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var data:Vector.<A3DTransformation> = Vector.<A3DTransformation>(object);
         var length:int = int(data.length);
         LengthCodecHelper.encodeLength(protocolBuffer,length);
         for(var i:int = 0; i < length; i++)
         {
            this.elementCodec.encode(protocolBuffer,data[i]);
         }
      }
   }
}

