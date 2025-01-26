package package_123
{
   use namespace collada;
   
   public class name_784 extends class_43
   {
      public function name_784(data:XML, document:name_707)
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
         var attr:XML = data.@name_789[0];
         return attr == null ? 0 : int(parseInt(attr.toString(),10));
      }
      
      public function prepareSource(minComponents:int) : name_740
      {
         var source:name_740 = document.findSource(this.source);
         if(source != null)
         {
            source.method_314();
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

