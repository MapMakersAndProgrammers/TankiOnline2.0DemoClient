package package_123
{
   import flash.utils.ByteArray;
   
   use namespace collada;
   
   public class class_43
   {
      private static var _byteArray:ByteArray = new ByteArray();
      
      public var document:name_707;
      
      public var data:XML;
      
      private var var_697:int = -1;
      
      public function class_43(data:XML, document:name_707)
      {
         super();
         this.document = document;
         this.data = data;
      }
      
      public function name_708(str:String) : String
      {
         if(str == null)
         {
            return null;
         }
         _byteArray.position = 0;
         _byteArray.writeUTF(str);
         _byteArray.position = 0;
         return _byteArray.readUTF();
      }
      
      public function method_314() : Boolean
      {
         if(this.var_697 < 0)
         {
            this.var_697 = this.parseImplementation() ? 1 : 0;
            return this.var_697 != 0;
         }
         return this.var_697 != 0;
      }
      
      protected function parseImplementation() : Boolean
      {
         return true;
      }
      
      protected function name_565(element:XML) : Array
      {
         return element.text().toString().split(/\s+/);
      }
      
      protected function method_866(element:XML) : Array
      {
         var value:String = null;
         var arr:Array = element.text().toString().split(/\s+/);
         for(var i:int = 0,var count:int = int(arr.length); i < count; i++)
         {
            value = arr[i];
            if(value.indexOf(",") != -1)
            {
               value = value.replace(/,/,".");
            }
            arr[i] = parseFloat(value);
         }
         return arr;
      }
      
      protected function method_867(element:XML) : Array
      {
         var value:String = null;
         var arr:Array = element.text().toString().split(/\s+/);
         for(var i:int = 0,var count:int = int(arr.length); i < count; i++)
         {
            value = arr[i];
            arr[i] = parseInt(value,10);
         }
         return arr;
      }
      
      protected function method_761(element:XML) : Number
      {
         var value:String = element.toString().replace(/,/,".");
         return parseFloat(value);
      }
      
      public function get id() : String
      {
         var idXML:XML = this.data.@id[0];
         return idXML == null ? null : idXML.toString();
      }
      
      public function get sid() : String
      {
         var attr:XML = this.data.@sid[0];
         return attr == null ? null : attr.toString();
      }
      
      public function get name() : String
      {
         var nameXML:XML = this.data.@name[0];
         return nameXML == null ? null : nameXML.toString();
      }
   }
}

