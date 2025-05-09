package alternativa.protocol
{
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class ProtocolBuffer
   {
      private var var_587:IDataOutput;
      
      private var var_588:IDataInput;
      
      private var var_586:OptionalMap;
      
      public function ProtocolBuffer(output:IDataOutput, input:IDataInput, optionalMap:OptionalMap)
      {
         super();
         this.var_587 = output;
         this.var_588 = input;
         this.var_586 = optionalMap;
      }
      
      public function get writer() : IDataOutput
      {
         return this.var_587;
      }
      
      public function set writer(value:IDataOutput) : void
      {
         this.var_587 = value;
      }
      
      public function get reader() : IDataInput
      {
         return this.var_588;
      }
      
      public function set reader(value:IDataInput) : void
      {
         this.var_588 = value;
      }
      
      public function get optionalMap() : OptionalMap
      {
         return this.var_586;
      }
      
      public function set optionalMap(value:OptionalMap) : void
      {
         this.var_586 = value;
      }
      
      public function toString() : String
      {
         var b:int = 0;
         var c:String = null;
         var result:String = "";
         var position:int = int(ByteArray(this.reader).position);
         result += "\n=== Dump data ===\n";
         var pos:int = 0;
         for(var chars:String = ""; Boolean(ByteArray(this.reader).bytesAvailable); )
         {
            b = int(this.reader.readByte());
            c = String.fromCharCode(b);
            if(b >= 0 && b < 16)
            {
               result += "0";
            }
            if(b < 0)
            {
               b = 256 + b;
            }
            result += b.toString(16);
            result += " ";
            if(b < 12 && b > 128)
            {
               chars += ".";
            }
            else
            {
               chars += c;
            }
            pos++;
            if(pos > 16)
            {
               result += "\t";
               result += chars;
               result += "\n";
               pos = 0;
               chars = "";
            }
         }
         if(pos != 0)
         {
            while(pos < 18)
            {
               pos++;
               result += "   ";
            }
            result += "\t";
            result += chars;
            result += "\n";
         }
         ByteArray(this.reader).position = position;
         return result;
      }
   }
}

