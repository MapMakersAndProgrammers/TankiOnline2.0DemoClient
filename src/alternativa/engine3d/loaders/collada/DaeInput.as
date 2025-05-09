package alternativa.engine3d.loaders.collada
{
   use namespace collada;
   
   public class DaeInput extends DaeElement
   {
      public function DaeInput(data:XML, document:DaeDocument)
      {
         super(data,document);
      }
      
      public function get semantic() : String
      {
         var attribute:XML = data.@semantic[0];
         return attribute == null ? null : attribute.toString();
      }
      
      public function get source() : XML
      {
         return data.@source[0];
      }
      
      public function get offset() : int
      {
         var attr:XML = data.@offset[0];
         return attr == null ? 0 : int(parseInt(attr.toString(),10));
      }
      
      public function get setNum() : int
      {
         var attr:XML = data.@name_616[0];
         return attr == null ? 0 : int(parseInt(attr.toString(),10));
      }
      
      public function prepareSource(minComponents:int) : DaeSource
      {
         var source:DaeSource = document.findSource(this.source);
         if(source != null)
         {
            source.parse();
            if(source.numbers != null && source.stride >= minComponents)
            {
               return source;
            }
         }
         else
         {
            document.logger.logNotFoundError(data.@source[0]);
         }
         return null;
      }
   }
}

