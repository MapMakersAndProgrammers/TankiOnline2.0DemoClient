package package_123
{
   use namespace collada;
   
   public class name_734 extends class_43
   {
      public function name_734(data:XML, document:name_707)
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

