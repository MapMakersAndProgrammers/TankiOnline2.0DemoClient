package _codec.versions.version2.a3d.objects
{
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.codec.OptionalCodecDecorator;
   import alternativa.protocol.impl.LengthCodecHelper;
   import alternativa.protocol.info.TypeCodecInfo;
   import versions.version2.a3d.objects.A3D2Surface;
   
   public class VectorCodecA3D2SurfaceLevel3 implements ICodec
   {
      private var elementCodec:ICodec;
      
      private var optionalElement:Boolean;
      
      public function VectorCodecA3D2SurfaceLevel3(optionalElement:Boolean)
      {
         super();
         this.optionalElement = optionalElement;
      }
      
      public function init(protocol:IProtocol) : void
      {
         this.elementCodec = protocol.getCodec(new TypeCodecInfo(A3D2Surface,false));
         if(this.optionalElement)
         {
            this.elementCodec = new OptionalCodecDecorator(this.elementCodec);
         }
      }
      
      public function decode(protocolBuffer:ProtocolBuffer) : Object
      {
         var length2:int = 0;
         var items2:Vector.<Vector.<A3D2Surface>> = null;
         var i2:int = 0;
         var length3:int = 0;
         var items3:Vector.<A3D2Surface> = null;
         var i3:int = 0;
         var length1:int = LengthCodecHelper.decodeLength(protocolBuffer);
         var result:Vector.<Vector.<Vector.<A3D2Surface>>> = new Vector.<Vector.<Vector.<A3D2Surface>>>(length1,true);
         for(var i1:int = 0; i1 < length1; )
         {
            if(!protocolBuffer.optionalMap.get())
            {
               length2 = LengthCodecHelper.decodeLength(protocolBuffer);
               items2 = new Vector.<Vector.<A3D2Surface>>(length2,true);
               result[i1] = items2;
               for(i2 = 0; i2 < length2; )
               {
                  if(!protocolBuffer.optionalMap.get())
                  {
                     length3 = LengthCodecHelper.decodeLength(protocolBuffer);
                     items3 = new Vector.<A3D2Surface>(length3,true);
                     items2[i2] = items3;
                     for(i3 = 0; i3 < length3; i3++)
                     {
                        items3[i3] = A3D2Surface(this.elementCodec.decode(protocolBuffer));
                     }
                  }
                  i2++;
               }
            }
            i1++;
         }
         return result;
      }
      
      public function encode(protocolBuffer:ProtocolBuffer, object:Object) : void
      {
         var items2:Vector.<Vector.<A3D2Surface>> = null;
         var length2:int = 0;
         var i2:int = 0;
         var items3:Vector.<A3D2Surface> = null;
         var length3:int = 0;
         var i3:int = 0;
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var data:Vector.<Vector.<Vector.<A3D2Surface>>> = Vector.<Vector.<Vector.<A3D2Surface>>>(object);
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
                  items3 = items2[i1];
                  if(items3 != null)
                  {
                     protocolBuffer.optionalMap.addBit(false);
                     length3 = int(items3.length);
                     LengthCodecHelper.encodeLength(protocolBuffer,length3);
                     for(i3 = 0; i3 < length3; i3++)
                     {
                        this.elementCodec.encode(protocolBuffer,items3[i3]);
                     }
                  }
                  else
                  {
                     protocolBuffer.optionalMap.addBit(true);
                  }
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

