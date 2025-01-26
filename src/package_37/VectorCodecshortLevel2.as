package package_37
{
   import package_32.name_148;
   import package_33.name_153;
   import package_34.name_150;
   import package_36.name_152;
   import package_36.name_163;
   import package_36.name_442;
   import package_38.name_443;
   
   public class VectorCodecshortLevel2 implements name_152
   {
      private var elementCodec:name_152;
      
      private var optionalElement:Boolean;
      
      public function VectorCodecshortLevel2(optionalElement:Boolean)
      {
         super();
         this.optionalElement = optionalElement;
      }
      
      public function init(protocol:name_163) : void
      {
         this.elementCodec = protocol.name_448(new name_148(name_153,false));
         if(this.optionalElement)
         {
            this.elementCodec = new name_150(this.elementCodec);
         }
      }
      
      public function method_296(protocolBuffer:name_442) : Object
      {
         var length2:int = 0;
         var items2:Vector.<uint> = null;
         var i2:int = 0;
         var length1:int = name_443.name_445(protocolBuffer);
         var result:Vector.<Vector.<uint>> = new Vector.<Vector.<uint>>(length1,true);
         for(var i1:int = 0; i1 < length1; )
         {
            if(!protocolBuffer.optionalMap.name_447())
            {
               length2 = name_443.name_445(protocolBuffer);
               items2 = new Vector.<uint>(length2,true);
               result[i1] = items2;
               for(i2 = 0; i2 < length2; i2++)
               {
                  items2[i2] = uint(this.elementCodec.method_296(protocolBuffer));
               }
            }
            i1++;
         }
         return result;
      }
      
      public function method_295(protocolBuffer:name_442, object:Object) : void
      {
         var items2:Vector.<uint> = null;
         var length2:int = 0;
         var i2:int = 0;
         if(object == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var data:Vector.<Vector.<uint>> = Vector.<Vector.<uint>>(object);
         var length1:int = int(data.length);
         name_443.name_446(protocolBuffer,length1);
         for(var i1:int = 0; i1 < length1; i1++)
         {
            items2 = data[i1];
            if(items2 != null)
            {
               protocolBuffer.optionalMap.name_444(false);
               length2 = int(items2.length);
               name_443.name_446(protocolBuffer,length2);
               for(i2 = 0; i2 < length2; i2++)
               {
                  this.elementCodec.method_295(protocolBuffer,items2[i2]);
               }
            }
            else
            {
               protocolBuffer.optionalMap.name_444(true);
            }
         }
      }
   }
}

