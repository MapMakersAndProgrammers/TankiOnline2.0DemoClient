package alternativa.engine3d.loaders.collada
{
   import alternativa.engine3d.alternativa3d;
   
   use namespace alternativa3d;
   use namespace collada;
   
   public class DaeVertices extends DaeElement
   {
      public var name_E6:DaeSource;
      
      public function DaeVertices(data:XML, document:DaeDocument)
      {
         super(data,document);
      }
      
      override protected function parseImplementation() : Boolean
      {
         var inputXML:XML = null;
         inputXML = data.input.(@semantic == "POSITION")[0];
         if(inputXML != null)
         {
            this.name_E6 = new DaeInput(inputXML,document).prepareSource(3);
            if(this.name_E6 != null)
            {
               return true;
            }
         }
         return false;
      }
   }
}

