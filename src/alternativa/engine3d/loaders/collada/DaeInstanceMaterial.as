package alternativa.engine3d.loaders.collada
{
   use namespace collada;
   
   public class DaeInstanceMaterial extends DaeElement
   {
      public function DaeInstanceMaterial(data:XML, document:DaeDocument)
      {
         super(data,document);
      }
      
      public function get symbol() : String
      {
         var attribute:XML = data.@symbol[0];
         return attribute == null ? null : attribute.toString();
      }
      
      private function get target() : XML
      {
         return data.@target[0];
      }
      
      public function get material() : DaeMaterial
      {
         var mat:DaeMaterial = document.findMaterial(this.target);
         if(mat == null)
         {
            document.logger.logNotFoundError(this.target);
         }
         return mat;
      }
      
      public function getBindVertexInputSetNum(semantic:String) : int
      {
         var bindVertexInputXML:XML = null;
         var setNumXML:XML = null;
         bindVertexInputXML = data.bind_vertex_input.(@semantic == semantic)[0];
         if(bindVertexInputXML == null)
         {
            return 0;
         }
         setNumXML = bindVertexInputXML.@input_set[0];
         return setNumXML == null ? 0 : int(parseInt(setNumXML.toString(),10));
      }
   }
}

