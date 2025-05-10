package alternativa.engine3d.loaders.collada
{
   import flash.utils.ByteArray;
   
   use namespace collada;
   
   public class DaeElement
   {
      private static var _byteArray:ByteArray = new ByteArray();
      
      public var document:DaeDocument;
      
      public var data:XML;
      
      private var name_Ba:int = -1;
      
      public function DaeElement(data:XML, document:DaeDocument)
      {
         super();
         this.document = document;
         this.data = data;
      }
      
      public function cloneString(str:String) : String
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
      
      public function parse() : Boolean
      {
         if(this.name_Ba < 0)
         {
            this.name_Ba = this.parseImplementation() ? 1 : 0;
            return this.name_Ba != 0;
         }
         return this.name_Ba != 0;
      }
      
      protected function parseImplementation() : Boolean
      {
         return true;
      }
      
      protected function parseStringArray(element:XML) : Array
      {
         return element.text().toString().split(/\s+/);
      }
      
      protected function parseNumbersArray(element:XML) : Array
      {
         var value:String = null;
         var arr:Array = element.text().toString().split(/\s+/);
         for(var i:int = 0, count:int = int(arr.length); i < count; i++)
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
      
      protected function parseIntsArray(element:XML) : Array
      {
         var value:String = null;
         var arr:Array = element.text().toString().split(/\s+/);
         for(var i:int = 0, count:int = int(arr.length); i < count; i++)
         {
            value = arr[i];
            arr[i] = parseInt(value,10);
         }
         return arr;
      }
      
      protected function parseNumber(element:XML) : Number
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

