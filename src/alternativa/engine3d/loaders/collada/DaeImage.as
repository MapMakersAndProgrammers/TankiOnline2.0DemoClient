package alternativa.engine3d.loaders.collada
{
   use namespace collada;
   
   public class DaeImage extends DaeElement
   {
      public function DaeImage(data:XML, document:DaeDocument)
      {
         super(data,document);
      }
      
      public function get init_from() : String
      {
         var refXML:XML = null;
         var element:XML = data.init_from[0];
         if(element != null)
         {
            if(document.versionMajor > 4)
            {
               refXML = element.ref[0];
               return refXML == null ? null : refXML.text().toString();
            }
            return element.text().toString();
         }
         return null;
      }
   }
}

