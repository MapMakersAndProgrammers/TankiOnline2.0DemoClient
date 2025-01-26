package package_123
{
   import alternativa.engine3d.alternativa3d;
   
   use namespace alternativa3d;
   use namespace collada;
   
   public class name_744 extends class_43
   {
      public var name_771:name_740;
      
      public function name_744(data:XML, document:name_707)
      {
         super(data,document);
      }
      
      override protected function parseImplementation() : Boolean
      {
         var inputXML:XML = null;
         inputXML = data.input.(@semantic == "POSITION")[0];
         if(inputXML != null)
         {
            this.name_771 = new name_784(inputXML,document).prepareSource(3);
            if(this.name_771 != null)
            {
               return true;
            }
         }
         return false;
      }
   }
}

