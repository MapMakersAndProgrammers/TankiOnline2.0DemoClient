package _codec.versions.version1.a3d.materials
{
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.codec.OptionalCodecDecorator;
   import alternativa.protocol.impl.LengthCodecHelper;
   import alternativa.protocol.info.TypeCodecInfo;
   import versions.version1.a3d.materials.A3DImage;
   
   public class VectorCodecA3DImageLevel2 implements ICodec
   {
      private var elementCodec:ICodec;
      
      private var optionalElement:Boolean;
      
      public function VectorCodecA3DImageLevel2(optionalElement:Boolean)
      {
         super();
         this.optionalElement = optionalElement;
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.elementCodec = protocol.getCodec(new TypeCodecInfo(A3DImage,false));
         if(this.optionalElement)
         {
            this.elementCodec = new OptionalCodecDecorator(this.elementCodec);
         }
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         var length2:int = 0;
         var items2:Vector.<A3DImage> = null;
         var i2:int = 0;
         var length1:int = LengthCodecHelper.decodeLength(protocolBuffer);
         var result:Vector.<Vector.<A3DImage>> = new Vector.<Vector.<A3DImage>>(length1,true);
         for(var i1:int = 0; i1 < length1; )
         {
            if(!protocolBuffer.optionalMap.OptionalMap())
            {
               length2 = LengthCodecHelper.decodeLength(protocolBuffer);
               items2 = new Vector.<A3DImage>(length2,true);
               result[i1] = items2;
               for(i2 = 0; i2 < length2; i2++)
               {
                  items2[i2] = A3DImage(this.elementCodec.decode(protocolBuffer));
               }
            }
            i1++;
         }
         return result;
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         var items2:Vector.<A3DImage> = null;
         var length2:int = 0;
         var i2:int = 0;
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var data:Vector.<Vector.<A3DImage>> = Vector.<Vector.<A3DImage>>(object);
         var length1:int = int(data.length);
         LengthCodecHelper.encodeLength(protocolBuffer,length1);
         for(var i1:int = 0; i1 < length1; i1++)
         {
            items2 = data[i1];
            if(items2 != null)
            {
               protocolBuffer.optionalMap.addBit(false);
               length2 = int(items2.length);
               LengthCodecHelper.encodeLength(protocolBuffer,length2);
               for(i2 = 0; i2 < length2; i2++)
               {
                  this.elementCodec.encode(protocolBuffer,items2[i2]);
               }
            }
            else
            {
               protocolBuffer.optionalMap.addBit(true);
            }
         }
      }
   }
}

