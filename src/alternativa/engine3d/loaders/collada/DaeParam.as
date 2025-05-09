package alternativa.engine3d.loaders.collada
{
   use namespace collada;
   
   public class DaeParam extends DaeElement
   {
      public function DaeParam(data:XML, document:DaeDocument)
      {
         super(data,document);
      }
      
      public function get ref() : String
      {
         var attribute:XML = data.@ref[0];
         return attribute == null ? null : attribute.toString();
      }
      
      public function getFloat() : Number
      {
         var floatXML:XML = data.float[0];
         if(floatXML != null)
         {
            return parseNumber(floatXML);
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
               components = parseNumbersArray(element);
               components[3] = 1;
            }
         }
         else
         {
            components = parseNumbersArray(element);
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
      
      public function get image() : DaeImage
      {
         var image:DaeImage = null;
         var init_from:XML = null;
         var _loc4_:XML = null;
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
            _loc4_ = data.instance_image.@url[0];
            if(_loc4_ == null)
            {
               return null;
            }
            image = document.findImage(_loc4_);
         }
         return image;
      }
   }
}

