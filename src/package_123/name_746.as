package package_123
{
   use namespace collada;
   
   public class name_746 extends class_43
   {
      public var array:Array;
      
      public function name_746(data:XML, document:name_707)
      {
         super(data,document);
      }
      
      public function get type() : String
      {
         return String(data.localName());
      }
      
      override protected function parseImplementation() : Boolean
      {
         var count:int = 0;
         this.array = name_565(data);
         var countXML:XML = data.@count[0];
         if(countXML != null)
         {
            count = int(parseInt(countXML.toString(),10));
            if(this.array.length < count)
            {
               document.logger.logNotEnoughDataError(data.@count[0]);
               return false;
            }
            this.array.length = count;
            return true;
         }
         return false;
      }
   }
}

