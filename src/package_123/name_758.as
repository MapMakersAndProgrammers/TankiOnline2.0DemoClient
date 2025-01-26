package package_123
{
   use namespace collada;
   
   public class name_758 extends class_43
   {
      public function name_758(data:XML, document:name_707)
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
      
      public function get material() : name_713
      {
         var mat:name_713 = document.findMaterial(this.target);
         if(mat == null)
         {
            document.logger.logNotFoundError(this.target);
         }
         return mat;
      }
      
      public function method_924(semantic:String) : int
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

