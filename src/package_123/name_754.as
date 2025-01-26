package package_123
{
   use namespace collada;
   
   public class name_754 extends class_43
   {
      public function name_754(data:XML, document:name_707)
      {
         super(data,document);
      }
      
      public function get ref() : String
      {
         var attribute:XML = data.@ref[0];
         return attribute == null ? null : attribute.toString();
      }
      
      public function name_777() : Number
      {
         var floatXML:XML = data.float[0];
         if(floatXML != null)
         {
            return method_761(floatXML);
         }
         return NaN;
      }
      
      public function getFloat4() : Array
      {
         var components:Array = null;
         var element:XML = data.float4[0];
         if(element == null)
         {
            element = data.float3[0];
            if(element != null)
            {
               components = method_866(element);
               components[3] = 1;
            }
         }
         else
         {
            components = method_866(element);
         }
         return components;
      }
      
      public function get surfaceSID() : String
      {
         var element:XML = data.sampler2D.source[0];
         return element == null ? null : element.text().toString();
      }
      
      public function get wrap_s() : String
      {
         var element:XML = data.sampler2D.wrap_s[0];
         return element == null ? null : element.text().toString();
      }
      
      public function get image() : name_734
      {
         var image:name_734 = null;
         var init_from:XML = null;
         var imageIDXML:XML = null;
         var surface:XML = data.surface[0];
         if(surface != null)
         {
            init_from = surface.init_from[0];
            if(init_from == null)
            {
               return null;
            }
            image = document.findImageByID(init_from.text().toString());
         }
         else
         {
            imageIDXML = data.instance_image.@url[0];
            if(imageIDXML == null)
            {
               return null;
            }
            image = document.findImage(imageIDXML);
         }
         return image;
      }
   }
}

