package alternativa.engine3d.loaders.collada
{
   use namespace collada;
   
   public class DaeArray extends DaeElement
   {
      public var array:Array;
      
      public function DaeArray(data:XML, document:DaeDocument)
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
         this.array = parseStringArray(data);
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

