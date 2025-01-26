package package_36
{
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class name_442
   {
      private var var_587:IDataOutput;
      
      private var var_586:IDataInput;
      
      private var var_588:name_648;
      
      public function name_442(output:IDataOutput, input:IDataInput, optionalMap:name_648)
      {
         super();
         this.var_587 = output;
         this.var_586 = input;
         this.var_588 = optionalMap;
      }
      
      public function get name_483() : IDataOutput
      {
         return this.var_587;
      }
      
      public function set name_483(value:IDataOutput) : void
      {
         this.var_587 = value;
      }
      
      public function get reader() : IDataInput
      {
         return this.var_586;
      }
      
      public function set reader(value:IDataInput) : void
      {
         this.var_586 = value;
      }
      
      public function get optionalMap() : name_648
      {
         return this.var_588;
      }
      
      public function set optionalMap(value:name_648) : void
      {
         this.var_588 = value;
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

