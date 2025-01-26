package package_123
{
   use namespace collada;
   
   public class name_775 extends class_43
   {
      private var effect:name_738;
      
      public function name_775(data:XML, effect:name_738)
      {
         super(data,effect.document);
         this.effect = effect;
      }
      
      public function name_777(setparams:Object) : Number
      {
         var param:name_754 = null;
         var floatXML:XML = data.float[0];
         if(floatXML != null)
         {
            return method_761(floatXML);
         }
         var paramRef:XML = data.param.@ref[0];
         if(paramRef != null)
         {
            param = this.effect.method_893(paramRef.toString(),setparams);
            if(param != null)
            {
               return param.name_777();
            }
         }
         return NaN;
      }
      
      public function method_273(setparams:Object) : Array
      {
         var param:name_754 = null;
         var colorXML:XML = data.color[0];
         if(colorXML != null)
         {
            return method_866(colorXML);
         }
         var paramRef:XML = data.param.@ref[0];
         if(paramRef != null)
         {
            param = this.effect.method_893(paramRef.toString(),setparams);
            if(param != null)
            {
               return param.getFloat4();
            }
         }
         return null;
      }
      
      private function get texture() : String
      {
         var attr:XML = data.texture.@texture[0];
         return attr == null ? null : attr.toString();
      }
      
      public function method_941(setparams:Object) : name_754
      {
         var sid:String = this.texture;
         if(sid != null)
         {
            return this.effect.method_893(sid,setparams);
         }
         return null;
      }
      
      public function method_604(setparams:Object) : name_734
      {
         var surfaceSID:String = null;
         var surface:name_754 = null;
         var sampler:name_754 = this.method_941(setparams);
         if(sampler != null)
         {
            surfaceSID = sampler.surfaceSID;
            if(surfaceSID != null)
            {
               surface = this.effect.method_893(surfaceSID,setparams);
               if(surface != null)
               {
                  return surface.image;
               }
               return null;
            }
            return sampler.image;
         }
         return document.findImageByID(this.texture);
      }
      
      public function get name_776() : String
      {
         var attr:XML = data.texture.@texcoord[0];
         return attr == null ? null : attr.toString();
      }
   }
}

